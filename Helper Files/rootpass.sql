use mysql;
UPDATE user SET `authentication_string` = PASSWORD('root') WHERE `User` = 'root';
UPDATE mysql.user SET plugin = 'mysql_native_password' WHERE User='root';
flush privileges;
quit