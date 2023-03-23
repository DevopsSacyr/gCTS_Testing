*&---------------------------------------------------------------------*
*& Report ZBUSCARPROGRAMA_GIT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBUSCARPROGRAMA_GIT line-size 255
                                 no standard page heading.

TYPE-POOLS:
  icon,
  rsfs,
  rsds,
  slis.              "Tipos de datos para listas genéricas.

TABLES:
  d010inc,          "Tabla de utilización para Includes ABAP
  dd03l,            "Campos de tabla
  modact,           "Modificaciones de la CMOD
  modsap,           "Ampliaciones SAP
  sxs_inter,        "Exit: Pág.definición: Interfaces
  sscrfields,       "Campos en las imágenes de selección
  tddir,            "Exits de campo activos para elementos de datos
  tddirs,           "Exits de campos en determinados dynpros
  tftit,            "Texto breve de un módulo de funciones
  trdirt,           "Textos tͭtulo p.programas en TRDIR
  tstc,             "Códigos de transacción SAP
  tstct.            "Textos de códigos de transacción

*----------------------------------------------------------------------*
* CONSTANTS
*----------------------------------------------------------------------*
CONSTANTS:
  c_sust(22)      TYPE c VALUE 'SUBSTITUTION',
  c_user_exit(22) TYPE c VALUE 'USEREXIT',
  c_badi(22)      TYPE c VALUE 'BADI',
  c_handler(30)   TYPE c VALUE 'CL_EXITHANDLER=>GET_INSTANCE',
  c_method(22)    TYPE c VALUE 'CALL METHOD',
  c_type_ref(22)  TYPE c VALUE 'TYPE REF TO',
  c_perform(22)   TYPE c VALUE 'PERFORM',
  c_form(22)      TYPE c VALUE 'FORM',
  c_endform(22)   TYPE c VALUE 'ENDFORM',
  c_bte(22)       TYPE c VALUE 'OPEN_FI_PERFORM',
  c_bte1(22)      TYPE c VALUE 'OUTBOUND_CALL',
  c_enhance(22)   TYPE c VALUE 'CALL CUSTOMER-FUNCTION',
  c_funcao_1(13)  TYPE c VALUE 'CALLFUNCTION''',
  c_funcao_2(13)  TYPE c VALUE 'CALL FUNCTION',
  c_enh(11)       TYPE c VALUE 'ENHANCEMENT',
  c_enh1(17)      TYPE c VALUE 'ENHANCEMENT-POINT',
  c_enh2(19)      TYPE c VALUE 'ENHANCEMENT-SECTION',
  c_endenh(14)    TYPE c VALUE 'ENDENHANCEMENT',
  c_endenh1(23)   TYPE c VALUE 'END-ENHANCEMENT-SECTION',
  c_include(07)   TYPE c VALUE 'INCLUDE',
  c_submit(06)    TYPE c VALUE 'SUBMIT',
  c_struct(11)    TYPE c VALUE ' STRUCTURE ',
  c_comentario    TYPE c VALUE '*',
  c_ponto         TYPE c VALUE '.',
  c_aspa          TYPE c VALUE '''',
  c_igual(3)      TYPE c VALUE ' = ',
  c_x             TYPE c VALUE 'X'.

CONSTANTS:
  c_ue(4)   TYPE c VALUE 'EXIT',
  c_b(4)    TYPE c VALUE 'BADI',
  c_bt(4)   TYPE c VALUE 'BTE',
  c_st(4)   TYPE c VALUE 'SUST',
  c_fdex(4) TYPE c VALUE 'FDEX',
  c_enht(4) TYPE c VALUE 'ENH',
  c_operation(4) TYPE c VALUE 'SHOW',
  c_type(4)      TYPE c VALUE 'PROG',
* Textos
  c_text_01  TYPE slis_fieldcat_alv-reptext_ddic VALUE 'Programa',
  c_text_02  TYPE slis_fieldcat_alv-reptext_ddic VALUE 'Nivel',
  c_text_03  TYPE slis_fieldcat_alv-reptext_ddic VALUE 'Linea',
  c_text_04  TYPE slis_fieldcat_alv-reptext_ddic VALUE 'Código fuente',
  c_text_05  TYPE slis_fieldcat_alv-reptext_ddic VALUE 'Tipo',
  c_text_06  TYPE string                         VALUE 'Breakpoint',
  c_text_07  TYPE slis_fieldcat_alv-reptext_ddic VALUE 'STOP',
  c_text_08  TYPE string                     VALUE 'Marcar todo',
  c_text_09  TYPE string                     VALUE 'Desmarcar todo',
  c_text_e01 TYPE slis_fieldcat_alv-reptext_ddic VALUE
    'Debe ingresar programa o transacción',
  c_text_e02 TYPE slis_fieldcat_alv-reptext_ddic VALUE
    'Debe ingresar solo programa o transacción',
  c_text_e03 TYPE slis_fieldcat_alv-reptext_ddic VALUE
    'Debe seleccionar un tipo de mejora'.

CONSTANTS:
  c_std_definition(3) TYPE c VALUE 'SAP',
  c_std_implmnt(3)    TYPE c VALUE 'KUN'.

*----------------------------------------------------------------------*
* TABLAS INTERNAS
*----------------------------------------------------------------------*
TYPES: BEGIN OF x_tadir,
          obj_name TYPE sobj_name,
          devclass TYPE devclass,
       END OF x_tadir.

TYPES: BEGIN OF x_slog,
          obj_name TYPE sobj_name,
       END OF x_slog.

DATA: BEGIN OF ti_programa OCCURS 0,
*        cf like rssource-line,
        cf(500),
      END   OF ti_programa.

DATA: BEGIN OF ti_includes OCCURS 0,
        nome     LIKE sy-repid,
        nivel(2) TYPE n,
      END   OF ti_includes.

DATA: BEGIN OF ti_user_exit OCCURS 0,
        programa  LIKE sy-repid,
        tipo(4),
        linea(10) TYPE n,
*        cf        LIKE rssource-line,
        cf(500),
        nivel(2)  TYPE n,
        break     LIKE icon-id,
        sel(1),
      END   OF ti_user_exit.

DATA: BEGIN OF ti_badi OCCURS 0,
        programa  LIKE sy-repid,
        tipo(4),
        linea(10) TYPE n,
*        cf        LIKE rssource-line,
        cf(500),
        nivel(2)  TYPE n,
        break     LIKE icon-id,
        sel(1),
      END   OF ti_badi.

DATA: BEGIN OF ti_bte OCCURS 0,
        programa  LIKE sy-repid,
        tipo(4),
        linea(10) TYPE n,
*        cf        LIKE rssource-line,
        cf(500),
        nivel(2)  TYPE n,
        break     LIKE icon-id,
        sel(1),
      END   OF ti_bte.

DATA: BEGIN OF ti_enh OCCURS 0,
        programa  LIKE sy-repid,
        tipo(4),
        linea(10) TYPE n,
*        cf        LIKE rssource-line,
        cf(500),
        nivel(2)  TYPE n,
        break     LIKE icon-id,
        sel(1),
      END   OF ti_enh.

DATA: BEGIN OF ti_enhobj OCCURS 0,
        enhname  LIKE enhobj-enhname,
        version  LIKE enhobj-version,
        obj_type LIKE enhobj-obj_type,
        obj_name LIKE enhobj-obj_name,
        sel(1),
      END   OF ti_enhobj.

DATA: BEGIN OF ti_fdex OCCURS 0,
        tipo(4),
*        cf        LIKE rssource-line,
        cf(500),
        sel(1),
      END   OF ti_fdex.

DATA:
  ti_tadir TYPE STANDARD TABLE OF x_tadir WITH HEADER LINE,
  ti_jtab  TYPE STANDARD TABLE OF x_slog  WITH HEADER LINE.

DATA: BEGIN OF ti_final OCCURS 0,
          name     LIKE modsap-name,
          member   LIKE modsap-member,
          include  LIKE rs38l-include, "(15), "Include name
          stext    LIKE tftit-stext,
          programa LIKE rs38l-include,
          sel(1),
      END OF ti_final.

DATA: BEGIN OF ti_sust OCCURS 0,
          substid   LIKE gb922-substid,
          subseqnr  LIKE gb922-subseqnr,
          conseqnr  LIKE gb922-conseqnr,
          substab   LIKE gb922-substab,
          subsfield LIKE gb922-subsfield,
          subsval   LIKE gb922-subsval,
          exitsubst LIKE gb922-exitsubst,
          sel(1),
      END OF ti_sust.

DATA: BEGIN OF ti_val OCCURS 0,
          valid    LIKE gb931-valid,
          valseqnr LIKE gb931-valseqnr,
          condid   LIKE gb931-condid,
          checkid  LIKE gb931-checkid,
          sel(1),
      END OF ti_val.

DATA : BEGIN OF ti_bdcdata OCCURS 0.
        INCLUDE STRUCTURE bdcdata.
DATA : END OF ti_bdcdata.

DATA: ti_gb31t TYPE TABLE OF gb31t WITH HEADER LINE.

DATA: BEGIN OF ti_cimp OCCURS 0,
        enhname    LIKE enhobj-enhname,
        obj_type   LIKE enhobj-obj_type,
        obj_name   LIKE enhobj-obj_name,
        elemusage  LIKE enhobj-elemusage,
        enhinclude(40),  "like ENHINCINX-ENHINCLUDE,
      END   OF ti_cimp.

*----------------------------------------------------------------------*
* VARIABLE GLOBALES
*----------------------------------------------------------------------*
DATA:
  functxt         TYPE smp_dyntxt,
  w_tini          LIKE sy-timlo,
  vg_caracter     TYPE c,
  vg_palavra(50)  TYPE c,
  vg_inicial      LIKE sy-index,
  vg_conta_aspa   TYPE n,
  vg_pname LIKE   tfdir-pname,
  vg_texto(50)    TYPE c,
  vg_contador     LIKE sy-tfill,
  vg_nivel(2)     TYPE n,
  vg_ini_contagem TYPE c, " INDICA QUE DEBE SER INICIADO EL CONTADOR
  vg_conta_espaco TYPE n. " TOTAL DE ESPACIOS ( MÁXIMO 2 )

*----------------------------------------------------------------------*
* DEFINICION DE Estructuras y tablas para ALV (FM).
*----------------------------------------------------------------------*
DATA:
  wa_cat     TYPE slis_fieldcat_alv,      " WA catálogo
  ti_cat     TYPE slis_t_fieldcat_alv,    " TI catálogo
  wa_layout  TYPE slis_layout_alv,        " WA opciones lista
  ti_header  TYPE slis_t_listheader,      " TI cabecera lista
  wa_header  TYPE slis_listheader,        " WA cabecera lista
  wa_events  TYPE slis_alv_event,         " WA eventos lista
  ti_events  TYPE slis_t_event,           " TI eventos lista
  wa_sort    TYPE slis_sortinfo_alv,      " WA sort
  ti_sort    TYPE slis_t_sortinfo_alv,    " TI sort
  wa_print   TYPE slis_print_alv.         " WA print

*----------------------------------------------------------------------*
* PARAMETROS
*----------------------------------------------------------------------*

*- DATOS OBLIGATORIOS.
SELECTION-SCREEN BEGIN OF BLOCK bl01 WITH FRAME TITLE tit1 .

SELECTION-SCREEN: BEGIN OF LINE,
                  COMMENT 1(15) text2,
                  POSITION 20.
PARAMETERS: p_tcode LIKE tstc-tcode.          "Transacción
SELECTION-SCREEN: END OF LINE.

SELECTION-SCREEN: BEGIN OF LINE,
                  COMMENT 1(15) text1,
                  POSITION 20.
PARAMETERS: p_prog  LIKE sy-repid.            "Programa
SELECTION-SCREEN: END OF LINE.

SELECTION-SCREEN END   OF BLOCK bl01.

SELECTION-SCREEN BEGIN OF BLOCK bl02 WITH FRAME TITLE tit2 .
SELECTION-SCREEN: BEGIN OF LINE,
                  COMMENT 1(15) text7,
                  POSITION 20.
PARAMETERS: p_ue AS CHECKBOX.             "User-exit

* Boton de Exit's en la DYNPRO.
SELECTION-SCREEN: PUSHBUTTON 25(45) btn USER-COMMAND ext
                                        VISIBLE LENGTH 12.

* Boton de Proyectos de Exit's en la DYNPRO.
SELECTION-SCREEN: PUSHBUTTON 38(45) ext1 USER-COMMAND ext1
                                         VISIBLE LENGTH 12.

* Boton de User-Exit's en la DYNPRO.
SELECTION-SCREEN: PUSHBUTTON 51(45) ext2 USER-COMMAND ext2
                                         VISIBLE LENGTH 12.

SELECTION-SCREEN: END OF LINE.

SELECTION-SCREEN: BEGIN OF LINE,
                  COMMENT 1(15) text8,
                  POSITION 20.
PARAMETERS: p_badi AS CHECKBOX.           "Badi's
* Boton de Interface en la DYNPRO.
SELECTION-SCREEN: PUSHBUTTON 25(60) badi USER-COMMAND badi
                                         VISIBLE LENGTH 25.
SELECTION-SCREEN: END OF LINE.

SELECTION-SCREEN: BEGIN OF LINE,
                  POSITION 25.
PARAMETERS: p_handl AS CHECKBOX DEFAULT 'X'.
"CL_EXITHANDLER=>GET_INSTANCE
SELECTION-SCREEN: COMMENT 30(40) text12.
SELECTION-SCREEN: END OF LINE.

SELECTION-SCREEN: BEGIN OF LINE,
                  COMMENT 1(15) text9,
                  POSITION 20.
PARAMETERS: p_bte AS CHECKBOX.            "Bte
* Boton de Tx. FIBF en la DYNPRO.
SELECTION-SCREEN: PUSHBUTTON 25(60) bte1 USER-COMMAND bte1
                                         VISIBLE LENGTH 1.
* Boton de Tx. Evento en la DYNPRO.
SELECTION-SCREEN: PUSHBUTTON 29(60) bte2 USER-COMMAND bte2
                                         VISIBLE LENGTH 10.
* Boton de Tx. Proceso en la DYNPRO.
SELECTION-SCREEN: PUSHBUTTON 40(60) bte3 USER-COMMAND bte3
                                         VISIBLE LENGTH 10.


SELECTION-SCREEN: END OF LINE.

SELECTION-SCREEN: BEGIN OF LINE,
                  COMMENT 1(19) text14,
                  POSITION 20.
PARAMETERS: p_enh AS CHECKBOX.            "Punto de ampliación

* Boton de Tx. SENH en la DYNPRO.
SELECTION-SCREEN: PUSHBUTTON 25(60) senh USER-COMMAND senh
                                         VISIBLE LENGTH 1.

* Boton de Customer Implementation en la DYNPRO.
SELECTION-SCREEN: PUSHBUTTON 29(60) cimp USER-COMMAND cimp
                                        VISIBLE LENGTH 24.

SELECTION-SCREEN: END OF LINE.

SELECTION-SCREEN: BEGIN OF LINE,
                  COMMENT 1(15) text10,
                  POSITION 20.
PARAMETERS: p_sust AS CHECKBOX.            "Sustitución

* Boton de Sustitución en la DYNPRO.
SELECTION-SCREEN: PUSHBUTTON 25(45) btn1 USER-COMMAND obb
                                        VISIBLE LENGTH 12.

* Boton de programa sustitución en la DYNPRO.
SELECTION-SCREEN: PUSHBUTTON 38(45) sust USER-COMMAND sust
                                         VISIBLE LENGTH 15.

SELECTION-SCREEN: END OF LINE.

SELECTION-SCREEN: BEGIN OF LINE,
                  COMMENT 1(15) text13,
                  POSITION 20.
PARAMETERS: p_val AS CHECKBOX.            "Validación

* Boton de Validación en la DYNPRO.
SELECTION-SCREEN: PUSHBUTTON 25(45) ob28 USER-COMMAND ob28
                                        VISIBLE LENGTH 12.

* Boton de programa sustitución en la DYNPRO.
SELECTION-SCREEN: PUSHBUTTON 38(45) val USER-COMMAND val
                                         VISIBLE LENGTH 15.

SELECTION-SCREEN: END OF LINE.

SELECTION-SCREEN: BEGIN OF LINE,
                  COMMENT 1(15) text11,
                  POSITION 20.
PARAMETERS: p_fdex AS CHECKBOX.            "Field-exit

* Boton de Field-exit en la DYNPRO.
SELECTION-SCREEN: PUSHBUTTON 25(60) btn2 USER-COMMAND fdex
                                        VISIBLE LENGTH 28.

SELECTION-SCREEN: END OF LINE.

SELECTION-SCREEN END   OF BLOCK bl02.

*- DATOS OPCIONALES.
SELECTION-SCREEN BEGIN OF BLOCK bl03 WITH FRAME TITLE tit3.

SELECTION-SCREEN: BEGIN OF LINE.
* Boton de ALL en la DYNPRO.
SELECTION-SCREEN: PUSHBUTTON 18(60) all USER-COMMAND all
                                         VISIBLE LENGTH 1.
* Boton de DAL en la DYNPRO.
SELECTION-SCREEN: PUSHBUTTON 21(60) dal USER-COMMAND dal
                                         VISIBLE LENGTH 1.
SELECTION-SCREEN: END OF LINE.

SELECTION-SCREEN: ULINE.

SELECTION-SCREEN: BEGIN OF LINE,
                  COMMENT 1(15) text3,
                  POSITION 20.
PARAMETERS: p_incl AS CHECKBOX DEFAULT 'X'.   "Includes
SELECTION-SCREEN: END OF LINE.

SELECTION-SCREEN: BEGIN OF LINE,
                  COMMENT 1(15) text4,
                  POSITION 20.
PARAMETERS: p_func AS CHECKBOX DEFAULT 'X'.   "Funciones
SELECTION-SCREEN: END OF LINE.

SELECTION-SCREEN: BEGIN OF LINE,
                  COMMENT 1(15) text5,
                  POSITION 20.
PARAMETERS: p_submit AS CHECKBOX DEFAULT 'X'. "Submit
SELECTION-SCREEN: END OF LINE.

SELECTION-SCREEN: BEGIN OF LINE,
                  COMMENT 1(15) text6,
                  POSITION 20.
PARAMETERS: p_nivel(2) TYPE n DEFAULT '04'.   "Nivel
SELECTION-SCREEN: END OF LINE.

SELECTION-SCREEN END   OF BLOCK bl03.

* Botón de Marcar todo en el STATUS GUI.
SELECTION-SCREEN: FUNCTION KEY 1.
* Botón de Desmarcar todo en el STATUS GUI.
SELECTION-SCREEN: FUNCTION KEY 2.
* Botón de Breakpoint en el STATUS GUI.
SELECTION-SCREEN: FUNCTION KEY 3.

*-----------------------------------------------------------------------
* DEFINICIÓN DE MACROS
*-----------------------------------------------------------------------
DEFINE icon_create.
* Creo para el botón indicado, el icono y los textos correspondientes.

  call function 'ICON_CREATE'
    exporting
      name   = &2
      text   = &3
      info   = &4
    importing
      result = &1
    exceptions
      others = 0.

END-OF-DEFINITION. "icon_create

*-----------------------------------------------------------------------
* INICIALIZACIÓN DE VARIABLES
*-----------------------------------------------------------------------
INITIALIZATION.

  PERFORM def_text_parameter.

  PERFORM def_botones.

  CLEAR   ti_gb31t.
  REFRESH ti_gb31t.

* Obtengo Validación/Sustitución/Eventos/Texto.
  SELECT *
    INTO TABLE ti_gb31t
    FROM gb31t
    WHERE spras EQ sy-langu.

*-----------------------------------------------------------------------
* AT SELECTION-SCREEN
*-----------------------------------------------------------------------

AT SELECTION-SCREEN.

  CASE sscrfields-ucomm.
    WHEN 'FC01'.
      MOVE 'X' TO : p_ue, p_badi, p_bte, p_sust, p_val, p_fdex, p_enh.
    WHEN 'FC02'.
      CLEAR: p_ue, p_badi, p_bte, p_sust, p_val, p_fdex, p_enh.
    WHEN 'FC03'.
      PERFORM breakpoint.
    WHEN 'EXT'.
      PERFORM visualizar_ampliacion.
    WHEN 'EXT1'.
      PERFORM visualizar_proyecto.
    WHEN 'EXT2'.
      PERFORM visualizar_fm_exit.
    WHEN 'BADI'.
      PERFORM visualizar_interface.
    WHEN 'OBB'.
      CALL TRANSACTION 'OBBH'.
    WHEN 'OB28'.
      CALL TRANSACTION 'OB28'.
    WHEN 'SUST' OR 'VAL'.
      PERFORM visualizar_programa.
    WHEN 'FDEX'.
      SUBMIT rsmodprf AND RETURN.
    WHEN 'BTE1'.
      CALL TRANSACTION 'FIBF'.
    WHEN 'BTE2'.
      PERFORM cargar_bte USING 'E'.
    WHEN 'BTE3'.
      PERFORM cargar_bte USING 'P'.
    WHEN 'SENH'.
      SUBMIT sapmsenh VIA SELECTION-SCREEN
        AND RETURN.
    WHEN 'CIMP'.
      PERFORM visualizar_imp_enh.
    WHEN 'ALL'.
      MOVE 'X' TO : p_incl, p_func, p_submit.
    WHEN 'DAL'.
      CLEAR: p_incl, p_func, p_submit.
    WHEN OTHERS.
* Do Nothing !!.
  ENDCASE.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_prog.

  PERFORM repid_f4.

*----------------------------------------------------------------------*
* INICIO
*----------------------------------------------------------------------*
START-OF-SELECTION.

  GET TIME FIELD w_tini.

*- CONSISTENCIAS DE LOS PARAMETROS.
  PERFORM consisti_parametros.

*- INICIALIZA TABLA.
  PERFORM inicializa_tabela.

*- VERIFICA SI EN EL PROGRAMA EXISTE ALGUN INCLUDE, FUNCION O SUBMIT.
  PERFORM verifica_include_funcao_submit.

*- ANALISA LOS INCLUDES Y BUSCA POR USER-EXIT, BADI'S Y BTE.
  PERFORM busca_user_exit_badi_bte.

*- ANALISA LOS INCLUDES Y BUSCA LOS FIELD-EXIT'S.
  PERFORM buscar_field_exit.

*- OBTENGO LOS EXIT's DE LA TRANSACCIÓN.
  PERFORM buscar_user_exit.

*- OBTENGO LAS PUNTOS DE AMPLIACIÓN.
  PERFORM buscar_enh.

*- OBTENGO LAS SUSTITUCIONES.
  PERFORM buscar_sustituciones.

*- OBTENGO LAS VALIDACIONES.
  PERFORM buscar_validaciones.

*- CARGO LOS BREAKPOINTS.
  PERFORM cargar_break.

*- VISUALIZA LAS AMPLIACIONES ENCONTRADAS.
  PERFORM exibe_user_exit.

*----------------------------------------------------------------------*
* FIN
*----------------------------------------------------------------------*
END-OF-SELECTION.

*&---------------------------------------------------------------------*
*&      Form  BUSCA_USER_EXIT_BADI_BTE
*&---------------------------------------------------------------------*
*       Busca EXIT's, BADI's y BTE en el código fuente.
*----------------------------------------------------------------------*
FORM busca_user_exit_badi_bte.

*- VERIFICA SI EN LOS INCLUDES SELECIONADOS EXISTEN EXITS.
  LOOP AT ti_includes.

    DESCRIBE TABLE ti_includes.
    PERFORM evitar_time_out USING sy-tfill.

*- BORRA LA TABLA INTERNA.
    REFRESH ti_programa.

*- REALIZA LECTURA DE INCLUDE ALMACENANDO EN TABLA INTERNA
    READ REPORT ti_includes-nome INTO ti_programa.

    LOOP AT ti_programa.

      IF p_ue EQ 'X'.
        PERFORM buscar_exit.
        PERFORM busca_enhancements.
      ENDIF.

      IF p_badi EQ 'X'.
        PERFORM buscar_badi.
      ENDIF.

      IF p_bte EQ 'X'.
        PERFORM buscar_bte.
      ENDIF.

      IF p_enh EQ 'X'.
        PERFORM buscar_punto_ampliacion.
      ENDIF.

    ENDLOOP.
  ENDLOOP.

ENDFORM.                               " BUSCA_USER_EXIT_BADI_BTE

*&---------------------------------------------------------------------*
*&      Form  BUSCA_ENHANCEMENTS
*&---------------------------------------------------------------------*
*       Busca las llamadas a los USER-EXIT.
*----------------------------------------------------------------------*
FORM busca_enhancements.

*- VERIFICA SI EN LA LINEA DEL PROGRAMA EXISTE EN ALGUN ENHANCEMENT.
  SEARCH ti_programa-cf FOR c_enhance.
*- SE ENCONTRO EL ENHANCEMENT Y LA LINEA NO ESTÁ COMENTADA.
  IF  sy-subrc EQ 0
  AND ti_programa-cf+0(1) NE c_comentario.
    CLEAR ti_user_exit.
*- REMUEVE ESPACIOS EN EL INICIO DEL STRING.
    SHIFT ti_programa-cf LEFT DELETING LEADING space.
    MOVE: ti_includes-nome  TO ti_user_exit-programa,
          c_ue              TO ti_user_exit-tipo,
          sy-tabix          TO ti_user_exit-linea,
          ti_programa-cf    TO ti_user_exit-cf,
          ti_includes-nivel TO ti_user_exit-nivel.
    APPEND ti_user_exit.
  ENDIF.

ENDFORM.                               " BUSCA_ENHANCEMENTS

*&---------------------------------------------------------------------*
*&      Form  EXIBE_USER_EXIT
*&---------------------------------------------------------------------*
*       Muestra los datos.
*----------------------------------------------------------------------*
FORM exibe_user_exit.

  PERFORM armar_alv.
  PERFORM mostrar_listado.

ENDFORM.                               " EXIBE_USER_EXIT

*&---------------------------------------------------------------------*
*&      Form  PROCURA_INCLUDE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM procura_include.

  CLEAR vg_palavra.

*- VERIFICA SI EN LA LINEA DEL PROGRAMA EXISTE ALGUN INCLUDE.
  SEARCH ti_programa-cf FOR c_include.
*- SE ENCONTRO EN EL INCLUDE Y LA LINEA NO ESTÁ COMENTADA.
  IF  sy-subrc EQ 0
  AND ti_programa-cf+0(1) NE c_comentario.

*- VERIFICA SI EN LA LINEA DEL PROGRAMA EXISTE ALGUN STRUCTURE.
    SEARCH ti_programa-cf FOR c_struct.

    IF sy-subrc IS INITIAL.
      EXIT.
    ENDIF.

*- VERIFICA TODOS LOS 500 CARACTERES DE LA LINEA PARA MONTAR NOMBRE
*- DEL INCLUDE
    DO 500 TIMES.
      vg_inicial = sy-index - 1.
      MOVE ti_programa-cf+vg_inicial(1) TO vg_caracter.
      IF NOT vg_caracter IS INITIAL.
*- VERIFICA SI NO ES FIN DE COMANDO.
        IF vg_caracter EQ c_ponto.
          EXIT.
        ENDIF.
*- ARMA PALABRA.
        CONCATENATE vg_palavra vg_caracter INTO vg_palavra.
*- CONVIERTE A MAYUSCULA PARA FUTURA COMPARACION.
        TRANSLATE vg_palavra TO UPPER CASE.
*- SE ENCONTRO ALGUN INCLUDE
        IF vg_palavra EQ c_include.
          CLEAR vg_palavra.
        ENDIF.
      ENDIF.
    ENDDO.
*- GRABA NOMBRE DEL INCLUDE PARA FUTURA BUSQUEDA POR USER EXIT.
    READ TABLE ti_includes WITH KEY nome = vg_palavra.
    IF NOT sy-subrc IS INITIAL.
      IF vg_nivel LE p_nivel.
        MOVE: vg_palavra TO ti_includes-nome,
              vg_nivel   TO ti_includes-nivel.
        APPEND ti_includes.
      ENDIF.
    ENDIF.

  ENDIF.

ENDFORM.                               " PROCURA_INCLUDE

*&---------------------------------------------------------------------*
*&      Form  PROCURA_FUNCAO
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM procura_funcao.

  CLEAR: vg_conta_aspa,
         vg_palavra.

*- VERIFICA SI EN LA LINEA DEL PROGRAMA EXISTE ALGUNA FUNCION.
  SEARCH ti_programa-cf FOR c_funcao_2.
*- SE ENCONTRO UNA FUNCION Y LA LINEA NO ESTA COMENTADA..
  IF  sy-subrc EQ 0
  AND ti_programa-cf+0(1) NE c_comentario.
*- VERIFICA TODOS LOS 500 CARACTERES DE LA LINEA PARA MONTAR NOMBRE
*- DE LA INCLUDE
    DO 500 TIMES.
      vg_inicial = sy-index - 1.
      MOVE ti_programa-cf+vg_inicial(1) TO vg_caracter.
      IF NOT vg_caracter IS INITIAL.
*- VERIFICA SI NO ES FIN DE COMANDO.
        IF vg_caracter EQ c_aspa.
          ADD 1 TO vg_conta_aspa.
          IF vg_conta_aspa EQ 2.
            EXIT.
          ENDIF.
        ENDIF.
*- ARMA PALABRA.
        CONCATENATE vg_palavra vg_caracter INTO vg_palavra.
*- CONVIERTE A MAYUSCULA PARA FUTURA COMPARACION.
        TRANSLATE vg_palavra TO UPPER CASE.
*- SE ENCONTRO ALGUN INCLUDE
        IF vg_palavra EQ c_funcao_1.
          CLEAR vg_palavra.
        ENDIF.
      ENDIF.
    ENDDO.
*- BUSCA NOMBRE DE LA FUNCION PARA FUTURA BUSQUEDA POR USER EXIT.
    CLEAR vg_pname.
    SELECT SINGLE pname
           INTO   vg_pname
           FROM   tfdir
           WHERE  funcname EQ vg_palavra.
    IF sy-subrc EQ 0.

      READ TABLE ti_includes WITH KEY nome = vg_pname.
      IF NOT sy-subrc IS INITIAL.
        IF vg_nivel LE p_nivel.
          MOVE: vg_pname TO ti_includes-nome,
                vg_nivel TO ti_includes-nivel.
          APPEND ti_includes.
        ENDIF.
      ENDIF.

    ENDIF.
  ENDIF.

ENDFORM.                               " PROCURA_FUNCAO

*&---------------------------------------------------------------------*
*&      Form  VERIFICA_INCLUDE_FUNCAO_SUBMIT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM verifica_include_funcao_submit.

  CHECK p_ue  IS NOT INITIAL OR p_badi IS NOT INITIAL
     OR p_bte IS NOT INITIAL OR p_enh  IS NOT INITIAL.

  LOOP AT ti_includes.

    ADD 1 TO vg_contador.
    DESCRIBE TABLE ti_includes.
    PERFORM evitar_time_out USING sy-tfill.
    MOVE ti_includes-nivel TO vg_nivel.
    ADD 1 TO vg_nivel.

*- BORRA TABLA INTERNA.
    REFRESH ti_programa.

*- REALIZA LECTURA DE INCLUDE/FUNCION ALMACENANDO EN TABLA INTERNA
    READ REPORT ti_includes-nome INTO ti_programa.

    LOOP AT ti_programa.

*- PROCURA POR INCLUDES.
      IF p_incl EQ c_x.
        PERFORM procura_include.
      ENDIF.
*- PROCURA POR FUNCION.
      IF p_func EQ c_x.
        PERFORM procura_funcao.
      ENDIF.
*- PROCURA POR SUBMIT.
      IF p_submit EQ c_x.
        PERFORM procura_submit.
      ENDIF.

    ENDLOOP.

  ENDLOOP.

ENDFORM.                               " VERIFICA_INCLUDE_FUNCAO_SUBMIT

*&---------------------------------------------------------------------*
*&      Form  EVITAR_TIME_OUT
*&---------------------------------------------------------------------*
*       Evito el TIME OUT visualizando un mensaje
*----------------------------------------------------------------------*
FORM evitar_time_out USING p_tfill LIKE sy-tfill.

  DATA:
    vl_total(10) TYPE n,
    vl_atual(10) TYPE n,
    l_tout       LIKE sy-timlo,
    l_time(10)   TYPE c.

  GET TIME FIELD l_tout.

  l_tout = l_tout - w_tini.

  MOVE:
    p_tfill     TO vl_total,
    vg_contador TO vl_atual.

  SHIFT vl_total LEFT DELETING LEADING '0'.
  SHIFT vl_atual LEFT DELETING LEADING '0'.
  WRITE l_tout TO l_time.

  CONCATENATE 'Tpo:' l_time 'Total:' vl_total 'Actual:' vl_atual
         INTO vg_texto
         SEPARATED BY space.

  CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
    EXPORTING
      text = vg_texto.

ENDFORM.                               " EVITAR_TIME_OUT

*&---------------------------------------------------------------------*
*&      Form  PROCURA_SUBMIT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM procura_submit.

  CLEAR: vg_conta_espaco, vg_palavra, vg_ini_contagem.

*- VERIFICA SI LA LINEA DEL PROGRAMA EXISTE ALGUN INCLUDE.
  SEARCH ti_programa-cf FOR c_submit.
*- SE ENCONTRO EN EL INCLUDE Y LA LINEA NO ESTÁ COMENTADA.
  IF  sy-subrc EQ 0
  AND ti_programa-cf+0(1) NE c_comentario.
*- VERIFICA TODOS LOS 500 CARACTERES DE LA LINEA PARA MONTAR NOMBRE
*- DEL INCLUDE
    DO 500 TIMES.
      vg_inicial = sy-index - 1.
      MOVE ti_programa-cf+vg_inicial(1) TO vg_caracter.
      IF vg_ini_contagem EQ c_x AND vg_caracter IS INITIAL.
        ADD 1 TO vg_conta_espaco.
      ENDIF.

      IF NOT vg_caracter IS INITIAL.
        MOVE c_x TO vg_ini_contagem.
        IF vg_caracter EQ c_ponto.
          EXIT.
        ENDIF.
*- ARMA PALABRA.
        IF vg_conta_espaco LT 2.
          CONCATENATE vg_palavra vg_caracter INTO vg_palavra.
*- CONVIERTE A MAYUSCULA PARA FUTURA COMPARACION..
          TRANSLATE vg_palavra TO UPPER CASE.
*- SE ENCONTRO ALGUN INCLUDE
          IF vg_palavra EQ c_submit.
            CLEAR vg_palavra.
          ENDIF.
        ELSE.
          EXIT.
        ENDIF.
      ENDIF.
    ENDDO.
*- BUSCA NOMBRE DE LA FUNCION PARA FUTURA BUSQUEDA POR USER EXIT.
    READ TABLE ti_includes WITH KEY nome = vg_palavra.
    IF NOT sy-subrc IS INITIAL.
      IF vg_nivel LE p_nivel.
        MOVE: vg_palavra TO ti_includes-nome,
              vg_nivel   TO ti_includes-nivel.
        APPEND ti_includes.
      ENDIF.
    ENDIF.
  ENDIF.

ENDFORM.                               " PROCURA_SUBMIT

*&---------------------------------------------------------------------*
*&      Form  CONSISTI_PARAMETROS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM consisti_parametros.

  IF p_nivel IS INITIAL.
    MOVE 1 TO p_nivel.
  ENDIF.

  IF p_prog IS INITIAL AND p_tcode IS INITIAL.
*- EL NOMBRE DEL PROGRAMA Y EL NOMBRE DE LA TRANSACCION NO PUEDEN SER
*- NULOS. UNO DE ELLOS DEBE SER INFORMADO.
    MESSAGE ID '00' TYPE 'I' NUMBER '398' WITH c_text_e01.
    STOP.
  ENDIF.

  IF NOT p_prog IS INITIAL AND NOT p_tcode IS INITIAL.
*- SE SOLICITA AL USUARIO QUE INFORME NOMBRE DE PROGRAMA O TRANSACCION.
    MESSAGE ID '00' TYPE 'I' NUMBER '398' WITH c_text_e02.
    STOP.
  ENDIF.

  IF p_ue IS INITIAL    AND p_badi IS INITIAL AND p_bte IS INITIAL
  AND p_sust IS INITIAL AND p_val IS INITIAL  AND p_fdex IS INITIAL
  AND p_enh  IS INITIAL.
*- SE SOLICITA AL USUARIO QUE INFORME UN TIPO DE MEJORA.
    MESSAGE ID '00' TYPE 'I' NUMBER '398' WITH c_text_e03.
    STOP.
  ENDIF.

ENDFORM.                               " CONSISTI_PARAMETROS

*&---------------------------------------------------------------------*
*&      Form  INICIALIZA_TABELA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM inicializa_tabela.

  DATA:
    e_tstc  TYPE tstc,
    l_tcode TYPE sy-tcode.

  REFRESH ti_includes.

  IF NOT p_prog IS INITIAL.

    MOVE: p_prog TO ti_includes-nome,
          '0'    TO ti_includes-nivel.
    APPEND ti_includes.

*- BUSCO EL PROGRAMA.
    READ REPORT ti_includes-nome INTO ti_programa.

    IF sy-subrc EQ 0.
      REFRESH ti_programa.
    ELSE.
*- EL PROGRAMA NO EXISTE.
      MESSAGE s893(pz) WITH 'El programa' p_prog 'no existe.'.
      STOP.
    ENDIF.

  ELSEIF NOT p_tcode IS INITIAL.

    SELECT SINGLE *
      FROM tstc
      WHERE tcode EQ p_tcode.

    IF sy-subrc EQ 0.

      IF tstc-pgmna IS NOT INITIAL.
        MOVE: tstc-pgmna TO ti_includes-nome,
               '0'       TO ti_includes-nivel.
        APPEND ti_includes.
      ELSE.
* Se trata de una transacción de parámetros. Obtengo la transacción
* asociada.
        CALL FUNCTION 'RS_TRANSACTION_SINGLE_GET'
          EXPORTING
            parameter_tcode = p_tcode
          IMPORTING
            tcode           = l_tcode.

        SELECT SINGLE *
          INTO e_tstc
          FROM tstc
          WHERE tcode EQ l_tcode.

        IF sy-subrc EQ 0.
          MOVE: e_tstc-pgmna TO ti_includes-nome,
                 '0'       TO ti_includes-nivel.
          APPEND ti_includes.
        ELSE.
*- LA TRANSACCIÓN NO EXISTE.
          MESSAGE s893(pz) WITH 'La transacción' p_tcode 'no existe.'.
        ENDIF.
      ENDIF.
    ELSE.
*- LA TRANSACCIÓN NO EXISTE.
      MESSAGE s893(pz) WITH 'La transacción' p_tcode 'no existe.'.
      STOP.
    ENDIF.
  ENDIF.

ENDFORM.                               " INICIALIZA_TABELA

*&---------------------------------------------------------------------*
*&      Form  armar_alv
*&---------------------------------------------------------------------*
*       Armo el ALV.
*----------------------------------------------------------------------*
FORM armar_alv .

  DATA:
    l_repid TYPE sy-repid.

  MOVE sy-repid TO l_repid.

  CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_INIT'
    EXPORTING
      i_callback_program      = l_repid
      i_callback_user_command = 'USER_COMMAND'.

  IF p_ue IS NOT INITIAL.
    PERFORM construir_catalogo_exit.
    PERFORM definir_layout  USING    'TI_USER_EXIT'
                            CHANGING wa_layout.
    PERFORM construir_eventos USING 'TOP_OF_PAGE'.
    PERFORM sort TABLES ti_sort
                 USING 'TI_USER_EXIT'.

    CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_APPEND'
      EXPORTING
        is_layout                  = wa_layout
        it_fieldcat                = ti_cat
        i_tabname                  = 'TI_USER_EXIT'
        it_events                  = ti_events
        it_sort                    = ti_sort
        i_text                     = 'User-exit'
      TABLES
        t_outtab                   = ti_user_exit
      EXCEPTIONS
        program_error              = 1
        maximum_of_appends_reached = 2
        OTHERS                     = 3.


    PERFORM construir_catalogo_uexit.
    PERFORM definir_layout  USING    'TI_FINAL'
                            CHANGING wa_layout.
    PERFORM construir_eventos USING 'TOP_OF_PAGE_UEXIT'.
    PERFORM sort TABLES ti_sort
                 USING 'TI_FINAL'.

    CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_APPEND'
      EXPORTING
        is_layout                  = wa_layout
        it_fieldcat                = ti_cat
        i_tabname                  = 'TI_FINAL'
        it_events                  = ti_events
        it_sort                    = ti_sort
        i_text                     = 'User-exit Tx.CMOD'
      TABLES
        t_outtab                   = ti_final
      EXCEPTIONS
        program_error              = 1
        maximum_of_appends_reached = 2
        OTHERS                     = 3.

  ENDIF.

  IF p_badi IS NOT INITIAL.
    PERFORM construir_catalogo_badi.
    PERFORM definir_layout  USING    'TI_BADI'
                            CHANGING wa_layout.
    PERFORM construir_eventos USING 'TOP_OF_PAGE_BADI'.
    PERFORM sort TABLES ti_sort
                 USING 'TI_BADI'.

    CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_APPEND'
      EXPORTING
        is_layout                  = wa_layout
        it_fieldcat                = ti_cat
        i_tabname                  = 'TI_BADI'
        it_events                  = ti_events
        it_sort                    = ti_sort
        i_text                     = 'Badis'
      TABLES
        t_outtab                   = ti_badi
      EXCEPTIONS
        program_error              = 1
        maximum_of_appends_reached = 2
        OTHERS                     = 3.

  ENDIF.

  IF p_bte IS NOT INITIAL.
    PERFORM construir_catalogo_bte.
    PERFORM definir_layout  USING    'TI_BTE'
                            CHANGING wa_layout.
    PERFORM construir_eventos USING 'TOP_OF_PAGE_BTE'.
    PERFORM sort TABLES ti_sort
                 USING 'TI_BTE'.

    CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_APPEND'
      EXPORTING
        is_layout                  = wa_layout
        it_fieldcat                = ti_cat
        i_tabname                  = 'TI_BTE'
        it_events                  = ti_events
        it_sort                    = ti_sort
        i_text                     = 'BTE'
      TABLES
        t_outtab                   = ti_bte
      EXCEPTIONS
        program_error              = 1
        maximum_of_appends_reached = 2
        OTHERS                     = 3.

  ENDIF.

  IF p_enh IS NOT INITIAL.
    PERFORM construir_catalogo_enh.
    PERFORM definir_layout  USING    'TI_ENH'
                            CHANGING wa_layout.
    PERFORM construir_eventos USING 'TOP_OF_PAGE_ENH'.
    PERFORM sort TABLES ti_sort
                 USING 'TI_ENH'.

    CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_APPEND'
      EXPORTING
        is_layout                  = wa_layout
        it_fieldcat                = ti_cat
        i_tabname                  = 'TI_ENH'
        it_events                  = ti_events
        it_sort                    = ti_sort
        i_text                     = 'ENH'
      TABLES
        t_outtab                   = ti_enh
      EXCEPTIONS
        program_error              = 1
        maximum_of_appends_reached = 2
        OTHERS                     = 3.

    PERFORM construir_catalogo_enhobj.
    PERFORM definir_layout  USING    'TI_ENHOBJ'
                            CHANGING wa_layout.
    PERFORM construir_eventos USING 'TOP_OF_PAGE_ENHOBJ'.
    PERFORM sort TABLES ti_sort
                 USING 'TI_ENHOBJ'.

    CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_APPEND'
      EXPORTING
        is_layout                  = wa_layout
        it_fieldcat                = ti_cat
        i_tabname                  = 'TI_ENHOBJ'
        it_events                  = ti_events
        it_sort                    = ti_sort
        i_text                     = 'ENHOBJ'
      TABLES
        t_outtab                   = ti_enhobj
      EXCEPTIONS
        program_error              = 1
        maximum_of_appends_reached = 2
        OTHERS                     = 3.

  ENDIF.

  IF p_sust IS NOT INITIAL.
    PERFORM construir_catalogo_sust.
    PERFORM definir_layout  USING    'TI_SUST'
                            CHANGING wa_layout.
    PERFORM construir_eventos USING 'TOP_OF_PAGE_SUST'.
    PERFORM sort TABLES ti_sort
                 USING 'TI_SUST'.

    CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_APPEND'
      EXPORTING
        is_layout                  = wa_layout
        it_fieldcat                = ti_cat
        i_tabname                  = 'TI_SUST'
        it_events                  = ti_events
        it_sort                    = ti_sort
        i_text                     = 'Sustituciones'
      TABLES
        t_outtab                   = ti_sust
      EXCEPTIONS
        program_error              = 1
        maximum_of_appends_reached = 2
        OTHERS                     = 3.

  ENDIF.

  IF p_val IS NOT INITIAL.
    PERFORM construir_catalogo_val.
    PERFORM definir_layout  USING    'TI_VAL'
                            CHANGING wa_layout.
    PERFORM construir_eventos USING 'TOP_OF_PAGE_VAL'.
    PERFORM sort TABLES ti_sort
                 USING 'TI_VAL'.

    CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_APPEND'
      EXPORTING
        is_layout                  = wa_layout
        it_fieldcat                = ti_cat
        i_tabname                  = 'TI_VAL'
        it_events                  = ti_events
        it_sort                    = ti_sort
        i_text                     = 'Validaciones'
      TABLES
        t_outtab                   = ti_val
      EXCEPTIONS
        program_error              = 1
        maximum_of_appends_reached = 2
        OTHERS                     = 3.

  ENDIF.

  IF p_fdex IS NOT INITIAL.
    PERFORM construir_catalogo_fdex.
    PERFORM definir_layout  USING    'TI_FDEX'
                            CHANGING wa_layout.
    PERFORM construir_eventos USING 'TOP_OF_PAGE_FDEX'.
    PERFORM sort TABLES ti_sort
                 USING 'TI_FDEX'.

    CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_APPEND'
      EXPORTING
        is_layout                  = wa_layout
        it_fieldcat                = ti_cat
        i_tabname                  = 'TI_FDEX'
        it_events                  = ti_events
        it_sort                    = ti_sort
        i_text                     = 'Field-exit'
      TABLES
        t_outtab                   = ti_fdex
      EXCEPTIONS
        program_error              = 1
        maximum_of_appends_reached = 2
        OTHERS                     = 3.

  ENDIF.

ENDFORM.                    " armar_alv

*&---------------------------------------------------------------------*
*&      Form  construir_catalogo_EXIT
*&---------------------------------------------------------------------*
*       Construir catalogo de campos para ALV
*----------------------------------------------------------------------*
FORM construir_catalogo_exit .

  DATA:
    l_repid  LIKE sy-repid.

  REFRESH: ti_cat.

  l_repid = sy-repid.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name         = l_repid
      i_internal_tabname     = 'TI_USER_EXIT'
      i_inclname             = l_repid
    CHANGING
      ct_fieldcat            = ti_cat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

* Asignar atributos de campo en el catalogo de reporte ALV
  PERFORM asignar_campo_a_catalogo TABLES ti_cat
                                   USING:

  'SEL'       'X' 'X' 'X' ' ' ' ' 'X' 'X' ' ' ' ' ' ',
  'PROGRAMA'  'X' ' ' 'X' ' ' ' ' ' ' ' ' ' ' ' ' c_text_01,
  'TIPO'      'X' ' ' ' ' 'X' ' ' ' ' ' ' ' ' ' ' c_text_05,
  'NIVEL'     'X' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' c_text_02,
  'BREAK'     'X' ' ' ' ' 'X' ' ' ' ' ' ' ' ' ' ' c_text_07,
  'LINEA'     'X' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' c_text_03,
  'CF'        ' ' ' ' ' ' 'X' ' ' ' ' ' ' ' ' ' ' c_text_04.

ENDFORM.                    " construir_catalogo_EXIT

*&---------------------------------------------------------------------*
*&      Form  asignar_campo_a_catalogo
*&---------------------------------------------------------------------*
*       Asignar campo al catalogo ALV
*----------------------------------------------------------------------*
FORM asignar_campo_a_catalogo TABLES pt_cat STRUCTURE wa_cat
                          USING  p_fieldname    LIKE wa_cat-fieldname
                                 p_key          LIKE wa_cat-key
                                 p_col_pos      TYPE c
                                 p_fix_column   LIKE wa_cat-fix_column
                                 p_hotspot      LIKE wa_cat-hotspot
                                 p_do_sum       LIKE wa_cat-do_sum
                                 p_input        LIKE wa_cat-input
                                 p_checkbox     LIKE wa_cat-checkbox
                                 p_no_out       LIKE wa_cat-no_out
                                 p_icon         LIKE wa_cat-icon
                                p_reptext_ddic LIKE wa_cat-reptext_ddic.

  STATICS l_col_pos LIKE sy-cucol.

* Asignar atributos de campo en el catalogo de cabecera ALV
  CLEAR wa_cat.
  READ TABLE pt_cat INTO wa_cat
             WITH KEY fieldname = p_fieldname.

  CHECK sy-subrc EQ 0.

  IF NOT p_reptext_ddic IS INITIAL.
    wa_cat-seltext_l = wa_cat-seltext_m =
    wa_cat-seltext_s = wa_cat-reptext_ddic = p_reptext_ddic.
  ENDIF.

  IF p_col_pos EQ 'X'.
* Inicializo el conteo para ordenar las columnas.
    l_col_pos = 1.
  ELSE.
    ADD 1 TO l_col_pos.
  ENDIF.

  wa_cat-fieldname     = p_fieldname.
  wa_cat-key           = p_key.
  wa_cat-col_pos       = l_col_pos.
  wa_cat-fix_column    = p_fix_column.
  wa_cat-hotspot       = p_hotspot.
  wa_cat-do_sum        = p_do_sum.
  wa_cat-edit = wa_cat-input = p_input.
  wa_cat-checkbox      = p_checkbox.
  wa_cat-no_out        = p_no_out.
  wa_cat-icon          = p_icon.

  MODIFY pt_cat FROM wa_cat INDEX sy-tabix.

ENDFORM.                    " asignar_campo_a_catalogo

*&---------------------------------------------------------------------*
*&      Form  definir_layout
*&---------------------------------------------------------------------*
*       Definir atributos del layout de reporte
*----------------------------------------------------------------------*
FORM definir_layout USING    p_table  TYPE slis_layout_alv-box_tabname
                    CHANGING p_layout TYPE slis_layout_alv .

  CLEAR p_layout.

  IF p_table NE 'TI_CIMP'.
* Marco el campo para la selección.
    p_layout-box_fieldname         = 'SEL'.
    p_layout-box_tabname           = p_table.
  ENDIF.
  p_layout-zebra                 = 'X'.
  p_layout-colwidth_optimize     = 'X'.
  p_layout-no_vline              = ' '.
  p_layout-no_colhead            = ' '.
  p_layout-lights_condense       = 'X'.
  p_layout-detail_popup          = 'X'.
  p_layout-detail_initial_lines  = 'X'.
  p_layout-flexible_key          = ' '.
  p_layout-key_hotspot           = ' '.
  p_layout-confirmation_prompt   = 'X'.

ENDFORM.                    " definir_layout

*&---------------------------------------------------------------------*
*&      Form  construir_eventos
*&---------------------------------------------------------------------*
*       Asignar eventos soportados
*----------------------------------------------------------------------*
FORM construir_eventos USING p_form LIKE wa_events-form.
  DATA:
    l_type(1) TYPE n.

  REFRESH: ti_events.
  CLEAR:   wa_events.

* ALV Simple Block append.
  l_type = 2.

* Buscar secciones para eventos
  CALL FUNCTION 'REUSE_ALV_EVENTS_GET'
    EXPORTING
      i_list_type = l_type
    IMPORTING
      et_events   = ti_events.

* Leer evento 'TOP_OF_PAGE'
  READ TABLE ti_events WITH KEY name = slis_ev_top_of_page
                           INTO wa_events.
* Asignar Rutina FORM 'TOP_OF_PAGE' a evento
  IF sy-subrc = 0.
    MOVE p_form TO wa_events-form.
    MODIFY ti_events FROM wa_events INDEX sy-tabix.
  ENDIF.

ENDFORM.                    " construir_eventos

*&---------------------------------------------------------------------*
*&      Form  top_of_page
*&---------------------------------------------------------------------*
*       Mostrar cabecera de página
*----------------------------------------------------------------------
FORM top_of_page.

  DATA:
    l_tfill_inc(20)  TYPE c,
    l_tfill_cant(20) TYPE c.

  DESCRIBE TABLE ti_includes.
  WRITE sy-tfill TO l_tfill_inc.
  CONDENSE l_tfill_inc NO-GAPS.

  DESCRIBE TABLE ti_user_exit.
  WRITE sy-tfill TO l_tfill_cant.
  CONDENSE l_tfill_cant NO-GAPS.

* Construir encabezado del reporte
  PERFORM set_header USING l_tfill_cant
                              l_tfill_inc
                              'User-exit'.

ENDFORM.                    "top_of_page

*&---------------------------------------------------------------------*
*&      Form  TOP_OF_PAGE_UEXIT
*&---------------------------------------------------------------------*
*       Mostrar cabecera de página
*----------------------------------------------------------------------
FORM top_of_page_uexit.

  DATA:
    l_tfill_inc(20)  TYPE c,
    l_tfill_cant(20) TYPE c.

  DESCRIBE TABLE ti_final.
  WRITE sy-tfill TO l_tfill_cant.
  CONDENSE l_tfill_cant NO-GAPS.

* Construir encabezado del reporte
  PERFORM set_header USING l_tfill_cant
                           l_tfill_inc
                           'USER-EXITs Tx.SMOD'.

ENDFORM.                    "TOP_OF_PAGE_UEXIT

*&---------------------------------------------------------------------*
*&      Form  TOP_OF_PAGE_FDEX
*&---------------------------------------------------------------------*
*       Mostrar cabecera de página
*----------------------------------------------------------------------
FORM top_of_page_fdex.

  DATA:
    l_tfill_inc(20)  TYPE c,
    l_tfill_cant(20) TYPE c.

  DESCRIBE TABLE ti_fdex.
  WRITE sy-tfill TO l_tfill_cant.
  CONDENSE l_tfill_cant NO-GAPS.

* Construir encabezado del reporte
  PERFORM set_header USING l_tfill_cant
                           l_tfill_inc
                           'FIELD-EXITs'.

ENDFORM.                    "TOP_OF_PAGE_FDEX

*&---------------------------------------------------------------------*
*&      Form  TOP_OF_PAGE_BADI
*&---------------------------------------------------------------------*
*       Mostrar cabecera de página
*----------------------------------------------------------------------
FORM top_of_page_badi.

  DATA:
    l_tfill_inc(20)  TYPE c,
    l_tfill_cant(20) TYPE c.

  DESCRIBE TABLE ti_includes.
  WRITE sy-tfill TO l_tfill_inc.
  CONDENSE l_tfill_inc NO-GAPS.

  DESCRIBE TABLE ti_badi.
  WRITE sy-tfill TO l_tfill_cant.
  CONDENSE l_tfill_cant NO-GAPS.

* Construir encabezado del reporte
  PERFORM set_header USING l_tfill_cant
                           l_tfill_inc
                           'BADIs'.

ENDFORM.                    "TOP_OF_PAGE_BADI

*&---------------------------------------------------------------------*
*&      Form  TOP_OF_PAGE_BTE
*&---------------------------------------------------------------------*
*       Mostrar cabecera de página
*----------------------------------------------------------------------
FORM top_of_page_bte.

  DATA:
    l_tfill_inc(20)  TYPE c,
    l_tfill_cant(20) TYPE c.

  DESCRIBE TABLE ti_includes.
  WRITE sy-tfill TO l_tfill_inc.
  CONDENSE l_tfill_inc NO-GAPS.

  DESCRIBE TABLE ti_bte.
  WRITE sy-tfill TO l_tfill_cant.
  CONDENSE l_tfill_cant NO-GAPS.

* Construir encabezado del reporte
  PERFORM set_header USING l_tfill_cant
                           l_tfill_inc
                           'BTEs'.

ENDFORM.                    "TOP_OF_PAGE_BTE

*&---------------------------------------------------------------------*
*&      Form  TOP_OF_PAGE_ENH
*&---------------------------------------------------------------------*
*       Mostrar cabecera de página
*----------------------------------------------------------------------
FORM top_of_page_enh.

  DATA:
    l_tfill_inc(20)  TYPE c,
    l_tfill_cant(20) TYPE c.

  DESCRIBE TABLE ti_includes.
  WRITE sy-tfill TO l_tfill_inc.
  CONDENSE l_tfill_inc NO-GAPS.

  DESCRIBE TABLE ti_enh.
  WRITE sy-tfill TO l_tfill_cant.
  CONDENSE l_tfill_cant NO-GAPS.

* Construir encabezado del reporte
  PERFORM set_header USING l_tfill_cant
                           l_tfill_inc
                           'Puntos de ampliación'.

ENDFORM.                    "TOP_OF_PAGE_ENH

*&---------------------------------------------------------------------*
*&      Form  sort
*&---------------------------------------------------------------------*
*       Creo el sort del ALV (FM).
*----------------------------------------------------------------------*
*      -->PT_sort     Tabla
*      -->P_tabname   Nombre de la tabla
*----------------------------------------------------------------------*
FORM sort  TABLES   pt_sort
           USING    p_tabname TYPE any.

  CLEAR:  pt_sort, wa_sort.
  REFRESH pt_sort.

  CASE p_tabname.
    WHEN 'TI_SUST'.

      wa_sort-fieldname = 'SUBSTID'.
      wa_sort-tabname   = p_tabname.
      wa_sort-up        = 'X'.
      wa_sort-comp      = 'X'.
      APPEND wa_sort TO pt_sort.

      CLEAR:  pt_sort, wa_sort.

      wa_sort-fieldname = 'SUBSEQNR'.
      wa_sort-tabname   = p_tabname.
      wa_sort-up        = 'X'.
      wa_sort-comp      = 'X'.
      APPEND wa_sort TO pt_sort.

      CLEAR:  pt_sort, wa_sort.

      wa_sort-fieldname = 'CONSEQNR'.
      wa_sort-tabname   = p_tabname.
      wa_sort-up        = 'X'.
      wa_sort-comp      = 'X'.
      APPEND wa_sort TO pt_sort.

    WHEN 'TI_VAL'.

      wa_sort-fieldname = 'VALID'.
      wa_sort-tabname   = p_tabname.
      wa_sort-up        = 'X'.
      wa_sort-comp      = 'X'.
      APPEND wa_sort TO pt_sort.

      CLEAR:  pt_sort, wa_sort.

      wa_sort-fieldname = 'VALSEQNR'.
      wa_sort-tabname   = p_tabname.
      wa_sort-up        = 'X'.
      wa_sort-comp      = 'X'.
      APPEND wa_sort TO pt_sort.

    WHEN 'TI_ENHOBJ'.

      wa_sort-fieldname = 'ENHNAME'.
      wa_sort-tabname   = p_tabname.
      wa_sort-up        = 'X'.
      wa_sort-comp      = 'X'.
      APPEND wa_sort TO pt_sort.

      CLEAR:  pt_sort, wa_sort.

      wa_sort-fieldname = 'VERSION'.
      wa_sort-tabname   = p_tabname.
      wa_sort-up        = 'X'.
      wa_sort-comp      = 'X'.
      APPEND wa_sort TO pt_sort.

    WHEN OTHERS.

      IF p_tabname NE 'TI_FINAL'.

        wa_sort-fieldname = 'TIPO'.
        wa_sort-tabname   = p_tabname.
        wa_sort-up        = 'X'.
        wa_sort-comp      = 'X'.
        APPEND wa_sort TO pt_sort.

        CLEAR:  pt_sort, wa_sort.

        IF p_tabname NE 'TI_FDEX'.

          wa_sort-fieldname = 'NIVEL'.
          wa_sort-tabname   = p_tabname.
          wa_sort-up        = 'X'.
          wa_sort-comp      = 'X'.
          APPEND wa_sort TO pt_sort.

          CLEAR:  pt_sort, wa_sort.

          wa_sort-fieldname = 'PROGRAMA'.
          wa_sort-tabname   = p_tabname.
          wa_sort-up        = 'X'.
          wa_sort-comp      = 'X'.
          APPEND wa_sort TO pt_sort.

          CLEAR:  pt_sort, wa_sort.

          wa_sort-fieldname = 'LINEA'.
          wa_sort-tabname   = p_tabname.
          wa_sort-up        = 'X'.
          wa_sort-comp      = 'X'.
          APPEND wa_sort TO pt_sort.

        ENDIF.

      ELSE.

        wa_sort-fieldname = 'NAME'.
        wa_sort-tabname   = p_tabname.
        wa_sort-up        = 'X'.
        wa_sort-comp      = 'X'.
        APPEND wa_sort TO pt_sort.

        CLEAR:  pt_sort, wa_sort.

        wa_sort-fieldname = 'MEMBER'.
        wa_sort-tabname   = p_tabname.
        wa_sort-up        = 'X'.
        wa_sort-comp      = 'X'.
        APPEND wa_sort TO pt_sort.
      ENDIF.
  ENDCASE.

ENDFORM.                    " sort

*&---------------------------------------------------------------------*
*&      Form  mostrar_listado
*&---------------------------------------------------------------------*
*       Mostrar listado ALV
*----------------------------------------------------------------------*
FORM mostrar_listado .

  wa_print-reserve_lines = 2.

  CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_DISPLAY'
    EXPORTING
      is_print      = wa_print
    EXCEPTIONS
      program_error = 1
      OTHERS        = 2.

ENDFORM.                    " mostrar_listado

*&---------------------------------------------------------------------*
*&      Form  user_command
*&---------------------------------------------------------------------*
*       Evaluar acciones del usuario
*----------------------------------------------------------------------
FORM user_command USING ucomm   LIKE sy-ucomm
                        sfields TYPE slis_selfield.

  DATA l_break TYPE c.

* Rescatar el registro seleccionado.
  CASE sfields-tabname.
    WHEN 'TI_USER_EXIT'.
      READ TABLE ti_user_exit INDEX sfields-tabindex.
    WHEN 'TI_BADI'.
      READ TABLE ti_badi INDEX sfields-tabindex.
    WHEN 'TI_BTE'.
      READ TABLE ti_bte INDEX sfields-tabindex.
    WHEN 'TI_ENH'.
      READ TABLE ti_enh INDEX sfields-tabindex.
    WHEN 'TI_ENHOBJ'.
      READ TABLE ti_enhobj INDEX sfields-tabindex.
    WHEN 'TI_FDEX'.
      READ TABLE ti_fdex INDEX sfields-tabindex.
    WHEN 'TI_FINAL'.
      READ TABLE ti_final INDEX sfields-tabindex.
    WHEN 'TI_SUST'.
      READ TABLE ti_sust INDEX sfields-tabindex.
    WHEN 'TI_VAL'.
      READ TABLE ti_val INDEX sfields-tabindex.
    WHEN 'TI_CIMP'.
      READ TABLE ti_cimp INDEX sfields-tabindex.
  ENDCASE.


* Seleccion de opcion.
  CASE ucomm.
*   DOUBLE CLICK.
    WHEN '&IC1'.
*     Evaluar valor de campo seleccionado.
      CHECK NOT sfields-value IS INITIAL.

      CASE sfields-tabname.
        WHEN 'TI_USER_EXIT'.
*       USER-EXIT.
          IF ti_user_exit-tipo EQ sfields-value(4).
            SEARCH ti_user_exit-cf FOR c_enhance.
            CHECK sy-subrc EQ 0.
            PERFORM visualizar_exit USING ti_user_exit-programa
                                          ti_user_exit-cf.
          ELSEIF ti_user_exit-cf(60) EQ sfields-value.
            PERFORM visualizar_linea USING ti_user_exit-programa
                                           ti_user_exit-linea.
            MOVE 'X' TO l_break.
          ELSEIF ti_user_exit-break EQ sfields-value(4)
              OR ti_user_exit-break+1(2) EQ sfields-value(2).
            PERFORM asignar_break USING ti_user_exit-programa
                                        ti_user_exit-linea
                                        ti_user_exit-break.
            MOVE 'X' TO l_break.
          ENDIF.

        WHEN 'TI_FINAL'.
*       USER-EXIT Tx. CMOD.
          IF ti_final-name EQ sfields-value.
            CALL FUNCTION 'MOD_SAP_HEAD'
              EXPORTING
                mode          = 'SHOM'
                modname       = ti_final-name
              EXCEPTIONS
                attr_enqueued = 1
                text_enqueued = 2
                OTHERS        = 3.

          ELSEIF ti_final-include EQ sfields-value.
            PERFORM visualizar_linea USING ti_final-programa
                                           '1'.
            MOVE 'X' TO l_break.
          ENDIF.

        WHEN 'TI_BADI'.
*       Badi.
          IF ti_badi-tipo EQ sfields-value(4).
            PERFORM visualizar_badi USING ti_badi-cf.
          ELSEIF ti_badi-cf(60) EQ sfields-value.
            PERFORM visualizar_linea USING ti_badi-programa
                                           ti_badi-linea.
            MOVE 'X' TO l_break.
          ELSEIF ti_badi-break EQ sfields-value(4)
              OR ti_badi-break+1(2) EQ sfields-value(2).
            PERFORM asignar_break USING ti_badi-programa
                                        ti_badi-linea
                                        ti_badi-break.
            MOVE 'X' TO l_break.
          ENDIF.

        WHEN 'TI_BTE'.
*       BTE.
          IF ti_bte-tipo EQ sfields-value(4).
            PERFORM fibf USING ti_bte-cf.
          ELSEIF ti_bte-cf(60) EQ sfields-value.
            PERFORM visualizar_linea USING ti_bte-programa
                                           ti_bte-linea.
            MOVE 'X' TO l_break.
          ELSEIF ti_bte-break EQ sfields-value(4)
              OR ti_bte-break+1(2) EQ sfields-value(2).
            PERFORM asignar_break USING ti_bte-programa
                                        ti_bte-linea
                                        ti_bte-break.
            MOVE 'X' TO l_break.
          ENDIF.

        WHEN 'TI_ENH'.
*       Punto de ampliación.
          IF ti_enh-cf(60) EQ sfields-value.
            PERFORM visualizar_linea USING ti_enh-programa
                                           ti_enh-linea.
            MOVE 'X' TO l_break.
          ELSEIF ti_enh-tipo EQ sfields-value(4).
            PERFORM bi_se18 USING ti_enh-cf.
          ENDIF.

        WHEN 'TI_ENHOBJ'.
*       Punto de ampliación.
          IF ti_enhobj-enhname EQ sfields-value(30).
            PERFORM bi_se19 USING ti_enhobj-enhname.
          ENDIF.

        WHEN 'TI_SUST'.
*       Sustituciones.
          IF ti_sust-substid  EQ sfields-value(7) OR
             ti_sust-subseqnr EQ sfields-value(3).
            PERFORM visualizar_sust USING ti_sust-substid
                                          ti_sust-subseqnr.
          ENDIF.

        WHEN 'TI_VAL'.
*       Validaciones.
          IF ti_val-valid    EQ sfields-value(7) OR
             ti_val-valseqnr EQ sfields-value(3).
            PERFORM visualizar_val USING ti_val-valid
                                         ti_val-valseqnr.
          ENDIF.


        WHEN 'TI_FDEX'.
*       Field-exit.
          IF ti_fdex-tipo EQ sfields-value.
            SUBMIT rsmodprf AND RETURN.
          ELSEIF ti_fdex-cf(60) EQ sfields-value.
* Visualizo el field-exit.
            CALL FUNCTION 'RS_FUNCTION_SHOW'
              EXPORTING
                funcname = ti_fdex-cf.

            CALL FUNCTION 'RS_NAVIGATION_MONITOR'.
          ENDIF.

        WHEN 'TI_CIMP'.
*       Customer implementation.

          CASE sfields-fieldname.
            WHEN 'ENHNAME'.
              PERFORM bi_se19 USING ti_cimp-enhname.
            WHEN 'ENHINCLUDE'.
              PERFORM visualizar_enh_cf USING ti_cimp-enhinclude.
            WHEN OTHERS.
* DO NOTHING !!!
          ENDCASE.

        WHEN OTHERS.
* DO NOTHING !!!
      ENDCASE.

    WHEN OTHERS.
*     DO NOTHING !!!
  ENDCASE.

  IF l_break IS NOT INITIAL AND sfields-tabname NE 'TI_CIMP'.
    WAIT UP TO 1 SECONDS.
    PERFORM cargar_break.
  ENDIF.
  sfields-refresh = 'X'.

ENDFORM.                    "user_command

*&---------------------------------------------------------------------*
*&      Form  visualizar_linea
*&---------------------------------------------------------------------*
*       Visualizo la linea de código del programa.
*----------------------------------------------------------------------*
FORM visualizar_linea USING p_programa TYPE sy-repid
                            p_linea.

* Visualizo la linea seleccionada en el programa.
  CALL FUNCTION 'RS_TOOL_ACCESS'
    EXPORTING
      operation           = c_operation
      object_name         = p_programa
      object_type         = c_type
      position            = p_linea
    EXCEPTIONS
      not_executed        = 1
      invalid_object_type = 2
      OTHERS              = 3.

ENDFORM.                    " visualizar_linea

*&---------------------------------------------------------------------*
*&      Form  buscar_exit
*&---------------------------------------------------------------------*
*       Buscar USER-EXIT.
*----------------------------------------------------------------------*
FORM buscar_exit .

*- VERIFICA SI EN LA LINEA DEL PROGRAMA EXISTE ALGUN USER-EXIT.
  SEARCH ti_programa-cf FOR c_user_exit.
*- SE ENCONTRO UN USER-EXIT Y SE VERIFICA SI LA LINEA NO ESTA COMENTADA
  IF  sy-subrc EQ 0
  AND ti_programa-cf+0(1) NE c_comentario.

*- VERIFICO QUE NO TRAIGA LOS ENDFORM.
    SEARCH ti_programa-cf FOR c_endform.
    CHECK sy-subrc NE 0.

*- VERIFICO QUE NO TRAIGA LOS PERFORM.
    SEARCH ti_programa-cf FOR c_perform.
    CHECK sy-subrc NE 0.

*- VERIFICO QUE NO TRAIGA LAS ASIGNACIONES.
    SEARCH ti_programa-cf FOR c_igual.
    CHECK sy-subrc NE 0.

    CLEAR ti_user_exit.
*- REMUEVE ESPACIOS EN EL INÍCIO DEL STRING.
    SHIFT ti_programa-cf LEFT DELETING LEADING space.
    MOVE: ti_includes-nome  TO ti_user_exit-programa,
          c_ue              TO ti_user_exit-tipo,
          sy-tabix          TO ti_user_exit-linea,
          ti_programa-cf    TO ti_user_exit-cf,
          ti_includes-nivel TO ti_user_exit-nivel.
    APPEND ti_user_exit.
  ENDIF.

ENDFORM.                    " buscar_exit

*&---------------------------------------------------------------------*
*&      Form  buscar_badi
*&---------------------------------------------------------------------*
*       Buscar BADI.
*----------------------------------------------------------------------*
FORM buscar_badi .

  DATA:
    l_subrc LIKE sy-subrc.

*- VERIFICA SI EN LA LINEA DEL PROGRAMA EXISTE ALGUNA BADI.
  SEARCH ti_programa-cf FOR c_badi.
*- SE ENCONTRO UNA BADI Y SE VERIFICA SI LA LINEA NO ESTÁ COMENTADA.
  IF  sy-subrc EQ 0
  AND ti_programa-cf+0(1) NE c_comentario.

    SEARCH ti_programa-cf FOR c_include.
    IF sy-subrc NE 0.
      CLEAR l_subrc.
      SEARCH ti_programa-cf FOR c_method.
      IF sy-subrc NE 0.
        SEARCH ti_programa-cf FOR c_funcao_2.
        IF sy-subrc NE 0.
          SEARCH ti_programa-cf FOR c_perform.
          IF sy-subrc NE 0.
            SEARCH ti_programa-cf FOR c_type_ref.
            IF sy-subrc NE 0.
              SEARCH ti_programa-cf FOR c_form.
              MOVE '4' TO l_subrc.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.

      IF l_subrc EQ 0.
        CLEAR ti_badi.
*- REMUEVE ESPACIOS EN EL INICIO DEL STRING.
        SHIFT ti_programa-cf LEFT DELETING LEADING space.
        MOVE: ti_includes-nome  TO ti_badi-programa,
              c_b               TO ti_badi-tipo,
              sy-tabix          TO ti_badi-linea,
              ti_programa-cf    TO ti_badi-cf,
              ti_includes-nivel TO ti_badi-nivel.
        APPEND ti_badi.
      ENDIF.
    ENDIF.
  ELSE.
    CHECK p_handl IS NOT INITIAL.
*- VERIFICA SI EN LA LINEA DEL PROGRAMA EXISTE ALGUNA INSTANCIA DE
*- UNA BADI.
    SEARCH ti_programa-cf FOR c_handler.
*- SE ENCONTRO UNA INSTANCIA DE IMPLEMENACIÓN Y SE VERIFICA SI LA LINEA
*- NO ESTÁ COMENTADA.
    IF  sy-subrc EQ 0
    AND ti_programa-cf+0(1) NE c_comentario.

      SEARCH ti_programa-cf FOR c_include.
      CHECK sy-subrc NE 0.
      CLEAR ti_badi.
*- REMUEVE ESPACIOS EN EL INICIO DEL STRING.
      SHIFT ti_programa-cf LEFT DELETING LEADING space.
      MOVE: ti_includes-nome  TO ti_badi-programa,
            c_b               TO ti_badi-tipo,
            sy-tabix          TO ti_badi-linea,
            ti_programa-cf    TO ti_badi-cf,
            ti_includes-nivel TO ti_badi-nivel.
      APPEND ti_badi.
    ENDIF.
  ENDIF.

ENDFORM.                    " buscar_badi

*&---------------------------------------------------------------------*
*&      Form  buscar_bte
*&---------------------------------------------------------------------*
*       Buscar BTE.
*----------------------------------------------------------------------*
FORM buscar_bte .

*- VERIFICA SI EN LA LINEA DEL PROGRAMA EXISTE ALGUNA BTE.
  SEARCH ti_programa-cf FOR c_bte.
*- SE ENCONTRO UNA BTE Y SE VERIFICA SI LA LINEA NO ESTÁ COMENTADA.
  IF  sy-subrc EQ 0
  AND ti_programa-cf+0(1) NE c_comentario.
* 'OPEN_FI_PERFORM'.

*- VERIFICO QUE TRAIGA EL LLAMADO A LA FUNCIÓN DE LA BTE.
    SEARCH ti_programa-cf FOR c_funcao_2.
    CHECK sy-subrc EQ 0.
*- VERIFICO QUE NO TRAIGA LOS INCLUDE DEL GRUPO DE FUNCIÓN.
    SEARCH ti_programa-cf FOR c_include.
    CHECK sy-subrc NE 0.
*- VERIFICO QUE NO TRAIGA LOS ENDFORM.
    SEARCH ti_programa-cf FOR c_endform.
    CHECK sy-subrc NE 0.

    CLEAR ti_bte.
*- REMUEVE ESPACIOS EN EL INICIO DEL STRING.
    SHIFT ti_programa-cf LEFT DELETING LEADING space.
    MOVE: ti_includes-nome  TO ti_bte-programa,
          c_bt              TO ti_bte-tipo,
          sy-tabix          TO ti_bte-linea,
          ti_programa-cf    TO ti_bte-cf,
          ti_includes-nivel TO ti_bte-nivel.
    APPEND ti_bte.
  ENDIF.

*- VERIFICA SI EN LA LINEA DEL PROGRAMA EXISTE ALGUNA BTE.
  SEARCH ti_programa-cf FOR c_bte1.
*- SE ENCONTRO UNA BTE Y SE VERIFICA SI LA LINEA NO ESTÁ COMENTADA.
  IF  sy-subrc EQ 0
  AND ti_programa-cf+0(1) NE c_comentario.
* 'OUTBOUND_CALL'.

*- VERIFICO QUE TRAIGA EL LLAMADO A LA FUNCIÓN DE LA BTE.
    SEARCH ti_programa-cf FOR c_funcao_2.
    CHECK sy-subrc EQ 0.
*- VERIFICO QUE NO TRAIGA LOS INCLUDE DEL GRUPO DE FUNCIÓN.
    SEARCH ti_programa-cf FOR c_include.
    CHECK sy-subrc NE 0.
*- VERIFICO QUE NO TRAIGA LOS ENDFORM.
    SEARCH ti_programa-cf FOR c_endform.
    CHECK sy-subrc NE 0.

    CLEAR ti_bte.
*- REMUEVE ESPACIOS EN EL INICIO DEL STRING.
    SHIFT ti_programa-cf LEFT DELETING LEADING space.
    MOVE: ti_includes-nome  TO ti_bte-programa,
          c_bt              TO ti_bte-tipo,
          sy-tabix          TO ti_bte-linea,
          ti_programa-cf    TO ti_bte-cf,
          ti_includes-nivel TO ti_bte-nivel.
    APPEND ti_bte.
  ENDIF.

ENDFORM.                    " buscar_bte

*&---------------------------------------------------------------------*
*&      Form  repid_f4
*&---------------------------------------------------------------------*
*       Ejecuto el F4 para buscar programas.
*----------------------------------------------------------------------*
FORM repid_f4 .

  CALL FUNCTION 'REPOSITORY_INFO_SYSTEM_F4'
    EXPORTING
      object_type          = 'PROG'
      object_name          = p_prog
      suppress_selection   = 'X'
    IMPORTING
      object_name_selected = p_prog
    EXCEPTIONS
      cancel               = 1
      wrong_type           = 2
      OTHERS               = 3.

ENDFORM.                                                    " repid_f4

*&---------------------------------------------------------------------*
*&      Form  visualizar_badi
*&---------------------------------------------------------------------*
*       Visualizo las definiciones de la BADI.
*---------------------------------------------------------------------*
FORM visualizar_badi  USING p_cf LIKE ti_user_exit-cf.

  DATA:
    l_answer(1),
    l_inter_name LIKE sxs_inter-inter_name,
    l_cf TYPE i.

  DATA: BEGIN OF lt_cf OCCURS 0,
          linea(500),
        END OF lt_cf.

  SEARCH p_cf FOR c_type_ref.

  CHECK sy-subrc IS INITIAL.

  REFRESH lt_cf.

  l_cf = 500 - sy-fdpos.

  SPLIT p_cf+sy-fdpos(l_cf) AT space INTO TABLE lt_cf.

  CHECK sy-subrc IS INITIAL.

  READ TABLE lt_cf INDEX 4.

  TRANSLATE lt_cf-linea TO UPPER CASE.
  TRANSLATE lt_cf-linea USING '. , '.

  MOVE lt_cf-linea TO l_inter_name.

* Obtengo a partir de la interface la definición de la BADI.
  SELECT SINGLE *
    FROM sxs_inter
    WHERE inter_name EQ l_inter_name.

  CHECK sy-subrc IS INITIAL.

* Muestro POP-UP para selección de si se desea visualiar la definición
* o la implementación de la BADI.
  CALL FUNCTION 'POPUP_WITH_2_BUTTONS_TO_CHOOSE'
    EXPORTING
      defaultoption = '1'
      diagnosetext1 = 'Definición BADI:'
      diagnosetext2 = sxs_inter-exit_name
      diagnosetext3 = '.'
      textline1     = ' '
      textline2     = 'Defina la visualización:'
      textline3     = ' '
      text_option1  = 'Definición BADI'
      text_option2  = 'Implementación BADI'
      titel         = 'Seleccionar tipo:'
    IMPORTING
      answer        = l_answer.

  CASE l_answer.
    WHEN '1'.
* Visualizo la definición de la BADI.
      CALL FUNCTION 'SXO_BADI_SHOW'
        EXPORTING
          exit_name         = sxs_inter-exit_name
        EXCEPTIONS
          action_canceled   = 1
          access_failure    = 2
          badi_not_exixting = 3
          OTHERS            = 4.

    WHEN '2'.
* Visualizo la implementación de la BADI.
      CALL FUNCTION 'SXO_IMPL_FOR_BADI_OVER'
        EXPORTING
          exit_name         = sxs_inter-exit_name
        EXCEPTIONS
          no_imps_existing  = 1
          badi_not_existing = 2
          action_canceled   = 3
          OTHERS            = 4.

      IF sy-subrc = 1.
        MESSAGE s380(enhancement) WITH sxs_inter-exit_name.
      ENDIF.

    WHEN OTHERS.
* Do Nothing !!
  ENDCASE.

ENDFORM.                    " visualizar_badi

*&---------------------------------------------------------------------*
*&      Form  visualizar_exit
*&---------------------------------------------------------------------*
*       Visualizo el USER-EXIT.
*----------------------------------------------------------------------*
*      -->P_REPID Nombre del programa.
*      -->P_CF    Linea de código del programa.
*----------------------------------------------------------------------*
FORM visualizar_exit USING p_repid LIKE sy-repid
                           p_cf    LIKE ti_user_exit-cf.

  DATA:
    l_exit        LIKE rs38l-name,
    l_modname     LIKE modact-name,
    l_standard(3) TYPE c,
    l_cf          TYPE i,
    l_linea(500)  TYPE c.

  DATA: BEGIN OF lt_cf OCCURS 0,
          linea(500),
        END OF lt_cf.

  CLEAR: d010inc, modsap, modact.

* Obtengo el programa de control.
  SELECT SINGLE *
    FROM d010inc
    WHERE include EQ p_repid.

  IF sy-subrc NE 0.
* No se trata de un INCLUDE.
    MOVE p_repid TO d010inc-master.
  ENDIF.

  SEARCH p_cf FOR c_enhance.

  CHECK sy-subrc IS INITIAL.

  REFRESH lt_cf.

  l_cf = 500 - sy-fdpos.

  MOVE p_cf+sy-fdpos(l_cf) TO l_linea.

  SPLIT l_linea AT space INTO TABLE lt_cf.
* Obtengo la posición del número del exit.
  READ TABLE lt_cf INDEX 3.

  TRANSLATE lt_cf USING ''' '.
  CONDENSE lt_cf NO-GAPS.

