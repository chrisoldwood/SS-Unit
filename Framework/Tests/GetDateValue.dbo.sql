/**
 * \file
 * \brief  The GetDateValue user-defined function.
 * \author Chris Oldwood
 */

if (object_id('dbo.GetDateValue') is not null)
	drop function dbo.GetDateValue;
go

/**
 * An example UDF that returns a date value.
 */

create function dbo.GetDateValue()
	returns date
as
begin
	return '2001-01-01';
end
go
