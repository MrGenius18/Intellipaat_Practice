import pandas as pd
import pyodbc
import os

# List of CSV files and their corresponding table names
csv_files = [
    ('Continent.csv', 'Continent'),
    ('Customers.csv', 'Customers'),
    ('Transaction.csv', 'Transactions'),
]

# Connect to SQL Server select your server wise
# Using Windows Authentication
conn = pyodbc.connect(
    r'DRIVER={ODBC Driver 17 for SQL Server};'
    r'SERVER=Genius\GENIUS;'
    r'DATABASE=case_study_3;'
    r'Trusted_Connection=yes;'
)

# Using SQL Server Authentication
# conn = pyodbc.connect(
#     r'DRIVER={ODBC Driver 17 for SQL Server};'
#     r'SERVER=Genius\GENIUS;'
#     r'DATABASE=case_study_3;'
#     r'UID=bhaut;'
#     r'PWD=your_password;'
# )

cursor = conn.cursor()

# Folder containing the CSV files
folder_path = r'04_Case-study'


######################################################
###################### Not Changes ###################

# Convert pandas dtype to SQL Server data types.
def get_sql_type(dtype):
    if pd.api.types.is_integer_dtype(dtype):
        return 'INT'
    elif pd.api.types.is_float_dtype(dtype):
        return 'FLOAT'
    elif pd.api.types.is_bool_dtype(dtype):
        return 'BIT'
    elif pd.api.types.is_datetime64_any_dtype(dtype):
        return 'DATETIME'
    else:
        return 'NVARCHAR(MAX)'

for csv_file, table_name in csv_files:
    try:
        file_path = os.path.join(folder_path, csv_file)
        
        # Read the CSV file into a pandas DataFrame
        df = pd.read_csv(file_path)
        
        # Replace NaN with None to handle SQL NULL
        df = df.where(pd.notnull(df), None)
        
        # Debugging: Check for NaN values
        print(f"Processing {csv_file}")
        print(f"NaN values before replacement:\n{df.isnull().sum()}\n")

        # Clean column names (replace spaces and special characters)
        df.columns = [col.replace(' ', '_').replace('-', '_').replace('.', '_') for col in df.columns]

        # Generate the CREATE TABLE statement with appropriate data types
        columns = ', '.join([f'[{col}] {get_sql_type(df[col].dtype)}' for col in df.columns])
        create_table_query = f"""
        IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '{table_name}')
        BEGIN
            CREATE TABLE [{table_name}] ({columns})
        END
        """
        
        # Execute the table creation query
        cursor.execute(create_table_query)
        print(f"Table [{table_name}] checked/created successfully.\n")

        # Insert DataFrame data into the SQL Server table
        for _, row in df.iterrows():
            values = tuple(None if pd.isna(x) else x for x in row)
            sql = f"INSERT INTO [{table_name}] ({', '.join(['[' + col + ']' for col in df.columns])}) VALUES ({', '.join(['?'] * len(row))})"
            
            cursor.execute(sql, values)

        # Commit the transaction for the current CSV file
        conn.commit()
        print(f"Data from {csv_file} inserted successfully into [{table_name}].\n")

    except Exception as e:
        print(f"Error processing {csv_file}: {e}")

# Close the connection
conn.close()
print("All operations completed successfully!")
