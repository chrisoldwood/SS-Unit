/**
 * \file
 * \brief  The main body of documentation.
 * \author Chris Oldwood
 */

/**
 * \mainpage SQL Server Unit Test Framework
 *
 * \section introduction Introduction
 *
 * SQL-Unit is a unit testing framework for SQL Server (i.e. T-SQL).
 *
 * \section example Example Test
 *
 * The following example shows a simple standalone test. T-SQL doesn't support
 * attributes and so we have to annotate the name instead with a string. In
 * SQL-Unit the form "_@attrib@_" pair should be considered synonmous with
 * "[attrib]" in NUnit; hence the attribute "_@Test@_" defines a test.
 *
 * \code
 * create procedure test._@Test@_Example
 * as
 *     declare @actual varchar(100) = '42';
 *
 *     exec ssunit.AssertStringEqualTo '42', @actual;
 * go
 * \endcode
 *
 * \note
 * This documentation was generated directly from the SQL-Unit T-SQL source code
 * using Doxygen and the sql2doxygen input filter.
 * See <a href="http://www.chrisoldwood.com">http://www.chrisoldwood.com</a>
 */
