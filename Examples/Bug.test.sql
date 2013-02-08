/**
 * \file
 * \brief  Unit tests for the Bug table and objects.
 * \author Chris Oldwood
 */

create procedure test._@FixtureSetUp@_$Bug$_
as
	create table test.Actual
	(
		BugId	pub.BugId_t		not null,
		Summary	pub.BodyText_t	not null,
	);

	create table test.Expected
	(
		BugId	pub.BugId_t		not null,
		Summary	pub.BodyText_t	not null,
	);
go

create procedure test._@FixtureTearDown@_$Bug$_
as
	drop table test.Expected;
	drop table test.Actual;
go

create procedure test._@Helper@_$Bug$_AddUser
	@userId		pub.UserId_t	= 99,
	@loginName	pub.LoginName_t	= 'test'
as
	set identity_insert dbo.SystemUser on;

	insert into dbo.SystemUser(UserId,  LoginName,  FirstName, LastName)
	                   values (@userId, @loginName, 'test',    'test');

	set identity_insert dbo.SystemUser off;
go

create procedure test._@Helper@_$Bug$_AddBug
	@userId		pub.UserId_t	= 99,
	@bugId		pub.BugId_t		= 42,
	@summary	pub.BodyText_t	= 'test summary'
as
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

	exec test._@Helper@_$Bug$_AddUser @userId;
	exec test._@Helper@_$Bug$_AddBug @userId, 42, 'test summary';
	exec test._@Helper@_$Bug$_AddBug @userId, 43, 'another';

	insert into Actual
	exec pub.Bug_FindBugsSubmittedByUser @userId;

	insert into Expected(BugId, Summary)
                  select 43,    'another'
	    union all select 42,    'test summary'

	exec ssunit.AssertTableEqualTo 'test.Expected', 'test.Actual';
go

exec ssunit.RunTests;
