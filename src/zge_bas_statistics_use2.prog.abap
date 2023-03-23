*----------------------------------------------------------------------*
*& Report  ZGE_BAS_STATISTICS_USE                                      *
*&                                                                     *
*&---------------------------------------------------------------------*
*&                                                                     *
*&                                                                     *
*&---------------------------------------------------------------------*
REPORT  zge_bas_statistics_use2.

TABLES: usr02, tstct, trdirt.

DATA: ptype(1) TYPE c.

******************************************
* 21.04.2010

* data: begin of database occurs 10000.
*   include structure SAPWLUENTI.
* data: end of database.

DATA: BEGIN OF database OCCURS 10000.
        INCLUDE STRUCTURE swncaggusertcode.
DATA: END OF database.

* 21.04.2010
*******************************************


DATA: BEGIN OF userstat OCCURS 1000,
        class LIKE usr02-class,
        account(12) TYPE c,
        typeo(1) TYPE c,
        ttype LIKE sapwluenti-ttype,
        objec(40) TYPE c,
        text LIKE trdirt-text,
        descr(32) TYPE c.
DATA: END OF userstat.

DATA: BEGIN OF columns OCCURS 10,
  column(10) TYPE c.
DATA: END OF columns.

PARAMETERS: month RADIOBUTTON GROUP per.
PARAMETERS: week RADIOBUTTON GROUP per.
PARAMETERS: day RADIOBUTTON GROUP per.

PARAMETERS: date_ref LIKE sy-datum.

IF month = 'X'.
  ptype = 'M'.
ELSEIF week = 'X'.
  ptype = 'W'.
ELSE.
  ptype = 'D'.
ENDIF.

columns-column = 'User Group'.
APPEND columns.
columns-column = 'User code'.
APPEND columns.
columns-column = 'Object type'.
APPEND columns.
columns-column = 'Task type'.
APPEND columns.
columns-column = 'Object Id.'.
APPEND columns.
columns-column = 'Description'.
APPEND columns.
columns-column = 'Details'.
APPEND columns.


****************************************************
* 21.04.2010 Sustituimos función

CALL FUNCTION 'SWNC_COLLECTOR_GET_AGGREGATES'
  EXPORTING
    component              = 'TOTAL'
*   ASSIGNDSYS             = SY-SYSID
    periodtype             = ptype
    periodstrt             = date_ref
*   SUMMARY_ONLY           = ' '
*   FACTOR                 = 1000
 TABLES
*   TASKTYPE               =
*   TASKTIMES              =
*   TIMES                  =
*   DBPROCS                =
*   EXTSYSTEM              =
*   TCDET                  =
*   FRONTEND               =
*   MEMORY                 =
*   SPOOLACT               =
*   TABLEREC               =
    usertcode              = database
*   USERWORKLOAD           =
*   RFCCLNT                =
*   RFCCLNTDEST            =
*   RFCSRVR                =
*   RFCSRVRDEST            =
*   SPOOL                  =
*   HITLIST_DATABASE       =
*   HITLIST_RESPTIME       =
*   ASTAT                  =
*   ASHITL_DATABASE        =
*   ASHITL_RESPTIME        =
*   COMP_HIERARCHY         =
*   ORG_UNITS              =
*   DBCON                  =
*   VMC                    =
*   WEBSD                  =
*   WEBCD                  =
*   WEBS                   =
*   WEBC                   =
 EXCEPTIONS
    no_data_found          = 1
    OTHERS                 = 2
          .
IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.


*CALL FUNCTION 'SAPWL_WORKLOAD_GET_STATISTIC'
*  EXPORTING
*    PERIODTYPE                          = ptype
*    HOSTID                              = 'TOTAL'
*    STARTDATE                           = date_ref
**   ONLY_APPLICATION_STATISTIC          = ' '
**   INSTANCE                            = ' '
** IMPORTING
**   SPOOL_PRINT_STATISTIC               =
*  TABLES
**   HITLIST_DBCALLS                     =
**   HITLIST_RESPTI                      =
**   ACCOUNTING_STATISTIC_TASKTYPE       =
**   TIME_STATISTIC                      =
**   TABLE_RECORD_STATISTIC              =
**   APPLICATION_STATISTIC               =
**   FUNCTION_CODE_STATISTIC             =
**   TERMINAL_IO_STATISTIC               =
**   TASKTYPE_STATISTIC                  =
*    USER_STATISTIC                      = database
**   MEMORY_STATISTIC                    =
**   RFC_CLIENT_STATISTIC                =
**   RFC_SERVER_STATISTIC                =
**   RFC_CLIENT_DEST_STATISTIC           =
**   INSTANCES                           =
**   RFC_SERVER_DEST_STATISTIC           =
**   SPOOL_ACTIVITY_STATISTIC            =
**   DBPROCEDURE_STATISTIC               =
**   EXTERN_SYS_WORKLOAD_STAT            =
* EXCEPTIONS
*   UNKNOWN_PERIODTYPE                  = 1
*   NO_DATA_FOUND                       = 2
*   NO_SERVER_GIVEN                     = 3
*   OTHERS                              = 4
*          .
*IF SY-SUBRC <> 0.
** MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
**         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
*ENDIF.

