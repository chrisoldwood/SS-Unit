/**
 * \file   Bug.dbo.sql
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
	BugId			int				not null identity,	--!< The unique ID of the bug.
	Summary			varchar(256)	not null,			--!< A summary of the bug.
	SubmitUserId	int				not null,			--!< The use that submitted the bug.
	BugStatus		tinyint			not null,			--!< Then current status of the bug.
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
	default (dbo.BugStatus_Open())
	for BugStatus;
go
