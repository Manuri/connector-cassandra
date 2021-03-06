package ballerina.data.cassandra;

@Description { value: "Parameter struct represents a query parameter for the queries specified in connector actions."}
@Field {value:"cqlType: The cassandra data type of the corresponding parameter"}
@Field {value:"value: Value of paramter pass into the query"}
public struct Parameter {
    Type cqlType;
    any value;
}

@Description { value: "ConnectionProperties structs represents the properties which are used to configure cassandra connection."}
@Field {value:"consistencyLevel: Determines how many nodes in the replica must respond for the coordinator node to
successfully process a non-lightweight transaction. Supported values are ANY, ONE, TWO, THREE, QUORUM,
 ALL, LOCAL_QUORUM, EACH_QUORUM, SERIAL, LOCAL_SERIAL, LOCAL_ONE"}
@Field {value:"sslEnabled: Enables the use of SSL for the created Cluster"}
@Field {value:"fetchSize:Sets the default fetch size to use for SELECT queries"}
public struct ConnectionProperties {
    string consistencyLevel;
    boolean sslEnabled;
    int fetchSize = -1;
}


@Description { value:"The Datatype of the parameter"}
@Field { value:"INT: A 32-bit signed integer"}
@Field { value:"BIGINT: A 64-bit signed long"}
@Field { value:"VARINT: Arbitrary precision integer"}
@Field { value:"FLOAT: A 32-bit IEEE-754 floating point"}
@Field { value:"DOUBLE: A 64-bit IEEE-754 floating point"}
@Field { value:"TEXT: UTF-8 encoded string"}
@Field { value:"BOOLEAN: Boolean value either True or false"}
@Field { value:"LIST: A collection of one or more ordered elements"}
public enum Type {
    INT,
    BIGINT,
    VARINT,
    FLOAT,
    DOUBLE,
    TEXT,
    BOOLEAN,
    LIST
}


@Description { value:"Cassandra client connector."}
@Param { value:"host:Comma seperate list of addresses of Cassandra nodes which are used to discover the cluster topology" }
@Param { value:"options: Optional properties for cassandra connection" }
public connector ClientConnector (string host, ConnectionProperties options) {

    map sharedMap = {};

    @Description {value:"Select data from cassandra datasource."}
    @Param {value:"query: Query to be executed"}
    @Param { value:"parameters: Parameter array used with the given query" }
    @Return { value:"Result set for the given query" }
    native action select (string query, Parameter[] parameters) (datatable);

    @Description {value:"Execute update query on cassandra datasource."}
    @Param {value:"query: Query to be executed"}
    @Param { value:"parameters: Parameter array used with the given query" }
    native action update (string query, Parameter[] parameters);

    @Description { value:"The close action implementation to shutdown the cassandra connections."}
    native action close ();
}
