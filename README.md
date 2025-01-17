# Faculty Recommendation System
This project is a machine learning-based recommendation system designed to assist students in identifying suitable faculties based on their BAC results (is the final high school graduation exam in Romania). The system utilizes a structured database, predictive algorithms, and a user-friendly web interface to provide personalized recommendations.

## Data Sources
The initial datasets used in this project were obtained from the following sources:

- **BAC Results**: Provided by [Ministerul Educatiei si Cercetarii](https://data.gov.ro/dataset?tags=bacalaureat)
- **Faculties Data**: Collected from [ROSE: Romanian Secondary Education Project](https://www.rose-edu.ro/lista-universitati/)
- **Address Data**: Extracted from [Ministerul Educatiei si Cercetarii](https://www.edu.ro/sites/default/files/Lista_unitati_invatamant_raspuns_invitatie_participare_PNRAS_0.pdf).

These datasets were processed and cleaned to generate the final datasets used for the recommendation system. See the `data_cleaning.py` script for details.

### Reference Values and Data Mapping

For the purpose of the recommendation system, we generated reference codes and associated faculties based on subjects and grades from the BAC exam. This mapping was created to simulate real-world scenarios and ensure alignment between subjects studied and potential faculties.

- **Reference Codes**: Unique identifiers were randomly selected and linked to specific faculties.
- **Mapping Criteria**:
  - Faculties were associated with reference codes based on the subjects taken in the BAC exam (e.g., Mathematics, Romanian Language, etc.).
  - Grades were considered to align with the admission standards of different faculties.

These reference values are not extracted from real data but were created manually to provide a framework for testing and implementing the recommendation system.

## Integration with Microsoft Azure

The database schema was implemented on Azure using four interconnected tables: persoana, adresa, rezultate_bac, and facultate. The persoana table stores candidate-specific details such as their unique code, gender, and specialization and is linked to rezultate_bac via cod_candidat and to adresa via the siiir field. The adresa table contains address data for high schools, with a connection to persoana through the siiir field. The rezultate_bac table records detailed BAC results and links to persoana using the cod_candidat field as a foreign key. Finally, the facultate table holds information about universities and admission requirements, with a relationship to rezultate_bac through the materii_bac field, aligning BAC subjects with faculty criteria. These relationships ensured data integrity and supported seamless integration into the recommendation system.


## Machine Learning Integration

The machine learning component of the recommendation system efficiently combines relational databases and Python-based algorithms to provide accurate faculty recommendations. By extracting and merging data from multiple tables (facultate, rezultate_bac, persoana, and adresa), the system processes student profiles, including BAC subjects, grades, and geographic information. A mapping function (faculty_subject_map) aligns student data with faculty requirements, calculating a threshold-based match ratio to prioritize the most relevant recommendations. The results are evaluated for accuracy, achieving a success rate of 66.16%, and are stored in the Azure SQL Database for further analysis. This modular and structured approach highlights the integration of database management and machine learning techniques to deliver a practical solution for educational guidance.

## Web Application

The web application was developed using Flask, a lightweight Python framework, to manage user authentication and facilitate interaction with the Microsoft SQL Server database via the pymssql library. Users log in using their unique codes and high school identifiers, allowing the system to query the database and execute the recommendation algorithm. Flask’s simplicity and modularity made it ideal for building a scalable and efficient platform, while pymssql provided seamless integration with the SQL Server for real-time data retrieval. Future enhancements could include advanced user interfaces and integration with Big Data technologies to improve scalability and functionality.
