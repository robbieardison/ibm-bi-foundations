# cp-access-log.sh
# This script downloads the file 'web-server-access-log.txt.gz'
# from "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/".
# Download the access log file

wget "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz"
# The script then extracts the .txt file using gunzip.
# Unzip the file to extract the .txt file.
gunzip -f web-server-access-log.txt.gz

# The .txt file contains the timestamp, latitude, longitude 
# and visitor id apart from other data.
# Extract phase

echo "Extracting data"

# Extract the columns 1 (timestamp), 2 (latitude), 3 (longitude) and 
# 4 (visitorid)

cut -d"#" -f1-4 web-server-access-log.txt > extracted-data.txt

# Transforms the text delimeter from "#" to "," and saves to a csv file.
tr "#" "," < extracted-data.txt > transformed-data.csv
# Loads the data from the CSV file into the table 'access_log' in PostgreSQL database.
echo "\c template1;\COPY access_log  FROM '/Users/robbieardison/Documents/projects/ibm-bi-foundations/etl_and_pipelines_shell_airflow_kafka/etl_using_shell_scripting/transformed-data.csv' DELIMITERS ',' CSV HEADER;" | psql --username=postgres --host=localhost
