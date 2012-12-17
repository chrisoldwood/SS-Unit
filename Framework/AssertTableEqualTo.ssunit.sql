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
	if (object_id(''))

	create table ssunit_impl.TableComparison
	(
		Differences int not null
	);

	declare @query varchar(max) =
	  'select	1 as [True] '
	+ 'into		#results '
	+ 'from '
	+ '( '
	+ ' select	* '
	+ '	from	'+ @actual +' '
	+ '	union all '
	+ '	select	* '
	+ '	from	' + @expected + ' '
	+ ') as AllRows '
	+ 'group	by FirstColumn, SecondColumn '
	+ 'having	count(*) <> 2 ';

	--print @query;
	exec(@query);

	select * from #results;

	if (not exists(select 1 from #results))
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		declare @reason ssunit.TextMessage;
		set		@reason = 'One or more rows differs between '
						 + '''' + @expected + ''' and '
						 + '''' + @actual   + '''';

		exec ssunit.AssertFail @reason;
	end
go
