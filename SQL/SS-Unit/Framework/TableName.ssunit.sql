/**
 * \file   TableName.ssunit.sql
 * \brief  The TableName user defined type.
 * \author Chris Oldwood
 */

/**
 * The type used to store the fully qualified name of a table.
 */

create type ssunit.TableName from varchar(128);
go
