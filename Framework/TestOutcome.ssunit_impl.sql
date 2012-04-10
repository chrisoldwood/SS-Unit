/**
 * \file
 * \brief  The TestOutcome user defined type.
 * \author Chris Oldwood
 */

/**
 * The enumeration used for the outcome of a test.
 */

create type ssunit_impl.TestOutcome from tinyint;
go

/**
 * The type for the test outcome enumeration as a string.
 */

create type ssunit_impl.TestOutcomeDisplayString from varchar(10);
go

/*
 * The test outcome enumeration type implementation.
 */

if (object_id('ssunit_impl.TestOutcome_Unknown') is not null)
	drop function ssunit_impl.TestOutcome_Unknown;
go

if (object_id('ssunit_impl.TestOutcome_Passed') is not null)
	drop function ssunit_impl.TestOutcome_Passed;
go

if (object_id('ssunit_impl.TestOutcome_Failed') is not null)
	drop function ssunit_impl.TestOutcome_Failed;
go

if (object_id('ssunit_impl.TestOutcome_ToString') is not null)
	drop function ssunit_impl.TestOutcome_ToString;
go

/**
 * The TestOutcome enumeration symbol for a test that is inconclusive.
 */

create function ssunit_impl.TestOutcome_Unknown()
	returns tinyint
as
begin
	return 1;
end
go

/**
 * The TestOutcome enumeration symbol for a test that has 'passed'.
 */

create function ssunit_impl.TestOutcome_Passed() returns
	tinyint
as
begin
	return 2;
end
go

/**
 * The TestOutcome enumeration symbol for a test that has 'failed'.
 */

create function ssunit_impl.TestOutcome_Failed() returns
	tinyint
as
begin
	return 3;
end
go

/**
 * The function to convert the enumeration value into a string.
 */

create function ssunit_impl.TestOutcome_ToString
(
	@value	ssunit_impl.TestOutcome	--!< The enumeration value.
)
	returns ssunit_impl.TestOutcomeDisplayString
as
begin
	return
	case @value
		when ssunit_impl.TestOutcome_Unknown() then	'Unknown'
		when ssunit_impl.TestOutcome_Passed()  then	'Passed'
		when ssunit_impl.TestOutcome_Failed()  then	'FAILED'
		else										'UNDEFINED'
	end
end
go
