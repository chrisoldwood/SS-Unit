/**
 * \file   TestOutcome_ToString.ssunit.sql
 * \brief  The TestOutcome_ToString user defined function.
 * \author Chris Oldwood
 */

if (object_id('ssunit.TestOutcome_ToString') is not null)
	drop function ssunit.TestOutcome_ToString;
go

/**
 * The function to convert the enumeration value into a string.
 */

create function ssunit.TestOutcome_ToString
(
	@value	ssunit.TestOutcome	--!< The enumeration value.
)
	returns varchar(10)
as
begin
	return
	case @value
		when ssunit.TestOutcome_Unknown() then	'Unknown'
		when ssunit.TestOutcome_Passed() then	'Passed'
		when ssunit.TestOutcome_Failed() then	'FAILED'
		else									'UNDEFINED'
	end
end
go
