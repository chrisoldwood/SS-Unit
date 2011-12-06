/**
 * \file   Bug.test.sql
 * \brief  Unit tests for the Bug table and objects.
 * \author Chris Oldwood
 */

create procedure test._@FixtureSetUp@_$Bug$_
as
	create table test.BugResults
	(
		BugId	int				not null,
		Summary	varchar(256)	not null,
	);
go

create procedure test._@FixtureTearDown@_$Bug$_
as
	drop table test.BugResults;
go

create procedure test._@TestSetUp@_$Bug$_
as
	declare @userId int = 99;
	declare @loginName varchar(50) = 'test';

	set identity_insert dbo.SystemUser on;

	insert into dbo.SystemUser(UserId, LoginName, FirstName, LastName)
	                   values (@userId, @loginName, 'test', 'test');

	set identity_insert dbo.SystemUser off;

	declare @bugId int = 42;
	declare @summary varchar(50) = 'test summary';

	set identity_insert dbo.Bug on;

	insert into dbo.Bug(BugId, Summary, SubmitUserId)
				 values(@bugId, @summary, @userId);

	set identity_insert dbo.Bug off;
go

create procedure test._@TestTearDown@_$Bug$_
as
	delete from dbo.Bug;
	delete from dbo.SystemUser;
go

create procedure test.InsertInvalidUser
as
	declare @invalidUserId int = -1;

	insert into dbo.Bug(Summary, SubmitUserId)
	             values('test',  @invalidUserId);
go

create procedure test._@Test@_$Bug$_InsertingBug_ShouldThrow_WhenInvalidUserSpecified
as
	exec ssunit.AssertThrew '%foreign%key%constraint%SubmitUserId%', 'test.InsertInvalidUser';
go

create procedure test._@Test@_$Bug$_FindBugsSubmittedByUser_ShouldReturnBugIdAndSummary
as
	declare @userId int = 99;
	declare @bugId int = 42;
	declare @summary varchar(50) = 'test summary';

	insert into BugResults
	exec dbo.Bug_FindBugsSubmittedByUser @userId;

	declare @count int;
	select	@count = count(*) from BugResults
	where	BugId = @bugId and Summary = @summary;

	exec ssunit.AssertIntegerEqualTo 1, @count;
go

exec ssunit.RunTests;
