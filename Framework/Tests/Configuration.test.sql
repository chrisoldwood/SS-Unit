/**
 * \file
 * \brief  Tests for the configuration table and procedures.
 * \author Chris Oldwood
 */

exec ssunit.TestSchema_Clear;
go

create procedure test._@Helper@_SetSchemaNameDefaultToNull
as
	exec ssunit.Configuration_SetSchemaNameDefault null;
go

create procedure test._@Test@_$Configuration$_SetSchemaNameDefault_ShouldThrow_WhenValueIsNull
as
	exec ssunit.AssertThrew '%invalid schema name%', 'test._@Helper@_SetSchemaNameDefaultToNull';
go

create procedure test._@Test@_$Configuration$_SetSchemaNameDefault_ShouldSetValue
as
	declare @oldValue ssunit.SchemaName;
	select	@oldValue = c.SchemaName from ssunit.Configuration c;

	declare @expected ssunit.SchemaName = 'unit test';

	exec ssunit.Configuration_SetSchemaNameDefault @expected;

	declare @actual ssunit.SchemaName;
	select	@actual = c.SchemaName from ssunit.Configuration c;
	
	exec ssunit.AssertStringEqualTo @expected, @actual;

	exec ssunit.Configuration_SetSchemaNameDefault @oldValue;
go

create procedure test._@Helper@_SetDisplayWidthDefaultToNull
as
	exec ssunit.Configuration_SetDisplayWidthDefault null;
go

create procedure test._@Test@_$Configuration$_SetDisplayWidthDefault_ShouldThrow_WhenValueIsNull
as
	exec ssunit.AssertThrew '%invalid display width%', 'test._@Helper@_SetDisplayWidthDefaultToNull';
go

create procedure test._@Helper@_SetDisplayWidthDefaultToNegativeValue
as
	exec ssunit.Configuration_SetDisplayWidthDefault -80;
go

create procedure test._@Test@_$Configuration$_SetDisplayWidthDefault_ShouldThrow_WhenValueIsNegative
as
	exec ssunit.AssertThrew '%invalid display width%', 'test._@Helper@_SetDisplayWidthDefaultToNegativeValue';
go

create procedure test._@Helper@_SetDisplayWidthDefaultToZero
as
	exec ssunit.Configuration_SetDisplayWidthDefault 0;
go

create procedure test._@Test@_$Configuration$_SetDisplayWidthDefault_ShouldThrow_WhenValueIsZero
as
	exec ssunit.AssertThrew '%invalid display width%', 'test._@Helper@_SetDisplayWidthDefaultToZero';
go

create procedure test._@Test@_$Configuration$_SetDisplayWidthDefault_ShouldSetValue
as
	declare @oldValue int;
	select	@oldValue = c.DisplayWidth from ssunit.Configuration c;

	declare @expected int = 123456789;

	exec ssunit.Configuration_SetDisplayWidthDefault @expected;

	declare @actual int;
	select	@actual = c.DisplayWidth from ssunit.Configuration c;
	
	exec ssunit.AssertIntegerEqualTo @expected, @actual;

	exec ssunit.Configuration_SetDisplayWidthDefault @oldValue;
go

create procedure test._@Helper@_SetReportResultsDefaultToNull
as
	exec ssunit.Configuration_SetReportResultsDefault null;
go

create procedure test._@Test@_$Configuration$_SetReportResultsDefault_ShouldThrow_WhenValueIsNull
as
	exec ssunit.AssertThrew '%invalid ''report results'' flag%', 'test._@Helper@_SetReportResultsDefaultToNull';
go

create procedure test._@Helper@_SetReportResultsDefaultToInvalidValue
as
	exec ssunit.Configuration_SetReportResultsDefault 255;
go

create procedure test._@Test@_$Configuration$_SetReportResultsDefault_ShouldThrow_WhenValueIsInvalid
as
	exec ssunit.AssertThrew '%invalid ''report results'' flag%', 'test._@Helper@_SetReportResultsDefaultToInvalidValue';
go

create procedure test._@Test@_$Configuration$_SetReportResultsDefault_ShouldSetValue
as
	declare @oldValue ssunit.ReportCondition;
	select	@oldValue = c.ReportResults from ssunit.Configuration c;

	declare @expected ssunit.ReportCondition = ssunit.ReportCondition_Never();

	exec ssunit.Configuration_SetReportResultsDefault @expected;

	declare @actual ssunit.ReportCondition;
	select	@actual = c.ReportResults from ssunit.Configuration c;
	
	exec ssunit.AssertIntegerEqualTo @expected, @actual;

	exec ssunit.Configuration_SetReportResultsDefault @oldValue;
go

create procedure test._@Helper@_SetReportSummaryDefaultToNull
as
	exec ssunit.Configuration_SetReportSummaryDefault null;
go

create procedure test._@Test@_$Configuration$_SetReportSummaryDefault_ShouldThrow_WhenValueIsNull
as
	exec ssunit.AssertThrew '%invalid ''report summary'' flag%', 'test._@Helper@_SetReportSummaryDefaultToNull';
go

create procedure test._@Helper@_SetReportSummaryDefaultToInvalidValue
as
	exec ssunit.Configuration_SetReportSummaryDefault 255;
go

create procedure test._@Test@_$Configuration$_SetReportSummaryDefault_ShouldThrow_WhenValueIsInvalid
as
	exec ssunit.AssertThrew '%invalid ''report summary'' flag%', 'test._@Helper@_SetReportSummaryDefaultToInvalidValue';
go

create procedure test._@Test@_$Configuration$_SetReportSummaryDefault_ShouldSetValue
as
	declare @oldValue ssunit.ReportCondition;
	select	@oldValue = c.ReportSummary from ssunit.Configuration c;

	declare @expected ssunit.ReportCondition = ssunit.ReportCondition_Never();

	exec ssunit.Configuration_SetReportSummaryDefault @expected;

	declare @actual ssunit.ReportCondition;
	select	@actual = c.ReportSummary from ssunit.Configuration c;
	
	exec ssunit.AssertIntegerEqualTo @expected, @actual;

	exec ssunit.Configuration_SetReportSummaryDefault @oldValue;
go

exec ssunit.RunTests;
