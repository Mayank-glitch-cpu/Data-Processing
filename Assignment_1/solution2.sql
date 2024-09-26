CREATE TABLE Genres (
    "GenreID" integer NOT NULL,
    "Name" text NOT NULL
);

CREATE TABLE HasAGenre (
    "MovieID" integer,
    "GenreID" integer
);

CREATE TABLE Movies (
    "MovieID" integer NOT NULL,
    "Title" text NOT NULL
);

CREATE TABLE Ratings (
    "UserID" integer NOT NULL,
    "MovieID" integer NOT NULL,
    ratings numeric(1,0) NOT NULL,
    "Timestamp" bigint,
    CONSTRAINT value_range_check CHECK (((ratings >= (0)::numeric) AND (ratings <= (5)::numeric)))
);

CREATE TABLE Taginfo (
    "TagId" integer NOT NULL,
    "Content" text
);

CREATE TABLE Tags (
    "UserID" integer,
    "MovieID" integer,
    "TagID" integer,
    "timestamp" bigint
);

CREATE TABLE Users (
    "UserID" integer NOT NULL,
    "Name" text
);

ALTER TABLE ONLY Genres
    ADD CONSTRAINT "Genres_pkey" PRIMARY KEY ("GenreID");

ALTER TABLE ONLY Movies
    ADD CONSTRAINT "Movies_pkey" PRIMARY KEY ("MovieID");	

ALTER TABLE ONLY Taginfo
    ADD CONSTRAINT "Taginfo_pkey" PRIMARY KEY ("TagId");

ALTER TABLE ONLY Users
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY ("UserID");

ALTER TABLE ONLY HasAGenre
    ADD CONSTRAINT "Genres_ID" FOREIGN KEY ("GenreID") REFERENCES Genres("GenreID");

ALTER TABLE ONLY Tags
    ADD CONSTRAINT "Movie-id" FOREIGN KEY ("MovieID") REFERENCES Movies("MovieID");

ALTER TABLE ONLY Ratings
    ADD CONSTRAINT "MoviesID" FOREIGN KEY ("MovieID") REFERENCES Movies("MovieID") NOT VALID;

ALTER TABLE ONLY HasAGenre
    ADD CONSTRAINT "Movies_id" FOREIGN KEY ("MovieID") REFERENCES Movies("MovieID");	

ALTER TABLE ONLY Tags
    ADD CONSTRAINT "TagID" FOREIGN KEY ("TagID") REFERENCES Taginfo("TagId");
	
ALTER TABLE ONLY Ratings
    ADD CONSTRAINT "UserID" FOREIGN KEY ("UserID") REFERENCES Users("UserID") NOT VALID;

ALTER TABLE ONLY Tags
    ADD CONSTRAINT "User_ID" FOREIGN KEY ("UserID") REFERENCES Users("UserID");
