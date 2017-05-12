-- create Client Profile Database authenticated_users table

DROP TABLE if exists authenticated_users;
create table authenticated_users 
(
user_id int not null AUTO_INCREMENT,
username varchar(50),
password_hash varchar(50),
primary key(user_id)
);
