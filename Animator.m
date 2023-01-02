classdef Animator
    properties (Access = private)
        pendulum {mustBeNonmissing}
        frames
    end

    methods
        function obj = Animator(passed_pendulum)
            obj.pendulum = passed_pendulum;
        end

        function modified_object = animate(self)
            values_array = self.pendulum.get_values();

            % dwie następne linijki zajebane ze stackoverflow
            values_cell_array = num2cell(values_array);
            [L_1, L_2, m_1, m_2] = values_cell_array{:};

            for t = 0:.1:self.pendulum.get_max_time()
                first_coordinates = self.pendulum.getFirstBallCoordinates(t);
                second_coordinates = self.pendulum.getSecondBallCoordinates(t);
                x_1 = first_coordinates(1);
                y_1 = first_coordinates(2);
                x_2 = second_coordinates(1);
                y_2 = first_coordinates(2);
                plot(x_1,y_1,'ro','MarkerSize',m_1*7,'MarkerFaceColor','r');
                hold on;
                plot([0 x_1],[0 y_1],'r-');
                plot(x_2,y_2,'go','MarkerSize',m_2*10,'MarkerFaceColor','g');
                plot([x_1 x_2],[y_1 y_2],'g-');
                text(-0.3,0.3,"Timer: "+num2str(t,2));
                hold off;
                xlim([-L_1-L_2-1,L_1+L_2+1]);
                ylim([-L_1-L_2-1,L_1+L_2+1]);
                modified_object.frames(round(t*10)+1) = getframe; 
            end
        end

        function save_animation_to_file(self)
            mov = VideoWriter('output.avi');
            open(mov);
            disp(self.frames);
            writeVideo(mov, self.frames);
            close(mov);
        end
    end
end