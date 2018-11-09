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
METHOD checkexists.

*      Plugin created by:
*      Juan Sebastián Soto
*      sebastiansoto@freeit.com.ar

  DATA: lv_objectname TYPE tstc-tcode.

  lv_objectname = me->objname.

  CALL FUNCTION 'RS_TRANSACTION_CHECK'
    EXPORTING
      objectname       = lv_objectname
      suppress_dialog  = abap_true
    EXCEPTIONS
      object_not_found = 1
      error_occured    = 2
      OTHERS           = 3.

  CHECK sy-subrc EQ 0.

  exists = abap_true.

ENDMETHOD.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2018. Sap Release 700
