/**
 * \file
 * \brief  The SystemUser table.
 * \author Chris Oldwood
 */

if (object_id('dbo.SystemUser') is not null)
	drop table dbo.SystemUser;
go

/**
 * A user of the bug tracking system.
 */

create table dbo.SystemUser
(
	UserId		pub.UserId_t			not null identity,	--!< The unique ID of the user.
	LoginName	pub.LoginName_t			not null,			--!< The users' login name.
	FirstName	pub.NamePart_t			not null,			--!< The users' first name.
	LastName	pub.NamePart_t			not null,			--!< The users' last name.
	CreateTime	pub.AuditDateTime_t		not null,			--!< The date & time of record creation.
);
go

/**
 * The default constraint used to set the date & time of record creation.
 */

alter table dbo.SystemUser
	add constraint SystemUser_Default_FullName
	default (getdate())
	for CreateTime;
go

/**
 * The table's primary key.
 */

alter table dbo.SystemUser
	add constraint SystemUser_PrimaryKey
	primary key clustered (UserId);
go

/**
 * The constraint to ensure each user is unique.
 */

alter table dbo.SystemUser
	add constraint SystemUser_UN_LoginName
	unique (LoginName);
go
