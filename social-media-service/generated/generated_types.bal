// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for social_media.
// It should not be modified by hand.

import ballerina/time;

public type User record {|
    readonly int id;
    string name;
    time:Date birthDate;
|};

public type UserInsert User;

public type UserUpdate record {|
    string name?;
    time:Date birthDate?;
|};

public type Post record {|
    readonly int id;
    string description;
    string tags;
    string category;
    time:Date created_date;
    int userId;
|};

public type PostInsert Post;

public type PostUpdate record {|
    string description?;
    string tags?;
    string category?;
    time:Date created_date?;
    int userId?;
|};

public type Follower record {|
    readonly int id;
    time:Date created_date;
    int userId;
|};

public type FollowerInsert Follower;

public type FollowerUpdate record {|
    time:Date created_date?;
    int userId?;
|};