* Armo el nombre del exit.
  CONCATENATE 'EXIT' d010inc-master lt_cf INTO l_exit
    SEPARATED BY '_'.

* Obtengo la ampliación.
  SELECT SINGLE *
    FROM modsap
    WHERE member EQ l_exit.

  CHECK sy-subrc IS INITIAL.

* Verifico las modificaciones.
  SELECT SINGLE *
    FROM modact
    WHERE member EQ modsap-name.

  IF sy-subrc IS INITIAL.
* Se encontró el proyecto para la ampliación.
    MOVE:
      modact-name   TO l_modname,
      c_std_implmnt TO l_standard.

    CALL FUNCTION 'MOD_COMPONENTS'
      EXPORTING
        mode               = 'SHOM'
        modname            = l_modname
        p_standard         = l_standard
      EXCEPTIONS
        permission_failure = 1
        not_found          = 2
        OTHERS             = 3.

  ELSE.
* No hay proyecto para la ampliación.
    MOVE:
      modsap-name      TO l_modname.

    CALL FUNCTION 'MOD_SAP_HEAD'
      EXPORTING
        mode          = 'SHOM'
        modname       = l_modname
      EXCEPTIONS
        attr_enqueued = 1
        text_enqueued = 2
        OTHERS        = 3.

  ENDIF.

