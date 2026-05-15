/*
 * Copyright (c) 2026 Juan Manuel Cruz <jcruz@fi.uba.ar> <jcruz@frba.utn.edu.ar>.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its
 *    contributors may be used to endorse or promote products derived from
 *    this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
 * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 * @author : Juan Manuel Cruz <jcruz@fi.uba.ar> <jcruz@frba.utn.edu.ar>
 */

/********************** inclusions *******************************************/
/* Project includes */
#include "main.h"

/* Demo includes */
#include "logger.h"
#include "dwt.h"

/* Application & Tasks includes */
#include "board.h"
#include "app.h"

#include "task_actuator_attribute.h"
#include "task_actuator_interface.h"
#include "task_display_attribute.h"
#include "task_display_interface.h"
#include "task_system_attribute.h"
#include "task_system_interface.h"

/********************** macros and definitions *******************************/
#define DEL_SYS_MIN			0ul
#define DEL_SYS_MED			250ul
#define DEL_SYS_MAX			500ul

/* Modes to excite Task System */
typedef enum task_system_mode {NORMAL, SETUP, MODE_QTY} task_system_mode_t;

#define SYSTEM_DTA_QTY	MODE_QTY
#define MOTORS_QTY 2
#define PARAMS_QTY 3

/********************** internal data declaration ****************************/
task_system_dta_t task_system_dta_list[SYSTEM_DTA_QTY];

/********************** internal functions declaration ***********************/
void task_system_normal_statechart(void);
void task_system_setup_statechart(void);

void task_system_set_mode(task_system_mode_t);

/********************** internal data definition *****************************/
const char *p_task_system 		= "Task System (System Statechart)";
const char *p_task_system_ 		= "Non-Blocking Code";
const char *p_task_system__ 	= "(Update by Time Code, period = 1mS)";

/********************** external data declaration ****************************/
task_system_mode_t g_task_system_mode;
uint8_t motor_idx, param_idx;
motor_t current_motor;
motor_t motors_list[] = {
		{false, 0, LEFT},
		{false, 0, LEFT}
};

/********************** external functions definition ************************/
void task_system_init(void *parameters)
{
	uint32_t index;
	task_system_dta_t 	*p_task_system_dta;
	task_system_st_t	state;
	task_system_ev_t	event;
	bool b_event;

	/* Print out: Task Initialized */
	LOGGER_INFO(" ");
	LOGGER_INFO("  %s is running - Tick [mS] = %lu", GET_NAME(task_system_init), HAL_GetTick());
	LOGGER_INFO("   %s is a %s", GET_NAME(task_system), p_task_system);
	LOGGER_INFO("   %s is a %s", GET_NAME(task_system), p_task_system_);
	LOGGER_INFO("   %s is a %s", GET_NAME(task_system), p_task_system__);

	init_event_task_system();

	task_system_set_mode(NORMAL);

	for (index = 0; SYSTEM_DTA_QTY > index; index++)
	{
		/* Update Task System Data Pointer */
		p_task_system_dta = &task_system_dta_list[index];

		/* Init & Print out: Task execution FSM */
		state = ST_SYS_IDLE;
		p_task_system_dta->state = state;

		event = EV_SYS_IDLE;
		p_task_system_dta->event = event;

		b_event = false;
		p_task_system_dta->flag = b_event;

		LOGGER_INFO(" ");
		LOGGER_INFO("   %s = %lu   %s = %lu   %s = %s",
					GET_NAME(state), (uint32_t)state,
					GET_NAME(event), (uint32_t)event,
					GET_NAME(b_event), (b_event ? "true" : "false"));
	}

	//put_event_task_display(0, 0, "task_system_mode");
	//put_event_task_display(0, 1, " NORMAL         ");

	char buffer[16];

	for(int i = 0; i < MOTORS_QTY; i++) {
		char* power_label = motors_list[i].power ? "ON" : "OFF";
		char spin_label = motors_list[i].spin == LEFT ? 'L' : 'R';
		snprintf(buffer, sizeof(buffer), "Motor %d:%s,%d,%c  ", i + 1, power_label, motors_list[i].speed, spin_label);
		//put_event_task_display(0, 0, " ENTER/ESC/NEXT ");
		put_event_task_display(0, i, buffer);
	}

	task_system_set_mode(NORMAL);

}

void task_system_update(void *parameters)
{
	/* Run Task Statechart */
	switch (g_task_system_mode)
	{
		case NORMAL:

			task_system_normal_statechart();

			break;

		case SETUP:

			task_system_setup_statechart();

			break;

		default:

			task_system_set_mode(NORMAL);

			break;
		}
}

