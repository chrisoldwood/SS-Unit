/**
 * \file   AssertTableRowCountEqualTo.ssunit.sql
 * \brief  The AssertTableRowCountEqualTo stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertTableRowCountEqualTo') is not null)
	drop procedure ssunit.AssertTableRowCountEqualTo;
go

/**
 * Asserts that the table contains exactly the number of rows specified.
 */

create procedure ssunit.AssertTableRowCountEqualTo
(
	@expected	int,				--!< The expected row count.
	@table		ssunit.TableName	--!< The table to verify.
)
as
	if (@table is null)
	begin
		exec ssunit.AssertFail 'Table name was (null)';
	end
	else
	begin
		declare @count int;

		select	@count = p.rows
		from	sys.tables t
		join	sys.schemas s
		on		s.schema_id = t.schema_id
		join	sys.partitions p
		on		p.object_id = t.object_id
		where	s.name+'.'+t.name = @table;

		exec ssunit.AssertIntegerEqualTo @expected, @count;
	end
go
