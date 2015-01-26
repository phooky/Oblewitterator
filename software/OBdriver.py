import sys
import os
import logging
import math
import numpy as np
from pylab import plot, show, grid

class ObleG(object):
    """
    Base class to drive Oblewitterator.
    """

    def __init__(self):
        logging.info("Initializing.")
        self.gcommands = []

    def home(self):
        #self.gcommands.append("G28 X Y Z")
        self.gcommands.append("G28 X Y") # NOTE: use this only while Z endstops are not installed

    def home_y(self):
        self.gcommands.append("G28 X Y")

    def home_x(self):
        self.gcommands.append("G28 Z")

    def goto(self, x=0, y=0, feedrate=100):
        """
        move to x, y coordinates at rate feedrate (mm/min)
        """
        self.gcommands.append("G1 X%s Y%s Z%s F%s" % (y, y, x, feedrate))

    def pen_up(self):
        self.gcommands.append("") #TODO

    def pen_down(self):
        self.gcommands.append("")

    def run(self):
        return '\n'.join(self.gcommands)


class ObleDraw(object):
    """
    Higher-level API for drawing awesome stuff
    """
    def __init__(self):
        self.G = ObleG()
        self.G.pen_up()
        self.G.home()

    def draw_line(self, x1, y1, x2, y2, speed=100):
        self.G.pen_up()
        self.G.goto(x1, y1, speed)
        self.G.pen_down()
        self.G.goto(x2, y2, speed)

    def draw_arc(self, x1, y1, x2, y2, angle, speed=100):
        self.G.pen_up()
        self.G.goto(x1, y1)
        

    def draw_circle(self, x, y, radius, speed=100):
        self.draw_ellipse(a=radius, b=radius, x=x, y=y, speed=speed)

    def draw_ellipse(self, a=0.0, b=0.0, x=0.0, y=0.0, angle=0.0, k=1, speed=100):
        """
        a: radius width
        b: radius height
        x: x center coordinate
        y: y center coordinate
        angle: rotate the entire ellipse this many degrees
        k: resolution of line segments (360 by default, one per degree)
        """
        # generate ellipse points
        points = np.zeros((360*k+1, 2))
        beta = -angle * np.pi/180.0
        sin_beta = np.sin(beta)
        cos_beta = np.cos(beta)
        alpha = np.radians(np.r_[0.:360.:1j*(360*k+1)])
 
        sin_alpha = np.sin(alpha)
        cos_alpha = np.cos(alpha)
        
        points[:, 0] = x + (a * cos_alpha * cos_beta - b * sin_alpha * sin_beta)
        points[:, 1] = y + (a * cos_alpha * sin_beta + b * sin_alpha * cos_beta)

        # generate gcode
        self.G.pen_up() #todo go home
        self.G.pen_down()
        for x, y in points:
            self.G.goto(x, y, speed)

        return points




if __name__ == '__main__':
    o = ObleDraw()
    pts = o.draw_ellipse(a=100.0, b=100.0, x=200, y=200, angle=0, k=.5)

    #pts = o.draw_ellipse(a=4.0, b=2.0, x=1, y=1, angle=30,k=1)
    ax = plot(pts[:,0], pts[:,1])
    show()

    #o.draw_line(10, 10, 30, 30)
    print o.G.run()
