% jakoś zaimportować Pendulum i Animator
clc;

pendulum = Pendulum(pi/2, pi/3, 3, 2, 1, 3, 9.8, 5);
animator = Animator(pendulum);
animator.change_pendulum_values(pi/2, pi/4, 50, 2, 1, 3, 1, 20);
animator.animate_and_save();