ENDFORM.                    " visualizar_exit

*&---------------------------------------------------------------------*
*&      Form  buscar_field_exit
*&---------------------------------------------------------------------*
*       Busco los field-exit's de los campos de las DYNPRO's.
*----------------------------------------------------------------------*
FORM buscar_field_exit .

  DATA: BEGIN OF lt_campo OCCURS 0,
          repid     LIKE sy-repid,
          dnum      LIKE d020s-dnum,
          tabname   LIKE dd03l-tabname,
          fieldname LIKE dd03l-fieldname,
        END OF lt_campo.

  DATA: BEGIN OF lt_fe OCCURS 0,
          cf(500),
        END OF lt_fe.

  DATA:
    l_prog   LIKE sy-repid,
    lt_d020s LIKE d020s OCCURS 0 WITH HEADER LINE,
    lt_d021s LIKE d021s OCCURS 0 WITH HEADER LINE,
    lt_dd03l LIKE dd03l OCCURS 0 WITH HEADER LINE.

  CHECK p_fdex IS NOT INITIAL.

  CLEAR ti_fdex.
  REFRESH: lt_d020s, lt_d021s, lt_dd03l, lt_fe.

  MOVE: c_fdex TO ti_fdex-tipo.
  APPEND ti_fdex.

  IF p_prog IS NOT INITIAL.
    MOVE p_prog   TO l_prog.
  ELSE.
    MOVE tstc-pgmna TO l_prog.
  ENDIF.

