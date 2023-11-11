#!/usr/bin/env python
#!/miniconda/bin/python
#!/usr/bin/python
# https://docs.python-zeep.org/en/master/
#import xmltodict
from zeep import Client
from requests import Session
from requests.auth import HTTPBasicAuth  # or HTTPDigestAuth, or OAuth1, etc.
from zeep.transports import Transport
import pyodbc
import logging.config

# logging.config.dictConfig({
#     'version': 1,
#     'formatters': {
#         'verbose': {
#             'format': '%(name)s: %(message)s'
#         }
#     },
#     'handlers': {
#         'console': {
#             'level': 'DEBUG',
#             'class': 'logging.StreamHandler',
#             'formatter': 'verbose',
#         },
#     },
#     'loggers': {
#         'zeep.transports': {
#             'level': 'DEBUG',
#             'propagate': True,
#             'handlers': ['console'],
#         },
#     }
# })


# https://docs.python-zeep.org/en/master/transport.html?highlight=authentication#http-authentication
session = Session()
# session.auth = HTTPBasicAuth('MGEdonReportsws@plex.com','9f45e3d-67ed-')
session.auth = HTTPBasicAuth('BuscheAlbionWs2@plex.com','6afff48-ba19-')
# User Name: BuscheAlbionWs2@plex.com 
# Password: 6afff48-ba19- 
# UserName: BuscheAvillaKorsws@plex.com 
# Password: 5b11b45-f59f- 
# User Name: BuscheFranklinKorsWs@plex.com 
# Password: 0a1da8b-71e 
# UserName: BuscFruitportKorsWs@plex.com 
# Password: ef4606b-adb1- 

client = Client(wsdl='Plex_SOAP_test.wsdl',transport=Transport(session=session))
# https://docs.python-zeep.org/en/master/datastructures.html
e_type = client.get_type('ns0:ExecuteDataSourceRequest')
a_ip_type = client.get_type('ns0:ArrayOfInputParameter')
ip_type=client.get_type('ns0:InputParameter')
Report_Date=ip_type(Value='2022-04-28 08:00:00',Name='@Report_Date',Required=False,Output=False)
End_Date=ip_type(Value='2022-04-28 08:59:59',Name='@End_Date',Required=False,Output=False)


Parameters=a_ip_type([Report_Date,End_Date])

# e=e_type(DataSourceKey=8619,InputParameters=[{'Value':'4/26/2022','Name':'@Report_Date','Required':False,'Output':False}],DataSourceName='Detailed_Production_Get_New')
e=e_type(DataSourceKey=8619,InputParameters=Parameters,DataSourceName='Detailed_Production_Get_New')


response = client.service.ExecuteDataSource(e)
# print(response['OutputParameters'])

# rs = response['ResultSets'].ResultSet[0].Rows.Row[0]
# print(rs.Columns.Column[2].Value)
# print(rs.Columns.Column[5].Value)
# rec = [(rs.Columns.Column[2].Value,rs.Columns.Column[5].Value)]

result = response['ResultSets'].ResultSet[0].Rows.Row
length=len(result)
# print("Length=% s" % length)
logging.error("Length=% s" % length)

# rs = response['ResultSets'].ResultSet[0].Rows.Row[0]

# rec = [(rs.Columns.Column[2].Value,rs.Columns.Column[5].Value)]
# rec.append((rs.Columns.Column[2].Value,rs.Columns.Column[5].Value))
# print(rec)

list = response['ResultSets'].ResultSet[0].Rows.Row
print("Length=% s" % len(list))
# Using for loop
for i in list:
    column_names=""
    column_values=""
    dic ={}
    ind=0
    for j in i.Columns.Column:
      column_names=column_names+j.Name+','
      if j.Value is None:
        column_values=column_values+','  
      else:
        column_values=column_values+j.Value+','
      dic.update({j.Name:ind}) 
      print(dic)
      logging.error(str(ind) + '-' + j.Name)
      print(str(ind) + '-' + j.Name)
    # print(column_names)
      # word_freq.update({'before': 23})
      ind=ind+1
    # print(column_names)
    # print(column_values)
# for i in list:
#     for j in i.Columns.Column:
#       print(j.Value)
    # print(i.Columns.Column[2].Name,i.Columns.Column[2].Value) part-key
    # print(i.Columns.Column[5].Name,i.Columns.Column[5].Value) 
#     rec.append((306766,i.Columns.Column[2].Value,i.Columns.Column[5].Value))

# print(rec)
rs = response['ResultSets'].ResultSet[0].Rows.Row[0]
PCN = 306766
rec=[]
for i in list:
  # rec.append((rs.Columns.Column[0].Value))
  # rec = [(rs.Columns.Column[0].Value)]
  rec.append((PCN,i.Columns.Column[18].Value,i.Columns.Column[1].Value,i.Columns.Column[2].Value,i.Columns.Column[9].Value))
