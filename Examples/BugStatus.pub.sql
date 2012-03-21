/**
 * \file
 * \brief  The BugStatus enumeration.
 * \author Chris Oldwood
 */

/**
 * The type for the bug status enumeration.
 */

create type pub.BugStatus_t from tinyint;
go

/**
 * The type for the bug status enumeration.
 */

create type pub.BugStatusDisplayString_t from varchar(10);
go

if (object_id('pub.BugStatus_Open') is not null)
	drop function pub.BugStatus_Open;
go

if (object_id('pub.BugStatus_Resolved') is not null)
	drop function pub.BugStatus_Resolved;
go

if (object_id('pub.BugStatus_Closed') is not null)
	drop function pub.BugStatus_Closed;
go

if (object_id('pub.BugStatus_IsValid') is not null)
	drop function pub.BugStatus_IsValid;
go

if (object_id('pub.BugStatus_ToString') is not null)
	drop function pub.BugStatus_ToString;
go

/**
 * The BugStatus enumeration symbol for Open.
 */

create function pub.BugStatus_Open()
	returns pub.BugStatus_t
as
begin
	return 1;
end
go

/**
 * The BugStatus enumeration symbol for Resolved.
 */

create function pub.BugStatus_Resolved()
	returns pub.BugStatus_t
as
begin
	return 2;
end
go

/**
 * The BugStatus enumeration symbol for Closed.
 */

create function pub.BugStatus_Closed()
	returns pub.BugStatus_t
as
begin
	return 3;
end
go

/**
 * The function to convert the enumeration value into a string.
 */

create function pub.BugStatus_IsValid
(
	@value	pub.BugStatus_t		--!< The enumeration value.
)
	returns bit
as
begin
	return 
	case 
		when @value between 1 and 3	then 1
		else						     0
	end
end
go

/**
 * The function to convert the enumeration value into a string.
 */

create function pub.BugStatus_ToString
(
	@value	pub.BugStatus_t		--!< The enumeration value.
)
	returns pub.BugStatusDisplayString_t
as
begin
	return
	case @value
		when pub.BugStatus_Open()		then	'Open'
		when pub.BugStatus_Resolved()	then	'Resolved'
		when pub.BugStatus_Closed()		then	'Closed'
		else									'UNDEFINED'
	end
end
go