* Obtengo las DYNPRO del programa.
  SELECT *
    FROM d020s
    INTO CORRESPONDING FIELDS OF TABLE lt_d020s
    WHERE prog EQ l_prog.

  LOOP AT lt_d020s.

    DESCRIBE TABLE ti_includes.
    PERFORM evitar_time_out USING sy-tfill.

    REFRESH lt_d021s.

* Obtengo los campos de la DYNPRO.
    CALL FUNCTION 'RS_SCRP_GET_SCREEN_INFOS'
      EXPORTING
        dynnr                 = lt_d020s-dnum
        progname              = lt_d020s-prog
      TABLES
        fieldlist             = lt_d021s
      EXCEPTIONS
        dynpro_does_not_exist = 1
        no_field_list         = 2
        cancelled             = 3
        OTHERS                = 4.

* Recorro solo los campos de entrada/salida.
    LOOP AT lt_d021s WHERE ityp = 'C'
                        OR ityp = 'N'
                        OR ityp = 'X'.

      SEARCH lt_d021s-fnam FOR '-'.

      IF sy-subrc IS INITIAL.

        MOVE:
          lt_d020s-prog TO lt_campo-repid,
          lt_d020s-dnum TO lt_campo-dnum.

* Separo el campo de la tabla o estructura.
        SPLIT lt_d021s-fnam AT '-' INTO lt_campo-tabname
                                        lt_campo-fieldname.

        APPEND lt_campo.

      ENDIF.

    ENDLOOP.
  ENDLOOP.

  CHECK lt_campo[] IS NOT INITIAL.

  SORT lt_campo BY repid dnum tabname fieldname.
  DELETE ADJACENT DUPLICATES FROM lt_campo.

