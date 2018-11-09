**************************************************************************
*   Method attributes.                                                   *
**************************************************************************
Instantiation: Public
**************************************************************************

*/---------------------------------------------------------------------\
*| This file is part of SAPlink.                                       |
*|                                                                     |
*| Copyright 2014-2015 SAPlink project members                         |
*|                                                                     |
*| Licensed under the Apache License, Version 2.0 (the "License");     |
*| you may not use this file except in compliance with the License.    |
*| You may obtain a copy of the License at                             |
*|                                                                     |
*|     http://www.apache.org/licenses/LICENSE-2.0                      |
*|                                                                     |
*| Unless required by applicable law or agreed to in writing, software |
*| distributed under the License is distributed on an "AS IS" BASIS,   |
*| WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or     |
*| implied.                                                            |
*| See the License for the specific language governing permissions and |
*| limitations under the License.                                      |
*\---------------------------------------------------------------------/
METHOD createixmldocfromobject.

*      Plugin created by:
*      Juan Sebastián Soto
*      sebastiansoto@freeit.com.ar

  DATA: lt_tcodes         TYPE STANDARD TABLE OF tstc,
        lt_gui_attributes TYPE STANDARD TABLE OF tstcc,
        lt_params         TYPE swyparam.

  DATA: ls_header         TYPE ty_header,
        ls_tadir          TYPE tadir,
        ls_tcodes         TYPE tstc,
        ls_gui_attributes TYPE tstcc,
        ls_tstct          TYPE tstct,
        ls_tstcp          TYPE tstcp,
        ls_params         TYPE LINE OF swyparam.

  DATA: lv_transaction TYPE tstc-tcode,
        lv_object      TYPE tadir-object,
        lv_obj_name    TYPE tadir-obj_name,
        lv_message     TYPE string.

*xml nodes
  DATA: _objtype   TYPE string,
        rootnode    TYPE REF TO if_ixml_element,
        header_node TYPE REF TO if_ixml_element,
        line_node   TYPE REF TO if_ixml_element,
        rc          TYPE sysubrc.

  lv_transaction = me->objname.
  lv_obj_name    = me->objname.

  _objtype  = me->getobjecttype( ).
  lv_object = me->getobjecttype( ).

* Read Master System Data
  CALL FUNCTION 'RM_TADIR_READ'
    EXPORTING
      p_object        = lv_object
      p_obj_name      = lv_obj_name
    IMPORTING
      e_tadir         = ls_tadir
    EXCEPTIONS
      interface_error = 1
      OTHERS          = 2.

  IF sy-subrc NE 0.
    RAISE EXCEPTION TYPE zcx_saplink
    EXPORTING
      textid = zcx_saplink=>system_error.
  ENDIF.

* Read Transaction Header Data
  CALL FUNCTION 'RPY_TRANSACTION_READ'
    EXPORTING
      transaction      = lv_transaction
    TABLES
      tcodes           = lt_tcodes
      gui_attributes   = lt_gui_attributes
    EXCEPTIONS
      permission_error = 1
      cancelled        = 2
      not_found        = 3
      object_not_found = 4
      OTHERS           = 5.

  IF sy-subrc NE 0.
    RAISE EXCEPTION TYPE zcx_saplink
    EXPORTING
      textid = zcx_saplink=>system_error.
  ENDIF.

* Get Default Description
  SELECT SINGLE *
  FROM tstct
  INTO ls_tstct
  WHERE sprsl EQ ls_tadir-masterlang
    AND tcode EQ lv_transaction.

* Compile Header
  READ TABLE lt_tcodes         INTO ls_tcodes INDEX 1.
  READ TABLE lt_gui_attributes INTO ls_gui_attributes INDEX 1.

  MOVE-CORRESPONDING ls_tcodes TO ls_header.
  MOVE-CORRESPONDING ls_gui_attributes TO ls_header.
  ls_header-masterlang = ls_tadir-masterlang.
  ls_header-ttext      = ls_tstct-ttext.

  CASE ls_tcodes-cinfo.
    WHEN c_hex_tra.
      ls_header-type = 'D'.
    WHEN c_hex_par.
      ls_header-type = 'P'.
    WHEN c_hex_rep.
      ls_header-type = 'R'.
    WHEN OTHERS.

      lv_message = text-001.

      RAISE EXCEPTION TYPE zcx_saplink
        EXPORTING
          textid = zcx_saplink=>error_message
          msg    = lv_message.

  ENDCASE.

* Read Transaction parameters if needed.
  IF ls_tcodes-cinfo EQ c_hex_par.
    SELECT SINGLE * FROM tstcp INTO ls_tstcp WHERE tcode EQ lv_transaction.

    IF ls_tstcp-param+1(1) EQ '*'. " Do skip initial screen.
      ls_header-skip_screen = abap_true.
    ENDIF.

    lt_params = me->convert_tstcp_param( ls_tstcp-param ).

    ls_header-tcode_call = me->get_tcode_from_param( ls_tstcp-param ).

  ENDIF.

* Create parent node
  _objtype = getobjecttype( ).
  rootnode = xmldoc->create_element( _objtype ).
  setattributesfromstructure( node = rootnode structure = ls_header ).

* Create param subnode
  LOOP AT lt_params INTO ls_params.
    line_node = xmldoc->create_element( 'params' ).
    setattributesfromstructure( node = line_node structure = ls_params ).
    rc = rootnode->append_child( line_node ).
  ENDLOOP.

*\--------------------------------------------------------------------/
  rc = xmldoc->append_child( rootnode ).
  ixmldocument = xmldoc.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2018. Sap Release 700
