/**
 * \file
 * \brief  The AssertTableEqualTo stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertTableEqualTo') is not null)
	drop procedure ssunit.AssertTableEqualTo;
go

/**
 * Asserts that the table contains exactly the same data as the expected table.
 *
 * \note This compares the tables without regard to row order. The tables must
 * also contain the same column names.
 */

create procedure ssunit.AssertTableEqualTo
(
	@expected	ssunit.TableName,	--!< The expected table data.
	@actual		ssunit.TableName	--!< The actual table data.
)
as
	declare @reason ssunit.TextMessage;

	declare @expectedCols ssunit_impl.List = ssunit_impl.FormatTableColumnList(@expected);
	declare @actualCols ssunit_impl.List = ssunit_impl.FormatTableColumnList(@actual);

	if (@actualCols <> @expectedCols)
	begin
		set @reason = 'The table schemas do not match for '
					+ '''' + @expected + ''' and '
					+ '''' + @actual   + '''';

		exec ssunit.AssertFail @reason;		
	end 
	else
	begin
		if (object_id('ssunit_impl.TableDifference') is not null)
			drop table ssunit_impl.TableDifference;

		create table ssunit_impl.TableDifference
		(
			True int not null
		);

		declare @query varchar(max) =
		  'insert into ssunit_impl.TableDifference (True) '
		+ 'select	1 as [True] '
		+ 'from '
		+ '( '
		+ ' select	* '
		+ '	from	'+ @actual +' '
		+ '	union all '
		+ '	select	* '
		+ '	from	' + @expected + ' '
		+ ') as AllRows '
		+ 'group	by ' + @expectedCols + ' '
		+ 'having	count(*) <> 2 ';

		--print @query;
		exec(@query);

		if (not exists(select 1 from ssunit_impl.TableDifference))
		begin
			exec ssunit.AssertPass;
		end
		else
		begin
			set @reason = 'One or more rows differs between '
						+ '''' + @expected + ''' and '
						+ '''' + @actual   + '''';

			exec ssunit.AssertFail @reason;
		end
	end
go
