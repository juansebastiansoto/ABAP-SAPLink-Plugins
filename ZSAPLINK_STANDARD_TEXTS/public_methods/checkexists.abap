**************************************************************************
*   Method attributes.                                                   *
**************************************************************************
Instantiation: Public
**************************************************************************

METHOD checkexists.

*      Plugin created by:
*      Juan Sebastián Soto
*      sebastiansoto@freeit.com.ar

  DATA: ls_text_header TYPE thead.

  SPLIT objname AT ',' INTO ls_text_header-tdobject
                            ls_text_header-tdname
                            ls_text_header-tdid
                            ls_text_header-tdspras.

  SELECT SINGLE tdobject
  FROM stxh
  INTO ls_text_header-tdobject
  WHERE tdobject EQ ls_text_header-tdobject
    AND tdname   EQ ls_text_header-tdname
    AND tdid     EQ ls_text_header-tdid
    AND tdspras  EQ ls_text_header-tdspras.

  CHECK sy-subrc EQ 0.

  exists = abap_true.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2016. Sap Release 700
