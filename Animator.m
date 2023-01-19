classdef Animator
    properties (Access = private)
        frames
        pendulum {mustBeNonmissing}
    end

    methods
        % constructor, it takes a pendulum object as a parameter
        function obj = Animator(passed_pendulum)
            obj.pendulum = passed_pendulum;
        end

        function modified_object = change_pendulum_values(self, a1, a2, m1, m2, l1, l2, g, max_t)
            modified_object = self;
            modified_object.pendulum = self.pendulum.change_values(a1, a2, m1, m2, l1, l2, g, max_t);
        end

        % a function that animates the pendulum and saves the output to the `output.avi` file
        function modified_object = animate(self)
            modified_object = self;
            values_array = self.pendulum.get_values();

            % two next lines stolen from stackoferflow
            values_cell_array = num2cell(values_array);
            [L_1, L_2, m_1, m_2] = values_cell_array{:};

            temp_frames = struct('cdata', cell(1, self.pendulum.get_max_time()), 'colormap', cell(1, self.pendulum.get_max_time()));

            fig = figure('Position',[100 100 850 600]);

            for t = 0:.1:self.pendulum.get_max_time()
                first_coordinates = self.pendulum.get_first_ball_coordinates(t);
                second_coordinates = self.pendulum.get_second_ball_coordinates(t);
                x_1 = first_coordinates(1);
                y_1 = first_coordinates(2);
                x_2 = second_coordinates(1);
                y_2 = second_coordinates(2);
                plot(x_1,y_1,'ro','MarkerSize',m_1*7,'MarkerFaceColor','r');
                hold on;
                plot([0 x_1],[0 y_1],'r-');
                plot(x_2,y_2,'go','MarkerSize',m_2*10,'MarkerFaceColor','g');
                plot([x_1 x_2],[y_1 y_2],'g-');
                text(-0.3,0.3,"Timer: "+num2str(t,2));
                xlim([-L_1-L_2-1,L_1+L_2+1]);
                ylim([-L_1-L_2-1,L_1+L_2+1]);
                hold off;
                temp_frames(round(t*10)+1) = getframe(fig);
            end

            modified_object.frames = temp_frames;
            close(fig);
        end

        function save(self)
            delete 'output.avi';
            mov = VideoWriter('output.avi');
            mov.open;
            writeVideo(mov, self.frames);
            mov.close;
        end
    end
end