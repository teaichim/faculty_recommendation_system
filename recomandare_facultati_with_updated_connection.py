import pandas as pd
from sqlalchemy import create_engine, text
import ast
from collections import defaultdict

# Configurare conexiune Azure SQL Database
server = 'ibd-student.database.windows.net'
database = 'ibdstudent'
username = 'student@ibd-student'
password = 'Parola123'
driver = 'ODBC Driver 17 for SQL Server'

# Creare engine SQLAlchemy
connection_string = (
    f"mssql+pyodbc://{username}:{password}@{server}:1433/{database}"
    f"?driver={driver.replace(' ', '+')}&encrypt=yes&trustServerCertificate=no"
)
engine = create_engine(connection_string)

# Încărcare date din baza de date Azure
facultati_query = "SELECT * FROM facultate"
rezultate_bac_query = "SELECT * FROM rezultate_bac"
persoane_promovate_query = "SELECT * FROM persoana"
adresa_query = "SELECT * FROM adresa"

# Citirea datelor cu pandas
facultati_df = pd.read_sql(facultati_query, engine)
rezultate_bac_df = pd.read_sql(rezultate_bac_query, engine)
persoane_promovate_df = pd.read_sql(persoane_promovate_query, engine)
adresa_df = pd.read_sql(adresa_query, engine)

print("Datele au fost încărcate cu succes!")

# Standardizare și curățare date
facultati_df.columns = facultati_df.columns.str.lower().str.strip()
rezultate_bac_df.columns = rezultate_bac_df.columns.str.lower().str.strip()
persoane_promovate_df.columns = persoane_promovate_df.columns.str.lower().str.strip()
adresa_df.columns = adresa_df.columns.str.lower().str.strip()

persoane_promovate_df['cod_candidat'] = persoane_promovate_df['cod_candidat'].astype(str)
rezultate_bac_df['cod_candidat'] = rezultate_bac_df['cod_candidat'].astype(str)
adresa_df['siiir'] = adresa_df['siiir'].astype(str)

facultati_df['materii_bac'] = facultati_df['materii_bac'].apply(lambda x: ast.literal_eval(x) if isinstance(x, str) else x)

# Unirea datelor
elevi_data = pd.merge(persoane_promovate_df, rezultate_bac_df[['cod_candidat', 'materii_bac', 'medie']], on='cod_candidat', how='left')
elevi_data = pd.merge(elevi_data, adresa_df[['siiir', 'judet']], on='siiir', how='left')

# Maparea facultăților cu materiile lor de bac
faculty_subject_map = defaultdict(list)
for _, row in facultati_df.iterrows():
    subjects = frozenset(row['materii_bac'])
    faculty_subject_map[subjects].append((row['facultate'], row['medie_intrare']))

# Funcția de potrivire optimizată
def optimized_match_faculty_with_county(row, threshold=0.1):
    student_subjects = frozenset(ast.literal_eval(row['materii_bac']))
    student_media = row['medie']
    student_judet = row['judet']

    matched_faculties = []
    for subjects, faculties in faculty_subject_map.items():
        match_ratio = len(student_subjects.intersection(subjects)) / len(subjects)
        if match_ratio >= threshold:
            matched_faculties.extend([(faculty, grade, match_ratio) for faculty, grade in faculties])

    matched_faculties = sorted(
        [f for f in matched_faculties if f[1] <= student_media + 0.5],
        key=lambda x: (-x[2], x[1])
    )

    return matched_faculties[0][0] if matched_faculties else None

# Aplicarea funcției de recomandare
elevi_data['facultate_recomandata_judet'] = elevi_data.apply(
    lambda row: optimized_match_faculty_with_county(row, threshold=0.1), axis=1
)

# Calcularea ratei de recomandare
new_recommendation_rate = elevi_data['facultate_recomandata_judet'].notnull().mean() * 100

# Inserarea rezultatelor în baza de date
output_table_name = 'elevi_facultati_recomandate'

# Truncate tabelul înainte de inserare
truncate_query = f"TRUNCATE TABLE {output_table_name}"
with engine.connect() as conn:
    conn.execute(text(truncate_query))
    print(f"Tabelul {output_table_name} a fost golit cu succes.")

try:
    elevi_data.to_sql(output_table_name, engine, if_exists='append', index=False)
    print(f"Datele au fost inserate cu succes în tabela '{output_table_name}'.")
except Exception as e:
    print(f"Eroare la inserarea datelor în baza de date: {e}")
