import mysql.connector

db = mysql.connector.connect(
    host="hospital-db.c9nzenfd5ofs.ap-south-1.rds.amazonaws.com",
    user="kira",
    password="kira1801",
    database="project"
)
cursor = db.cursor()
file = open('hospital-db.sql')
sql = file.read()

for result in cursor.execute(sql, multi=True):
  if result.with_rows:
    print("Rows produced by statement '{}':".format(
      result.statement))
    print(result.fetchall())
  else:
    print("Number of rows affected by statement '{}': {}".format(
      result.statement, result.rowcount))
