/**
 * \file   CreateDatabase.test.sql
 * \brief  Creates the database for the unit tests.
 * \author Chris Oldwood
 */

if (db_id('SSUnit_Tests')  is not null)
	drop database SSUnit_Tests;
go

create database SSUnit_Tests;
go
