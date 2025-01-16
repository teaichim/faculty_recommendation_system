from flask import Flask, render_template, request, redirect, url_for
import pymssql

app = Flask(__name__)
app.secret_key = 'secret_key'  # Schimbă aceasta cu un secret mai sigur

# Configurația conexiunii la baza de date Azure
server = 'ibd-student.database.windows.net'
database = 'ibdstudent'
username = 'student'
password = 'Parola123'

def get_db_connection():
    conn = pymssql.connect(server=server, user=username, password=password, database=database)
    return conn

@app.route('/')
def home():
    return render_template('login.html')

@app.route('/login', methods=['POST'])
def login():
    cod_candidat = request.form['cod_candidat']
    parola = request.form['parola']

    connection = get_db_connection()
    cursor = connection.cursor()
    
    # Primul select - verifică dacă există un utilizator cu cod_candidat și parola
    cursor.execute("SELECT * FROM persoana WHERE cod_candidat = %s AND siiir = %s", (cod_candidat, parola))
    user = cursor.fetchone()

    if user:
        # Al doilea select - caută facultatea recomandată
        cursor.execute("SELECT facultate_recomandata_judet FROM elevi_facultati_recomandate WHERE cod_candidat = %s", (cod_candidat,))
        facultate_recomandata = cursor.fetchone()

        if facultate_recomandata and facultate_recomandata[0] is not None:
            # Dacă există o facultate recomandată, o prezentăm
            return render_template('result.html', facultate=[facultate_recomandata[0]])
        else:
            # Al treilea select - caută facultatea pe baza județului
            cursor.execute("""
                SELECT f.facultate 
                FROM facultate f 
                JOIN adresa a ON a.judet = f.judet 
                JOIN persoana p ON a.siiir = p.siiir 
                WHERE p.cod_candidat = %s
            """, (cod_candidat,))
            facultate_alternativa = cursor.fetchall()

            if facultate_alternativa:
                # Aici, avem mai multe facultăți, le vom trimite ca listă
                return render_template('result.html', facultate=[f[0] for f in facultate_alternativa])
            else:
                return render_template('result.html', facultate=['Pe baza informatiilor oferite nu s-a putut face o recomandare de universitate'])
    else:
       error_message = "Credentialele introduse sunt gresite, reintroduceti Codul de Candidat si/sau parola"
       return render_template('login.html', error=error_message)
if __name__ == '__main__':
    app.run(debug=True)