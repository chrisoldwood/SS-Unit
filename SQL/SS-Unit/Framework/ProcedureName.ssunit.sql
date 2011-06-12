/*******************************************************************************
**! \file   ProcedureName.ssunit.sql
**! \brief  The ProcedureName user defined type.
**! \author Chris Oldwood
**/

/*******************************************************************************
** The type used to store the fully qualified name of a stored procedure.
**/

create type ssunit.ProcedureName from varchar(128);
go
