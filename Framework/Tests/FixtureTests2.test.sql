/**
 * \file
 * \brief  Additional tests for the fixture features such as SetUp & TearDown.
 * \author Chris Oldwood
 */

exec ssunit.TestSchema_Clear;
go

create table test.FixtureLevelTable
(
	Value	int	not null,
);
go

create procedure test._@FixtureSetUp@_$TheFixture$_
as
	--exec test._@FixtureTearDown@_$TheFixture$_;

	insert into test.FixtureLevelTable(Value) values(1);
go

create procedure test._@FixtureTearDown@_$TheFixture$_
as
	insert into test.FixtureLevelTable(Value) values(2);
go

create procedure test._@TestSetUp@_$TheFixture$_
as
	--exec test._@TestTearDown@_$TheFixture$_;

	insert into test.FixtureLevelTable(Value) values(3);
go

create procedure test._@TestTearDown@_$TheFixture$_
as
	insert into test.FixtureLevelTable(Value) values(4);
go

create procedure test._@Test@_$TheFixture$_ShouldPass_WhenTearDownWasExecutedBeforeTheTest_1
as
	declare @rowCount int;

	select	@rowCount = count(Value)
	from	test.FixtureLevelTable;

	declare @passed bit = case when @rowCount in (4, 7) then 1 else 0 end;

	exec ssunit.AssertTrue @passed;
go

create procedure test._@Test@_$TheFixture$_ShouldPass_WhenTearDownWasExecutedBeforeTheTest_2
as
	declare @rowCount int;

	select	@rowCount = count(Value)
	from	test.FixtureLevelTable;

	declare @passed bit = case when @rowCount in (4, 7) then 1 else 0 end;

	exec ssunit.AssertTrue @passed;
go

exec ssunit.RunTests @tearDownFirst = 1;
go
