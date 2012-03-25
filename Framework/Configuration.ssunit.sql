/**
 * \file   Configuration.ssunit.sql
 * \brief  The Configuration table.
 * \author Chris Oldwood
 */

if (object_id('ssunit.Configuration') is not null)
	drop table ssunit.Configuration;
go

/**
 * The global configuration data for use when running the tests. These settings
 * provide the baseline for the runner and can be overriden when invoking
 * ssunit.RunTests.
 */

create table ssunit.Configuration
(
	--! The schema used for the tests.
	SchemaName		ssunit.SchemaName	null,

	--! The width of the console in batch mode.
	DisplayWidth	int					null,

	--! Return the per-test results?
	ReportResults	bit					null,

	--! Return the test result summary?
	ReportSummary	bit					null,
);
go

insert into ssunit.Configuration
	  (SchemaName, DisplayWidth, ReportResults, ReportSummary)
select 'test',     80,           1,             1
