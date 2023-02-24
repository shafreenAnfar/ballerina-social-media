// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for social_media.
// It should not be modified by hand.

import ballerina/persist;
import ballerina/sql;
import ballerina/time;
import ballerinax/mysql;

const USER = "user";
const POST = "post";
const FOLLOWER = "follower";

public client class SocialMediaClient {
    *persist:AbstractPersistClient;

    private final mysql:Client dbClient;

    private final map<persist:SQLClient> persistClients;

    private final record {|persist:Metadata...;|} metadata = {
        "user": {
            entityName: "User",
            tableName: `User`,
            fieldMetadata: {
                id: {columnName: "id", 'type: int},
                name: {columnName: "name", 'type: string},
                birthDate: {columnName: "birthDate", 'type: time:Date}
            },
            keyFields: ["id"]
        },
        "post": {
            entityName: "Post",
            tableName: `Post`,
            fieldMetadata: {
                id: {columnName: "id", 'type: int},
                description: {columnName: "description", 'type: string},
                tags: {columnName: "tags", 'type: string},
                category: {columnName: "category", 'type: string},
                created_date: {columnName: "created_date", 'type: time:Date},
                userId: {columnName: "userId", 'type: int}
            },
            keyFields: ["id"]
        },
        "follower": {
            entityName: "Follower",
            tableName: `Follower`,
            fieldMetadata: {
                id: {columnName: "id", 'type: int},
                created_date: {columnName: "created_date", 'type: time:Date},
                userId: {columnName: "userId", 'type: int}
            },
            keyFields: ["id"]
        }
    };

    public function init() returns persist:Error? {
        mysql:Client|error dbClient = new (host = host, user = user, password = password, database = database, port = port);
        if dbClient is error {
            return <persist:Error>error(dbClient.message());
        }
        self.dbClient = dbClient;
        self.persistClients = {
            user: check new (self.dbClient, self.metadata.get(USER)),
            post: check new (self.dbClient, self.metadata.get(POST)),
            follower: check new (self.dbClient, self.metadata.get(FOLLOWER))
        };
    }

    isolated resource function get user() returns stream<User, persist:Error?> {
        stream<record {}, sql:Error?>|persist:Error result = self.persistClients.get(USER).runReadQuery(User);
        if result is persist:Error {
            return new stream<User, persist:Error?>(new UserStream((), result));
        } else {
            return new stream<User, persist:Error?>(new UserStream(result));
        }
    }

    isolated resource function get user/[int id]() returns User|persist:Error {
        User|error result = (check self.persistClients.get(USER).runReadByKeyQuery(User, id)).cloneWithType(User);
        if result is error {
            return <persist:Error>error(result.message());
        }
        return result;
    }

    isolated resource function post user(UserInsert[] data) returns int[]|persist:Error {
        _ = check self.persistClients.get(USER).runBatchInsertQuery(data);
        return from UserInsert inserted in data
            select inserted.id;
    }

    isolated resource function put user/[int id](UserUpdate value) returns User|persist:Error {
        _ = check self.persistClients.get(USER).runUpdateQuery(id, value);
        return self->/user/[id].get();
    }

    isolated resource function delete user/[int id]() returns User|persist:Error {
        User result = check self->/user/[id].get();
        _ = check self.persistClients.get(USER).runDeleteQuery(id);
        return result;
    }

    isolated resource function get post() returns stream<Post, persist:Error?> {
        stream<record {}, sql:Error?>|persist:Error result = self.persistClients.get(POST).runReadQuery(Post);
        if result is persist:Error {
            return new stream<Post, persist:Error?>(new PostStream((), result));
        } else {
            return new stream<Post, persist:Error?>(new PostStream(result));
        }
    }

    isolated resource function get post/[int id]() returns Post|persist:Error {
        Post|error result = (check self.persistClients.get(POST).runReadByKeyQuery(Post, id)).cloneWithType(Post);
        if result is error {
            return <persist:Error>error(result.message());
        }
        return result;
    }

    isolated resource function post post(PostInsert[] data) returns int[]|persist:Error {
        _ = check self.persistClients.get(POST).runBatchInsertQuery(data);
        return from PostInsert inserted in data
            select inserted.id;
    }

    isolated resource function put post/[int id](PostUpdate value) returns Post|persist:Error {
        _ = check self.persistClients.get(POST).runUpdateQuery(id, value);
        return self->/post/[id].get();
    }

    isolated resource function delete post/[int id]() returns Post|persist:Error {
        Post result = check self->/post/[id].get();
        _ = check self.persistClients.get(POST).runDeleteQuery(id);
        return result;
    }

    isolated resource function get follower() returns stream<Follower, persist:Error?> {
        stream<record {}, sql:Error?>|persist:Error result = self.persistClients.get(FOLLOWER).runReadQuery(Follower);
        if result is persist:Error {
            return new stream<Follower, persist:Error?>(new FollowerStream((), result));
        } else {
            return new stream<Follower, persist:Error?>(new FollowerStream(result));
        }
    }

    isolated resource function get follower/[int id]() returns Follower|persist:Error {
        Follower|error result = (check self.persistClients.get(FOLLOWER).runReadByKeyQuery(Follower, id)).cloneWithType(Follower);
        if result is error {
            return <persist:Error>error(result.message());
        }
        return result;
    }

    isolated resource function post follower(FollowerInsert[] data) returns int[]|persist:Error {
        _ = check self.persistClients.get(FOLLOWER).runBatchInsertQuery(data);
        return from FollowerInsert inserted in data
            select inserted.id;
    }

    isolated resource function put follower/[int id](FollowerUpdate value) returns Follower|persist:Error {
        _ = check self.persistClients.get(FOLLOWER).runUpdateQuery(id, value);
        return self->/follower/[id].get();
    }

    isolated resource function delete follower/[int id]() returns Follower|persist:Error {
        Follower result = check self->/follower/[id].get();
        _ = check self.persistClients.get(FOLLOWER).runDeleteQuery(id);
        return result;
    }

    public function close() returns persist:Error? {
        error? result = self.dbClient.close();
        if result is error {
            return <persist:Error>error(result.message());
        }
        return result;
    }
}

public class UserStream {

    private stream<anydata, sql:Error?>? anydataStream;
    private persist:Error? err;

    public isolated function init(stream<anydata, sql:Error?>? anydataStream, persist:Error? err = ()) {
        self.anydataStream = anydataStream;
        self.err = err;
    }

    public isolated function next() returns record {|User value;|}|persist:Error? {
        if self.err is persist:Error {
            return <persist:Error>self.err;
        } else if self.anydataStream is stream<anydata, sql:Error?> {
            var anydataStream = <stream<anydata, sql:Error?>>self.anydataStream;
            var streamValue = anydataStream.next();
            if streamValue is () {
                return streamValue;
            } else if (streamValue is sql:Error) {
                return <persist:Error>error(streamValue.message());
            } else {
                User|error value = streamValue.value.cloneWithType(User);
                if value is error {
                    return <persist:Error>error(value.message());
                }
                record {|User value;|} nextRecord = {value: value};
                return nextRecord;
            }
        } else {
            return ();
        }
    }

    public isolated function close() returns persist:Error? {
        check persist:closeEntityStream(self.anydataStream);
    }
}

public class PostStream {

    private stream<anydata, sql:Error?>? anydataStream;
    private persist:Error? err;

    public isolated function init(stream<anydata, sql:Error?>? anydataStream, persist:Error? err = ()) {
        self.anydataStream = anydataStream;
        self.err = err;
    }

    public isolated function next() returns record {|Post value;|}|persist:Error? {
        if self.err is persist:Error {
            return <persist:Error>self.err;
        } else if self.anydataStream is stream<anydata, sql:Error?> {
            var anydataStream = <stream<anydata, sql:Error?>>self.anydataStream;
            var streamValue = anydataStream.next();
            if streamValue is () {
                return streamValue;
            } else if (streamValue is sql:Error) {
                return <persist:Error>error(streamValue.message());
            } else {
                Post|error value = streamValue.value.cloneWithType(Post);
                if value is error {
                    return <persist:Error>error(value.message());
                }
                record {|Post value;|} nextRecord = {value: value};
                return nextRecord;
            }
        } else {
            return ();
        }
    }

    public isolated function close() returns persist:Error? {
        check persist:closeEntityStream(self.anydataStream);
    }
}

public class FollowerStream {

    private stream<anydata, sql:Error?>? anydataStream;
    private persist:Error? err;

    public isolated function init(stream<anydata, sql:Error?>? anydataStream, persist:Error? err = ()) {
        self.anydataStream = anydataStream;
        self.err = err;
    }

    public isolated function next() returns record {|Follower value;|}|persist:Error? {
        if self.err is persist:Error {
            return <persist:Error>self.err;
        } else if self.anydataStream is stream<anydata, sql:Error?> {
            var anydataStream = <stream<anydata, sql:Error?>>self.anydataStream;
            var streamValue = anydataStream.next();
            if streamValue is () {
                return streamValue;
            } else if (streamValue is sql:Error) {
                return <persist:Error>error(streamValue.message());
            } else {
                Follower|error value = streamValue.value.cloneWithType(Follower);
                if value is error {
                    return <persist:Error>error(value.message());
                }
                record {|Follower value;|} nextRecord = {value: value};
                return nextRecord;
            }
        } else {
            return ();
        }
    }

    public isolated function close() returns persist:Error? {
        check persist:closeEntityStream(self.anydataStream);
    }
}

