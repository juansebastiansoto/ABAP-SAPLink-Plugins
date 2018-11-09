**************************************************************************
*   Method attributes.                                                   *
**************************************************************************
Instantiation: Private
**************************************************************************

METHOD GET_TCODE_FROM_PARAM.

  DATA: lv_garbage      TYPE c LENGTH 1,
        lv_params       TYPE c LENGTH 240.

  SPLIT iv_param AT ' ' INTO lv_params lv_garbage IN CHARACTER MODE.

  re_tcode = lv_params+2.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2018. Sap Release 700
