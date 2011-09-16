/**
 * \file   BugStatus.dbo.sql
 * \brief  The BugStatus enumeration.
 * \author Chris Oldwood
 */

if (object_id('dbo.BugStatus_Open') is not null)
	drop function dbo.BugStatus_Open;
go

if (object_id('dbo.BugStatus_Resolved') is not null)
	drop function dbo.BugStatus_Resolved;
go

if (object_id('dbo.BugStatus_Closed') is not null)
	drop function dbo.BugStatus_Closed;
go

if (object_id('dbo.BugStatus_ToString') is not null)
	drop function dbo.BugStatus_ToString;
go

/**
 * The BugStatus enumeration symbol for Open.
 */

create function dbo.BugStatus_Open()
	returns tinyint
as
begin
	return 1;
end
go

/**
 * The BugStatus enumeration symbol for Resolved.
 */

create function dbo.BugStatus_Resolved()
	returns tinyint
as
begin
	return 2;
end
go

/**
 * The BugStatus enumeration symbol for Closed.
 */

create function dbo.BugStatus_Closed()
	returns tinyint
as
begin
	return 3;
end
go

/**
 * The function to convert the enumeration value into a string.
 */

create function dbo.BugStatus_ToString
(
	@value	tinyint		--!< The enumeration value.
)
	returns varchar(10)
as
begin
	return
	case @value
		when dbo.BugStatus_Open()		then	'Open'
		when dbo.BugStatus_Resolved()	then	'Resolved'
		when dbo.BugStatus_Closed()		then	'Closed'
		else									'UNDEFINED'
	end
end
go
