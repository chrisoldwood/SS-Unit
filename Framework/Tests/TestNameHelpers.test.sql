/**
 * \file
 * \brief  Tests for the helper functions that format and pass test names.
 * \author Chris Oldwood
 */

create procedure test._@Test@_GetFixtureName_ShouldReturnNull_WhenNoNameExists
as
	declare @actual ssunit_impl.FixtureName = ssunit_impl.GetFixtureName('test._@Test@_NoFixtureName');

	exec ssunit.AssertStringIsNull @actual;
go

create procedure test._@Test@_GetFixtureName_ShouldReturnName_WhenNameExists
as
	declare @expected ssunit_impl.FixtureName = 'FixtureName';
	declare @testName ssunit.ProcedureName = 'test._@Test@_$' + @expected + '$_TestName';

	declare @actual ssunit_impl.FixtureName = ssunit_impl.GetFixtureName(@testName);

	exec ssunit.AssertStringEqualTo @expected, @actual;
go

create procedure test._@Test@_GetFixtureName_ShouldReturnNull_WhenFixtureNameMalformed
as
	declare @actual ssunit_impl.FixtureName = ssunit_impl.GetFixtureName('test._@Test@_$FixtureName_');

	exec ssunit.AssertStringIsNull @actual;

	set @actual = ssunit_impl.GetFixtureName('test._@Test@_FixtureName$_');

	exec ssunit.AssertStringIsNull @actual;
go

create procedure test._@Test@_FormatResultTestName_ShouldReturnOriginal_WhenNotAdorned
as
	declare @expected ssunit.ProcedureName = 'TestName';
	declare @testName ssunit.ProcedureName = @expected;

	declare @actual ssunit_impl.FixtureName = ssunit_impl.FormatResultTestName(@testName);

	exec ssunit.AssertStringEqualTo @expected, @actual;
go

create procedure test._@Test@_FormatResultTestName_ShouldRemoveSchemaName
as
	declare @expected ssunit.ProcedureName = 'TestName';
	declare @testName ssunit.ProcedureName = 'test.' + @expected;

	declare @actual ssunit_impl.FixtureName = ssunit_impl.FormatResultTestName(@testName);

	exec ssunit.AssertStringEqualTo @expected, @actual;
go

create procedure test._@Test@_FormatResultTestName_ShouldRemoveTestAttribute
as
	declare @expected ssunit.ProcedureName = 'TestName';
	declare @testName ssunit.ProcedureName = '_@Test@_' + @expected;

	declare @actual ssunit_impl.FixtureName = ssunit_impl.FormatResultTestName(@testName);

	exec ssunit.AssertStringEqualTo @expected, @actual;
go

create procedure test._@Test@_FormatResultTestName_ShouldRemoveFixtureAttribute
as
	declare @expected ssunit.ProcedureName = 'TestName';
	declare @testName ssunit.ProcedureName = '_$Fixture$_' + @expected;

	declare @actual ssunit_impl.FixtureName = ssunit_impl.FormatResultTestName(@testName);

	exec ssunit.AssertStringEqualTo @expected, @actual;
go

create procedure test._@Test@_FormatResultTestName_ShouldRemoveAttributesWhenAjoined
as
	declare @expected ssunit.ProcedureName = 'TestName';
	declare @actual ssunit_impl.FixtureName;

	set @actual = ssunit_impl.FormatResultTestName('_@Test@__$Fixture$_' + @expected);

	exec ssunit.AssertStringEqualTo @expected, @actual;

	set @actual = ssunit_impl.FormatResultTestName('_@Test@_$Fixture$_' + @expected);

	exec ssunit.AssertStringEqualTo @expected, @actual;

	set @actual = ssunit_impl.FormatResultTestName('_$Fixture$__@Test@_' + @expected);

	exec ssunit.AssertStringEqualTo @expected, @actual;

	set @actual = ssunit_impl.FormatResultTestName('_$Fixture$_@Test@_' + @expected);

	exec ssunit.AssertStringEqualTo @expected, @actual;
go

create procedure test._@Test@_GetAttributeName_ShouldReturnNull_WhenNoNameExists
as
	declare @actual ssunit_impl.AttributeName = ssunit_impl.GetAttributeName('test.NoAttributeExists');

	exec ssunit.AssertStringIsNull @actual;
go

create procedure test._@Test@_GetAttributeName_ShouldReturnName_WhenNameExists
as
	declare @expected ssunit_impl.AttributeName = 'AttributeName';
	declare @testName ssunit.ProcedureName = 'test._@' + @expected + '@_TestName';

	declare @actual ssunit_impl.AttributeName = ssunit_impl.GetAttributeName(@testName);

	exec ssunit.AssertStringEqualTo @expected, @actual;
go

create procedure test._@Test@_GetAttributeName_ShouldReturnNull_WhenAttributeNameMalformed
as
	declare @actual ssunit_impl.AttributeName = ssunit_impl.GetAttributeName('test._@AttributeName_');

	exec ssunit.AssertStringIsNull @actual;

	set @actual = ssunit_impl.GetAttributeName('test._Attribute@_');

	exec ssunit.AssertStringIsNull @actual;
go

exec ssunit.RunTests;
