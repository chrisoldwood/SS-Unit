/**
 * \file
 * \brief  The GetDateTimeValue user-defined function.
 * \author Chris Oldwood
 */

if (object_id('dbo.GetDateTimeValue') is not null)
	drop function dbo.GetDateTimeValue;
go

/**
 * An example UDF that returns a datetime value.
 */

create function dbo.GetDateTimeValue()
	returns datetime
as
begin
	return '2001-01-01 01:01:01.010';
end
go
