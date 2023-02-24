import ballerina/http;

type NewPost record {|
    string description;
    string tags;
    string category;
|};

type PostForbidden record {|
    *http:Forbidden;
    ErrorDetails body;
|};

type PostCreated record {|
    *http:Created;
    record {
        string message;
    } body;
|};
