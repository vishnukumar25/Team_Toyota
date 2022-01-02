%   SLDEMO_SUSPGRAPH script which runs the suspension model.
%   SLDEMO_SUSPGRAPH when typed at the command line runs the simulation and
%   plots the results of the Simulink model SLDEMO_SUSPN.
%
%   See also SLDEMO_SUSPDAT, SLDEMO_SUSPN.

%   Author(s): D. Maclay, S. Quinn, 12/1/97
%   Modified by R. Shenoy 11/12/04
%   Modified by G. Chistol 08/24/06
%   Copyright 1990-2015 The MathWorks, Inc.

if ~exist('sldemo_suspn_output','var')
    disp('Did not find sldemo_suspn_output to plot results.');
    disp('Please run simulation on the sldemo_suspn model.');
else

    % data saved to sldemo_suspn_output
    % this is a Simulink.Timeseries 
    % sldemo_suspn_output.FrontForce
    % sldemo_suspn_output.RearForce
    % sldemo_suspn_output.My
    % sldemo_suspn_output.h
    % sldemo_suspn_output.Z
    % sldemo_suspn_output.Zdot
    % sldemo_suspn_output.Theta
    % sldemo_suspn_output.Thetadot
    
    % make the time vector
    Time = sldemo_suspn_output.get('Z').Values.Time;
    % Plot graphs
    suspnFigH = findobj('Type','figure','Tag','SimulationResultsPlot');
    
    if isempty(suspnFigH)
        suspnFigH = figure;
        set(suspnFigH,'position',[222 245 572 650])
        set(suspnFigH,'Tag','SimulationResultsPlot'); % tag used later to close the figure
    end
    
    suspnAxH = subplot(5,1,1); 
    plot(suspnAxH,Time,sldemo_suspn_output.get('Thetadot').Values.Data);
    ylabel(suspnAxH,'$$\dot{\theta}$$ (rad/sec)','Interpreter','LaTex');
    text(2.2,0.002,'d\theta/dt')
    title(suspnAxH,'Suspension Model Simulation Results')
    set(suspnAxH, 'xticklabel', '')
    
    suspnAxH = subplot(5,1,2); 
    plot(suspnAxH,Time,sldemo_suspn_output.get('Zdot').Values.Data);
    ylabel(suspnAxH,'$$\dot{Z}$$ (m/sec)','Interpreter','LaTex');
    text(2.2, 0.03, 'dz/dt')
    set(suspnAxH, 'xticklabel', '')
    
    suspnAxH = subplot(5,1,3); 
    plot(suspnAxH,Time,sldemo_suspn_output.get('FrontForce').Values.Data); 
    ylabel(suspnAxH,'$$F_{front}$$ (N)','Interpreter','LaTex');
    text(0.5,6500,'reaction force at front wheels')
    set(suspnAxH, 'xticklabel', '')
    
    suspnAxH = subplot(5,1,4); 
    plot(suspnAxH, Time, sldemo_suspn_output.get('h').Values.Data);
    ylabel(suspnAxH,'h (m)', 'Interpreter','LaTex');
    set(suspnAxH,'Ylim',[-0.005 0.015]);
    text(0.5,0.005 ,'road height')
    set(suspnAxH, 'xticklabel', '')
    
    suspnAxH = subplot(5,1,5); 
    plot(suspnAxH, Time, sldemo_suspn_output.get('My').Values.Data);
    ylabel(suspnAxH,'$$M_y$$ (units)', 'Interpreter','LaTex');
    set(suspnAxH,'Ylim',[-20 120]);
    text(3.5,70,'moment due to vehicle accel/decel')
    xlabel(suspnAxH,'Time (sec)','Interpreter','LaTex')
    echo off
end
clear stat Time;
