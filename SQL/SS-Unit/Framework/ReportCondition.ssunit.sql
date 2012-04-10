/**
 * \file
 * \brief  The ReportCondition user defined type.
 * \author Chris Oldwood
 */

/**
 * The enumeration used to control the reporting of test results.
 */

create type ssunit.ReportCondition from tinyint;
go

/**
 * The type for the report condition enumeration as a string.
 */

create type ssunit.ReportConditionDisplayString from varchar(10);
go

/*
 * The report condition enumeration type implementation.
 */

if (object_id('ssunit.ReportCondition_Never') is not null)
	drop function ssunit.ReportCondition_Never;
go

if (object_id('ssunit.ReportCondition_Always') is not null)
	drop function ssunit.ReportCondition_Always;
go

if (object_id('ssunit.ReportCondition_OnFailure') is not null)
	drop function ssunit.ReportCondition_OnFailure;
go

if (object_id('ssunit.ReportCondition_IsValid') is not null)
	drop function ssunit.ReportCondition_IsValid
go

if (object_id('ssunit.ReportCondition_ToString') is not null)
	drop function ssunit.ReportCondition_ToString
go

/**
 * The ReportCondition enumeration symbol to disable the report.
 */

create function ssunit.ReportCondition_Never()
	returns ssunit.ReportCondition
as
begin
	return 1;
end
go

/**
 * The ReportCondition enumeration symbol to always generate the report.
 */

create function ssunit.ReportCondition_Always()
	returns ssunit.ReportCondition
as
begin
	return 2;
end
go

/**
 * The ReportCondition enumeration symbol to generate the report only when a
 * test failure occurs.
 */

create function ssunit.ReportCondition_OnFailure()
	returns ssunit.ReportCondition
as
begin
	return 3;
end
go

/**
 * Validate a ReportCondition enumeration value.
 */

create function ssunit.ReportCondition_IsValid
(
	@value	ssunit.ReportCondition		--!< The enumeration value.
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
 * Convert a ReportCondition enumeration value to a string.
 */

create function ssunit.ReportCondition_ToString
(
	@value	ssunit.ReportCondition		--!< The enumeration value.
)
	returns ssunit.ReportConditionDisplayString
as
begin
	return
	case @value
		when ssunit.ReportCondition_Never()		then 'Never'
		when ssunit.ReportCondition_Always()	then 'Always'
		when ssunit.ReportCondition_OnFailure()	then 'On failure'
		else									     'UNDEFINED'
	end
end
go
