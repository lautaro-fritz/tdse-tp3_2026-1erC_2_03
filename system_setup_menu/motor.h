/*
 * motor.h
 *
 *  Created on: 13 may 2026
 */

#ifndef MOTOR_H_
#define MOTOR_H_

#define MOTOR_QTY 2

#include <stdbool.h>
#include <stdint.h>

typedef enum spin {
	LEFT, RIGHT
}spin_t;

typedef struct {
	bool power;
	uint8_t speed;
	spin_t spin;
} motor_t;

motor_t motors_list[2] = {
		{false, 0, LEFT},
		{false, 0, LEFT}
};

#endif /* MOTOR_H_ */
