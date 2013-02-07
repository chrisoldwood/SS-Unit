/**
 * \file
 * \brief  Manual tests for the fixture features such as SetUp & TearDown.
 * \author Chris Oldwood
 */

/*
exec ssunit.TestSchema_Clear;
go

create procedure test._@FixtureSetUp@_$Fixture1$_v1
as
go

create procedure test._@FixtureTearDown@_$Fixture1$_v1
as
go

create procedure test._@TestSetUp@_$Fixture1$_v1
as
go

create procedure test._@TestTearDown@_$Fixture1$_v1
as
go

create procedure test._@FixtureSetUp@_$Fixture1$_v2
as
go

create procedure test._@FixtureTearDown@_$Fixture1$_v2
as
go

create procedure test._@TestSetUp@_$Fixture1$_v2
as
go

create procedure test._@TestTearDown@_$Fixture1$_v2
as
go

create procedure test._@Test@_$Fixture1$_TestRunner_ShouldFail_WhenDuplicateSetUpTearDownExists
as
	exec ssunit.AssertFail 'Should not execute';
go

exec ssunit.RunTests;
go
*/

/*
exec ssunit.TestSchema_Clear;
go

create table test.TestCounter
(
	Value	int
);

insert into test.TestCounter(Value) values(1);
go

create procedure test._@FixtureSetUp@_$Fixture$_
as
go

create procedure test._@FixtureTearDown@_$Fixture$_
as
	update test.TestCounter
	set	   Value = Value + 100;
go

create procedure test._@TestSetUp@_$Fixture$_
as
go

create procedure test._@TestTearDown@_$Fixture$_
as
	update test.TestCounter
	set	   Value = Value + 10;
go

create procedure test._@Test@_$Fixture$_TestRunner_ShouldFail_WhenDuplicateSetUpTearDownExists
as
	declare @actual int;
	select	@actual = Value from test.TestCounter;

	exec ssunit.AssertIntegerEqualTo 111, @actual;
go

declare @true ssunit.Bool = ssunit.True();

exec ssunit.RunTests @tearDownFirst = @true;
go
*/

/*
exec ssunit.TestSchema_Clear;
go

create procedure test._@InvalidAttribute@_
as
go

exec ssunit.RunTests;
go
*/
