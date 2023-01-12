clc;

pendulum = Pendulum(pi/2, pi/3, 3, 2, 1, 3, 9.8, 5);
animator = Animator(pendulum);
animator = animator.change_pendulum_values(0, 3*pi/2, 4, 5, 2, 3, 9.8, 5);
animator = animator.animate();
animator.save();