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
 * SS-Unit is a unit testing framework for SQL Server (i.e. T-SQL).
 *
 * \section example Example Test
 *
 * The following example shows a simple standalone test. T-SQL doesn't support
 * attributes and so we have to annotate the name instead with a string. In
 * SS-Unit the form "_@attrib@_" pair should be considered synonmous with
 * "[attrib]" in NUnit; hence the attribute "_@Test@_" defines a test.
 *
 * \code
 * create procedure test._@Test@_Example
 * as
 *     exec ssunit.AssertPass;
 * go
 * \endcode
 *
 * \note
 * This documentation was generated directly from the SS-Unit T-SQL source code
 * using Doxygen and the sql2doxygen input filter.
 * See <a href="http://www.cix.co.uk/~gort">http://www.cix.co.uk/~gort</a>
 */

/**
 * \namespace ssunit
 * \brief     The schema used for all SS-Unit objects.
 *
 * SS-Unit uses its own schema so that they will not conflict with your
 * application or your tests.
 */

/**
 * \namespace test
 * \brief     The default schema for unit tests.
 *
 * SS-Unit assumes that all tests are part of a schema called 'test' by default.
 * You can put your tests in any schema but you will need to pass that schema
 * name to SS-Unit when running your tests so it can find them.
 */
