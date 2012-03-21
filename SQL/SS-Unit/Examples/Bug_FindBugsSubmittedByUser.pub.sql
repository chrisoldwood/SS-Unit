/**
 * \file
 * \brief  The Bug_FindBugsSubmittedByUser stored prcoedure.
 * \author Chris Oldwood
 */

if (object_id('dbo.Bug_FindBugsSubmittedByUser') is not null)
	drop procedure dbo.Bug_FindBugsSubmittedByUser;
go

/**
 * Find all bugs that were submitted by the specified user.
 */

create procedure pub.Bug_FindBugsSubmittedByUser
(
	@userId		pub.UserId_t		--!< The user to find bugs for.
)
as
	select	b.BugId,
			b.Summary
	from	dbo.Bug b
	where	b.SubmitUserId = @userId;
go