* Obtengo los elementos de datos.
  SELECT *
    FROM dd03l
    INTO CORRESPONDING FIELDS OF TABLE lt_dd03l
    FOR ALL ENTRIES IN lt_campo
    WHERE tabname   EQ lt_campo-tabname
      AND fieldname EQ lt_campo-fieldname.

  SORT lt_dd03l BY rollname.
  DELETE ADJACENT DUPLICATES FROM lt_dd03l.

  LOOP AT lt_dd03l.

    CLEAR: tddir, tddirs.

    SELECT SINGLE *
      FROM tddir
      WHERE de EQ lt_dd03l-rollname.

    CHECK sy-subrc IS INITIAL.

    DESCRIBE TABLE ti_includes.
    PERFORM evitar_time_out USING sy-tfill.

    IF tddir-activ EQ 'S'.
* Selectivo en dynpros.
      SELECT SINGLE *
        FROM tddirs
        WHERE de    EQ lt_dd03l-rollname
          AND prog  EQ lt_d020s-prog.

      CHECK sy-subrc IS INITIAL.
* Verifico si se trata del programa en cuestión.
    ENDIF.

* Armo la FM.
    CONCATENATE 'FIELD_EXIT_' lt_dd03l-rollname INTO lt_fe-cf.

    IF tddirs-exitnr IS NOT INITIAL.
      CONCATENATE ti_user_exit-cf tddirs-exitnr INTO lt_fe-cf
        SEPARATED BY '_'.
    ENDIF.

    READ TABLE lt_fe WITH KEY cf = lt_fe-cf.

    CHECK sy-subrc IS NOT INITIAL.
* Aún no se encontró el field-exit.
    APPEND lt_fe.
  ENDLOOP.

  LOOP AT lt_fe.
* Cargo los field-exit's.
    MOVE:
      c_fdex   TO ti_fdex-tipo,
      lt_fe-cf TO ti_fdex-cf.
    APPEND ti_fdex.

  ENDLOOP.

ENDFORM.                    " buscar_field_exit

*&---------------------------------------------------------------------*
*&      Form  fibf
*&---------------------------------------------------------------------*
*       Visualizo la BTE.
*----------------------------------------------------------------------*
*      -->P_CF  Código fuente
*----------------------------------------------------------------------*
FORM fibf  USING p_cf LIKE ti_bte-cf.

  DATA:
    l_fdpos       TYPE sy-fdpos,
    l_cf          TYPE i,
    l_tipo        TYPE c,
    l_linea(500)  TYPE c.

  SEARCH p_cf FOR c_bte.

  IF sy-subrc IS INITIAL.
* 'OPEN_FI_PERFORM'.
    l_fdpos = sy-fdpos + 16.

    l_cf = 500 - l_fdpos.

    MOVE p_cf+l_fdpos(l_cf) TO l_linea.

    MOVE l_linea+9(1) TO l_tipo.

  ELSE.

    SEARCH p_cf FOR c_bte1.

    CHECK sy-subrc IS INITIAL.
* 'OUTBOUND_CALL'.
    l_fdpos = sy-fdpos + 14.

    l_cf = 500 - l_fdpos.

    MOVE p_cf+l_fdpos(l_cf) TO l_linea.

    MOVE l_linea+9(1) TO l_tipo.

  ENDIF.

  IF l_tipo IS NOT INITIAL.

    PERFORM visualizar_bte USING l_tipo
                                 l_linea.

  ELSE.
    CALL TRANSACTION 'FIBF'.
  ENDIF.

ENDFORM.                    " fibf

*&---------------------------------------------------------------------*
*&      Form  breakpoint
*&---------------------------------------------------------------------*
*       Seteo los breakpoint para las intancias de las BADI's
*       y para los eventos de las BTE's.
*----------------------------------------------------------------------*
FORM breakpoint .

  TYPES: BEGIN OF showbreakpointstruc.
  INCLUDE TYPE breakpoint.
  TYPES:   mainprog TYPE trdir-name,
          text(72),
          mark(1).
  TYPES: END OF showbreakpointstruc.
  DATA: showbreakpointtab TYPE TABLE OF showbreakpointstruc.

  IF p_badi IS NOT INITIAL AND p_handl IS NOT INITIAL.
* Break en el método GET_INSTANCE de la clase CL_EXITHANDLER para
* obtener la definiciones de las BADI's.
    CALL FUNCTION 'RS_SET_BREAKPOINT'
      EXPORTING
        index        = '25'
        program      = 'CL_EXITHANDLER================CM001'
        mainprogram  = 'CL_EXITHANDLER================CP'
      EXCEPTIONS
        not_executed = 1
        OTHERS       = 2.
  ENDIF.

  IF p_bte IS NOT INITIAL.
* Break en el módulo de funciones BF_FUNCTIONS_FIND para obtener los
* eventos de las BTE's de proceso.
    CALL FUNCTION 'RS_SET_BREAKPOINT'
      EXPORTING
        index        = '15'
        program      = 'LITSRU02'
        mainprogram  = 'SAPLITSR'
      EXCEPTIONS
        not_executed = 1
        OTHERS       = 2.

* Break en el módulo de funciones PC_FUNCTION_FIND para obtener los
* eventos de las P&S (publicación y suscripción) BTE's.
    CALL FUNCTION 'RS_SET_BREAKPOINT'
      EXPORTING
        index        = '18'
        program      = 'LITSRU07'
        mainprogram  = 'SAPLITSR'
      EXCEPTIONS
        not_executed = 1
        OTHERS       = 2.
  ENDIF.

  IF p_sust IS NOT INITIAL.
* Break en el módulo de funciones G_VSR_SUBSTITUTION_CALL del cual se
* desprende el llamado a las sustituciones.
    CALL FUNCTION 'RS_SET_BREAKPOINT'
      EXPORTING
        index        = '42'
        program      = 'LGBL5U04'
        mainprogram  = 'SAPLGBL5'
      EXCEPTIONS
        not_executed = 1
        OTHERS       = 2.

* Break en el módulo de funciones G_VSR_MULTI_SUBSTITUTION_CALL del cual
* se desprende el llamado a las sustituciones.
    CALL FUNCTION 'RS_SET_BREAKPOINT'
      EXPORTING
        index        = '21'
        program      = 'LGBL5U09'
        mainprogram  = 'SAPLGBL5'
      EXCEPTIONS
        not_executed = 1
        OTHERS       = 2.
  ENDIF.

  IF p_val IS NOT INITIAL.
* Break en el módulo de funciones G_VSR_VALIDATION_CALL del cual se
* desprende el llamado a las validaciones.
    CALL FUNCTION 'RS_SET_BREAKPOINT'
      EXPORTING
        index        = '30'
        program      = 'LGBL5U01'
        mainprogram  = 'SAPLGBL5'
      EXCEPTIONS
        not_executed = 1
        OTHERS       = 2.

* Break en el módulo de funciones G_VSR_MULTI_VALIDATION_CALL del cual
* se desprende el llamado a las validaciones.
    CALL FUNCTION 'RS_SET_BREAKPOINT'
      EXPORTING
        index        = '15'
        program      = 'LGBL5U08'
        mainprogram  = 'SAPLGBL5'
      EXCEPTIONS
        not_executed = 1
        OTHERS       = 2.
  ENDIF.


* Visualizo todos los breakpoint.
  CALL FUNCTION 'RS_SHOW_BREAKPOINTS'
    EXPORTING
      objektinfp  = '*'
      objekttypp  = 'PG'
      text1p      = ' '
      text2p      = ' '
      text3p      = ' '
    TABLES
      breakpoints = showbreakpointtab.

ENDFORM.                    " breakpoint

*&---------------------------------------------------------------------*
*&      Form  construir_catalogo_badi
*&---------------------------------------------------------------------*
*       Construir catalogo de campos para ALV.
*----------------------------------------------------------------------*
FORM construir_catalogo_badi .

  DATA:
    l_repid  LIKE sy-repid.

  REFRESH: ti_cat.

  l_repid = sy-repid.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name         = l_repid
      i_internal_tabname     = 'TI_BADI'
      i_inclname             = l_repid
    CHANGING
      ct_fieldcat            = ti_cat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

* Asignar atributos de campo en el catalogo de reporte ALV
  PERFORM asignar_campo_a_catalogo TABLES ti_cat
                                   USING:

  'SEL'       'X' 'X' 'X' ' ' ' ' 'X' 'X' ' ' ' ' ' ',
  'PROGRAMA'  'X' ' ' 'X' ' ' ' ' ' ' ' ' ' ' ' ' c_text_01,
  'TIPO'      'X' ' ' ' ' 'X' ' ' ' ' ' ' ' ' ' ' c_text_05,
  'NIVEL'     'X' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' c_text_02,
  'BREAK'     'X' ' ' ' ' 'X' ' ' ' ' ' ' ' ' ' ' c_text_07,
  'LINEA'     'X' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' c_text_03,
  'CF'        ' ' ' ' ' ' 'X' ' ' ' ' ' ' ' ' ' ' c_text_04.

ENDFORM.                    " construir_catalogo_badi

*&---------------------------------------------------------------------*
*&      Form  construir_catalogo_bte
*&---------------------------------------------------------------------*
*       Construir catalogo de campos para ALV.
*----------------------------------------------------------------------*
FORM construir_catalogo_bte .

  DATA:
    l_repid  LIKE sy-repid.

  REFRESH: ti_cat.

  l_repid = sy-repid.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name         = l_repid
      i_internal_tabname     = 'TI_BTE'
      i_inclname             = l_repid
    CHANGING
      ct_fieldcat            = ti_cat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

