import pandas as pd
from sqlalchemy import create_engine

hostname = 'localhost'
username = 'root'
password = '110752'
port = 3306
database = 'isas'

# MySQL connection string
conn_string = 'mysql+pymysql://' +username+':'+password+'@'+hostname+':'+str(port)+'/'+database

# Create an engine
db = create_engine(conn_string)
conn = db.connect()

# List of CSV files to be uploaded
files = ['artist', 'canvas_size', 'image_link', 'museum_hours', 'museum', 'product_size', 'subject', 'work']

# Loop through each file and upload to the MySQL database
for file in files:
    # Read the CSV file into a DataFrame
    df = pd.read_csv(f'/Users/emondemoniac/Desktop/SQL/Instagram/data/{file}.csv')
    # Upload the DataFrame to the database
    df.to_sql(file, con=conn, if_exists='replace', index=False)

# Close the connection
conn.close()

