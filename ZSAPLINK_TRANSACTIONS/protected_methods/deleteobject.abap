**************************************************************************
*   Method attributes.                                                   *
**************************************************************************
Instantiation: Protected
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

METHOD deleteobject.

*      Plugin created by:
*      Juan Sebastián Soto
*      elsebasoto@gmail.com

  DATA: lv_trobjtype   TYPE trobjtype,
        lv_trobj_name  TYPE trobj_name,
        lv_transaction TYPE tstc-tcode.

  lv_transaction = me->objname.

  CALL FUNCTION 'RPY_TRANSACTION_DELETE'
    EXPORTING
      transaction      = lv_transaction
    EXCEPTIONS
      not_excecuted    = 1
      object_not_found = 2
      OTHERS           = 3.

  IF sy-subrc NE 0.
    RAISE EXCEPTION TYPE zcx_saplink
    EXPORTING
      textid = zcx_saplink=>system_error.
  ENDIF.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2018. Sap Release 700
