SS-Unit v1.5
============

Introduction
------------

SS-Unit is a unit testing framework for SQL Server (i.e. T-SQL). It comprises of
a set of stored procedures that allow you to write unit tests for your SQL
objects and code in T-SQL itself using the familiar xUnit model. By this I mean
that the concepts of Fixtures, the SetUp & TearDown helper functions and use of
AssertXxx functions to verify expectations are all present. Naturally there are
limitations to T-SQL that make these concepts less accessible than in a language
like C# but they should be pretty easy to grasp.

Installation
------------

None required, this archive contains only source files and scripts. You do need
to have SQLCMD on your path to apply the framework to a database or run the
framework test suite/examples.

Documentation
-------------

In the HelpFile folder there is a HTML based manual.

Contact Details
------------------

Email: gort@cix.co.uk
Web:   http://www.chrisoldwood.com

Chris Oldwood 
8th February 2013
