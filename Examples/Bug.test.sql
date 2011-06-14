/*******************************************************************************
**! \file   Bug.test.sql
**! \brief  Unit tests for the Bug table and objects.
**! \author Chris Oldwood
**/

create procedure test.InsertInvalidUser
as
	declare @invalidUserId int;
	set		@invalidUserId = -1;

	insert into dbo.Bug(Summary, SubmitUserId)
	             values('test',  @invalidUserId);
go

create procedure test._@Test@_Bug_ShouldThrow_WhenInvalidUserSpecified
as
	exec ssunit.AssertThrew '%foreign%key%constraint%SubmitUserId%', 'test.InsertInvalidUser';
go

/*******************************************************************************
** Helper procedures.
** NB: These have to be manually dropped at the moment.
**/

if (object_id('test.InsertUser') is not null)
	drop procedure test.InsertUser
go

create procedure test.InsertUser
(
	@userId		int,
	@loginName	varchar(50)
)
as
	set identity_insert dbo.SystemUser on;

	insert into dbo.SystemUser(UserId, LoginName, FirstName, LastName)
	                   values (@userId, @loginName, 'test', 'test');

	set identity_insert dbo.SystemUser off;
go

if (object_id('test.InsertBug') is not null)
	drop procedure test.InsertBug
go

create procedure test.InsertBug
(
	@bugId		int,
	@summary	varchar(50),
	@userId		int
)
as
	set identity_insert dbo.Bug on;

	insert into dbo.Bug(BugId, Summary, SubmitUserId)
				 values(@bugId, @summary, @userId);

	set identity_insert dbo.Bug off;
go

/**
*******************************************************************************/

create procedure test._@Test@_Bug_FindBugsSubmittedByUser_ShouldReturnBugIdAndSummary
as
	declare @userId int;
	set		@userId = 99;

	declare @bugId int;
	set		@bugId = 42;

	declare @summary varchar(50);
	set		@summary = 'test summary';

	delete from dbo.Bug;
	delete from dbo.SystemUser;

	exec test.InsertUser @userId, 'test';
	exec test.InsertBug @bugId, @summary, @userId;

	create table #results
	(
		BugId	int				not null,
		Summary	varchar(256)	not null,
	);

	insert into #results
	exec dbo.Bug_FindBugsSubmittedByUser @userId;

	if exists (	select	1
				from	#results
				where	BugId = @bugId
				and		Summary = @summary )
	begin
		exec ssunit.AssertPass;
	end
	else	
	begin
		exec ssunit.AssertFail 'bug not returned';
	end
go

exec ssunit.RunTests;
