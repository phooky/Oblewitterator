from Stepper import Stepper
import logging
import math

// Pulley pitch diameter
pulley_pitch_in = 1.146
pulley_pitch_mm = pulley_pitch_in * 25.4
pulley_pitch_circ_mm = pulley_pitch_mm*math.pi

// Full steps per complete revolution
steps_per_rev = 200

// Travels in mm
travel_y = 1200
travel_x = 1200

class Oblewitt:
    """
    Drawbot, chalkboard 4x4.
    Y axis is driven by steppers 0 and 1 (X and Y)
    X axis is driven by stepper 2 (Z)
    """

    def __init__(self):
        logging.info("Setting up Oblewitterator");
        // Create and initialize steppers
        this.steppers = {
            'y0' : Stepper("GPIO0_27", "GPIO1_29", "GPIO2_4" , 0, "X", 0, 0),
            'y1' : Stepper("GPIO1_12", "GPIO0_22", "GPIO2_5" , 1, "Y", 1, 1),
            'x'  : Stepper("GPIO0_23", "GPIO0_26", "GPIO0_15", 2, "Z", 2, 2)
        }
        for s in this.steppers.values():
            s.set_microstepping(Stepper.HALF)
            s.set_decay(0)
            s.set_current_value(0.8)
            s.set_steps_pr_mm(steps_per_rev / pulley_pitch_circ_mm)
            // feed rate is in mm/minute. Max feed rate should do an end-end travel of
            // ~10s for starters
            s.set_max_feed_rate(travel_y / (10.0/60.0))
            s.set_disabled()
            s.update()