* Asignar atributos de campo en el catalogo de reporte ALV
  PERFORM asignar_campo_a_catalogo TABLES ti_cat
                                   USING:

  'SEL'       'X' 'X' 'X' ' ' ' ' 'X' 'X' ' ' ' ' ' ',
  'PROGRAMA'  'X' ' ' 'X' ' ' ' ' ' ' ' ' ' ' ' ' c_text_01,
  'TIPO'      'X' ' ' ' ' 'X' ' ' ' ' ' ' ' ' ' ' c_text_05,
  'NIVEL'     'X' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' c_text_02,
  'BREAK'     'X' ' ' ' ' 'X' ' ' ' ' ' ' ' ' 'X' c_text_07,
  'LINEA'     'X' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' c_text_03,
  'CF'        ' ' ' ' ' ' 'X' ' ' ' ' ' ' ' ' ' ' c_text_04.

ENDFORM.                    " construir_catalogo_bte

*&---------------------------------------------------------------------*
*&      Form  construir_catalogo_FDEX
*&---------------------------------------------------------------------*
*       Construir catalogo de campos para ALV.
*----------------------------------------------------------------------*
FORM construir_catalogo_fdex .

  DATA:
    l_repid  LIKE sy-repid.

  REFRESH: ti_cat.

  l_repid = sy-repid.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name         = l_repid
      i_internal_tabname     = 'TI_FDEX'
      i_inclname             = l_repid
    CHANGING
      ct_fieldcat            = ti_cat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

* Asignar atributos de campo en el catalogo de reporte ALV
  PERFORM asignar_campo_a_catalogo TABLES ti_cat
                                   USING:

  'SEL'       'X' 'X' 'X' ' ' ' ' 'X' 'X' ' ' ' ' ' ',
  'TIPO'      'X' ' ' ' ' 'X' ' ' ' ' ' ' ' ' ' ' c_text_05,
  'CF'        ' ' ' ' ' ' 'X' ' ' ' ' ' ' ' ' ' ' c_text_04.

ENDFORM.                    " construir_catalogo_FDEX

*&---------------------------------------------------------------------*
*&      Form  cargar_break
*&---------------------------------------------------------------------*
*       Cargo los break-points en las tablas correspondientes.
*----------------------------------------------------------------------*
FORM cargar_break .

  TYPES: BEGIN OF showbreakpointstruc.
  INCLUDE TYPE breakpoint.
  TYPES:   mainprog TYPE trdir-name,
          text(72),
          mark(1).
  TYPES: END OF showbreakpointstruc.

  DATA:
    l_tabix   TYPE sy-tabix,
    l_line    TYPE breakpoint-line,
    l_program TYPE breakpoint-program,
    wa_break  TYPE showbreakpointstruc,
    lt_break  TYPE TABLE OF showbreakpointstruc.

* Obtengo todos los breakpoints marcados.
  CALL FUNCTION 'RS_GET_ALL_BREAKPOINTS'
    TABLES
      breakpointtab = lt_break.

  CHECK lt_break[] IS NOT INITIAL.

  IF p_ue IS NOT INITIAL.
    LOOP AT ti_user_exit.
      l_tabix = sy-tabix.

      MOVE:
        ti_user_exit-linea    TO l_line,
        ti_user_exit-programa TO l_program.

      READ TABLE lt_break INTO wa_break
                          WITH KEY program = l_program
                                   line    = l_line.

      IF sy-subrc IS INITIAL.
        MOVE icon_breakpoint TO ti_user_exit-break.
      ELSE.
        MOVE icon_space TO ti_user_exit-break.
      ENDIF.
      MODIFY ti_user_exit INDEX l_tabix.
    ENDLOOP.
  ENDIF.

  IF p_badi IS NOT INITIAL.
    LOOP AT ti_badi.
      l_tabix = sy-tabix.

      MOVE:
        ti_badi-linea    TO l_line,
        ti_badi-programa TO l_program.

      READ TABLE lt_break INTO wa_break
                          WITH KEY program = l_program
                                   line    = l_line.

      IF sy-subrc IS INITIAL.
        MOVE icon_breakpoint TO ti_badi-break.
      ELSE.
        MOVE icon_space TO ti_badi-break.
      ENDIF.
      MODIFY ti_badi INDEX l_tabix.
    ENDLOOP.
  ENDIF.

  IF p_bte IS NOT INITIAL.
    LOOP AT ti_bte.
      l_tabix = sy-tabix.

      MOVE:
        ti_bte-linea    TO l_line,
        ti_bte-programa TO l_program.

      READ TABLE lt_break INTO wa_break
                          WITH KEY program = l_program
                                   line    = l_line.

      IF sy-subrc IS INITIAL.
        MOVE icon_breakpoint TO ti_bte-break.
      ELSE.
        MOVE icon_space TO ti_bte-break.
      ENDIF.
      MODIFY ti_bte INDEX l_tabix.
    ENDLOOP.
  ENDIF.

ENDFORM.                    " cargar_break

*&---------------------------------------------------------------------*
*&      Form  asignar_break
*&---------------------------------------------------------------------*
*       Asigno el break a la linea.
*----------------------------------------------------------------------*
*      -->P_PROGRAMA  text
*      -->P_LINEA  text
*      -->P_BREAK  text
*----------------------------------------------------------------------*
FORM asignar_break  USING p_programa TYPE sy-repid
                          p_linea    LIKE ti_bte-linea
                          p_break    TYPE icon-id.

  TYPES: BEGIN OF showbreakpointstruc.
  INCLUDE TYPE breakpoint.
  TYPES:   mainprog TYPE trdir-name,
          text(72),
          mark(1).
  TYPES: END OF showbreakpointstruc.
  DATA: showbreakpointtab TYPE TABLE OF showbreakpointstruc.

  DATA:
    l_tabix   TYPE sy-tabix,
    l_line    TYPE breakpoint-line,
    l_program TYPE breakpoint-program,
    wa_break  TYPE showbreakpointstruc,
    lt_break  TYPE TABLE OF showbreakpointstruc.

* Obtengo todos los breakpoints marcados.
  CALL FUNCTION 'RS_GET_ALL_BREAKPOINTS'
    TABLES
      breakpointtab = lt_break.

  SELECT SINGLE *
    FROM d010inc
    WHERE include = p_programa.

  IF sy-subrc IS NOT INITIAL.
    MOVE p_programa TO d010inc-master.
  ENDIF.

  MOVE:
    p_linea    TO l_line,
    p_programa TO l_program.

  READ TABLE lt_break INTO wa_break
                      WITH KEY program = l_program
                               line    = l_line.

  IF sy-subrc IS INITIAL.
* Borro el break.
    CALL FUNCTION 'RS_DELETE_BREAKPOINT'
      EXPORTING
        index    = p_linea
        mainprog = d010inc-master
        program  = p_programa.
  ELSE.
* Seteo el breakpoint.
    CALL FUNCTION 'RS_SET_BREAKPOINT'
      EXPORTING
        index        = p_linea
        program      = p_programa
        mainprogram  = d010inc-master
      EXCEPTIONS
        not_executed = 1
        OTHERS       = 2.
  ENDIF.

* Visualizo todos los breakpoint.
  CALL FUNCTION 'RS_SHOW_BREAKPOINTS'
    EXPORTING
      objektinfp  = '*'
      objekttypp  = 'PG'
      text1p      = ' '
      text2p      = ' '
      text3p      = ' '
    TABLES
      breakpoints = showbreakpointtab.

ENDFORM.                    " asignar_break

*&---------------------------------------------------------------------*
*&      Form  buscar_user_exit
*&---------------------------------------------------------------------*
*       Obtengo los user-exits.
*----------------------------------------------------------------------*
FORM buscar_user_exit .

  IF p_prog IS INITIAL.
    MOVE tstc-pgmna TO p_prog.
  ENDIF.

  PERFORM get_objects.     "Get Objects

ENDFORM.                    " buscar_user_exit

*&---------------------------------------------------------------------*
*& Form get_objects
*&---------------------------------------------------------------------*
* Get Objects
*----------------------------------------------------------------------*
FORM get_objects.

  DATA:
    l_fname LIKE rs38l-name,
    l_group LIKE rs38l-area,
    l_include LIKE rs38l-include,
    l_namespace LIKE rs38l-namespace,
    l_str_area LIKE rs38l-str_area.

  DATA: v_include LIKE rodiobj-iobjnm.
  DATA: e_t_include TYPE STANDARD TABLE OF abapsource WITH HEADER LINE.
  DATA:
    l_line TYPE string,
    l_tabix LIKE sy-tabix.

  SELECT obj_name devclass
    INTO TABLE ti_tadir
    FROM tadir
    WHERE pgmid    = 'R3TR' AND
          object   = 'PROG' AND
          obj_name = p_prog.

  IF sy-subrc = 0.

    SORT ti_tadir BY obj_name devclass.

    SELECT obj_name
      INTO TABLE ti_jtab
      FROM tadir
      FOR ALL ENTRIES IN ti_tadir
      WHERE pgmid    = 'R3TR' AND
            object   = 'SMOD' AND
            devclass = ti_tadir-devclass.

    IF sy-subrc = 0.
      SORT ti_jtab BY obj_name.
    ENDIF.
  ENDIF.

*- Get UserExit names
  LOOP AT ti_jtab.

    SELECT name member
      INTO (ti_final-name, ti_final-member)
      FROM modsap
      WHERE name = ti_jtab-obj_name AND
            typ  = 'E'.

      APPEND ti_final.
      CLEAR ti_final.
    ENDSELECT.
  ENDLOOP.
*- Process it_final contents.
  LOOP AT ti_final.
    l_tabix = sy-tabix.
    CLEAR:
      l_fname, l_group, l_include, l_namespace, l_str_area.

    l_fname = ti_final-member.

    CALL FUNCTION 'FUNCTION_EXISTS'
      EXPORTING
        funcname           = l_fname
      IMPORTING
        group              = l_group
        include            = l_include
        namespace          = l_namespace
        str_area           = l_str_area
      EXCEPTIONS
        function_not_exist = 1
        OTHERS             = 2.

    IF sy-subrc = 0.
      IF NOT l_include IS INITIAL.
*- Get Source code of include.
        CLEAR: v_include, e_t_include, e_t_include[].
        v_include = l_include.
*        CALL FUNCTION 'MU_INCLUDE_GET'
*          EXPORTING
*            i_include   = v_include
*          TABLES
*            e_t_include = e_t_include.
*
*        LOOP AT e_t_include.
*          IF e_t_include-line CS 'INCLUDE'.
*            CLEAR l_line.
*            l_line = e_t_include-line.
*            CONDENSE l_line NO-GAPS.
*            TRANSLATE l_line USING '. '.
*            l_line = l_line+7.
*            ti_final-include  = l_line.
*            ti_final-programa = l_include.
*            MODIFY ti_final INDEX l_tabix
*              TRANSPORTING include programa.
*          ENDIF.
*        ENDLOOP.

        CLEAR tftit.
        SELECT SINGLE stext
          INTO ti_final-stext
          FROM tftit
          WHERE spras = sy-langu AND
                funcname = ti_final-member.
        MODIFY ti_final INDEX l_tabix TRANSPORTING stext.
      ENDIF.
    ENDIF.
  ENDLOOP.

ENDFORM.                                         " get_objects

*&---------------------------------------------------------------------*
*&      Form  construir_catalogo_uexit
*&---------------------------------------------------------------------*
*       Construir catalogo de campos para ALV
*----------------------------------------------------------------------*
FORM construir_catalogo_uexit .

  DATA:
    l_repid  LIKE sy-repid.

  REFRESH: ti_cat.

  l_repid = sy-repid.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name         = l_repid
      i_internal_tabname     = 'TI_FINAL'
      i_inclname             = l_repid
    CHANGING
      ct_fieldcat            = ti_cat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

* Asignar atributos de campo en el catalogo de reporte ALV
  PERFORM asignar_campo_a_catalogo TABLES ti_cat
                                   USING:

  'SEL'       'X' 'X' 'X' ' ' ' ' 'X' 'X' ' ' ' ' ' ',
  'NAME'      'X' ' ' ' ' 'X' ' ' ' ' ' ' ' ' ' ' ' ',
  'MEMBER'    'X' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ',
  'STEXT'     ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ',
  'INCLUDE'   ' ' ' ' ' ' 'X' ' ' ' ' ' ' ' ' ' ' ' ',
  'PROGRAMA'  ' ' ' ' ' ' ' ' ' ' ' ' ' ' 'X' ' ' ' '.

ENDFORM.                    " construir_catalogo_uexit

*&---------------------------------------------------------------------*
*&      Form  visualizar_ampliacion
*&---------------------------------------------------------------------*
*       Visualizo la ampliación de un exit.
*----------------------------------------------------------------------*
FORM visualizar_ampliacion .

  DATA:
    l_ret     TYPE c,
    l_member  TYPE modsap-member,
    lt_fields TYPE sval OCCURS 0 WITH HEADER LINE.

  MOVE:
    'MODSAP'    TO lt_fields-tabname,
    'MEMBER'    TO lt_fields-fieldname,
    'User-Exit' TO lt_fields-fieldtext.

  APPEND lt_fields.

  CALL FUNCTION 'POPUP_GET_VALUES'
    EXPORTING
      popup_title     = 'Ingrese user-exit:'
    IMPORTING
      returncode      = l_ret
    TABLES
      fields          = lt_fields
    EXCEPTIONS
      error_in_fields = 1
      OTHERS          = 2.

* Verifico que no haya cancelado.
  CHECK l_ret NE 'A'.

  READ TABLE lt_fields INDEX 1.

  CHECK sy-subrc IS INITIAL.

  IF lt_fields-value IS INITIAL.
*   El exit de función & no existe
    MESSAGE e015(enhancement) WITH lt_fields-value.
  ELSE.
    MOVE lt_fields-value TO l_member.
  ENDIF.

  SELECT SINGLE *
    FROM modsap
    WHERE member EQ l_member.

  IF sy-subrc IS INITIAL.

* Visualizo la ampliación.
    CALL FUNCTION 'MOD_SAP_HEAD'
      EXPORTING
        mode          = 'SHOM'
        modname       = modsap-name
      EXCEPTIONS
        attr_enqueued = 1
        text_enqueued = 2
        OTHERS        = 3.

  ELSE.
*   El exit de función & no existe
    MESSAGE e015(enhancement) WITH l_member.
  ENDIF.

ENDFORM.                    " visualizar_ampliacion

*&---------------------------------------------------------------------*
*&      Form  visualizar_bte
*&---------------------------------------------------------------------*
*       Visualizo la BTE.
*----------------------------------------------------------------------*
*      -->P_TIPO   Tipo de BTE
*      -->P_LINEA  Evento o proceso.
*----------------------------------------------------------------------*
FORM visualizar_bte  USING p_tipo  TYPE c
                           p_linea.

  RANGES:
    r_event FOR tbe01-event,
    r_procs FOR tps01-procs.

  REFRESH: r_event, r_procs.

  CASE p_tipo.
    WHEN 'E'.
* Interface de publicación y suscripción.
      MOVE:
        'I'          TO r_event-sign,
        'EQ'         TO r_event-option,
        p_linea(8)   TO r_event-low.
      APPEND r_event.

      SUBMIT rfopfi00
             WITH event IN r_event
             WITH xonlk = ' '
             AND RETURN.
    WHEN 'P'.
* Interface de proceso.
      MOVE:
        'I'          TO r_procs-sign,
        'EQ'         TO r_procs-option,
        p_linea(8)   TO r_procs-low.
      APPEND r_procs.

      SUBMIT rfopfi01
             WITH procs IN r_procs
             WITH xonlk = ' '
             AND RETURN.
    WHEN OTHERS.
* Do nothing !!
  ENDCASE.

ENDFORM.                    " visualizar_bte

*&---------------------------------------------------------------------*
*&      Form  cargar_bte
*&---------------------------------------------------------------------*
*       Ingreso la BTE que quiero visualizar.
*----------------------------------------------------------------------*
*      -->P_TIPO   Tipo de BTE
*----------------------------------------------------------------------*
FORM cargar_bte  USING p_tipo TYPE c.

  DATA:
    l_linea(500)  TYPE c.

  DATA:
    l_ret     TYPE c,
    lt_fields TYPE sval OCCURS 0 WITH HEADER LINE.

  CASE p_tipo.
    WHEN 'E'.
* Interface de publicación y suscripción.
      MOVE:
        'TBE01' TO lt_fields-tabname,
        'EVENT' TO lt_fields-fieldname.
    WHEN 'P'.
* Interface de proceso.
      MOVE:
        'TPS01' TO lt_fields-tabname,
        'PROCS' TO lt_fields-fieldname.
    WHEN OTHERS.
* Do nothing !!
  ENDCASE.
  APPEND lt_fields.

  CALL FUNCTION 'POPUP_GET_VALUES'
    EXPORTING
      popup_title     = 'Ingrese BTE:'
    IMPORTING
      returncode      = l_ret
    TABLES
      fields          = lt_fields
    EXCEPTIONS
      error_in_fields = 1
      OTHERS          = 2.

* Verifico que no haya cancelado.
  CHECK l_ret NE 'A'.

  READ TABLE lt_fields INDEX 1.

  CHECK sy-subrc IS INITIAL.

  MOVE lt_fields-value TO l_linea.

  PERFORM visualizar_bte USING p_tipo
                               l_linea.

ENDFORM.                    " cargar_bte

*&---------------------------------------------------------------------*
*&      Form  visualizar_interface
*&---------------------------------------------------------------------*
*       Visualizo la definición de la BADI que corresponde a la
*       interface.
*----------------------------------------------------------------------*
FORM visualizar_interface .

  DATA:
    l_linea(500)  TYPE c.

  DATA:
    l_ret        TYPE c,
    l_inter_name TYPE sxs_inter-inter_name,
    lt_fields    TYPE sval OCCURS 0 WITH HEADER LINE.

* Interface.
  MOVE:
    'SXS_INTER'  TO lt_fields-tabname,
    'INTER_NAME' TO lt_fields-fieldname.
  APPEND lt_fields.

  CALL FUNCTION 'POPUP_GET_VALUES'
    EXPORTING
      popup_title     = 'Ingrese interface:'
    IMPORTING
      returncode      = l_ret
    TABLES
      fields          = lt_fields
    EXCEPTIONS
      error_in_fields = 1
      OTHERS          = 2.

* Verifico que no haya cancelado.
  CHECK l_ret NE 'A'.

  READ TABLE lt_fields INDEX 1.

  CHECK sy-subrc IS INITIAL.

  TRANSLATE lt_fields-value TO UPPER CASE.
  MOVE lt_fields-value TO l_inter_name.

* Obtengo a partir de la interface la definición de la BADI.
  SELECT SINGLE *
    FROM sxs_inter
    WHERE inter_name EQ l_inter_name.

  IF sy-subrc IS INITIAL.
* Visualizo la definición de la BADI.
    CALL FUNCTION 'SXO_BADI_SHOW'
      EXPORTING
        exit_name         = sxs_inter-exit_name
      EXCEPTIONS
        action_canceled   = 1
        access_failure    = 2
        badi_not_exixting = 3
        OTHERS            = 4.

  ELSE.
*   El interface & es erróneo.
    MESSAGE e226(enhancement) WITH l_inter_name.
  ENDIF.

ENDFORM.                    "visualizar_interface

*&---------------------------------------------------------------------*
*&      Form  buscar_sustituciones
*&---------------------------------------------------------------------*
*       Obtengo las sustituciones creadas.
*----------------------------------------------------------------------*
FORM buscar_sustituciones .

  CHECK p_sust IS NOT INITIAL.

  SELECT *
    INTO CORRESPONDING FIELDS OF TABLE ti_sust
    FROM gb922.

ENDFORM.                    " buscar_sustituciones

