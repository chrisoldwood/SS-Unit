/**
 * \file   CreateDatabase.test.sql
 * \brief  Creates the Examples database.
 * \author Chris Oldwood
 */

if (db_id('SSUnit_Examples')  is not null)
	drop database SSUnit_Examples;
go

create database SSUnit_Examples;
go
