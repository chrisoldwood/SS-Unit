/**
 * \file
 * \brief  The boolean user defined type.
 * \author Chris Oldwood
 */

/**
 * The boolean type.
 */

create type ssunit.Bool from bit;
go

/**
 * The type for the boolean as a string.
 */

create type ssunit.BoolDisplayString from varchar(5);
go

/*
 * The boolean type implementation.
 */

if (object_id('ssunit.False') is not null)
	drop function ssunit.False;
go

if (object_id('ssunit.True') is not null)
	drop function ssunit.True;
go

if (object_id('ssunit.Bool_ToString') is not null)
	drop function ssunit.Bool_ToString;
go

/**
 * The boolean constant for 'false'.
 */

create function ssunit.False()
	returns tinyint
as
begin
	return 0;
end
go

/**
 * The boolean constant for 'true'.
 */

create function ssunit.True() returns
	tinyint
as
begin
	return 1;
end
go

/**
 * The function to convert the enumeration value into a string.
 */

create function ssunit.Bool_ToString
(
	@value	ssunit.Bool		--!< The value.
)
	returns ssunit.BoolDisplayString
as
begin
	return
	case @value
		when ssunit.False() then	'false'
		when ssunit.True()  then	'true'
		else						'UNDEFINED'
	end
end
go
