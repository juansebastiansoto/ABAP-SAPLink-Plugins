**************************************************************************
*   Method attributes.                                                   *
**************************************************************************
Instantiation: Public
**************************************************************************

*/---------------------------------------------------------------------\
*| This file is part of SAPlink.                                       |
*|                                                                     |
*| Copyright 2014-2015 SAPlink project members                              |
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
METHOD createobjectfromixmldoc.

*      Plugin created by:
*      Juan Sebastián Soto
*      sebastiansoto@freeit.com.ar

  DATA: ls_text_header TYPE thead,
        ls_text_line   TYPE tline,
        lt_text_lines  TYPE STANDARD TABLE OF tline.

*xml nodes
  DATA: rootnode     TYPE REF TO if_ixml_element,
        line_node    TYPE REF TO if_ixml_element,
        node         TYPE REF TO if_ixml_element,
        filter       TYPE REF TO if_ixml_node_filter,
        iterator     TYPE REF TO if_ixml_node_iterator,
        _objtype     TYPE string.

  DATA: trobjtype  TYPE trobjtype,
        trobj_name TYPE trobj_name.

  _objtype = getobjecttype( ).

  xmldoc = ixmldocument.
  rootnode = xmldoc->find_from_name( _objtype ).

  CALL METHOD getstructurefromattributes
    EXPORTING
      node      = rootnode
    CHANGING
      structure = ls_text_header.

***OBJECT ==> TDOBJECT,TDNAME,TDID,TDSPRAS

  CONCATENATE ls_text_header-tdobject
              ls_text_header-tdname
              ls_text_header-tdid
              ls_text_header-tdspras
  INTO objname
  SEPARATED BY ','.

  IF checkexists( ) EQ abap_true.
    IF overwrite IS INITIAL.
      RAISE EXCEPTION TYPE zcx_saplink
        EXPORTING
          textid = zcx_saplink=>existing.
    ELSE.
*     delete object for new install
      deleteobject( ).
    ENDIF.
  ENDIF.

* retrieve standard text lines
  FREE: filter, iterator, node.
  filter = xmldoc->create_filter_name( 'line' ).
  iterator = xmldoc->create_iterator_filtered( filter ).
  node ?= iterator->get_next( ).

  WHILE node IS NOT INITIAL.
    CLEAR line_node.
    CALL METHOD getstructurefromattributes
      EXPORTING
        node      = node
      CHANGING
        structure = ls_text_line.
    APPEND ls_text_line TO lt_text_lines.
    node ?= iterator->get_next( ).
  ENDWHILE.

  CALL FUNCTION 'SAVE_TEXT'
    EXPORTING
      header          = ls_text_header
      savemode_direct = abap_true
    TABLES
      lines           = lt_text_lines
    EXCEPTIONS
      id              = 1
      language        = 2
      name            = 3
      object          = 4
      OTHERS          = 5.

  IF sy-subrc NE 0.
    RAISE EXCEPTION TYPE zcx_saplink
    EXPORTING
      textid = zcx_saplink=>system_error.
  ENDIF.

  trobjtype  = _objtype.
  trobj_name = objname.

  CALL FUNCTION 'RS_INSERT_INTO_WORKING_AREA'
    EXPORTING
      object            = trobjtype
      obj_name          = trobj_name
    EXCEPTIONS
      wrong_object_name = 1.

  name = objname.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2016. Sap Release 700
