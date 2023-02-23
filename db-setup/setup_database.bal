import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

// Initializes the database as a prerequisite to `Database Access` samples.
public function main() returns sql:Error? {
    mysql:Client mysqlClient = check new (host = "localhost", port = 3306, user = "root", password = "dummypassword");

    // Creates `albums` table in the database.
    _ = check mysqlClient->execute(`CREATE TABLE social_media_database.User (
                                        id INT NOT NULL,
                                        name VARCHAR(191) NOT NULL,
                                        birthDate DATE NOT NULL,
                                        PRIMARY KEY(id)
                                    );`);

    // Creates `albums` table in the database.
    _ = check mysqlClient->execute(`CREATE TABLE social_media_database.Post (
                                        id INT NOT NULL,
                                        description VARCHAR(191) NOT NULL,
                                        tags VARCHAR(191) NOT NULL,
                                        category VARCHAR(191) NOT NULL,
                                        created_date DATE NOT NULL,
                                        userId INT NOT NULL,
                                        CONSTRAINT FK_POST_USER FOREIGN KEY(userId) REFERENCES User(id),
                                        PRIMARY KEY(id)
                                    );`);

    // Adds the records to the `albums` table.
    _ = check mysqlClient->execute(`INSERT INTO social_media_database.user(id, birth_date, name)
                                    VALUES(1, CURDATE(), "Ranga");`);
    _ = check mysqlClient->execute(`INSERT INTO social_media_database.user(id, birth_date, name)
                                    VALUES(2, CURDATE(), 'Ravi');`);
    _ = check mysqlClient->execute(`INSERT INTO social_media_database.user(id, birth_date, name)
                                    VALUES(3, CURDATE(), 'Satish');`);                               


    // Adds the records to the `artists` table.
    _ = check mysqlClient->execute(`INSERT INTO social_media_database.post(id, description, category, created_date, tags, user_id)
                                    VALUES (1, 'I want to learn AWS', 'education', CURDATE(), 'aws, cloud, learn',1);`);
    _ = check mysqlClient->execute(`INSERT INTO social_media_database.post(id, description, category, created_date, tags, user_id)
                                    VALUES (2, 'I want to learn DevOps', 'education', CURDATE(), 'devops, infra, learn', 1);`);
    _ = check mysqlClient->execute(`INSERT INTO social_media_database.post(id, description, category, created_date, tags, user_id)
                                    VALUES (3, 'I want to learn GCP', 'education', CURDATE(), 'gcp, google, learn', 2);`);
    _ = check mysqlClient->execute(`INSERT INTO social_media_database.post(id, description, category, created_date, tags, user_id)
                                    VALUES (4, 'I want to learn multi cloud', 'education', CURDATE(), 'gcp, aws, azure, infra, learn', 3);`);

    check mysqlClient.close();
}