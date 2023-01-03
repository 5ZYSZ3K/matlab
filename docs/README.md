# Installation

- Make sure you have the MATLAB package installed
- Clone this repo
- Run the matlab packet
- In the MATLAB IDE, navigate to the folder where you have cloned this repo
- Open `View.m` file and hit the `F5` button

# Development

## Pendulum class

<b>Public methods</b>

1. constructor <br />
   A function that lets you create the new Pendulum object. It takes 8 arguments: the inclination angle of the first ball from the axis, the inclination angle of the second ball, the mass of the first ball, the mass of the second ball, the length of the first rode, the length of the second rode, the gravity of the environment and the duration of the animation (in seconds).

2. getFirstBallCoordinates <br />
   A function that takes only one argument (the time) and returns a vector with the `x` and `y` position of the first ball in a given time.

3. getSecondBallCoordinates <br />
   Similar to the one above, it returns the position of the second ball

4. change_values <br />
   It takes the same arguments as the constructor, it mutates the pendulum

5. get_values <br />
   It returns a vector with the first rod length, the second rod length, the first ball mass and the second ball mass

6. get_max_time <br />
   It returns the duration of the animation

## Animator class

<b>Public methods</b>

1. constructor <br />
   It takes the pendulum object as a parameter, creates the Animator object

2. animate_and_save <br />
   It fires the animation and then saves the animation file to the `output.avi` file (already in `.gitignore`)

## TODO

1. Create a GUI interface, with a form inside, which, on submit, will either create new pendulum class and override the old one, or simply fire `change_values` method on the pendulum object to change its inner implementation. For now, the preferable way is to create a new pendulum and animator object on submit, because I still haven't figured out how attributes mutation works in MATLAB.

2. Figure out how attributes mutation works in MATLAB, and how complex objects are being passed (via reference or via value). Then, create a solution to update the pendulum object values on submit, to reduce complexicity.