*&---------------------------------------------------------------------*
*&      Form  construir_catalogo_sust
*&---------------------------------------------------------------------*
*       Construir catalogo de campos para ALV.
*----------------------------------------------------------------------*
FORM construir_catalogo_sust .

  DATA:
    l_repid  LIKE sy-repid.

  REFRESH: ti_cat.

  l_repid = sy-repid.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name         = l_repid
      i_internal_tabname     = 'TI_SUST'
      i_inclname             = l_repid
    CHANGING
      ct_fieldcat            = ti_cat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

* Asignar atributos de campo en el catalogo de reporte ALV
  PERFORM asignar_campo_a_catalogo TABLES ti_cat
                                   USING:

  'SEL'       'X' 'X' 'X' ' ' ' ' 'X' 'X' ' ' ' ' ' ',
  'SUBSTID'   'X' ' ' 'X' 'X' ' ' ' ' ' ' ' ' ' ' ' ',
  'SUBSEQNR'  'X' ' ' 'X' 'X' ' ' ' ' ' ' ' ' ' ' ' ',
  'CONSEQNR'  'X' ' ' 'X' ' ' ' ' ' ' ' ' ' ' ' ' ' ',
  'SUBSTAB'   ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ',
  'SUBSFIELD' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ',
  'SUBSVAL'   ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ',
  'EXITSUBST' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' '.

ENDFORM.                    " construir_catalogo_sust

*&---------------------------------------------------------------------*
*&      Form  TOP_OF_PAGE_SUST
*&---------------------------------------------------------------------*
*       Mostrar cabecera de página
*----------------------------------------------------------------------
FORM top_of_page_sust.

  DATA:
    l_tfill_inc(20)  TYPE c,
    l_tfill_cant(20) TYPE c.

  DESCRIBE TABLE ti_sust.
  WRITE sy-tfill TO l_tfill_cant.
  CONDENSE l_tfill_cant NO-GAPS.

* Construir encabezado del reporte
  PERFORM set_header USING l_tfill_cant
                           l_tfill_inc
                           'Sustituciones'.

ENDFORM.                    "TOP_OF_PAGE_SUST

*&---------------------------------------------------------------------*
*&      Form  visualizar_sust
*&---------------------------------------------------------------------*
*       Visualizo la sustitución.
*----------------------------------------------------------------------*
*      -->P_SUBSTID  Nombre de la sustitución
*      -->P_SUBSEQNR Número de paso de la sustitución
*----------------------------------------------------------------------*
FORM visualizar_sust  USING p_substid  TYPE gb922-substid
                            p_subseqnr TYPE gb922-subseqnr.

  DATA:
    l_valuser LIKE gb31-valuser,
    l_valeven LIKE gb31-valevent.

  CALL FUNCTION 'G_BOOL_EXIST_SUBSTITUTION'
    EXPORTING
      substitution = p_substid
    IMPORTING
      valevent_fnd = l_valeven
      valuser_fnd  = l_valuser
    EXCEPTIONS
      not_found    = 1
      OTHERS       = 4.

  CALL FUNCTION 'G_SUBSTITUTION_ENVIRONMENT'
    EXPORTING
      bsubevent         = 'X'
      bsubuser          = 'X'
      subevent          = l_valeven
      substid           = p_substid
      subuser           = l_valuser
      view_only         = 'X'
      action_mode       = 'V'
      skip_first_screen = 'X'
      step              = p_subseqnr
    EXCEPTIONS
      not_found         = 1
      OTHERS            = 2.

ENDFORM.                    " visualizar_sust

*&---------------------------------------------------------------------*
*&      Form  buscar_validaciones
*&---------------------------------------------------------------------*
*       Obtengo las validaciones creadas.
*----------------------------------------------------------------------*
FORM buscar_validaciones .

  CHECK p_val IS NOT INITIAL.

  SELECT *
    INTO CORRESPONDING FIELDS OF TABLE ti_val
    FROM gb931.

ENDFORM.                    " buscar_validaciones

*&---------------------------------------------------------------------*
*&      Form  construir_catalogo_val
*&---------------------------------------------------------------------*
*       Construir catalogo de campos para ALV.
*----------------------------------------------------------------------*
FORM construir_catalogo_val .

  DATA:
    l_repid  LIKE sy-repid.

  REFRESH: ti_cat.

  l_repid = sy-repid.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name         = l_repid
      i_internal_tabname     = 'TI_VAL'
      i_inclname             = l_repid
    CHANGING
      ct_fieldcat            = ti_cat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

* Asignar atributos de campo en el catalogo de reporte ALV
  PERFORM asignar_campo_a_catalogo TABLES ti_cat
                                   USING:

  'SEL'       'X' 'X' 'X' ' ' ' ' 'X' 'X' ' ' ' ' ' ',
  'VALID'     'X' ' ' 'X' 'X' ' ' ' ' ' ' ' ' ' ' ' ',
  'VALSEQNR'  'X' ' ' 'X' 'X' ' ' ' ' ' ' ' ' ' ' ' ',
  'CONDID'    ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ',
  'CHECKID'   ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' '.

ENDFORM.                    " construir_catalogo_val

*&---------------------------------------------------------------------*
*&      Form  TOP_OF_PAGE_VAL
*&---------------------------------------------------------------------*
*       Mostrar cabecera de página
*----------------------------------------------------------------------
FORM top_of_page_val.

  DATA:
    l_tfill_inc(20)  TYPE c,
    l_tfill_cant(20) TYPE c.

  DESCRIBE TABLE ti_val.
  WRITE sy-tfill TO l_tfill_cant.
  CONDENSE l_tfill_cant NO-GAPS.

* Construir encabezado del reporte
  PERFORM set_header USING l_tfill_cant
                           l_tfill_inc
                           'Validaciones'.

ENDFORM.                    "TOP_OF_PAGE_VAL
*&---------------------------------------------------------------------*
*&      Form  visualizar_val
*&---------------------------------------------------------------------*
*       Visualizo la validación.
*----------------------------------------------------------------------*
*      -->P_VALID    Validación
*      -->P_VALSEQNR Número secuencial de una etapa de validación
*----------------------------------------------------------------------*
FORM visualizar_val  USING p_valid    TYPE gb931-valid
                           p_valseqnr TYPE gb931-valseqnr.

  DATA:
    l_valuser LIKE gb31-valuser,
    l_valeven LIKE gb31-valevent.

  CALL FUNCTION 'G_BOOL_EXIST_VALIDATION'
    EXPORTING
      validation   = p_valid
    IMPORTING
      valuser_fnd  = l_valuser
      valevent_fnd = l_valeven
    EXCEPTIONS
      not_found    = 1
      null_id      = 2.

  CALL FUNCTION 'G_VALIDATION_ENVIRONMENT'
    EXPORTING
      action_mode       = 'V'
      skip_first_screen = 'X'
      bvalevent         = 'X'
      bvaluser          = 'X'
      valid             = p_valid
      valuser           = l_valuser
      valevent          = l_valeven
      view_only         = 'X'
      step              = p_valseqnr
    EXCEPTIONS
      not_found         = 1
      OTHERS            = 2.

ENDFORM.                    " visualizar_val

*&---------------------------------------------------------------------*
*&      Form  visualizar_proyecto
*&---------------------------------------------------------------------*
*       Visualizo el proyecto asosiado a una ampliación.
*----------------------------------------------------------------------*
FORM visualizar_proyecto .

  DATA:
    l_ret     TYPE c,
    l_name    TYPE modsap-name,
    l_member  TYPE modact-member,
    l_modname TYPE modact-name,
    l_standard(3) TYPE c,
    lt_fields TYPE sval OCCURS 0 WITH HEADER LINE.

  MOVE:
    'MODSAP' TO lt_fields-tabname,
    'NAME'   TO lt_fields-fieldname.

  APPEND lt_fields.

  CALL FUNCTION 'POPUP_GET_VALUES'
    EXPORTING
      popup_title     = 'Ingrese ampliación:'
    IMPORTING
      returncode      = l_ret
    TABLES
      fields          = lt_fields
    EXCEPTIONS
      error_in_fields = 1
      OTHERS          = 2.

* Verifico que no haya cancelado.
  CHECK l_ret NE 'A'.

  READ TABLE lt_fields INDEX 1.

  CHECK sy-subrc IS INITIAL.

  IF lt_fields-value IS INITIAL.
*   La ampliación & no existe
    MESSAGE e012(enhancement) WITH lt_fields-value.
  ELSE.
    MOVE lt_fields-value TO l_name.
  ENDIF.

  SELECT SINGLE *
    FROM modsap
    WHERE name EQ l_name.

  IF sy-subrc IS INITIAL.

    MOVE l_name TO l_member.

    SELECT SINGLE *
      FROM modact
      WHERE member EQ l_member.

    IF sy-subrc IS INITIAL.
* Se encontró el proyecto para la ampliación.
      MOVE:
        modact-name   TO l_modname,
        c_std_implmnt TO l_standard.

      CALL FUNCTION 'MOD_COMPONENTS'
        EXPORTING
          mode               = 'SHOM'
          modname            = l_modname
          p_standard         = l_standard
        EXCEPTIONS
          permission_failure = 1
          not_found          = 2
          OTHERS             = 3.
    ELSE.
*   Indicar un proyecto de ampliación
      MESSAGE e398(00)
        WITH 'La ampliación ' l_name ' no tiene proyecto.'.
    ENDIF.

  ELSE.
*   La ampliación & no existe
    MESSAGE e012(enhancement) WITH lt_fields-value.
  ENDIF.

ENDFORM.                    " visualizar_proyecto

*&---------------------------------------------------------------------*
*&      Form  buscar_punto_ampliación
*&---------------------------------------------------------------------*
*       Obtengo los puntos de ampliación ya implementados.
*----------------------------------------------------------------------*
FORM buscar_punto_ampliacion .

*- VERIFICA SI EN LA LINEA DEL PROGRAMA EXISTE ALGUN PUNTO DE
*- AMPLIACIÓN.
  SEARCH ti_programa-cf FOR c_enh1.
*- SE ENCONTRO UN PUNTO DE AMPLIACIÓN Y SE VERIFICA SI LA LINEA NO ESTÁ
*- COMENTADA.
  IF  sy-subrc EQ 0
  AND ti_programa-cf+0(1) NE c_comentario.

*- VERIFICO QUE NO TRAIGA LOS INCLUDE DEL GRUPO DE FUNCIÓN.
    SEARCH ti_programa-cf FOR c_include.
    CHECK sy-subrc NE 0.
*- VERIFICO QUE NO TRAIGA LOS ENDENHANCEMENT.
    SEARCH ti_programa-cf FOR c_endenh.
    CHECK sy-subrc NE 0.

*- VERIFICO QUE NO TRAIGA LOS END-ENHANCEMENT-SECTION.
    SEARCH ti_programa-cf FOR c_endenh1.
    CHECK sy-subrc NE 0.

    CLEAR ti_enh.
*- REMUEVE ESPACIOS EN EL INICIO DEL STRING.
    SHIFT ti_programa-cf LEFT DELETING LEADING space.
    MOVE: ti_includes-nome  TO ti_enh-programa,
          c_enht            TO ti_enh-tipo,
          sy-tabix          TO ti_enh-linea,
          ti_programa-cf    TO ti_enh-cf,
          ti_includes-nivel TO ti_enh-nivel.
    APPEND ti_enh.
  ELSE.

*- VERIFICA SI EN LA LINEA DEL PROGRAMA EXISTE ALGUN PUNTO DE
*- AMPLIACIÓN.
    SEARCH ti_programa-cf FOR c_enh2.
*- SE ENCONTRO UN PUNTO DE AMPLIACIÓN Y SE VERIFICA SI LA LINEA NO ESTÁ
*- COMENTADA.
    IF  sy-subrc EQ 0
    AND ti_programa-cf+0(1) NE c_comentario.

*- VERIFICO QUE NO TRAIGA LOS ENDENHANCEMENT.
      SEARCH ti_programa-cf FOR c_endenh.
      CHECK sy-subrc NE 0.

*- VERIFICO QUE NO TRAIGA LOS END-ENHANCEMENT-SECTION.
      SEARCH ti_programa-cf FOR c_endenh1.
      CHECK sy-subrc NE 0.

      CLEAR ti_enh.
*- REMUEVE ESPACIOS EN EL INICIO DEL STRING.
      SHIFT ti_programa-cf LEFT DELETING LEADING space.
      MOVE: ti_includes-nome  TO ti_enh-programa,
            c_enht            TO ti_enh-tipo,
            sy-tabix          TO ti_enh-linea,
            ti_programa-cf    TO ti_enh-cf,
            ti_includes-nivel TO ti_enh-nivel.
      APPEND ti_enh.
    ELSE.

*- VERIFICA SI EN LA LINEA DEL PROGRAMA EXISTE ALGUN PUNTO DE
*- AMPLIACIÓN.
      SEARCH ti_programa-cf FOR c_enh.
*- SE ENCONTRO UN PUNTO DE AMPLIACIÓN Y SE VERIFICA SI LA LINEA NO ESTÁ
*- COMENTADA.
      IF  sy-subrc EQ 0
      AND ti_programa-cf+0(1) NE c_comentario.

*- VERIFICO QUE TRAIGA LOS ENHANCEMENT.
        CHECK ti_programa-cf(11) EQ c_enh.

        CLEAR ti_enh.
*- REMUEVE ESPACIOS EN EL INICIO DEL STRING.
        SHIFT ti_programa-cf LEFT DELETING LEADING space.
        MOVE: ti_includes-nome  TO ti_enh-programa,
              c_enht            TO ti_enh-tipo,
              sy-tabix          TO ti_enh-linea,
              ti_programa-cf    TO ti_enh-cf,
              ti_includes-nivel TO ti_enh-nivel.
        APPEND ti_enh.

      ENDIF.
    ENDIF.
  ENDIF.

ENDFORM.                    " buscar_punto_ampliación

*&---------------------------------------------------------------------*
*&      Form  construir_catalogo_enh
*&---------------------------------------------------------------------*
*       Construir catalogo de campos para ALV.
*----------------------------------------------------------------------*
FORM construir_catalogo_enh .

  DATA:
    l_repid  LIKE sy-repid.

  REFRESH: ti_cat.

  l_repid = sy-repid.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name         = l_repid
      i_internal_tabname     = 'TI_ENH'
      i_inclname             = l_repid
    CHANGING
      ct_fieldcat            = ti_cat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

* Asignar atributos de campo en el catalogo de reporte ALV
  PERFORM asignar_campo_a_catalogo TABLES ti_cat
                                   USING:

  'SEL'       'X' 'X' 'X' ' ' ' ' 'X' 'X' ' ' ' ' ' ',
  'PROGRAMA'  'X' ' ' 'X' ' ' ' ' ' ' ' ' ' ' ' ' c_text_01,
  'TIPO'      'X' ' ' ' ' 'X' ' ' ' ' ' ' ' ' ' ' c_text_05,
  'NIVEL'     'X' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' c_text_02,
  'BREAK'     'X' ' ' ' ' 'X' ' ' ' ' ' ' ' ' 'X' c_text_07,
  'LINEA'     'X' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' c_text_03,
  'CF'        ' ' ' ' ' ' 'X' ' ' ' ' ' ' ' ' ' ' c_text_04.

ENDFORM.                    " construir_catalogo_enh

*&---------------------------------------------------------------------*
*&      Form  buscar_enh
*&---------------------------------------------------------------------*
*       Busco los puntos de ampliación del programa.
*----------------------------------------------------------------------*
FORM buscar_enh .

*  DATA:
*    l_obj_name TYPE enhobj-obj_name.

  DATA: BEGIN OF lt_obj_name OCCURS 0,
          obj_name TYPE enhobj-obj_name,
        END OF lt_obj_name.

  CHECK p_enh IS NOT INITIAL.

*  IF p_prog IS NOT INITIAL.
*    MOVE p_prog TO l_obj_name.
*  ELSE.
*    MOVE tstc-pgmna TO l_obj_name.
*  ENDIF.

  REFRESH lt_obj_name.

  LOOP AT ti_includes.
    APPEND ti_includes-nome TO lt_obj_name.
  ENDLOOP.

  SELECT enhname version obj_type obj_name
    INTO CORRESPONDING FIELDS OF TABLE ti_enhobj
    FROM enhobj
    FOR ALL ENTRIES IN lt_obj_name
    WHERE obj_type EQ 'PROG'
      AND obj_name EQ lt_obj_name-obj_name.

ENDFORM.                    " buscar_enh

*&---------------------------------------------------------------------*
*&      Form  construir_catalogo_enhobj
*&---------------------------------------------------------------------*
*       Construir catalogo de campos para ALV.
*----------------------------------------------------------------------*
FORM construir_catalogo_enhobj .

  DATA:
    l_repid  LIKE sy-repid.

  REFRESH: ti_cat.

  l_repid = sy-repid.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name         = l_repid
      i_internal_tabname     = 'TI_ENHOBJ'
      i_inclname             = l_repid
    CHANGING
      ct_fieldcat            = ti_cat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

* Asignar atributos de campo en el catalogo de reporte ALV
  PERFORM asignar_campo_a_catalogo TABLES ti_cat
                                   USING:

  'SEL'       'X' 'X' 'X' ' ' ' ' 'X' 'X' ' ' ' ' ' ',
  'ENHNAME'   'X' ' ' 'X' 'X' ' ' ' ' ' ' ' ' ' ' ' ',
  'VERSION'   'X' ' ' 'X' ' ' ' ' ' ' ' ' ' ' ' ' ' ',
  'OBJ_TYPE'  ' ' ' ' ' ' ' ' ' ' ' ' ' ' 'X' ' ' ' ',
  'OBJ_NAME'  ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' '.

ENDFORM.                    " construir_catalogo_enhobj

*&---------------------------------------------------------------------*
*&      Form  TOP_OF_PAGE_ENHOBJ
*&---------------------------------------------------------------------*
*       Mostrar cabecera de página
*----------------------------------------------------------------------
FORM top_of_page_enhobj.

  DATA:
    l_tfill_inc(20)  TYPE c,
    l_tfill_cant(20) TYPE c.

  DESCRIBE TABLE ti_enhobj.
  WRITE sy-tfill TO l_tfill_cant.
  CONDENSE l_tfill_cant NO-GAPS.

* Construir encabezado del reporte
  PERFORM set_header USING l_tfill_cant
                           l_tfill_inc
                           'Puntos de ampliación'.

ENDFORM.                    "TOP_OF_PAGE_ENHOBJ

*&---------------------------------------------------------------------*
*&      Form  bi_se19
*&---------------------------------------------------------------------*
*       Visualizo el punto de ampliación implementado.
*----------------------------------------------------------------------*
*      -->P_ENHNAME  Punto de ampliación implementado.
*----------------------------------------------------------------------*
FORM bi_se19  USING p_enhname TYPE enhobj-enhname .

* Visualizo la linea seleccionada en el programa.
  CALL FUNCTION 'RS_TOOL_ACCESS'
    EXPORTING
      operation           = c_operation
      object_name         = p_enhname
      object_type         = 'ENHO'
    EXCEPTIONS
      not_executed        = 1
      invalid_object_type = 2
      OTHERS              = 3.

ENDFORM.                                                    " bi_se19

*&---------------------------------------------------------------------*
*&      Form  BDC_DYNPRO
*&---------------------------------------------------------------------*
FORM bdc_dynpro USING program dynpro.

  CLEAR ti_bdcdata.
  ti_bdcdata-program  = program.
  ti_bdcdata-dynpro   = dynpro.
  ti_bdcdata-dynbegin = 'X'.
  APPEND ti_bdcdata.

