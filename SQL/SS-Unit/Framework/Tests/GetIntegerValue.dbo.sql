/**
 * \file
 * \brief  The GetIntegerValue user-defined function.
 * \author Chris Oldwood
 */

if (object_id('dbo.GetIntegerValue') is not null)
	drop function dbo.GetIntegerValue;
go

/**
 * An example UDF that returns an integer value.
 */

create function dbo.GetIntegerValue()
	returns int
as
begin
	return 42;
end
go
