**************************************************************************
*   Class attributes.                                                    *
**************************************************************************
Instantiation: Public
Message class:
State: Implemented
Final Indicator: X
R/3 Release: 700

**************************************************************************
*   Public section of class.                                             *
**************************************************************************
class ZSAPLINK_STANDARD_TEXTS definition
  public
  inheriting from ZSAPLINK
  final
  create public .

*"* public components of class ZSAPLINK_STANDARD_TEXTS
*"* do not include other source files here!!
public section.

  methods CHECKEXISTS
    redefinition .
  methods CREATEIXMLDOCFROMOBJECT
    redefinition .
  methods CREATEOBJECTFROMIXMLDOC
    redefinition .

**************************************************************************
*   Private section of class.                                            *
**************************************************************************
*"* private components of class ZSAPLINK_STANDARD_TEXTS
*"* do not include other source files here!!
PRIVATE SECTION.

  TYPES: BEGIN OF ty_thead,
           tdname     TYPE thead-tdname,
           tdobject   TYPE thead-tdobject,
           tdid       TYPE thead-tdid,
           tdspras    TYPE thead-tdspras,
           tdtitle    TYPE thead-tdtitle,
           tdform     TYPE thead-tdform,
           tdstyle    TYPE thead-tdstyle,
           tdversion  TYPE thead-tdversion,
           tdfuser    TYPE thead-tdfuser,
           tdfreles   TYPE thead-tdfreles,
           tdfdate    TYPE thead-tdfdate,
           tdftime    TYPE thead-tdftime,
           tdluser    TYPE thead-tdluser,
           tdlreles   TYPE thead-tdlreles,
           tdldate    TYPE thead-tdldate,
           tdltime    TYPE thead-tdltime,
           tdlinesize TYPE thead-tdlinesize,
           tdtxtlines TYPE thead-tdtxtlines,
           tdhyphenat TYPE thead-tdhyphenat,
           tdospras   TYPE thead-tdospras,
           tdtranstat TYPE thead-tdtranstat,
           tdmacode1  TYPE thead-tdmacode1,
           tdmacode2  TYPE thead-tdmacode2,
           tdrefobj   TYPE thead-tdrefobj,
           tdrefname  TYPE thead-tdrefname,
           tdrefid    TYPE thead-tdrefid,
           tdtexttype TYPE thead-tdtexttype,
           tdcompress TYPE thead-tdcompress,
           mandt      TYPE thead-mandt,
           tdoclass   TYPE thead-tdoclass,
           logsys     TYPE thead-logsys,
         END OF ty_thead.

**************************************************************************
*   Protected section of class.                                          *
**************************************************************************
*"* protected components of class ZSAPLINK_STANDARD_TEXTS
*"* do not include other source files here!!
protected section.

  methods DELETEOBJECT
    redefinition .
  methods GETOBJECTTYPE
    redefinition .

**************************************************************************
*   Types section of class.                                              *
**************************************************************************
*"* dummy include to reduce generation dependencies between
*"* class ZSAPLINK_STANDARD_TEXTS and it's users.
*"* touched if any type reference has been changed

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2016. Sap Release 700
