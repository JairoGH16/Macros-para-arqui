;==========================================
; Archivo de macros y procedimientos útiles
; Autor: [Tu Nombre]
; Fecha: [Fecha Actual]
;==========================================

;------------------------------------------
; Macros
;------------------------------------------

; Macro: mWriteString
; Descripción: Escribe una cadena de caracteres en la consola.
; Parámetros:
;   msg - Etiqueta de la cadena a imprimir.
mWriteString MACRO msg
    mov edx, OFFSET msg
    call WriteString
ENDM

; Macro: mReadInt
; Descripción: Lee un número entero desde la entrada estándar y lo almacena en un registro.
; Parámetros:
;   reg - Registro donde se almacenará el entero leído.
mReadInt MACRO reg
    call ReadInt
    mov reg, eax
ENDM

; Macro: mSetColor
; Descripción: Cambia el color del texto en la consola.
; Parámetros:
;   color - Código del color.
mSetColor MACRO color
    mov eax, color
    call SetTextColor
ENDM

;------------------------------------------
; Procedimientos
;------------------------------------------

; Procedimiento: LeerCadena
; Descripción: Lee una cadena de caracteres desde la entrada estándar.
; Entradas:
;   EDX - Dirección del buffer donde se almacenará la cadena.
;   ECX - Tamaño máximo de la cadena.
LeerCadena PROC
    call ReadString
    ret
LeerCadena ENDP

; Procedimiento: EscribirCadena
; Descripción: Escribe una cadena de caracteres en la consola.
; Entradas:
;   EDX - Dirección de la cadena a imprimir.
EscribirCadena PROC
    call WriteString
    ret
EscribirCadena ENDP

; Procedimiento: LeerEntero
; Descripción: Lee un número entero desde la entrada estándar.
; Salidas:
;   EAX - Número entero leído.
LeerEntero PROC
    call ReadInt
    ret
LeerEntero ENDP

; Procedimiento: EscribirEntero
; Descripción: Escribe un número entero en la consola.
; Entradas:
;   EAX - Número entero a imprimir.
EscribirEntero PROC
    call WriteInt
    ret
EscribirEntero ENDP

; Procedimiento: RecorrerArray
; Descripción: Recorre un array de bytes y aplica una operación a cada elemento.
; Entradas:
;   ESI - Dirección inicial del array.
;   ECX - Número de elementos en el array.
; Nota:
;   Debes definir la operación a realizar dentro del bucle (etiqueta 'procesar_elemento').
RecorrerArray PROC
    ; Inicio del bucle
    recorrer_loop:
        cmp ecx, 0
        JE recorrer_fin
        mov al, [esi]
        ; Aquí puedes agregar el código para procesar cada elemento
        ; procesar_elemento:
        ;   [Código de procesamiento]
        inc esi
        dec ecx
        JMP recorrer_loop
    recorrer_fin:
    ret
RecorrerArray ENDP

; Procedimiento: CopiarArray
; Descripción: Copia elementos de un array fuente a un array destino.
; Entradas:
;   ESI - Dirección del array fuente.
;   EDI - Dirección del array destino.
;   ECX - Número de elementos a copiar.
CopiarArray PROC
    ; Inicio del bucle
    copiar_loop:
        cmp ecx, 0
        JE copiar_fin
        mov al, [esi]
        mov [edi], al
        inc esi
        inc edi
        dec ecx
        JMP copiar_loop
    copiar_fin:
    ret
CopiarArray ENDP

; Procedimiento: CambiarColorTexto
; Descripción: Cambia el color del texto en la consola.
; Entradas:
;   EAX - Código del color.
CambiarColorTexto PROC
    call SetTextColor
    ret
CambiarColorTexto ENDP

; Procedimiento: LeerNumeroEnRango
; Descripción: Lee un número entero dentro de un rango especificado.
; Entradas:
;   EDX - Límite inferior del rango.
;   ECX - Límite superior del rango.
; Salidas:
;   EAX - Número entero leído dentro del rango.
LeerNumeroEnRango PROC
    leer_numero:
        call ReadInt
        cmp eax, edx
        JL leer_invalido
        cmp eax, ecx
        JG leer_invalido
        ret
    leer_invalido:
        ; Opcional: Agregar mensaje de error
        JMP leer_numero
LeerNumeroEnRango ENDP

; Procedimiento: GenerarNumeroAleatorio
; Descripción: Genera un número aleatorio dentro de un rango.
; Entradas:
;   EAX - Límite superior del rango (el número generado será entre 0 y EAX - 1).
; Salidas:
;   EAX - Número aleatorio generado.
GenerarNumeroAleatorio PROC
    call RandomRange
    ret
GenerarNumeroAleatorio ENDP

; Procedimiento: PausarPrograma
; Descripción: Pausa la ejecución del programa hasta que el usuario presione una tecla.
PausarPrograma PROC
    call WaitMsg
    ret
PausarPrograma ENDP

; Procedimiento: ConcatenarCadenas
; Descripción: Concatena dos cadenas y almacena el resultado en un buffer.
; Entradas:
;   ESI - Dirección de la primera cadena.
;   EDI - Dirección del buffer donde se almacenará la cadena resultante.
;   EDX - Dirección de la segunda cadena.
ConcatenarCadenas PROC
    ; Copiar primera cadena al buffer
    copiar_primera_cadena:
        mov al, [esi]
        mov [edi], al
        inc esi
        inc edi
        cmp al, 0
        JNE copiar_primera_cadena
    ; Eliminar terminador nulo para concatenar
    dec edi
    ; Copiar segunda cadena al buffer
    copiar_segunda_cadena:
        mov al, [edx]
        mov [edi], al
        inc edx
        inc edi
        cmp al, 0
        JNE copiar_segunda_cadena
    ret
ConcatenarCadenas ENDP

;------------------------------------------
; Definición de colores comunes
;------------------------------------------

; Constantes de color para usar con SetTextColor
COLOR_NEGRO           EQU 0
COLOR_AZUL            EQU 1
COLOR_VERDE           EQU 2
COLOR_CIAN            EQU 3
COLOR_ROJO            EQU 4
COLOR_MAGENTA         EQU 5
COLOR_MARRON          EQU 6
COLOR_GRIS_CLARO      EQU 7
COLOR_GRIS_OSCURO     EQU 8
COLOR_AZUL_CLARO      EQU 9
COLOR_VERDE_CLARO     EQU 10
COLOR_CIAN_CLARO      EQU 11
COLOR_ROJO_CLARO      EQU 12
COLOR_MAGENTA_CLARO   EQU 13
COLOR_AMARILLO        EQU 14
COLOR_BLANCO          EQU 15

;------------------------------------------
; Estructuras
;------------------------------------------

; Estructura: MiEstructura
; Descripción: Ejemplo de estructura con un número y un carácter.
MiEstructura STRUCT
    numero  DWORD ?
    caracter BYTE  ?
MiEstructura ENDS

; Fin del archivo de macros y procedimientos
