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
METHOD createixmldocfromobject.

*      Plugin created by:
*      Juan Sebastián Soto
*      sebastiansoto@freeit.com.ar

*xml nodes
  DATA: _objtype   TYPE string,
        rootnode    TYPE REF TO if_ixml_element,
        header_node TYPE REF TO if_ixml_element,
        line_node   TYPE REF TO if_ixml_element,
        rc          TYPE sysubrc.

  DATA: ls_text_header      TYPE thead,
        ls_text_header_link TYPE ty_thead, " Same structure like thead but with TDNAME at first field
        lt_text_lines       TYPE STANDARD TABLE OF tline,
        ls_text_line        TYPE tline.

***OBJECT ==> TDOBJECT,TDNAME,TDID,TDSPRAS

  SPLIT objname AT ',' INTO ls_text_header-tdobject
                            ls_text_header-tdname
                            ls_text_header-tdid
                            ls_text_header-tdspras.

  CALL FUNCTION 'READ_TEXT'
    EXPORTING
      id                      = ls_text_header-tdid
      language                = ls_text_header-tdspras
      name                    = ls_text_header-tdname
      object                  = ls_text_header-tdobject
    IMPORTING
      header                  = ls_text_header
    TABLES
      lines                   = lt_text_lines
    EXCEPTIONS
      id                      = 1
      language                = 2
      name                    = 3
      not_found               = 4
      object                  = 5
      reference_check         = 6
      wrong_access_to_archive = 7
      OTHERS                  = 8.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  MOVE-CORRESPONDING ls_text_header TO ls_text_header_link.

* Create parent node
  _objtype = getobjecttype( ).
  rootnode = xmldoc->create_element( _objtype ).
  setattributesfromstructure( node = rootnode structure = ls_text_header_link ).

* Create lines node
  LOOP AT lt_text_lines INTO ls_text_line.
    line_node = xmldoc->create_element( 'line' ).
    setattributesfromstructure( node = line_node structure = ls_text_line ).
    rc = rootnode->append_child( line_node ).
  ENDLOOP.

*\--------------------------------------------------------------------/
  rc = xmldoc->append_child( rootnode ).
  ixmldocument = xmldoc.


ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2016. Sap Release 700
