/*******************************************************************************
**! \file   GetStringValue.dbo.sql
**! \brief  The GetStringValue user-defined function.
**! \author Chris Oldwood
**/

if (object_id('dbo.GetStringValue') is not null)
	drop function dbo.GetStringValue;
go

/*******************************************************************************
** An example UDF that returns a string value.
**/

create function dbo.GetStringValue()
	returns varchar(max)
as
begin
	return '42';
end
go
