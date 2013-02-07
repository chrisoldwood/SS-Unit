/**
 * \file
 * \brief  The private user defined types.
 * \author Chris Oldwood
 */

/**
 * The name of an attribute used to mark a procedure as special. Attributes
 * are used to annotate which procedures are tests or helpers.
 */

create type ssunit_impl.AttributeName from varchar(128);
go

/**
 * The name of a test fixture. The fixture name is used to group together tests
 * for the same 'module' and provides a convenient mechansim for factoring out
 * the performance burden of common SetUp & TearDown helper procedures.
 */

create type ssunit_impl.FixtureName from varchar(128);
go

/**
 * A comma-separated list of values.
 */

create type ssunit_impl.List from varchar(max);
go
