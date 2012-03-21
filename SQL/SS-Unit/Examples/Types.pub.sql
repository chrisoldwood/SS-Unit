/**
 * \file
 * \brief  The user-defined types.
 * \author Chris Oldwood
 */

/**
 * The type for a user's login name.
 */

create type pub.LoginName_t from varchar(50);
go

/**
 * The type for part of a person's name, e.g. first or last name.
 */

create type pub.NamePart_t from varchar(50);
go

/**
 * The type for the user ID surrogate key.
 */

create type pub.UserId_t from int;
go

/**
 * The type for the bug ID surrogate key.
 */

create type pub.BugId_t from int;
go

/**
 * The type for a block of text.
 */

create type pub.BodyText_t from varchar(256);
go

/**
 * The type for an audit timestamp.
 */

create type pub.AuditDateTime_t from datetime;
go
