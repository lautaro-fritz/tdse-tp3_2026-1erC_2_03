¡Claro que sí! Este es un excelente proyecto de sistemas embebidos. Integrar una pantalla LCD, portar código, configurar el sistema y modelar la lógica mediante *statecharts* (máquinas de estado) abarca casi todos los pilares del diseño de firmware moderno.

Para ayudarte a estructurar tu Trabajo Práctico (TP), te propongo dividirlo en **cuatro fases principales**. Aquí tienes una guía paso a paso de cómo abordarlas:

---

### Fase 1: Porting C Code para el LCD (Capa de Abstracción)

"Portar" código significa tomar un driver de LCD que fue escrito para un microcontrolador (por ejemplo, un Arduino o un PIC) y adaptarlo para que funcione en tu microcontrolador actual (por ejemplo, un STM32, ESP32 o NXP).

Para hacerlo correctamente y que tu código sea reutilizable, debes **separar la lógica del LCD de la lógica del hardware (Hardware Abstraction Layer - HAL)**.

**Cómo hacerlo en C:**
Crea un archivo `lcd_port.c` y `lcd_port.h` donde definas funciones "envoltorio" (wrappers) para los pines y los *delays*.

```c
// lcd_port.h
#include <stdint.h>

// Prototipos de funciones que dependen del hardware
void LCD_Delay_ms(uint32_t ms);
void LCD_Set_RS(uint8_t state);
void LCD_Set_EN(uint8_t state);
void LCD_Write_Data_Bus(uint8_t data);
```

Luego, en el driver original del LCD (ej. `lcd.c`), reemplazas cualquier llamada directa a registros o librerías específicas (como `digitalWrite` o `HAL_GPIO_WritePin`) por tus nuevas funciones: `LCD_Set_RS(1);`

---

### Fase 2: System Setup (Configuración del Sistema)

Antes de que la máquina de estados o el LCD puedan funcionar, el microcontrolador necesita su configuración inicial. Esta etapa en tu TP debe documentar la inicialización.

* **Configuración del Reloj (Clock):** Definir la frecuencia de operación del sistema (necesario para que los *delays* del LCD sean precisos).
* **Configuración de GPIO:** Configurar los pines conectados al LCD como salidas digitales (Push-Pull, alta velocidad). ¿Usarás modo de 4 bits o de 8 bits? ¿O es un LCD por I2C/SPI?
* **Inicialización de Periféricos:** Si usas I2C o SPI, configurar el *baudrate* y los pines correspondientes.
* **Inicialización del LCD:** Llamar a la secuencia de inicialización requerida por el fabricante de la pantalla (por ejemplo, el clásico controlador HD44780 requiere enviar comandos específicos con retardos exactos al arrancar).

---

### Fase 3: Statechart y Modelado (Diseño del Sistema)

Para la lógica de tu aplicación (lo que se muestra en pantalla y cómo interactúa el usuario o el sistema), no debes usar código secuencial bloqueante (`delays` largos en el `main`). En su lugar, debes usar un **Statechart** o Máquina de Estados Finita (FSM).



**Ejemplo de modelo básico para tu LCD:**
1.  **Estado `INIT`:** El sistema arranca, configura hardware e inicializa el LCD. Transición automática a `IDLE`.
2.  **Estado `IDLE` / `HOME_SCREEN`:** Muestra la pantalla principal. Espera eventos (ej. un botón presionado o un dato de un sensor).
3.  **Estado `UPDATE_DISPLAY`:** Un sensor reportó un nuevo valor. El LCD actualiza solo la porción de texto necesaria. Transición automática de regreso a `IDLE`.
4.  **Estado `MENU_NAVIGATION`:** Si hay botones, este estado maneja la navegación por opciones.
5.  **Estado `ERROR`:** Si falla la comunicación (ej. I2C desconectado), muestra un mensaje de error.

---

### Fase 4: C Coding (Implementación de la Máquina de Estados)

Una vez que tienes tu diagrama de estados, pasarlo a C es muy metódico. La forma más común es usar una variable enumerada y una estructura `switch-case` dentro de tu bucle principal o en un temporizador (Timer Tick).

```c
// Definición de los estados
typedef enum {
    STATE_INIT,
    STATE_IDLE,
    STATE_UPDATE_DISPLAY,
    STATE_ERROR
} SystemState_t;

SystemState_t currentState = STATE_INIT;

int main(void) {
    // System Setup inicial
    Hardware_Init(); 

    while (1) {
        switch (currentState) {
            case STATE_INIT:
                LCD_Init();
                LCD_Print("Iniciando...");
                LCD_Delay_ms(1000);
                currentState = STATE_IDLE; // Transición
                break;

            case STATE_IDLE:
                // Esperar un evento, por ejemplo, una lectura de sensor
                if (Sensor_Data_Ready()) {
                    currentState = STATE_UPDATE_DISPLAY;
                }
                break;

            case STATE_UPDATE_DISPLAY:
                LCD_Clear();
                LCD_Print("Dato: ");
                // Lógica para imprimir valor...
                currentState = STATE_IDLE; // Vuelve a reposo
                break;

            case STATE_ERROR:
                LCD_Clear();
                LCD_Print("Error Sistema");
                while(1); // Bloqueo seguro o lógica de reinicio
                break;
        }
    }
}
```
Este conjunto de archivos de código fuente en lenguaje C implementa una arquitectura de software "Bare Metal" orientada a eventos (Event-Triggered System o ETS). Está diseñada para un sistema embebido y utiliza un planificador cooperativo que ejecuta tareas de forma no bloqueante a intervalos regulares. 

