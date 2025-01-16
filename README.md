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