# rec.append((rs.Columns.Column[2].Value,rs.Columns.Column[5].Value))
  print(rec)
  logging.error(rec)

try:
#server = 'tcp:mgsqlmi.public.48d444e7f69b.database.windows.net,3342' 
# database = 'mgdw' 
  username = 'mgadmin' 
  password = 'WeDontSharePasswords1!' 
  conn = pyodbc.connect('DSN=dw;UID='+username+';PWD='+ password + ';DATABASE=mgdw')

  cursor = conn.cursor()
  #Sample select query
  query ='''insert into Validation.Detailed_Production_History (pcn)
  values (2)'''
  # cursor.execute(query) 

  im ='''insert into Validation.Detailed_Production_History (pcn,production_no)
  values (?,?)'''

  ins ='''insert into Validation.Detailed_Production_History (pcn,production_no,part_no,part_key,record_date)
  values (?,?,?,?,?)'''

  print(ins)
  cursor.executemany(ins,rec)
  cursor.commit()
  cursor.close()
  conn.close()

#   rec = [(1, 2),
#  (1, 1),
#  (1, 1),
#  (1, 1),
#  (1, 0)]
  # print(im)
  # cursor.executemany(im,rec)
# https://towardsdatascience.com/how-i-made-inserts-into-sql-server-100x-faster-with-pyodbc-5a0b5afdba5
  # cursor.executemany(ins,rec)
  # cursor.executemany(im,rec)
# #   cursor.executemany(im, [(1, 2),
# #  (1, 1),
# #  (1, 1),
# #  (1, 1),
# #  (1, 0)])
#   # cursor.executemany(im,[(1)]) 
#   cursor.commit()
#   # cursor.executemany(insert_query, records_to_insert)
#   print(cursor.rowcount, "Record inserted successfully into Laptop table")

#   # cursor.execute('insert into Validation.Detailed_Production_History (pcn) values (12345)') 
#   # cursor.execute("SELECT @@version;") 

#   # cursor.execute('insert into Validation.Detailed_Production_History (pcn) values (12345)') 
#   # cursor.commit()
#   # print(cursor.rowcount)

# #   insert_query = """insert into Validation.Detailed_Production_History (pcn)
# #                             VALUES (%i) """
# #   sql = """
# # insert into Table1(field1, field2, field3) values (?, ?, ?)
# # """
                          
# #   records_to_insert = [(1),(2),(3)]
# #   cursor.executemany('insert into Validation.Detailed_Production_History(pcn) VALUES (?)', [1,2,3])
#   # cursor.commit()
#   # cursor.executemany(insert_query, records_to_insert)
#   print(cursor.rowcount, "Record inserted successfully into Laptop table")
# # https://towardsdatascience.com/how-i-made-inserts-into-sql-server-100x-faster-with-pyodbc-5a0b5afdba5
# # row = cursor.fetchone() 
# # while row: 
# #     print(row[0])
# #     row = cursor.fetchone()

except pyodbc.Error as ex:
  # exception.PyODBCError(ex)  
  sqlstate = ex.args[0]
  # if sqlstate == '28000':
  #     print("LDAP Connection failed: check password")

finally:
  print('end')
  # conn.close()
# # insert into Validation.detailed_production_history
# # values
# # print(response['ResultSets'].ResultSet[0].Rows.Row[100].Columns.Column[0].Value)
# # print(response['ResultSets'].ResultSet[0].Rows.Row[100].Columns.Column[0].Value)

# for word in response:
#     print(word)

# #python -mzeep Plex_SOAP_test.wsdl
# # https://www.youtube.com/watch?v=JBYEQjg_znI
# # request = '<ExecuteDataSourceRequest xmlns="http://www.plexus-online.com/DataSource"><DataSourceKey>8619</DataSourceKey><InputParameters><InputParameter><Value>4/26/2022</Value><Name>@Report_Date</Name><Required>false</Required><Output>false</Output></InputParameter></InputParameters><DataSourceName>Detailed_Production_Get_New</DataSourceName></ExecuteDataSourceRequest>'

# # request = '''<ExecuteDataSourceRequest xmlns="http://www.plexus-online.com/DataSource">
# #     <DataSourceKey>8619</DataSourceKey>
# #     <InputParameters>
# #       <InputParameter>
# #         <Value>4/26/2022</Value>
# #         <Name>@Report_Date</Name>
# #         <Required>false</Required>
# #         <Output>false</Output>
# #       </InputParameter>
# #     </InputParameters>
# #     <DataSourceName>Detailed_Production_Get_New</DataSourceName>
# #   </ExecuteDataSourceRequest>'''
# # print(request)
# # client.service.ExecuteDataSource(request)