ENDFORM.                               " BDC_DYNPRO

*&---------------------------------------------------------------------*
*&      Form  BDC_FIELD
*&---------------------------------------------------------------------*
FORM bdc_field USING fnam fval.

  CLEAR ti_bdcdata.
  ti_bdcdata-fnam = fnam.
  ti_bdcdata-fval = fval.
  APPEND ti_bdcdata.

ENDFORM.                    "BDC_FIELD

*&---------------------------------------------------------------------*
*&      Form  visualizar_programa
*&---------------------------------------------------------------------*
*       Visualizo el programa que se genera dinámicamente para las
*       sustituciones y validaciones de FI.
*----------------------------------------------------------------------*
FORM visualizar_programa .

  DATA:
    l_selfield     TYPE slis_selfield,
    l_exit         TYPE c,
    l_repid        TYPE sy-repid,
    l_boolpool(8).

  CHECK ti_gb31t[] IS NOT INITIAL.

  DO.

* Visualizo los distintos eventos para que puedan realizar la selección.
    CALL FUNCTION 'REUSE_ALV_POPUP_TO_SELECT'
      EXPORTING
        i_title          = 'Validación/Sustitución Evento'
        i_zebra          = 'X'
        i_tabname        = 'TI_GB31T'
        i_structure_name = 'GB31T'
      IMPORTING
        es_selfield      = l_selfield
        e_exit           = l_exit
      TABLES
        t_outtab         = ti_gb31t
      EXCEPTIONS
        program_error    = 1
        OTHERS           = 2.

    IF l_exit EQ 'X'.
      EXIT.
    ENDIF.

    CHECK l_exit IS INITIAL.

* Obtengo el nombre del programa de sustitución y validación asociado
* a la selección del usuario.
    PERFORM create_bool_filename(saplgbl5)
              USING    ti_gb31t-valuser
                       ti_gb31t-valevent
              CHANGING l_boolpool
              IF FOUND.

    CHECK l_boolpool IS NOT INITIAL.

    MOVE l_boolpool TO l_repid.

* Visualizo el programa.
    PERFORM visualizar_linea USING l_repid
                                   '01'.

  ENDDO.

ENDFORM.                    " visualizar_programa

*&---------------------------------------------------------------------*
*&      Form  texto_tope
*&---------------------------------------------------------------------*
*       Encabezado que explica la funcionalidad de algunas columnas
*       del reporte.
*----------------------------------------------------------------------*
FORM texto_tope .

  STATICS l_flag TYPE c.

  DATA l_tit(65) TYPE c.

  CHECK l_flag IS INITIAL.

  l_flag = 'X'.

  WRITE 'FUNCIOANALIDAD DE LAS COLUMNAS:' TO l_tit CENTERED.
  FORMAT COLOR = 1.

  WRITE:
* Título.
  /(70)   sy-uline,
  /1(1)   sy-vline,
   3      l_tit,
   70(1)  sy-vline,
  /(70)   sy-uline,
*1er linea.
  /1(1)   sy-vline,
   3      'TIPO: Se visualiza las definiciones de los objetos de',
   70(1)  sy-vline,
*2da linea.
  /1(1)   sy-vline,
   3      '      ampliación.',
   70(1)  sy-vline,
*3ra linea.
  /1(1)   sy-vline,
   3      'STOP: Agrega un BREAK en la línea de código seleccionada.',
   70(1)  sy-vline,
*4ta linea.
  /1(1)   sy-vline,
   3      'CÓDIGO FUENTE: Se visualiza la línea de código en el ',
   70(1)  sy-vline,
*5ta linea.
  /1(1)   sy-vline,
   3      '               programa correspondiente.',
   70(1)  sy-vline,
* Cierro el cuadro.
   /(70)  sy-uline.

  SKIP.

ENDFORM.                    " texto_tope

*&---------------------------------------------------------------------*
*&      Form  bi_se18
*&---------------------------------------------------------------------*
*       Visualizo la definición del enhancement point.
*&---------------------------------------------------------------------*
FORM bi_se18  USING  p_cf.

  DATA:
    l_enhspotname TYPE enhspotname,
    l_off TYPE i,
    l_cf  TYPE i.

  DATA: BEGIN OF lt_cf OCCURS 0,
          linea(500),
        END OF lt_cf.

  FIND FIRST OCCURRENCE OF ' SPOT ' IN p_cf MATCH OFFSET l_off.

  CHECK l_off IS NOT INITIAL.

  ADD 7 TO l_off.
  l_cf = 500 - l_off.

  SPLIT p_cf+l_off(l_cf) AT space INTO TABLE lt_cf.

  CHECK sy-subrc IS INITIAL.

* Obtengo el nombre de la definición del enhancement.
  READ TABLE lt_cf INDEX 1.

  TRANSLATE lt_cf-linea TO UPPER CASE.
  TRANSLATE lt_cf-linea USING '. , '.

  MOVE lt_cf-linea TO l_enhspotname.

* Visualizo la linea seleccionada en el programa.
  CALL FUNCTION 'RS_TOOL_ACCESS'
    EXPORTING
      operation           = c_operation
      object_name         = l_enhspotname
      object_type         = 'ENHS'
    EXCEPTIONS
      not_executed        = 1
      invalid_object_type = 2
      OTHERS              = 3.

ENDFORM.                                                    " bi_se18

*&---------------------------------------------------------------------*
*&      Form  visualizar_fm_exit
*&---------------------------------------------------------------------*
*       Se visualiza el módulo de funciones del user-exit's que
*       contiene al include Z indicado.
*----------------------------------------------------------------------*
FORM visualizar_fm_exit .

  DATA:
    l_ret     TYPE c,
    l_flag    TYPE c,
    l_name    TYPE trdir-name,
    lt_fields TYPE sval OCCURS 0 WITH HEADER LINE,
    lt_tfdir  TYPE tfdir OCCURS 0 WITH HEADER LINE.

  DATA:
    v_include LIKE rodiobj-iobjnm,
    l_fname LIKE rs38l-name,
    l_group LIKE rs38l-area,
    l_include LIKE rs38l-include,
    l_namespace LIKE rs38l-namespace,
    l_str_area LIKE rs38l-str_area,
    lt_incl TYPE STANDARD TABLE OF abapsource WITH HEADER LINE.

  MOVE:
    'RS38L'   TO lt_fields-tabname,
    'INCLUDE' TO lt_fields-fieldname,
    'Include' TO lt_fields-fieldtext.

  APPEND lt_fields.

  CALL FUNCTION 'POPUP_GET_VALUES'
    EXPORTING
      popup_title     = 'Ingrese ampliación:'
    IMPORTING
      returncode      = l_ret
    TABLES
      fields          = lt_fields
    EXCEPTIONS
      error_in_fields = 1
      OTHERS          = 2.

* Verifico que no haya cancelado.
  CHECK l_ret NE 'A'.

  READ TABLE lt_fields INDEX 1.

  CHECK sy-subrc IS INITIAL.

  IF lt_fields-value IS INITIAL OR lt_fields-value(1) NE 'Z'.
*   La ampliación & no existe
    MESSAGE e012(enhancement) WITH lt_fields-value.
  ELSE.
    MOVE lt_fields-value TO l_name.
  ENDIF.

* Obtengo los FM de los exit's.
  SELECT *
    INTO TABLE lt_tfdir
    FROM tfdir
    WHERE funcname LIKE 'EXIT_%'.

  LOOP AT lt_tfdir.

    CLEAR:
      l_group, l_include, l_namespace, l_str_area.

    l_fname = lt_tfdir-funcname.
* Obtengo el include del user-exti's.
    CALL FUNCTION 'FUNCTION_EXISTS'
      EXPORTING
        funcname           = l_fname
      IMPORTING
        group              = l_group
        include            = l_include
        namespace          = l_namespace
        str_area           = l_str_area
      EXCEPTIONS
        function_not_exist = 1
        OTHERS             = 2.

    IF sy-subrc = 0.
      IF NOT l_include IS INITIAL.
*- Obtengo el código fuente del user-exit's.
        CLEAR: v_include, lt_incl, lt_incl[].
        v_include = l_include.
*        CALL FUNCTION 'MU_INCLUDE_GET'
*          EXPORTING
*            i_include   = v_include
*          TABLES
*            e_t_include = lt_incl.
*
*        IF lt_incl[] IS NOT INITIAL.
** Verifico si alguna de las líneas contiene el include.
*          FIND FIRST OCCURRENCE OF l_name
*            IN TABLE lt_incl.
*
*          CHECK sy-subrc IS INITIAL.
*
** Visualizo el FM del user-exit.
*          PERFORM visualizar_linea USING l_include
*                                         '01'.
*          l_flag = 'X'.
*          EXIT.
*        ENDIF.
      ENDIF.
    ENDIF.
  ENDLOOP.

  CHECK l_flag IS INITIAL.

*   La ampliación & no existe
  MESSAGE e012(enhancement) WITH lt_fields-value.

ENDFORM.                    " visualizar_fm_exit

*&---------------------------------------------------------------------*
*&      Form  def_text_parameter
*&---------------------------------------------------------------------*
*       Defino los textos de los parámetros de selección.
*----------------------------------------------------------------------*
FORM def_text_parameter .

  tit1   = 'Parámetros:'.
  tit2   = 'Tipo de ampliación:'.
  tit3   = 'Tipo de ejecución:'.
  text1  = 'Programa'.
  text2  = 'Transacción'.
  text3  = 'Includes'.
  text4  = 'Funciones'.
  text5  = 'Submit'.
  text6  = 'Nivel'.
  text7  = 'User-exit'.
  text8  = 'Badi'.
  text9  = 'BTE'.
  text10 = 'Sustitución'.
  text11 = 'Field-exit'.
  text12 = c_handler.
  text13 = 'Validación'.
  text14 = 'Punto de ampliación'.

ENDFORM.                    " def_text_parameter

*&---------------------------------------------------------------------*
*&      Form  def_botones
*&---------------------------------------------------------------------*
*       Defino los textos de las botoneras de la pantalla de selección.
*----------------------------------------------------------------------*
FORM def_botones .

* Agrego el boton de marcar todo en STATUS GUI.
  functxt-icon_id   = icon_select_all.
  functxt-quickinfo = c_text_08.
  sscrfields-functxt_01 = functxt.

* Agrego el boton de desmarcar todo en STATUS GUI.
  functxt-icon_id   = icon_deselect_all.
  functxt-quickinfo = c_text_09.
  sscrfields-functxt_02 = functxt.

* Agrego el boton de Breakpoint en STATUS GUI.
  functxt-icon_id   = icon_message_critical.
  functxt-quickinfo = c_text_06.
  functxt-icon_text = c_text_06.
  sscrfields-functxt_03 = functxt.


* icon_create:   RESULT  name  text info.
  icon_create:

* Creo la visualización del botón de exit's en la DYNPRO.
  btn icon_display_note 'Ampliación' 'Visualizar ampliación',
* Creo la visualización del botón de proyectos exit's en la DYNPRO.
  ext1 icon_display_note 'Proyecto' 'Visualizar Proyecto',
* Creo la visualización del botón de proyectos exit's en la DYNPRO.
  ext2 icon_display_note 'User-exit' 'Visualizar User-exit',
* Creo la visualización del botón de Interface en la DYNPRO.
  badi icon_availability_display 'Interface' 'Visualizar Def.Interface',
* Creo la visualización del botón de sustitución en la DYNPRO.
  btn1 icon_display_text 'Tx. OBBH' 'Visualizar sustituciones',
* Creo la visualización del botón de sustitución en la DYNPRO.
  sust icon_report 'Prog.Generado' 'Vis.programa generado',
* Creo la visualización del botón de sustitución en la DYNPRO.
  ob28 icon_display_text 'Tx. OB28' 'Visualizar validaciones',
* Creo la visualización del botón de sustitución en la DYNPRO.
  btn2 icon_display 'Field-exits' 'Visualizar Field-exits',
* Creo la visualización del botón de FIBF en la DYNPRO.
  bte1 icon_toggle_display '' 'Visualizar FIBF',
* Creo la visualización del botón de Evento en la DYNPRO.
  bte2 icon_show_events  'Evento' 'Visualizar Evento',
* Creo la visualización del botón de Proceso en la DYNPRO.
  bte3 icon_bw_apd 'Proceso' 'Visualizar Proceso',
* Creo Marcar todo en la DYNPRO.
  all  icon_select_all '' c_text_08,
* Creo Desmarcar todo en la DYNPRO.
  dal  icon_deselect_all '' c_text_09,
* Creo la visualización del botón de SENH en la DYNPRO.
  senh icon_detail '' 'Visualizar SENH',
* Creo la visualización del botón de Customer Implement. en la DYNPRO.
  cimp icon_table_settings 'Cust.Impl.' 'Customer Implementation'.

  MOVE sust TO val.

ENDFORM.                    " def_botones

*&---------------------------------------------------------------------*
*&      Form  set_header
*&---------------------------------------------------------------------*
*       Creo el encabezado del ALV correspondiente.
*----------------------------------------------------------------------*
FORM set_header  USING p_cant
                       p_inc
                       p_text.

  DATA:
    l_tit(65) TYPE c.

  STATICS l_col TYPE i.

  PERFORM texto_tope.

  IF l_col IS INITIAL OR l_col EQ 7.
    l_col = 3.
  ELSE.
    ADD 1 TO l_col.
  ENDIF.

  FORMAT COLOR = l_col.

  WRITE p_text TO l_tit CENTERED.

  TRANSLATE l_tit USING ' *'.

  WRITE:
* Título.
  /(70)   sy-uline,
  /1(1)   sy-vline,
   3      l_tit,
   70(1)  sy-vline,
  /(70)   sy-uline.

  FORMAT COLOR = 2.

  IF p_tcode IS INITIAL.
    CONCATENATE 'Ampliaciones encontradas en el programa' p_prog
           INTO l_tit SEPARATED BY space.
  ELSE.
    CONCATENATE 'Ampliaciones encontradas en la transacción' p_tcode
           INTO l_tit SEPARATED BY space.
  ENDIF.

  WRITE:
* Título.
  /1(1)   sy-vline,
   3      l_tit,
   70(1)  sy-vline.

  IF p_tcode IS INITIAL.
* Obtengo la descripción del programa.
    SELECT SINGLE *
      FROM trdirt
      WHERE name  EQ p_prog
        AND sprsl EQ sy-langu.

    CONCATENATE 'Descripción:' trdirt-text
      INTO l_tit SEPARATED BY space.

  ELSE.
* Obtengo la descripción de la transacción.
    SELECT SINGLE *
      FROM tstct
      WHERE sprsl EQ sy-langu
        AND tcode EQ p_tcode.

    CONCATENATE 'Descripción:' tstct-ttext
      INTO l_tit SEPARATED BY space.

  ENDIF.

  WRITE:
  /1(1)   sy-vline,
   3      l_tit,
   70(1)  sy-vline,
  /(70)   sy-uline.

  IF p_inc IS NOT INITIAL.

    CONCATENATE 'PGMs analizados:' p_inc
      INTO l_tit SEPARATED BY space.

    WRITE:
    /1(1)   sy-vline,
     3      l_tit,
     70(1)  sy-vline.

    CONCATENATE 'Nivel:' p_nivel
      INTO l_tit SEPARATED BY space.

    WRITE:
    /1(1)   sy-vline,
     3      l_tit,
     70(1)  sy-vline.

  ENDIF.

  CONCATENATE 'Cant.Ampliaciones:' p_cant
    INTO l_tit SEPARATED BY space.

  WRITE:
  /1(1)   sy-vline,
   3      l_tit,
   70(1)  sy-vline,
* Cierro el cuadro.
 /(70)  sy-uline.

  SKIP.

ENDFORM.                    " set_header

*&---------------------------------------------------------------------*
*&      Form  visualizar_imp_enh
*&---------------------------------------------------------------------*
*       Visualizo las implementaciones del cliente de los enhancement
*       de cualquier tipo.
*----------------------------------------------------------------------*
FORM visualizar_imp_enh .

  DATA:
    l_repid LIKE sy-repid.

  l_repid = sy-repid.

  PERFORM get_imp_enh.
  PERFORM construir_catalogo_cimp.
  PERFORM definir_layout  USING    'TI_CIMP'
                          CHANGING wa_layout.

  CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'
    EXPORTING
      i_callback_program      = l_repid
      i_callback_user_command = 'USER_COMMAND'
      is_layout               = wa_layout
      it_fieldcat             = ti_cat
      i_default               = 'X'
      i_save                  = 'A'
    TABLES
      t_outtab                = ti_cimp
    EXCEPTIONS
      program_error           = 1
      OTHERS                  = 2.

ENDFORM.                    " visualizar_imp_enh

*&---------------------------------------------------------------------*
*&      Form  construir_catalogo_cimp
*&---------------------------------------------------------------------*
*       Construir catalogo de campos para ALV
*----------------------------------------------------------------------*
FORM construir_catalogo_cimp .

  DATA:
    l_repid  LIKE sy-repid.

  REFRESH: ti_cat.

  l_repid = sy-repid.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name         = l_repid
      i_internal_tabname     = 'TI_CIMP'
      i_inclname             = l_repid
    CHANGING
      ct_fieldcat            = ti_cat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

* Asignar atributos de campo en el catalogo de reporte ALV
  PERFORM asignar_campo_a_catalogo TABLES ti_cat
                                   USING:

  'ENHNAME'    'X' 'X' 'X' 'X' ' ' ' ' ' ' ' ' ' ' ' ',
  'OBJ_TYPE'   ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ',
  'OBJ_NAME'   ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ',
  'ELEMUSAGE'  ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ',
  'ENHINCLUDE' ' ' ' ' ' ' 'X' ' ' ' ' ' ' ' ' ' ' ' '.

ENDFORM.                    " construir_catalogo_cimp

*&---------------------------------------------------------------------*
*&      Form  get_imp_enh
*&---------------------------------------------------------------------*
*       Obtengo las implementaciones creadas.
*----------------------------------------------------------------------*
FORM get_imp_enh .

  SELECT enhobj~enhname enhobj~obj_type enhobj~obj_name enhobj~elemusage
         enhincinx~enhinclude
    FROM enhobj LEFT OUTER JOIN enhincinx ON
      enhobj~enhname = enhincinx~enhname
    INTO TABLE ti_cimp
    WHERE enhobj~enhname LIKE 'Z%' OR
          enhobj~enhname LIKE 'Y%' AND
          enhobj~version EQ 'A'.

  SORT ti_cimp BY enhname obj_type.

ENDFORM.                    " get_imp_enh

*&---------------------------------------------------------------------*
*&      Form  visualizar_enh_cf
*&---------------------------------------------------------------------*
*       Visualizo el código fuente del enhancement.
*----------------------------------------------------------------------*
FORM visualizar_enh_cf  USING p_enhinclude TYPE any.

  DATA:
  l_changed LIKE s38e-buf_varied,
  l_subrc   LIKE sy-subrc,
  lt_source TYPE TABLE OF string.

  CHECK p_enhinclude IS NOT INITIAL.

  READ REPORT p_enhinclude INTO lt_source.

  CHECK sy-subrc IS INITIAL.

  CALL FUNCTION 'EDITOR_TABLE'
    EXPORTING
      display = 'X'
      name    = p_enhinclude
    IMPORTING
      changed = l_changed
      subrc   = l_subrc
    TABLES
      content = lt_source.

ENDFORM.                    " visualizar_enh_cf
