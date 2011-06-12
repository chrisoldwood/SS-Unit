/*******************************************************************************
**! \file   TestOutcome.ssunit.sql
**! \brief  The TestOutcome user defined type.
**! \author Chris Oldwood
**/

/*******************************************************************************
** The enumeration used for the outcome of a test.
**/

create type ssunit.TestOutcome from tinyint;
go
