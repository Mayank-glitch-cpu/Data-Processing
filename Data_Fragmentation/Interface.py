import pandas as pd
import psycopg2
import numpy as np 
# df=pd.read_csv('ratings.dat',delimiter="::")
# print(df.head())

def load_ratings(filepath,dbconfig):
   # Step1: read file
   try:
     ratings= pd.read_csv(filepath,delimiter='::',header=None, engine='python')
     ratings.columns = ['UserID','MovieID','Rating','TimeStamp']
    #  ratings=ratings['UserID','MovieID','Rating']
    #  df= pd.DataFrame(ratings)
    #  df.head()
   except Exception as e:
      print(f"Rendering Error: {e}")
   # Step 2 Connect to postgreSQL
   try:
      conn= psycopg2.connect(**dbconfig)
      cursor= conn.cursor()

      # step3 Create Table if not exsist

      create_table_query= """
      Create Table IF NOT EXISTS Ratings(
      UserID INTEGER,
      MovieID INTEGER,
      Rating numeric CHECK(Rating BETWEEN 0 AND 5 AND MOD(Rating*10,5)=0)
      )
      """
      cursor.execute(create_table_query)
      conn.commit()
    
      # Step4 Insert values into the table
      for _,row in ratings.iterrows():
        cursor.execute(
           "INSERT INTO Ratings (UserID,MovieID,Rating) VALUES (%s,%s,%s)",
           (int(row['UserID']),int(row['MovieID']),float(row['Rating']))
        )

      # commit all transactions
      conn.commit()
      print("Data has been succefully Loaded into the Database")
   except Exception as e:
      print(f'database Error : {e}')

   finally:
      cursor.close()
      conn.close()  

def Range_partition(N,dbconfig):
    range_width= 5/N

    try:
       # establish the connection
       conn= psycopg2.connect(**dbconfig)
       cursor=conn.cursor()
        # Creating partitions
       for i in range(N):
          lower_bound= i*range_width
          upper_bound= (i+1)*range_width
          
          # naming the partitions
          partition_table= f"Ratings_partition_{i+1}"
          cursor.execute(f"drop table if exists {partition_table}")

          #insert into partition query
          create_partition_query=f"""
          Create Table {partition_table} AS
          Select * from Ratings
          where rating >= {lower_bound} and rating <= {upper_bound}
          """
          cursor.execute(create_partition_query)
          print(f"Partition{i+1} created for range {lower_bound} to {upper_bound}")
       conn.commit()  
       print("All partitions are created Succesfully")  

    except Exception as e:
       print(f'error: {e}')
    
    finally:
       cursor.close()
       conn.close()

def roundrobinpartition(N,dbconfig):
   # establish the connection
    try:
        conn= psycopg2.connect(**dbconfig)
        cursor= conn.cursor()
    
        # Create N tables
        for i in range(N):
            Partition_name= f"Ratings_round_robin_{i+1}"
            cursor.execute(f"drop table if exists {Partition_name}")
            create_table_query= f"""
            Create Table {Partition_name} (
            UserID Integer,
            movieID Integer,
            Rating Float)
            """
            cursor.execute(create_table_query)
            print(f"Partition {i+1} created")
        conn.commit()
        print("All tables are created Succesfully")

        # Fetch all the data from the main table
        cursor.execute("SELECT * FROM Ratings")
        data= cursor.fetchall()

        # Insert data into the partitions
        for i in range(len(data)):
            cursor.execute(f"INSERT INTO Ratings_round_robin_{i%N +1}  VALUES (%s,%s,%s)",
                           (data[i][0],data[i][1],data[i][2]))
        # commit all the transactions
        conn.commit()

        print("Data has been inserted into the partitions")

    except Exception as e:
        print(f'error: {e}')
    finally:
        cursor.close()
        conn.close()

def roundrobininsert(dbconfig,UserId,MovieID,Rating):
    try:
        conn= psycopg2.connect(**dbconfig)
        cursor= conn.cursor()

        # Fetch the number of partitions
        cursor.execute("SELECT COUNT(*) FROM information_schema.tables WHERE table_name LIKE 'Ratings_round_robin%'")
        N= cursor.fetchone()[0]

        # Insert data into the partitions
        cursor.execute(f"INSERT INTO Ratings_round_robin_{UserId%N +1} VALUES (%s,%s,%s)",
                       (UserId,MovieID,Rating))
        conn.commit()
        print("Data has been inserted into the partition")

    except Exception as e:
        print(f'error: {e}')
    finally:
        cursor.close()
        conn.close()

def Range_insert(dbconfig,UserId,MovieID,Rating):
    try:
        conn= psycopg2.connect(**dbconfig)
        cursor= conn.cursor()

        # Fetch the number of partitions
        cursor.execute("SELECT COUNT(*) FROM information_schema.tables WHERE table_name LIKE 'Ratings_partition%'")
        N= cursor.fetchone()[0]

        # Insert data into the partitions
        cursor.execute(f"INSERT INTO Ratings_partition_{UserId%N +1} VALUES (%s,%s,%s)",
                       (UserId,MovieID,Rating))
        conn.commit()
        print("Data has been inserted into the partition")

    except Exception as e:
        print(f'error: {e}')
    finally:
        cursor.close()
        conn.close()        

# what is fetchone and fetchall
# fetchone() method returns the next row of a query result set, returning a single sequence, or None when no more data is available.


def deletepartitions(dbconfig):
    try:
        conn= psycopg2.connect(**dbconfig)
        cursor= conn.cursor()

        # Fetch the number of partitions
        cursor.execute("SELECT COUNT(*) FROM information_schema.tables WHERE table_name LIKE 'Ratings_partition%'")
        N= cursor.fetchone()[0]

        # Delete all the partitions
        for i in range(N):
            cursor.execute(f"DROP TABLE IF EXISTS Ratings_partition_{i+1}")
            print(f"Partition {i+1} deleted")
        conn.commit()
        print("All partitions are deleted")

    except Exception as e:
        print(f'error: {e}')
    finally:
        cursor.close()
        conn.close()

dbconfig={
   'dbname': 'assignement_3',
   'user' : 'postgres',
   'password':'mayank@2310',
   'host':'localhost',
   'port':'5432'
}

load_ratings('text_data.txt',dbconfig)
Range_partition(5,dbconfig)
roundrobinpartition(5,dbconfig) 
roundrobininsert(dbconfig,1,1,1)