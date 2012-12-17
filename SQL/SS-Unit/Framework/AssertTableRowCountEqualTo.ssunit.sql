/**
 * \file
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
		and		p.index_id in (0, 1)			-- Heap or clustered index
		where	s.name+'.'+t.name = @table;

		if (@count = @expected)
		begin
			exec ssunit.AssertPass;
		end
		else
		begin
			declare @failure ssunit.TextMessage;
			set		@failure = 'Row count differs for ''' + @table + '''';

			declare @reason ssunit.TextMessage;
			set		@reason = ssunit_impl.FormatIntegerCompareFailure(@failure, @expected, @count);

			exec ssunit.AssertFail @reason;
		end
	end
go
