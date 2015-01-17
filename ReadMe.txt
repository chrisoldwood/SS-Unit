SQL Server Unit v1.6
====================

Introduction
------------

SQL Server Unit (aka SQL-Unit) is a unit testing framework for SQL Server (i.e.
T-SQL). It comprises of a set of stored procedures that allow you to write unit
tests for your SQL objects and code in T-SQL itself using the familiar xUnit
model. By this I mean that the concepts of Fixtures, the SetUp & TearDown helper
functions and use of AssertXxx functions to verify expectations are all present.
Naturally there are limitations to T-SQL that make these concepts less
accessible than in a language like C# but they should be pretty easy to grasp.

Releases
--------

Stable releases are formally packaged and made available from my SQL tools page:
http://www.chrisoldwood.com/sql.htm

The latest code is available from my GitHub repo:
https://github.com/chrisoldwood/SS-Unit

Installation
------------

None required, this archive contains only source files and scripts. You do need
to have SQLCMD on your path to apply the framework to a database or run the
framework test suite/examples. Alternatively you can run the batch files with
the --use-ps switch and it will use the (experimental) PowerShell based SQL
runner instead.

Documentation
-------------

In the stable release package there is a HelpFile folder containing an HTML
based manual. There is also an online version of the manual available here:
http://www.chrisoldwood.com/sql/ss-unit/manual/SQL-Unit.html

Doxygen based documentation (generated with my sql2doxygen script) for the
framework API is available here:
http://www.chrisoldwood.com/sql/ss-unit/dox/index.html

Development
-----------

See DevNotes.txt.

Contact Details
------------------

Email: gort@cix.co.uk
Web:   http://www.chrisoldwood.com

Chris Oldwood 
17th January 2015
