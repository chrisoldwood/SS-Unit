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

create procedure test._$Fixture6$_@FixtureSetUp@_
as
	create table test.TestCounter
	(
		Value	int
	);

	insert into test.TestCounter(Value) values(1);
go

create procedure test._$Fixture6$_@FixtureTearDown@_
as
	drop table test.TestCounter;
go

create procedure test._$Fixture6$_@TestSetUp@_
as
	update test.TestCounter
	set	   Value = Value + 10;
go

create procedure test._$Fixture6$_@TestTearDown@_
as
	update test.TestCounter
	set	   Value = Value + 100;
go

create procedure test._$Fixture6$_ShouldPassWithAtTestAtSuffix_@Test@_
as
	declare @value int;
	select	@value = Value from test.TestCounter;

	declare @passed bit = case when (@value = 11 or @value = 121) then 1 else 0 end;

	exec ssunit.AssertTrue @passed;
go

create procedure test._$Fixture6$_@Test@_ShouldPassWithAtTestAtOnNeitherEnd
as
	declare @value int;
	select	@value = Value from test.TestCounter;

	declare @passed bit = case when (@value = 11 or @value = 121) then 1 else 0 end;

	exec ssunit.AssertTrue @passed;
go

create procedure test.AtHelperAtSuffixProcedure_@Helper@_
as
	exec ssunit.AssertPass;
go

create procedure test._@Test@_TestShouldPassAndDeleteAtHelperAtSuffixProcedure
as
	exec test.AtHelperAtSuffixProcedure_@Helper@_

	exec ssunit.AssertPass;
go

create procedure test._@Test@_$TestSchema$_Clear_ShouldPassByRemovingUserDefinedTypes
as
	if (type_id('unit_test.TestType') is not null)
		drop type unit_test.TestType;

	create type unit_test.TestType from tinyint;

	exec ssunit.TestSchema_Clear @schemaName = 'unit_test';

	declare @count int;

	select	@count = count(*)
	from	sys.schemas s
	join	sys.types t
	on		t.schema_id = s.schema_id
	where	s.name = 'unit_test'
	and		t.name = 'TestType'

	exec ssunit.AssertIntegerEqualTo 0, @count;
go

exec ssunit.RunTests;
go
