/**
 * \file
 * \brief  Non-automated unit tests for checking the test runner output options.
 * \author Chris Oldwood
 * \note   These tests should be run manaully with a text mode client.
 */

create procedure test._@Test@_ShouldPass
as
	exec ssunit.AssertPass;
go

set nocount on;
select	'' as [=========== Normal Output ===========]
go

exec ssunit.RunTests @isInteractive = 0;
go

set nocount on;
select	'' as [=========== Reduced Display Width ===========]
go

create procedure test._@Test@_ShouldPass
as
	exec ssunit.AssertPass;
go

exec ssunit.RunTests @isInteractive = 0,
					 @displayWidth = 20;

set nocount on;
select	'' as [=========== No Output ===========]
go

create procedure test._@Test@_ShouldPass
as
	exec ssunit.AssertPass;
go

declare @never ssunit.ReportCondition = ssunit.ReportCondition_Never();

exec ssunit.RunTests @isInteractive = 0,
					 @reportResults = @never,
					 @reportSummary = @never;

set nocount on;
select	'' as [=========== Results Only ===========]
go

create procedure test._@Test@_ShouldPass
as
	exec ssunit.AssertPass;
go

declare @never ssunit.ReportCondition = ssunit.ReportCondition_Never();

exec ssunit.RunTests @isInteractive = 0,
					 @reportSummary = @never;

set nocount on;
select	'' as [=========== Summary Only ===========]
go

create procedure test._@Test@_ShouldPass
as
	exec ssunit.AssertPass;
go

declare @never ssunit.ReportCondition = ssunit.ReportCondition_Never();

exec ssunit.RunTests @isInteractive = 0,
					 @reportResults = @never;

set nocount on;
select	'' as [=========== Results & Summary Only On Failure - No Failure ===========]
go

create procedure test._@Test@_ShouldPass
as
	exec ssunit.AssertPass;
go

declare @onFailure ssunit.ReportCondition = ssunit.ReportCondition_OnFailure();

exec ssunit.RunTests @isInteractive = 0,
					 @reportResults = @onFailure,
					 @reportSummary = @onFailure;

set nocount on;
select	'' as [=========== Results & Summary Only On Failure - With Failure ===========]
go

create procedure test._@Test@_ShouldFail
as
	exec ssunit.AssertFail 'Report results & summary';
go

declare @onFailure ssunit.ReportCondition = ssunit.ReportCondition_OnFailure();

exec ssunit.RunTests @isInteractive = 0,
					 @reportResults = @onFailure,
					 @reportSummary = @onFailure;
