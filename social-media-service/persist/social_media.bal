import ballerina/persist as _;
import ballerina/time;

type User record {|
    readonly int id;
    string name;
    time:Date birthDate;
    Post[] posts;
|};

type Post record {|
    readonly int id;
    string description;
    string tags;
    string category;
    time:Date created_date;
    User user;
|};
