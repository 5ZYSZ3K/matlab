# Installation

- Make sure you have the MATLAB package installed
- Clone this repo
- Run the matlab packet
- In the MATLAB IDE, navigate to the folder where you have cloned this repo
- Open `View.mlapp` file using MATLAB App Designer and press the `run` button

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
   `mutating`
   It takes the same arguments as the constructor, it mutates the pendulum.

5. get_values <br />
   It returns a vector with the first rod length, the second rod length, the first ball mass and the second ball mass

6. get_max_time <br />
   It returns the duration of the animation

## Animator class

<b>Public methods</b>

1. constructor <br />
   It takes the pendulum object as a parameter, creates the Animator object

2. animate <br />
   `mutating`
   It fires the animation

3. save <br />
   Saves the animation file to the `output.avi` file (already in `.gitignore`)

## TODO

1. Enhance the GUI (e.g. background image, better validation)

2. Figure out, how to get rid of this randomly occuring "all 'cdata' fields must be the same size" error while saving the video

3. Figure out how attributes mutation works in MATLAB, and how complex objects are being passed (via reference or via value). Then, find a better solution to update the pendulum object values on submit, to reduce complexicity.

## Notes

1. Methods marked as `mutating` requires assigning the output to the object on which you have called the method
