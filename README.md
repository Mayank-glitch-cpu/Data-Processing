# Data-Processing
It contains the coursework projects and assignments completed and submitted by me.
This Repo is solely made for knowledge purpose and discussing the errors and improving aspects of thr code.
Do not copy this repo for your assignment porpose.
## Assignemnt 1 and 2 
Problem: According to the database design made by you, the movie database includes multiple tables. In particular, you need to consider seven tables: users, movies, taginfo, genres, ratings, tags, hasagenre. In this phase, you must create these tables and load the corresponding data into these tables.

![ER-diagram](https://github.com/user-attachments/assets/cf0007ae-19c6-4078-8ba3-e83a1060f76d)


1. The description of the tables is as follows. You should also check the requirement in the given graphic description:

 

users: userid (int, primary key), name (text)

movies: movieid (integer, primary key), title (text)

taginfo: tagid (int, primary key), content (text)

genres: genreid (integer, primary key), name (text)

ratings: userid (int, foreign key), movieid (int, foreign key), rating (numeric), timestamp (bigint, seconds since midnight Coordinated Universal Time (UTC) of January 1, 1970)

tags: userid (int, foreign key), movieid (int, foreign key), tagid (int, foreign key), timestamp (bigint, seconds since midnight Coordinated Universal Time (UTC) of January 1, 1970).

hasagenre: movieid (int, foreign key), genreid (int, foreign key)

 

2. The requirement only tells you the name and data type of each attribute in each table. You need to figure out the primary keys, foreign keys, constraints or other necessary settings by yourself. The key information in the requirement is not complete and attributes can be primary keys and foreign keys at the same time.

You should assume the data has been loaded into the database. Then you need to implement the following SQL queries. For each query, we provide an example of the schema of the saved query result.

1. Write a SQL query to return the total number of movies for each genre. Your query result should be saved in a table called “query1” which has two attributes: name, moviecount.

q1

 ![q1](https://github.com/user-attachments/assets/f6d11b72-ee24-4261-a404-0213809dfd21)


2. Write a SQL query to return the average rating per genre. Your query result should be saved in a table called “query2” which has two attributes: name, rating.
q2

![q2](https://github.com/user-attachments/assets/29d84c26-06a6-43ef-a9eb-abb00f7cc148)

3. Write a SQL query to return the movies have at least 10 ratings. Your query result should be saved in a table called “query3” which has two attributes: title, countofratings.

q3

 
![q3](https://github.com/user-attachments/assets/59ef40b5-00ad-429f-9e96-0761fb4cf6e7)

 

4. Write a SQL query to return all “Comedy” movies, including movieid and title. Your query result should be saved in a table called “query4” which has two attributes, movieid and title.
q4
![q4](https://github.com/user-attachments/assets/a0e5a670-c8e7-454e-b93c-9ae4732dfe47)


5. Write a SQL query to return the average rating per movie. Your query result should be saved in a table called “query5” which has two attributes, title and average.

q5

 ![q5](https://github.com/user-attachments/assets/ce34fb60-a8f3-4a2b-89db-7b06528338db)


6. Write a SQL query to return the average rating for all “Comedy” movies. Your query result should be saved in a table called “query6” which has one attribute, average.
q6
![q6](https://github.com/user-attachments/assets/a8525318-7956-4660-80bb-b18bb9993c9a)


7. Write a SQL query to return the average rating for all movies and each of these movies is both “Comedy” and “Romance”. Your query result should be saved in a table called “query7” which has one attribute, average.

q7
![q7](https://github.com/user-attachments/assets/db9bbe77-6541-4fee-a8dd-61f15fd24f9e)

 

8. Write a SQL query to return the average rating for all movies and each of these movies is “Romance” but not “Comedy”. Your query result should be saved in a table called “query8” which has one attribute, average.
q8

 ![q8](https://github.com/user-attachments/assets/ccb8907d-7ff9-403b-a256-e2f469186d9b)


Locked image9. Find all movies that are rated by a User such that the userId is equal to v1. The v1 will be an integer parameter passed to the SQL query. Your query result should be saved in a table called “query9” which has two attributes, movieid and rating.
q9

 ![q9](https://github.com/user-attachments/assets/869156d1-1405-4517-b1a1-43797a502a38)
 


Above all, your script should be able to generate 9 tables, namely, “query1”, “query2”, …, “query9”.
 
