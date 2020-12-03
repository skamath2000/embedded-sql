import cx_Oracle
import pandas as pd

"""

Some quick start guides:
* cx_Oracle 8: https://cx-oracle.readthedocs.io/en/latest/user_guide/installation.html
* pandas: https://pandas.pydata.org/pandas-docs/stable/user_guide/10min.html
"""
def checkInput(prompt):
	query = input(prompt)
	try:
		query = int(query);
	except ValueError:
		print('You have entered an invalid choice.')
		return -1;
	if (query < 1 or query > 5):
		print('You have entered an invalid choice.')
		return -1
	else:
		return query

def performQuery(query):
	if (query == 1):
		cursor.execute("""
    		SELECT c.* 
    		FROM Client c, Requirement r
    		WHERE c.clientNo = r.clientNo AND r.hours = 2
    		""")

	elif (query == 2):
		cursor.execute("""
			SELECT e.*
		    FROM Equipment e, Use u
		    WHERE e.equipmentNo = u.equipmentNo 
		    AND u.useDate < TO_DATE('01-JAN-21', 'DD-MON-YY')
		    """)

	elif (query == 3):
		cursor.execute("""
			SELECT staffNo, SUM(hours) as totalHours
		    FROM Service 
		    GROUP BY(staffNo)
		    """)

	elif (query == 4):
		cursor.execute("""
			SELECT r.*
		    FROM Requirement r, Service s, Staff st 
		    WHERE st.salary > 30000 AND st.staffNo = s.staffNo AND s.requirementNo = r.requirementNo
		    """)

	elif (query == 5):
		cursor.execute("""
			SELECT u.*, e.cost/u.hours as costPerHour
		    FROM Use u, Equipment e 
		    WHERE u.equipmentNo = e.equipmentNo
		    """)

	else:
		print("Error has occurred")

# TODO change path of Oracle Instant Client to yours
cx_Oracle.init_oracle_client(lib_dir = "./instantclient_19_8")

# TODO change credentials
# Connect as user "user" with password "mypass" to the "CSC423" service
# running on lawtech.law.miami.edu
connection = cx_Oracle.connect(
    "sakacsc423", "Cocoarani123", "lawtech.law.miami.edu/CSC_423")
cursor = connection.cursor()

prompt = "Enter the number of the query you would like to do.\n1. List the details of all clients that have requirements with 2 hours of cleaning per day.\n2. List the details of equipment that have been used for a requirement before 2021.\n3. List the total hours each staff member has worked along with the staff numbers.\n4. List the details of all requirements worked on by a staff member with a salary above 30000.\n5. List the details of all equipment usage and cost per hour for each use.\n"

query = checkInput(prompt)
while (query == -1):
	print("Please choose again\n")
	query = checkInput(prompt)

performQuery(query)
# get column names from cursor
columns = [c[0] for c in cursor.description]
# fetch data
data = cursor.fetchall()
# bring data into a pandas dataframe for easy data transformation
df = pd.DataFrame(data, columns = columns)
print(df) # examine
print(df.columns)
# print(df['FIRST_NAME']) # example to extract a column

