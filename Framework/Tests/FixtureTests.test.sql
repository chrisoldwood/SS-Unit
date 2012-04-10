/**
 * \file
 * \brief  Tests for the fixture features such as SetUp & TearDown.
 * \author Chris Oldwood
 */

exec ssunit.TestSchema_Clear;
go

create procedure test._@Test@_FixturelessTest_ShouldExecuteAnd_ShouldPass
as
	exec ssunit.AssertPass;
go

create procedure test._@FixtureSetUp@_$Fixture1$_FixtureSetUp
as
	create table test.TestCounter
	(
		Value	int
	);

	insert into test.TestCounter(Value) values(1);
go

create procedure test._@FixtureTearDown@_$Fixture1$_FixtureTearDown
as
	drop table test.TestCounter;
go

create procedure test._@TestSetUp@_$Fixture1$_TestSetUp
as
	update test.TestCounter
	set	   Value = Value + 10;
go

create procedure test._@TestTearDown@_$Fixture1$_TestTearDown
as
	update test.TestCounter
	set	   Value = Value + 100;
go

create procedure test._@Test@_$Fixture1$_ShouldPass_WhenTestSetUpAndTearDownAreInvoked_1
as
	declare @value int;
	select	@value = Value from test.TestCounter;

	declare @passed bit = case when (@value = 11 or @value = 121) then 1 else 0 end;

	exec ssunit.AssertTrue @passed;
go

create procedure test._@Test@_$Fixture1$_ShouldPass_WhenTestSetUpAndTearDownAreInvoked_2
as
	declare @value int;
	select	@value = Value from test.TestCounter;

	declare @passed bit = case when (@value = 11 or @value = 121) then 1 else 0 end;

	exec ssunit.AssertTrue @passed;
go

create procedure test._@TestSetUp@_$Fixture2$_TestSetUp
as
	raiserror('error raised from test set up', 16, 1);
go

create procedure test._@Test@_$Fixture2$_TestShouldFail_WhenErrorThrownFromTestSetUp
as
	exec ssunit.AssertFail 'Test should not have been invoked';
go

create procedure test._@TestTearDown@_$Fixture3$_TestTearDown
as
	raiserror('error raised from test tear down', 16, 1);
go

create procedure test._@Test@_$Fixture3$_TestShouldFail_WhenErrorThrownFromTestTearDown
as
	exec ssunit.AssertPass;
go

create procedure test._@Helper@_HelperProcedure
as
	exec ssunit.AssertPass;
go

create procedure test._@Test@_TestShouldPassAndDeleteHelperProcedure
as
	exec test._@Helper@_HelperProcedure;

	exec ssunit.AssertPass;
go

create procedure test._@FixtureSetUp@_$Fixture4$_FixtureSetUp
as
	raiserror('fixture set-up failure', 16, 1);
go

create procedure test._@Test@_$Fixture4$_TestShouldFail_WhenFixtureSetUpThrows
as
	exec ssunit.AssertPass;
go

create procedure test._@FixtureTearDown@_$Fixture5$_FixtureTearDown
as
	raiserror('fixture tear-down failure', 16, 1);
go

create procedure test._@Test@_$Fixture5$_TestShouldFail_WhenFixtureTearDownThrows
as
	exec ssunit.AssertPass;
go

exec ssunit.RunTests;
