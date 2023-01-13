classdef Pendulum
    properties (Access = private)
        length_first {mustBeNumeric}
        length_second {mustBeNumeric}
        solutions
        mass_first {mustBeNumeric}
        mass_second {mustBeNumeric}
        max_time {mustBeNumeric}
    end

    methods (Access = private)
        function modified_object = solve_equations(self, a1, a2, m1, m2, l1, l2, g, max_t)
            modified_object = self;

            modified_object.mass_first = m1;
            modified_object.mass_second = m2;
            modified_object.max_time = max_t;
            modified_object.length_first = l1;
            modified_object.length_second = l2;
            syms angle_1(t) angle_2(t) length_1 length_2 mass_1 mass_2 gravity;
            x_1 = length_1*sin(angle_1);
            y_1 = -length_1*cos(angle_1);
            x_2 = x_1 + length_2*sin(angle_2);
            y_2 = y_1 - length_2*cos(angle_2);
            velocity_x_1 = diff(x_1);
            velocity_y_1 = diff(y_1);
            velocity_x_2 = diff(x_2);
            velocity_y_2 = diff(y_2);
            acceleration_x_1 = diff(velocity_x_1);
            acceleration_y_1 = diff(velocity_y_1);
            acceleration_x_2 = diff(velocity_x_2);
            acceleration_y_2 = diff(velocity_y_2);
            
            syms tension_1 tension_2;
            
            differental_equation_x_1 = mass_1*acceleration_x_1(t) == -tension_1*sin(angle_1(t)) + tension_2*sin(angle_2(t));
            differental_equation_y_1 = mass_1*acceleration_y_1(t) == tension_1*cos(angle_1(t)) - tension_2*cos(angle_2(t)) - mass_1*gravity;
            
            differental_equation_x_2 = mass_2*acceleration_x_2(t) == -tension_2*sin(angle_2(t));
            differental_equation_y_2 = mass_2*acceleration_y_2(t) == tension_2*cos(angle_2(t)) - mass_2*gravity;
            
            overall_tension = solve([differental_equation_x_1 differental_equation_y_1],[tension_1 tension_2]);
            
            general_differental_equation_1 = subs(differental_equation_x_2,[tension_1 tension_2], [overall_tension.tension_1, overall_tension.tension_2]);
            general_differental_equation_2 = subs(differental_equation_y_2,[tension_1 tension_2], [overall_tension.tension_1, overall_tension.tension_2]);

            substituted_equation_1 = subs(general_differental_equation_1, [length_1, length_2, mass_1, mass_2, gravity], [l1, l2, m1, m2, g]);
            substituted_equation_2 = subs(general_differental_equation_2, [length_1, length_2, mass_1, mass_2, gravity], [l1, l2, m1, m2, g]);
            
            V = odeToVectorField(substituted_equation_1, substituted_equation_2);
            M = matlabFunction(V,'vars',{'t','Y'});

            modified_object.solutions = ode45(M,[0 max_t], [a1 0 a2 0]);

        end
    end

    methods
        % constructor, as a parameter takes first and second ball initial angles, masses and lengths, the gravity and the animation duration
        function obj = Pendulum(a1, a2, m1, m2, l1, l2, g, max_t)
            obj = obj.solve_equations(a1, a2, m1, m2, l1, l2, g, max_t);
        end

        % a function that returns the first ball coordinates within given time
        function coords = get_first_ball_coordinates(self, t)
            coords = [self.length_first*sin(deval(self.solutions, t, 3)), -self.length_first*cos(deval(self.solutions, t, 3))];
        end

        % a function that returns the second ball coordinates within given time
        function coords = get_second_ball_coordinates(self, t)
            first_ball_coordinates = self.get_first_ball_coordinates(t);
            coords = [first_ball_coordinates(1) + self.length_second*sin(deval(self.solutions, t, 1)), first_ball_coordinates(2) - self.length_second*cos(deval(self.solutions, t, 1))];
        end

        % a function that lets us change the pendulum parameters - takes identical parameters as the constructor
        function modified_object = change_values(self, a1, a2, m1, m2, l1, l2, g, max_t)
            modified_object = self;
            modified_object = modified_object.solve_equations( a1, a2, m1, m2, l1, l2, g, max_t);
        end

        % a function that returns the pendulum parameters
        function values = get_values(self)
            values = [self.length_first, self.length_second, self.mass_first, self.mass_second];
        end

        % a function that returns the animation duration
        function time = get_max_time(self)
            time = self.max_time;
        end
    end
end
