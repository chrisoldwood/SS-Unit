/**
 * \file
 * \brief  Unit tests for the SystemUser table and objects.
 * \author Chris Oldwood
 */

create procedure test.SystemUser_InsertDuplicate
as
	insert into dbo.SystemUser(LoginName, FirstName, LastName)
	                    values('TestLogin', 'TestFirstName', 'TestLastName');

	insert into dbo.SystemUser(LoginName, FirstName, LastName)
	                    values('TestLogin', 'TestFirstName', 'TestLastName');
go

create procedure test._@Test@_SystemUser_ShouldThrow_WhenDuplicateLoginNameAdded
as
	delete from dbo.SystemUser

	exec ssunit.AssertThrew '%SystemUser_UN_LoginName%', 'test.SystemUser_InsertDuplicate';
go

exec ssunit.RunTests;
