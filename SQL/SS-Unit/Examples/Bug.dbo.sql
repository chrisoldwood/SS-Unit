/**
 * \file
 * \brief  The Bug table.
 * \author Chris Oldwood
 */

if (object_id('dbo.Bug') is not null)
	drop table dbo.Bug;
go

/**
 * A bug in the product.
 */

create table dbo.Bug
(
	BugId			pub.BugId_t			not null identity,	--!< The unique ID of the bug.
	Summary			pub.BodyText_t		not null,			--!< A summary of the bug.
	SubmitUserId	pub.UserId_t		not null,			--!< The user that submitted the bug.
	BugStatus		pub.BugStatus_t		not null,			--!< Then current status of the bug.
	AssignedUserId	pub.UserId_t		null,				--!< The user that is assigned to the bug.
);
go

/**
 * The constraint used to ensure the submit user is valid.
 */

alter table dbo.Bug
	add constraint Bug_FK_SubmitUserId
	foreign key (SubmitUserId) references SystemUser (UserId);
go

/**
 * The constraint used to provide the default status.
 */

alter table dbo.Bug
	add constraint Bug_Default_BugStatus
	default (pub.BugStatus_Open())
	for BugStatus;
go

/**
 * The constraint used to check the bug status is valid.
 */

alter table dbo.Bug
	add constraint Bug_Check_BugStatus
	check (pub.BugStatus_IsValid(BugStatus) <> 0);
go

/**
 * The constraint used to ensure the assigned user is valid.
 */

alter table dbo.Bug
	add constraint Bug_FK_AssignedUserId
	foreign key (AssignedUserId) references SystemUser (UserId);
go
