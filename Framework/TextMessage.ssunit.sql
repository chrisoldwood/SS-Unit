/**
 * \file   TextMessage.ssunit.sql
 * \brief  The TextMessage user defined type.
 * \author Chris Oldwood
 */

/**
 * The type used to store a text message, such as the reason for a test failure.
 */

create type ssunit.TextMessage from varchar(max);
go