A continuación se detalla el funcionamiento de cada módulo:

### Análisis de los Archivos

* **app.c y app_it.c**: Constituyen el núcleo del sistema. `app.c` contiene la lista de tareas a ejecutar (`task_cfg_list`), que incluyen inicialización y actualización de tareas como el display y las pruebas. También se encarga de llamar a las tareas periódicamente y medir sus tiempos de ejecución (como el mejor y peor caso de tiempo de ejecución o BCET/WCET). Por su parte, `app_it.c` maneja las interrupciones del sistema, específicamente la interrupción del temporizador del sistema (`HAL_SYSTICK_Callback`), la cual actualiza el contador de *ticks* global que rige la ejecución del bucle principal.
* **systick.c**: Proporciona funciones relacionadas con el temporizador de hardware (SysTick), como `systick_delay_us`, la cual genera retardos bloqueantes en microsegundos calculando los ciclos del procesador que han transcurrido.
* **display.h y display.c**: Conforman el controlador (driver) de bajo nivel para una pantalla LCD alfanumérica. Permiten configurar la pantalla mediante conexiones GPIO de 4 u 8 bits y envían los comandos de inicialización, control del cursor y escritura de caracteres individuales o cadenas de texto mediante funciones como `displayCharPositionWrite` y `displayStringWrite`.
* **task_display_attribute.h, task_display_interface.c y task_display.c**: Implementan una tarea específica para gestionar lo que se muestra en el LCD. `task_display.c` contiene la lógica principal de la tarea orientada a una máquina de estados. `task_display_interface.c` expone la función `put_event_task_display`, la cual sirve como interfaz para que otras tareas envíen mensajes de texto a la pantalla, guardándolos en un buffer interno (DDRAM) y generando un evento de actualización.
* **task_test_attribute.h y task_test.c**: Definen e implementan una tarea de prueba del sistema. Esta tarea lleva un conteo de ciclos y utiliza temporizadores no bloqueantes para enviar periódicamente eventos a la tarea del display, demostrando que el sistema y la comunicación entre tareas funcionan correctamente. Las estructuras de datos asociadas, como el temporizador y el contador, se definen en los atributos.

---

### Comportamiento de las funciones de máquina de estados (Statecharts)

Ambas funciones implementan máquinas de estados finitos (FSM) que permiten ejecutar lógica de forma asíncrona y no bloqueante.

#### 1. Función `void task_test_statechart(void)`
Esta función evalúa periódicamente el estado de la tarea de pruebas:
1. **Actualización de contador:** Al ingresar, incrementa un contador de ejecuciones de la tarea (`p_task_test_dta->counter++`).
2. **Temporizador no bloqueante:** Evalúa el valor de un temporizador interno (`tick`). Si el `tick` es mayor al mínimo configurado (`DEL_TEST_XX_MIN`), simplemente lo decrementa en 1 y sale de la función, permitiendo que otras tareas se ejecuten.
3. **Generación del evento:** Cuando el `tick` llega a su valor mínimo (alcanzando el tiempo límite definido), la función recarga el temporizador con su valor máximo (`DEL_TEST_XX_MAX`).
4. **Envío a pantalla:** Inmediatamente después, formula una cadena de texto dividiendo el contador total por el temporizador máximo para obtener el número de prueba actual, y utiliza la interfaz `put_event_task_display` para mandar a imprimir la frase "Test Nro: ******" junto con el valor calculado a la segunda línea del display LCD.

#### 2. Función `void task_display_statechart(void)`
Esta función controla el flujo de envío de información física hacia el display LCD y opera con dos estados principales definidos mediante un `switch`:
1. **Estado ST_DSP_IDLE (Reposo):** La tarea permanece en este estado esperando que haya datos nuevos. Verifica si se ha levantado una bandera booleana (`flag == true`) y si el evento registrado es de tipo actualización (`EV_DSP_UPDATE`). Si se cumplen estas condiciones (lo cual ocurre cuando alguien llama a `put_event_task_display`), transiciona al estado `ST_DSP_UPDATE`.
2. **Estado ST_DSP_UPDATE (Actualización):** En este estado, la tarea vuelve a confirmar la presencia del evento. Luego, baja la bandera de actualización (`flag = false`) indicando que el evento está siendo procesado. 
3. **Escritura en Hardware:** Seguidamente, reposiciona el cursor del hardware (fila 0, columna 0) y escribe en la pantalla la primera línea almacenada en su memoria interna (`ddram`). Repite el mismo proceso para la segunda línea (fila 1, columna 0).
4. **Retorno:** Una vez finalizada la escritura, el estado vuelve a cambiar a `ST_DSP_IDLE` para quedar a la espera del próximo texto a dibujar. También incluye un estado *default* de seguridad que reinicia la máquina a sus valores iniciales en caso de fallo.

### Ejecución
<img width="662" height="260" alt="image" src="https://github.com/user-attachments/assets/296fe79d-4fef-4e16-a419-e77b802d8a24" />

La variable NOE representa la cantidad de ejecuciones y es adimensional. Las variables LET, BCET y WCET representan el último tiempo, mejor tiempo y peor tiempo de ejecución de cada ciclo, respectivamente, y están medidas en μs.  
En particular, el peor tiempo de ejecución de la función <tt>task_display_update</tt> es de 6000 μs (6 ms), por lo que no cumple con la restricción del ejecutor cíclico, que es de 1ms.
