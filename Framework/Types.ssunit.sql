/**
 * \file
 * \brief  The public user defined types.
 * \author Chris Oldwood
 */

/**
 * The fully qualified name of a stored procedure.
 */

create type ssunit.ProcedureName from varchar(128);
go

/**
 * The name of an object schema.
 */

create type ssunit.SchemaName from varchar(32);
go

/**
 * The fully qualified name of a table.
 */

create type ssunit.TableName from varchar(128);
go

/**
 * A text message, such as the reason for a test failure.
 */

create type ssunit.TextMessage from varchar(max);
go