void task_system_normal_statechart(void)
{

	task_system_dta_t *p_task_system_dta;
	char buffer[16];

	/* Update Task System Data Pointer */
	p_task_system_dta = &task_system_dta_list[NORMAL];

//	printf("%d\n", p_task_system_dta->state);
	if (true == any_event_task_system())
	{
		p_task_system_dta->flag = true;
		p_task_system_dta->event = get_event_task_system();
		while(any_event_task_system()) get_event_task_system();
	}

	switch (p_task_system_dta->state)
	{
		case ST_SYS_IDLE:

			if ((true == p_task_system_dta->flag) && (EV_SYS_BTN_A == p_task_system_dta->event))
			{
				p_task_system_dta->flag = false;
				put_event_task_actuator(EV_LED_ACTIVE, ID_LED_A);
				p_task_system_dta->state = ST_SYS_ACTIVE;

				put_event_task_display(0, 0, "task_system_mode");
				put_event_task_display(0, 1, " SETUP          ");

				task_system_set_mode(SETUP);
			}

			if ((true == p_task_system_dta->flag) && (EV_SYS_ENTER == p_task_system_dta->event))
			{
				p_task_system_dta->flag = false;
				p_task_system_dta->event = EV_SYS_IDLE;
				put_event_task_actuator(EV_LED_ACTIVE, ID_LED_A);

				char buffer[16];
				motor_idx = 0;
				current_motor = motors_list[motor_idx];
				snprintf(buffer, sizeof(buffer), "    MOTOR %d     ", motor_idx+1);
				put_event_task_display(0, 0, " ENTER/ESC/NEXT ");
				put_event_task_display(0, 1, buffer);

				p_task_system_dta->state = ST_SYS_MENU_1;

				/*put_event_task_display(0, 0, "task_system_mode");
				put_event_task_display(0, 1, " SETUP          ");

				task_system_set_mode(SETUP);*/
			}

			break;

		case ST_SYS_ACTIVE:

			if ((true == p_task_system_dta->flag) && (EV_SYS_IDLE == p_task_system_dta->event))
			{
				p_task_system_dta->flag = false;
				put_event_task_actuator(EV_LED_IDLE, ID_LED_A);
				p_task_system_dta->state = ST_SYS_IDLE;
			}

			break;

		case ST_SYS_MENU_1:
			if ((true == p_task_system_dta->flag) && (EV_SYS_ESCAPE == p_task_system_dta->event))
			{
				put_event_task_actuator(EV_LED_ACTIVE, ID_LED_A);
				p_task_system_dta->flag = false;
				p_task_system_dta->event = EV_SYS_IDLE;

				for(int i = 0; i < MOTORS_QTY; i++) {
					char* power_label = motors_list[i].power ? "ON" : "OFF";
					char spin_label = motors_list[i].spin == LEFT ? 'L' : 'R';
					snprintf(buffer, sizeof(buffer), "Motor %d:%s,%d,%c  ", i + 1, power_label, motors_list[i].speed, spin_label);
					//put_event_task_display(0, 0, " ENTER/ESC/NEXT ");
					put_event_task_display(0, i, buffer);
				}
				p_task_system_dta->state = ST_SYS_IDLE;
			}
			if ((true == p_task_system_dta->flag) && (EV_SYS_NEXT == p_task_system_dta->event))
			{
				put_event_task_actuator(EV_LED_ACTIVE, ID_LED_A);
				p_task_system_dta->flag = false;
				motor_idx = (motor_idx + 1) % MOTORS_QTY;

				snprintf(buffer, sizeof(buffer), "%d", motor_idx+1);
				//put_event_task_display(0, 0, " ENTER/ESC/NEXT ");
				put_event_task_display(10, 1, buffer);
			}

			if ((true == p_task_system_dta->flag) && (EV_SYS_ENTER == p_task_system_dta->event))
			{
				p_task_system_dta->event = EV_SYS_IDLE;
				put_event_task_actuator(EV_LED_ACTIVE, ID_LED_A);
				p_task_system_dta->flag = false;

				current_motor = motors_list[motor_idx];

				put_event_task_display(0, 1, "     >POWER     ");
				p_task_system_dta->state = ST_SYS_MENU_2;
			}

			break;

		case ST_SYS_MENU_2:
			if ((true == p_task_system_dta->flag) && (EV_SYS_ESCAPE == p_task_system_dta->event))
			{
				put_event_task_actuator(EV_LED_ACTIVE, ID_LED_A);
				p_task_system_dta->flag = false;
				p_task_system_dta->event = EV_SYS_IDLE;

				char buffer[16];
				motor_idx = 0;
				current_motor = motors_list[motor_idx];
				snprintf(buffer, sizeof(buffer), "    MOTOR %d     ", motor_idx+1);
				put_event_task_display(0, 0, " ENTER/ESC/NEXT ");
				put_event_task_display(0, 1, buffer);

				p_task_system_dta->state = ST_SYS_MENU_1;
			}
			if ((true == p_task_system_dta->flag) && (EV_SYS_NEXT == p_task_system_dta->event))
			{
				put_event_task_actuator(EV_LED_ACTIVE, ID_LED_A);
				p_task_system_dta->flag = false;

				param_idx = (param_idx + 1) % PARAMS_QTY;

				//usar array
				switch(param_idx) {
				case 0:
					put_event_task_display(0, 1, "     >POWER     ");
					break;
				case 1:
					put_event_task_display(0, 1, "     >SPEED     ");
					break;
				case 2:
					put_event_task_display(0, 1, "     >SPIN      ");
					break;
				}
			}

			if ((true == p_task_system_dta->flag) && (EV_SYS_ENTER == p_task_system_dta->event))
			{
				put_event_task_actuator(EV_LED_ACTIVE, ID_LED_A);
				p_task_system_dta->flag = false;
//				p_task_system_dta->event = EV_SYS_IDLE;

				p_task_system_dta->state = ST_SYS_MENU_3;

			}

			break;

		case ST_SYS_MENU_3:
			switch(param_idx) {
				case 0:{
					bool power = current_motor.power;
					char* power_label = power ? "ON" : "OFF";

					snprintf(buffer, sizeof(buffer), "     > %s      ", power_label);
					put_event_task_display(0, 0, "asd");
					put_event_task_display(0, 1, buffer);
					break;}
				case 1:{
					put_event_task_display(0, 1, "     >SPEED     ");
					break;}
				case 2:{
					put_event_task_display(0, 1, "     >SPIN      ");
					break;}
				}

			if ((true == p_task_system_dta->flag) && (EV_SYS_ESCAPE == p_task_system_dta->event))
			{
				put_event_task_actuator(EV_LED_ACTIVE, ID_LED_A);
				p_task_system_dta->flag = false;
	//				p_task_system_dta->event = EV_SYS_IDLE;

				p_task_system_dta->state = ST_SYS_MENU_2;

				put_event_task_display(0, 1, "     >POWER     ");
			}


		break;


		default:

			p_task_system_dta->tick  = DEL_SYS_MIN;
			p_task_system_dta->state = ST_SYS_IDLE;
			p_task_system_dta->event = EV_SYS_IDLE;
			p_task_system_dta->flag = false;

			break;
	}
}

