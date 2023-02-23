import ballerina/time;
import ballerina/constraint;
import ballerina/http;

type NewUser record {|
    @constraint:String {
        minLength: 2
    }
    string name;
    time:Date birthDate;
|};

type UserNotFound record {|
    *http:NotFound;
    ErrorDetails body;
|};

type UserCreated record {|
    *http:Created;
    record {
        string message;
    } body;
|};
