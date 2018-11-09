**************************************************************************
*   Method attributes.                                                   *
**************************************************************************
Instantiation: Private
**************************************************************************

METHOD convert_tstcp_param.

  DATA: lt_param_list   TYPE stringtab.

  DATA: lw_param        TYPE LINE OF swyparam.

  DATA: lv_garbage      TYPE c LENGTH 1,
        lv_params       TYPE c LENGTH 240,
        lv_param_list   TYPE string.

  SPLIT iv_param AT ' ' INTO lv_garbage lv_params IN CHARACTER MODE.

  SPLIT lv_params AT ';' INTO TABLE lt_param_list IN CHARACTER MODE.

  LOOP AT lt_param_list INTO lv_param_list.

    CLEAR lw_param.

    SPLIT lv_param_list AT '=' INTO lw_param-field lw_param-value.
    APPEND lw_param TO re_param.

  ENDLOOP.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2018. Sap Release 700
