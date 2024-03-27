global _main
extern _printf
extern _scanf

;Segmento de datos
section .data   
    n1:         dd  0   ;Guardamos el primer número (tamaño de 4B)
    n2:         dd  0   ;Guardamos el segundo número
    suma:       dd  0   ;Guardamos el resultado de la suma
    resta:      dd  0   ;Guardamos el resultado de la resta
    multi:      dd  0   ;Guardamos el resultado de la multiplicación 
    divi:       dd  0   ;Guardamos el resultado de la división. [Cosiente]
    resi:       dd  0   ;Guardamos el resultado de la división. [Residuo]
    prompt1:    db  "Digite el primer número: ", 0 ;Mensaje 1
    prompt2:    db  "Digite el segundo numero: ",0 ;Mensaje 2
    formatIn:    db  "%d", 0 ;Esta variable me ayudará las funciones scanf y printf como formato de salida
    formatOut:   db  "%d", 10,0 ;Formato de salida
    
;Segmento de de código
section .text
    _main:
          push  ebx     ;Metemos el registro a pila
          push  ecx     ;Metemos el registro a pila
          push  edx     ;Metemos el registro a pila
          
          ;Imprimimos el primer mensaje en pantalla
          push  prompt1     ;Pasamos el parametro a pila
          call  _printf     ;Llamamos la función para imprimir en pantalla
          add   esp,4       ;Dirección de retorno de pila. La suma en el stack pointer debe respetar el ancho de registro según la arquitectura
          
          ;Pediremos el primer número y se almacenará en la variable n1
          push  n1          ;Metemos n1 a la pila
          push  formatIn     ;Metemos format a la pila
          call  _scanf      ;Llamamos la función para entrada estandar
          add   esp,8       ;Dirección de retorno de la pila (2 parámetros)
          mov   ebx, [n1]   ;Guardamos n1 en el registro EBX 
          
          ;Imprimimos el segundo mensaje en pantalla
          push  prompt2     ;Pasamos el parametro a la pila
          call  _printf     ;Llamamos la función para imprimir en pantalla
          add   esp,4       ;Dirección de retorno de la pila
          
          ;Pedimos el segundo número
          push  n2          ;Metemos n2 a la pila
          push  formatIn    ;Metemos format a la pila
          call  _scanf      ;Llamamos la función para entrada estandar
          add   esp, 8      ;Dirección de retorno de la Pila
          mov   ecx,[n2]    ;Guardamos n2 en el registro ECX
          
          ;Operación suma 
          mov   [suma], ebx ;Como n1 se encuntra en EBX, copiamos EBX al valor de suma (suma = ebx)
          add   [suma], ecx ;Como n2 esta en ECX, efectuamos la suma (suma = suma + ecx)
          
          ;Operación resta
          mov   [resta], ebx ;Como n1 esta en EBX, copiamos EBX al valor de resta (resta = ebx)
          sub   [resta], ecx ;Como n2 esta en ECX, efectuamos la resta (resta = resta - ecx)
          
          ;Operación multiplicación
          mov   [multi], ebx   ;Como n1 esta en EBX, copiamos EBX al valor de multi ( multi = ebx)
          mov   edx, ecx       ;Como n2 esta en ECX, copiamos ECX en EDX ( edx = ecx)
          imul  edx,[multi]    ;Multiplicamos (edx = edx*multi)
          mov   [multi], edx   ;Copiamos el resultado en el valor de multi
          
          ;Operamos la divisiòn y el residuo lo guardaremos en resi
          mov   eax, ebx        ;Como EBX tiene el valor de n1 lo copiamos a EAX
          cdq                   ;Inicia EDX con la extención de signo. 
          idiv  ecx             ;EAX = EAX / ECX Cociente. EDX = EAX / ECX Residuo
          mov   [divi], eax     ;Guardamos el cociente en el valor de divi
          neg   edx             ;Niega el residuo
          mov   [resi], edx     ;Guardamor el residuo en el valor de resi
          
          ;Impresión del resultado de la suma
          push  dword[suma]     ;Metemos el valor de suma a la pila Double Word
          push  formatOut       ;Pasamos el parametro con formato de salida a la pila
          call  _printf         ;Llamamos la función para imprimir en pantalla
          add   esp, 8          ;Dirección de retorno de pila.
          
          ;Impresión del resultado de la resta
          push  dword[resta]    ;Metemos el valor de la resta a la pila
          push  formatOut       ;Metemos el parametro con formato de salida a la pila.
          call  _printf         ;Llamamos la función para imprimir en pantalla
          add   esp,8           ;Dirección de retorno de la pila
          
          ;Impresion de la multiplicacion
          push  dword[multi]    ;Metemos el valor de multiplicación a la pila
          push  formatOut       ;Metemos el parametro con formato de salida a la pila.
          call  _printf         ;Llamamos la función de impresión en pantalla
          add   esp,8           ;Dirección de retorno de la pila
          
          ;Impresión de división
          push  dword[divi]     ;Metemos el valor de división a la pila
          push  formatOut       ;Metemos el parámetro con formato de salida a la pila
          call  _printf         ;Llamamos la función para imprimir en pantalla
          add   esp,8           ;Dirección de retorno de la pila
          
          ;Impresión del residuo almacenado
          push  dword[resi]     ;Metemos el valor del residuo a la pila
          push  formatOut       ;Metemos el parámetro con formato de salida a la pila
          call  _printf         ;Llamamos la función para imprimir en pantalla
          add   esp,8           ;Dirección de retorno de la pila.
          
          ;Limpiamos los resgistros
          mov eax, 0            ;Limpiamos el valor de registro de EAX
          
          ;Sacamos de la pila a los que introducimos
          pop   edx             ;Sacamos el registro EDX de la pila
          pop   ecx             ;Sacmos el registro ECX de la pila
          pop   ebx             ;Sacamos el registro EBX de la pila

ret