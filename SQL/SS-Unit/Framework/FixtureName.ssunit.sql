/**
 * \file   FixtureName.ssunit.sql
 * \brief  The FixtureName user defined type.
 * \author Chris Oldwood
 */

/**
 * The type used to store the name of a test fixture.
 */

create type ssunit.FixtureName from varchar(128);
go
