DROP DATABASE IF EXISTS test;
CREATE USER IF NOT EXISTS "${MYSQL_USER}"@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
GRANT ALL PRIVILEGES ON *.* TO "${MYSQL_USER}"@'%';
FLUSH PRIVILEGES;