void task_system_setup_statechart(void)
{
	task_system_dta_t *p_task_system_dta;

	/* Update Task System Data Pointer */
	p_task_system_dta = &task_system_dta_list[SETUP];

	if (true == any_event_task_system())
	{
		p_task_system_dta->flag = true;
		p_task_system_dta->event = get_event_task_system();
	}

	switch (p_task_system_dta->state)
	{
		/*case ST_SYS_MENU_1:

			if ((true == p_task_system_dta->flag) && (EV_SYS_BTN_A == p_task_system_dta->event))
			{
				p_task_system_dta->flag = false;
				put_event_task_actuator(EV_LED_ACTIVE, ID_LED_A);
				p_task_system_dta->state = ST_SYS_MENU_1;

				put_event_task_display(0, 0, "task_system_mode");
				put_event_task_display(0, 1, " NORMAL         ");

				task_system_set_mode(NORMAL);
			}

			break;*/

			/*case ST_SYS_MENU_1:
				if ((true == p_task_system_dta->flag) && (EV_SYS_NEXT == p_task_system_dta->event))
				{
					p_task_system_dta->flag = false;
					idx = (idx + 1) % MOTORS_QTY;

					current_motor = motors_list[idx];
				}

				char buffer[16];
				snprintf(buffer, sizeof(buffer), "    MOTOR %d    ", idx);
				put_event_task_display(0, 0, " ENTER/ESC/NEXT ");
				put_event_task_display(0, 1, buffer);

				break;*/

		/*case ST_SYS_MENU_1:

			if ((true == p_task_system_dta->flag) && (EV_SYS_IDLE == p_task_system_dta->event))
			{
				p_task_system_dta->flag = false;
				put_event_task_actuator(EV_LED_IDLE, ID_LED_A);
				p_task_system_dta->state = ST_SYS_MENU_1;
			}

			break;*/

		default:

			p_task_system_dta->tick  = DEL_SYS_MIN;
			p_task_system_dta->state = ST_SYS_IDLE;
			p_task_system_dta->event = EV_SYS_IDLE;
			p_task_system_dta->flag = false;

			break;
	}
}

void task_system_set_mode(task_system_mode_t task_system_mode)
{
	g_task_system_mode = task_system_mode;
}

/********************** end of file ******************************************/
