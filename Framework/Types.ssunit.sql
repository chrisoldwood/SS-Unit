/**
 * \file
 * \brief  The public user defined types.
 * \author Chris Oldwood
 */

/**
 * The name of an object's schema.
 */

create type ssunit.SchemaName from varchar(128);
go

/**
 * The fully qualified name of a stored procedure. The type includes space for
 * the schema name, separator and procedure name (128 + 1 + 128).
 */

create type ssunit.ProcedureName from varchar(257);
go

/**
 * The fully qualified name of a table. The type includes space for the schema
 * name, separator and table name (128 + 1 + 128).
 */

create type ssunit.TableName from varchar(257);
go

/**
 * A text message, such as the reason for a test failure.
 */

create type ssunit.TextMessage from varchar(max);
go

/**
 * The version number as a single integer. For example v1.5.0 is
 * represented as the integer 150. This allows for the standard
 * arithmetic operators to be used for comparison.
 */

create type ssunit.Version from int;
go
