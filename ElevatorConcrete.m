classdef ElevatorConcrete < Elevator
    % RLENVDOUBLEINTEGRATORCONTINUOUSACTION: Creates double integrator RL
    % environment with continuous action.
    
    % Copyright 2017-2018 The MathWorks Inc.
    
    
    methods (Access = protected)
        function force = getForce(this,force)
            % saturate the action
            umax = this.MaxForce;
            force = min(max(force,-umax),umax);
        end
        
        function setMaxForce_(this,val)
            validateattributes(val,{'numeric'},{'scalar'});
            this.MaxForce_ = val;
            this.ActionInfo.UpperLimit =  val;
            this.ActionInfo.LowerLimit = -val;
        end
    end
    
    methods
        function this = ElevatorConcrete()
            % ENV = DOUBLEINTEGRATORCONTINUOUSACTION()
            ActionInfo = rlNumericSpec([1 1]);
            ActionInfo.Name = 'force';
            this = this@Elevator(ActionInfo);
            
        end
        function obs = reset(this)
            % reset the double integrator to +/- 0.8*MaxDistance
            r = rand(1,1) - 0.5;
            if r == 0, r = 1; end
            % X
            X0 = 0.8*this.FinalPoint*sign(r);
            % Xdot
            Xd0 = 0;
            this.State = [X0;Xd0];
            obs = this.State;
        end
        % Function to plot the elevator
        function plotState(obj,listStates,listStateOptimal)
            figure(1);
            hold on
            box on
            axis([0 4 -2 8])
            axis equal
            plot(0.1,0,'ro')
            text(-0.5,0,'x_i','FontSize',14)
            plot(0.1,5,'ro')
            text(-0.5,5,'x_f','FontSize',14)
            for i = 1:length(listStates)
                if i>1
                    delete(h1);
                    delete(h2);
                end
                h1 = patch([0,0.2,0.2,0],[listStates(i)-0.1,listStates(i)-0.1,...
                    listStates(i)+0.1,listStates(i)+0.1],'g');
                h2 = plot(0.1,listStates(i),'k+');
                pause(0.1)
            end
            axis([0 4 -2 8])
            axis equal
            plot(0.1,0,'ro')
            text(-0.5,0,'x_i','FontSize',14)
            plot(0.1,5,'ro')
            text(-0.5,5,'x_f','FontSize',14)
            for i = 1:length(listStateOptimal)
                if i>1
                    delete(h3);
                    delete(h4);
                end
                h3 = patch([0,0.2,0.2,0],[listStateOptimal(i)-0.1,listStateOptimal(i)-0.1,...
                    listStateOptimal(i)+0.1,listStateOptimal(i)+0.1],'r');
                h4 = plot(0.1,listStateOptimal(i),'k+');
                pause(0.1)
            end
        end
    end
end
