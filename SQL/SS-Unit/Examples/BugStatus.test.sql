/**
 * \file
 * \brief  Unit tests for the BugStatus enumeration.
 * \author Chris Oldwood
 */

create procedure test._@Test@_BugStatus_IsValid_ShouldReturnTrue_WhenValid
as
	declare @true bit = 1;
	declare @actual bit;

	set @actual = pub.BugStatus_IsValid(pub.BugStatus_Open());

	exec ssunit.AssertIntegerEqualTo @true, @actual;

	set @actual = pub.BugStatus_IsValid(pub.BugStatus_Resolved());

	exec ssunit.AssertIntegerEqualTo @true, @actual;

	set @actual = pub.BugStatus_IsValid(pub.BugStatus_Closed());

	exec ssunit.AssertIntegerEqualTo @true, @actual;
go

create procedure test._@Test@_BugStatus_IsValid_ShouldReturnFalse_WhenInvalid
as
	create table #EnumValues
	(
		EnumValue	int		not null
	);

	insert into #EnumValues(EnumValue)
	          select pub.BugStatus_Open()
	union all select pub.BugStatus_Resolved()
	union all select pub.BugStatus_Closed()

	declare @false bit = 0;
	declare @actual bit;
	declare @value pub.BugStatus_t;

	select @value = min(EnumValue)-1 from #EnumValues;
	set    @actual = pub.BugStatus_IsValid(@value);

	exec ssunit.AssertIntegerEqualTo @false, @actual;

	select @value = max(EnumValue)+1 from #EnumValues;
	set    @actual = pub.BugStatus_IsValid(@value);

	exec ssunit.AssertIntegerEqualTo @false, @actual;
go

exec ssunit.RunTests;
