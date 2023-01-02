% jakoś zaimportować Pendulum i Animat

pendulum = Pendulum(pi/2, pi/3, 3, 2, 1, 3, 9.8, 20);
animator = Animator(pendulum);
animator.animate();
animator.save_animation_to_file();