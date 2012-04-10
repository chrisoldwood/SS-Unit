/**
 * \file
 * \brief  The private user defined types.
 * \author Chris Oldwood
 */

/**
 * The name of a test fixture. The fixture name is used to group together tests
 * for the same 'module' and provides a convenient mechansim for factoring out
 * the performance burden of common SetUp & TearDown helper procedures.
 */

create type ssunit_impl.FixtureName from varchar(128);
go
