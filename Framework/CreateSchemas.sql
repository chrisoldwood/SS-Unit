/**
 * \file
 * \brief  Creates the schemas for the unit test framework.
 * \author Chris Oldwood
 */

/**
 * \namespace ssunit_impl
 * \brief     The schema used for the SS-Unit implementation.
 *
 * No client code should access objects in the schema except for the framework's
 * own unit tests.
 */

create schema ssunit_impl;
go

/**
 * \namespace ssunit
 * \brief     The schema used for the SS-Unit public interface.
 *
 * SS-Unit uses its own schema so that they will not conflict with your
 * application or your tests.
 *
 * \note Although the nature of unit testing means that privileges are naturally
 * elevated clients should only attempt to invoke SS-Unit via the objects in
 * this schema.
 */

create schema ssunit;
go

/**
 * \namespace test
 * \brief     The default schema for unit tests.
 *
 * SS-Unit assumes that all tests are part of a schema called 'test' by default.
 * You can put your tests in any schema but you will need to pass that schema
 * name to SS-Unit when running your tests so it can find them.
 */
