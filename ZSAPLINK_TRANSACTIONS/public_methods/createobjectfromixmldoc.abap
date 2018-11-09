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
METHOD createobjectfromixmldoc.

*      Plugin created by:
*      Juan Sebastián Soto
*      sebastiansoto@freeit.com.ar

  DATA: lt_params         TYPE swyparam.

  DATA: ls_header    TYPE ty_header,
        ls_params    TYPE LINE OF swyparam.

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
      structure = ls_header.

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
  filter = xmldoc->create_filter_name( 'params' ).
  iterator = xmldoc->create_iterator_filtered( filter ).
  node ?= iterator->get_next( ).

  WHILE node IS NOT INITIAL.
    CLEAR line_node.
    CALL METHOD getstructurefromattributes
      EXPORTING
        node      = node
      CHANGING
        structure = ls_params.
    APPEND ls_params TO lt_params.
    node ?= iterator->get_next( ).
  ENDWHILE.

* Create object
  CASE ls_header-type.
    WHEN 'D'. " Dialog

      CALL FUNCTION 'SWY_CREATE_DIALOG_TRANSACTION'
        EXPORTING
          new_tcode                     = ls_header-tcode
          text                          = ls_header-ttext
          program                       = ls_header-pgmna
          dynpro                        = ls_header-dypno
          enabled_html                  = ls_header-s_webgui
          enabled_java                  = ls_header-s_platin
          enabled_wingui                = ls_header-s_win32
          devclass                      = devclass
        EXCEPTIONS
          transaction_could_not_created = 1
          OTHERS                        = 2.

      IF sy-subrc NE 0.
        RAISE EXCEPTION TYPE zcx_saplink
        EXPORTING
          textid = zcx_saplink=>system_error.
      ENDIF.

    WHEN 'R'. " Report

      CALL FUNCTION 'RPY_TRANSACTION_INSERT'
        EXPORTING
          transaction                   = ls_header-tcode
          program                       = ls_header-pgmna
          dynpro                        = ls_header-dypno
          language                      = ls_header-masterlang
          development_class             = devclass
          transaction_type              = 'R'
          shorttext                     = ls_header-ttext
          professionel_user_transaction = abap_true
          html_enabled                  = ls_header-s_webgui
          java_enabled                  = ls_header-s_platin
          wingui_enabled                = ls_header-s_win32
        EXCEPTIONS
          cancelled                     = 1
          already_exist                 = 2
          permission_error              = 3
          name_not_allowed              = 4
          name_conflict                 = 5
          illegal_type                  = 6
          object_inconsistent           = 7
          db_access_error               = 8
          OTHERS                        = 9.
      IF sy-subrc <> 0.
        RAISE EXCEPTION TYPE zcx_saplink
        EXPORTING
          textid = zcx_saplink=>system_error.
      ENDIF.

    WHEN 'P'. " Params

      CALL FUNCTION 'SWY_CREATE_PARAM_TRANSACTION'
        EXPORTING
          new_tcode                     = ls_header-tcode
          text                          = ls_header-ttext
          called_transaction            = ls_header-tcode_call
          transaction_easy_web          = abap_false
          transaction_complex           = abap_true
          enabled_html                  = ls_header-s_webgui
          enabled_java                  = ls_header-s_platin
          enabled_wingui                = ls_header-s_win32
          parameter                     = lt_params
          devclass                      = devclass
        EXCEPTIONS
          transaction_could_not_created = 1
          OTHERS                        = 2.

      IF sy-subrc NE 0.
        RAISE EXCEPTION TYPE zcx_saplink
        EXPORTING
          textid = zcx_saplink=>system_error.
      ENDIF.

  ENDCASE.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2018. Sap Release 700