* 21.04.2010
****************************************************


CLEAR userstat. REFRESH userstat.

LOOP AT database.
  SELECT SINGLE * FROM usr02
    WHERE bname = database-account.
  IF sy-subrc <> 0. usr02-class = ''. ENDIF.
  MOVE usr02-class TO userstat-class.
  MOVE-CORRESPONDING database TO userstat.
  MOVE database-entry_id+0(39) TO userstat-objec.
  MOVE database-entry_id+40(31) TO userstat-descr.
  MOVE database-entry_id+72(1) TO userstat-typeo.

  IF userstat-typeo = 'T'.
    CLEAR userstat-text. CLEAR tstct.
    SELECT SINGLE * FROM tstct WHERE sprsl = 'E'
                                 AND tcode = userstat-objec+0(20).
    IF sy-subrc <> 0.
      SELECT SINGLE * FROM tstct WHERE sprsl = 'S'
                                   AND tcode = userstat-objec+0(20).
      IF sy-subrc <> 0.
        SELECT SINGLE * FROM tstct WHERE sprsl = 'D'
                                     AND tcode = userstat-objec+0(20).
      ENDIF.
    ENDIF.
    MOVE tstct-ttext TO userstat-text.
  ELSEIF userstat-typeo = 'R'.
    CLEAR userstat-text. CLEAR trdirt.
    SELECT SINGLE * FROM trdirt WHERE sprsl = 'E'
                                  AND name = userstat-objec.
    IF sy-subrc <> 0.
      SELECT SINGLE * FROM trdirt WHERE sprsl = 'S'
                                    AND name = userstat-objec.
      IF sy-subrc <> 0.
        SELECT SINGLE * FROM trdirt WHERE sprsl = 'D'
                                      AND name = userstat-objec.
      ENDIF.
    ENDIF.
    MOVE trdirt-text TO userstat-text.


  ENDIF.

  APPEND userstat.
ENDLOOP.

CALL FUNCTION 'DISPLAY_BASIC_LIST'
  EXPORTING
    basic_list_title           = 'Statistics System Use'
    file_name                  = 'STAT-USE'
*   HEAD_LINE1                 = ' '
*   HEAD_LINE2                 = ' '
*   HEAD_LINE3                 = ' '
*   HEAD_LINE4                 = ' '
*   FOOT_NOTE1                 = ' '
*   FOOT_NOTE2                 = ' '
*   FOOT_NOTE3                 = ' '
*   LAY_OUT                    = 0
*   DYN_PUSHBUTTON_TEXT1       =
*   DYN_PUSHBUTTON_TEXT2       =
*   DYN_PUSHBUTTON_TEXT3       =
*   DYN_PUSHBUTTON_TEXT4       =
*   DYN_PUSHBUTTON_TEXT5       =
*   DYN_PUSHBUTTON_TEXT6       =
*   DATA_STRUCTURE             = ' '
*   CURRENT_REPORT             =
*   LIST_LEVEL                 = ' '
*   ADDITIONAL_OPTIONS         = ' '
*   WORD_DOCUMENT              =
*   APPLICATION                =
*   OLDVALUES                  = ' '
*   NO_ALV_GRID               =
*   ALV_MARKER                 =
* IMPORTING
*   RETURN_CODE                =
  TABLES
    data_tab                   = userstat
    fieldname_tab              = columns
*   SELECT_TAB                 =
*   ERROR_TAB                  =
*   RECEIVERS                  =
 EXCEPTIONS
   download_problem           = 1
   no_data_tab_entries        = 2
   table_mismatch             = 3
   print_problems             = 4
   OTHERS                     = 5
          .
IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.
