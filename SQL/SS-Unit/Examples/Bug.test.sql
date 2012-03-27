/**
 * \file
 * \brief  Unit tests for the Bug table and objects.
 * \author Chris Oldwood
 */

create procedure test._@FixtureSetUp@_$Bug$_
as
	create table test.BugResults
	(
		BugId	pub.BugId_t		not null,
		Summary	pub.BodyText_t	not null,
	);
go

create procedure test._@FixtureTearDown@_$Bug$_
as
	drop table test.BugResults;
go

create procedure test._@TestSetUp@_$Bug$_
as
	declare @userId pub.UserId_t = 99;
	declare @loginName pub.LoginName_t = 'test';

	set identity_insert dbo.SystemUser on;

	insert into dbo.SystemUser(UserId, LoginName, FirstName, LastName)
	                   values (@userId, @loginName, 'test', 'test');

	set identity_insert dbo.SystemUser off;

	declare @bugId pub.BugId_t = 42;
	declare @summary pub.BodyText_t = 'test summary';

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

create procedure test._@Helper@_InsertInvalidUser
as
	declare @invalidUserId pub.UserId_t = -1;

	insert into dbo.Bug(Summary, SubmitUserId)
	             values('test',  @invalidUserId);
go

create procedure test._@Test@_$Bug$_InsertingBug_ShouldThrow_WhenInvalidUserSpecified
as
	exec ssunit.AssertThrew '%foreign%key%constraint%SubmitUserId%', 'test._@Helper@_InsertInvalidUser';
go

create procedure test._@Helper@_InsertInvalidBugStatus
as
	declare @invalidBugStatus pub.BugStatus_t = 255;

	insert into dbo.Bug(Summary, SubmitUserId, BugStatus)
	             values('test',  99,           @invalidBugStatus);
go

create procedure test._@Test@_$Bug$_InsertingBug_ShouldThrow_WhenInvalidBugStatusSpecified
as
	exec ssunit.AssertThrew '%Bug_Check_BugStatus%', 'test._@Helper@_InsertInvalidBugStatus';
go

create procedure test._@Test@_$Bug$_FindBugsSubmittedByUser_ShouldReturnBugIdAndSummary
as
	declare @userId pub.UserId_t = 99;
	declare @bugId pub.BugId_t = 42;
	declare @summary pub.BodyText_t = 'test summary';

	insert into BugResults
	exec pub.Bug_FindBugsSubmittedByUser @userId;

	declare @count int;
	select	@count = count(*) from BugResults
	where	BugId = @bugId and Summary = @summary;

	exec ssunit.AssertIntegerEqualTo 1, @count;
go

exec ssunit.RunTests;
