classdef Pendulum
    properties (Access = private)
        length_first {mustBeNumeric}
        length_second {mustBeNumeric}
        solutions
        mass_first {mustBeNumeric}
        mass_second {mustBeNumeric}
        max_time {mustBeNumeric}
    end

    methods
        function obj = Pendulum(a1, a2, m1, m2, l1, l2, g, max_t)
            obj.mass_first = m1;
            obj.mass_second = m2;
            obj.max_time = max_t;
            obj.length_first = l1;
            obj.length_second = l2;

            syms theta_1(t) theta_2(t) L_1 L_2 m_1 m_2 grav;
            x_1 = L_1*sin(theta_1);
            y_1 = -L_1*cos(theta_1);
            x_2 = x_1 + L_2*sin(theta_2);
            y_2 = y_1 - L_2*cos(theta_2);
            vx_1 = diff(x_1);
            vy_1 = diff(y_1);
            vx_2 = diff(x_2);
            vy_2 = diff(y_2);
            ax_1 = diff(vx_1);
            ay_1 = diff(vy_1);
            ax_2 = diff(vx_2);
            ay_2 = diff(vy_2);
            
            syms T_1 T_2;
            
            eqx_1 = m_1*ax_1(t) == -T_1*sin(theta_1(t)) + T_2*sin(theta_2(t));
            eqy_1 = m_1*ay_1(t) == T_1*cos(theta_1(t)) - T_2*cos(theta_2(t)) - m_1*grav;
            
            eqx_2 = m_2*ax_2(t) == -T_2*sin(theta_2(t));
            eqy_2 = m_2*ay_2(t) == T_2*cos(theta_2(t)) - m_2*grav;
            
            Tension = solve([eqx_1 eqy_1],[T_1 T_2]);
            
            equation_1 = subs(eqx_2,[T_1 T_2],[Tension.T_1 Tension.T_2]);
            equation_2 = subs(eqy_2,[T_1 T_2],[Tension.T_1 Tension.T_2]);

            substituted_equation_1 = subs(equation_1, [L_1, L_2, m_1, m_2, grav], [l1, l2, m1, m2, g]);
            substituted_equation_2 = subs(equation_2, [L_1, L_2, m_1, m_2, grav], [l1, l2, m1, m2, g]);
            
            V = odeToVectorField(substituted_equation_1, substituted_equation_2);
            M = matlabFunction(V,'vars',{'t','Y'});

            obj.solutions = ode45(M,[0 max_t], [a1 0 a2 0]);
            
        end

        function coords = getFirstBallCoordinates(self, t)
            coords = [self.length_first*sin(deval(self.solutions, t, 3)), -self.length_first*cos(deval(self.solutions, t, 3))];
        end

        function coords = getSecondBallCoordinates(self, t)
            firstBallCoordinates = self.getFirstBallCoordinates(t);
            coords = [firstBallCoordinates(1) + self.length_second*sin(deval(self.solutions, t, 1)), firstBallCoordinates(2) - self.length_second*cos(deval(self.solutions, t, 1))];
        end

        function modified_object = change_values(~, a1, a2, m1, m2, l1, l2, g, max_t)
            syms theta_1(t) theta_2(t) L_1 L_2 m_1 m_2 grav;
            x_1 = L_1*sin(theta_1);
            y_1 = -L_1*cos(theta_1);
            x_2 = x_1 + L_2*sin(theta_2);
            y_2 = y_1 - L_2*cos(theta_2);
            vx_1 = diff(x_1);
            vy_1 = diff(y_1);
            vx_2 = diff(x_2);
            vy_2 = diff(y_2);
            ax_1 = diff(vx_1);
            ay_1 = diff(vy_1);
            ax_2 = diff(vx_2);
            ay_2 = diff(vy_2);
            
            syms T_1 T_2;
            
            eqx_1 = m_1*ax_1(t) == -T_1*sin(theta_1(t)) + T_2*sin(theta_2(t));
            eqy_1 = m_1*ay_1(t) == T_1*cos(theta_1(t)) - T_2*cos(theta_2(t)) - m_1*grav;
            
            eqx_2 = m_2*ax_2(t) == -T_2*sin(theta_2(t));
            eqy_2 = m_2*ay_2(t) == T_2*cos(theta_2(t)) - m_2*grav;
            
            Tension = solve([eqx_1 eqy_1],[T_1 T_2]);
            
            equation_1 = subs(eqx_2,[T_1 T_2],[Tension.T_1 Tension.T_2]);
            equation_2 = subs(eqy_2,[T_1 T_2],[Tension.T_1 Tension.T_2]);

            substituted_equation_1 = subs(equation_1, [L_1, L_2, m_1, m_2, grav], [l1, l2, m1, m2, g]);
            substituted_equation_2 = subs(equation_2, [L_1, L_2, m_1, m_2, grav], [l1, l2, m1, m2, g]);

            V = odeToVectorField(substituted_equation_1, substituted_equation_2);
            M = matlabFunction(V,'vars',{'t','Y'});

            modified_object.solutions = ode45(M,[0 max_t], [a1 0 a2 0]);
        end

        function values = get_values(self)
            values = [self.length_first, self.length_second, self.mass_first, self.mass_second];
        end

        function time = get_max_time(self)
            time = self.max_time;
        end
    end
end
