/**
 * \file
 * \brief  Creates the Examples database.
 * \author Chris Oldwood
 * \note   The database name is passed via the -v switch of SQLCMD.
 *         e.g. sqlcmd -E ... -d master -i CreateDatabase.dbo.sql -v DatabaseName=MyDatabase
 */

if (db_id('$(DatabaseName)')  is not null)
	drop database $(DatabaseName);
go

create database $(DatabaseName);
go
