/**
 * \file
 * \brief  Unit tests for the ReportCondition enumeration.
 * \author Chris Oldwood
 */

create procedure test._@Test@_ReportCondition_IsValid_ShouldReturnTrue_WhenValid
as
	declare @true bit = 1;
	declare @actual bit;

	set @actual = ssunit.ReportCondition_IsValid(ssunit.ReportCondition_Never());

	exec ssunit.AssertIntegerEqualTo @true, @actual;

	set @actual = ssunit.ReportCondition_IsValid(ssunit.ReportCondition_Always());

	exec ssunit.AssertIntegerEqualTo @true, @actual;

	set @actual = ssunit.ReportCondition_IsValid(ssunit.ReportCondition_OnFailure());

	exec ssunit.AssertIntegerEqualTo @true, @actual;
go

create procedure test._@Test@_ReportCondition_IsValid_ShouldReturnFalse_WhenInvalid
as
	create table #EnumValues
	(
		EnumValue	int		not null
	);

	insert into #EnumValues(EnumValue)
	          select ssunit.ReportCondition_Never()
	union all select ssunit.ReportCondition_Always()
	union all select ssunit.ReportCondition_OnFailure()

	declare @false bit = 0;
	declare @actual bit;
	declare @value ssunit.ReportCondition;

	select @value = min(EnumValue)-1 from #EnumValues;
	set    @actual = ssunit.ReportCondition_IsValid(@value);

	exec ssunit.AssertIntegerEqualTo @false, @actual;

	select @value = max(EnumValue)+1 from #EnumValues;
	set    @actual = ssunit.ReportCondition_IsValid(@value);

	exec ssunit.AssertIntegerEqualTo @false, @actual;
go

exec ssunit.RunTests;
