/**
 * \file
 * \brief  The AssertTableIsEmpty stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertTableIsEmpty') is not null)
	drop procedure ssunit.AssertTableIsEmpty;
go

/**
 * Asserts that the table contains no rows.
 */

create procedure ssunit.AssertTableIsEmpty
(
	@table	ssunit.TableName	--!< The table to verify.
)
as
	exec ssunit.AssertTableRowCountEqualTo 0, @table;
go
