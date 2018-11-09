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
class ZSAPLINK_TRANSACTIONS definition
  public
  inheriting from ZSAPLINK
  final
  create public .

*"* public components of class ZSAPLINK_TRANSACTIONS
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
*"* private components of class ZSAPLINK_TRANSACTIONS
*"* do not include other source files here!!
private section.

  types:
    BEGIN OF ty_header,
           tcode       TYPE tstc-tcode,
           pgmna       TYPE tstc-pgmna,
           dypno       TYPE swydynp-dynpro,
           tcode_call  TYPE tstc-tcode,
           type        TYPE c LENGTH 1,
           skip_screen TYPE c LENGTH 1,
           s_webgui    TYPE tstcc-s_webgui,
           s_win32     TYPE tstcc-s_win32,
           s_platin    TYPE tstcc-s_platin,
           masterlang  TYPE tadir-masterlang,
           ttext       TYPE tstct-ttext,
       END OF ty_header .

  constants C_HEX_TRA type X value '00'. "#EC NOTEXT
  constants C_HEX_PAR type X value '02'. "#EC NOTEXT
  constants C_HEX_REP type X value '80'. "#EC NOTEXT
  constants C_HEX_OBJ type X value '08'. "#EC NOTEXT

  methods CONVERT_TSTCP_PARAM
    importing
      IV_PARAM type TSTCP-PARAM
    returning
      value(RE_PARAM) type SWYPARAM .
  methods GET_TCODE_FROM_PARAM
    importing
      IV_PARAM type TSTCP-PARAM
    returning
      value(RE_TCODE) type TSTC-TCODE .

**************************************************************************
*   Protected section of class.                                          *
**************************************************************************
*"* protected components of class ZSAPLINK_TRANSACTIONS
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
*"* class ZSAPLINK_TRANSACTIONS and it's users.
*"* touched if any type reference has been changed

*Text elements
*----------------------------------------------------------
* 001 Unknown transaction type

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2018. Sap Release 700
