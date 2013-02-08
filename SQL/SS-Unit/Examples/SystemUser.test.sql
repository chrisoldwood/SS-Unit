/**
 * \file
 * \brief  Unit tests for the SystemUser table and objects.
 * \author Chris Oldwood
 */

create procedure test._@TestTearDown@_$SystemUser$_
as
	delete from dbo.SystemUser;
go

create procedure test._@Helper@_$SystemUser$_InsertDuplicate
as
	insert into dbo.SystemUser(LoginName,   FirstName,     LastName)
	                    values('SameLogin', 'FirstName_1', 'LastName_1');

	insert into dbo.SystemUser(LoginName,   FirstName,     LastName)
	                    values('SameLogin', 'FirstName_2', 'LastName_2');
go

create procedure test._@Test@_$SystemUser$_ShouldThrow_WhenDuplicateLoginNameAdded
as
	exec ssunit.AssertThrew '%SystemUser_UN_LoginName%', 'test._@Helper@_$SystemUser$_InsertDuplicate';
go

create procedure test._@Test@_$SystemUser$_ShouldAllowSameNameForDifferentLogins
as
	insert into dbo.SystemUser(LoginName, FirstName,       LastName)
	                    values('Login_1', 'SameFirstName', 'SameLastName');

	insert into dbo.SystemUser(LoginName, FirstName,       LastName)
	                    values('Login_2', 'SameFirstName', 'SameLastName');

	exec ssunit.AssertPass;
go

create procedure test._@Test@_$SystemUser$_ShouldAllocateUniqueIdsPerLogin
as
	insert into dbo.SystemUser(LoginName, FirstName,     LastName)
	                    values('Login_1', 'FirstName_1', 'LastName_1');

	insert into dbo.SystemUser(LoginName, FirstName,     LastName)
	                    values('Login_2', 'FirstName_2', 'LastName_2');

	declare @userId_1 pub.UserId_t,
			@userId_2 pub.UserId_t;

	select @userId_1 = su.UserId from dbo.SystemUser su where su.LoginName = 'Login_1';
	select @userId_2 = su.UserId from dbo.SystemUser su where su.LoginName = 'Login_2';

	exec ssunit.AssertIntegerNotEqualTo @userId_2, @userId_1;
go

exec ssunit.RunTests;
