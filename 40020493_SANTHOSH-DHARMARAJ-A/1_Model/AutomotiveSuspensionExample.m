%% Automotive Suspension  
%
% This example shows how to model a simplified half-car model that includes
% an independent front and rear vertical suspension. The model also
% includes body pitch and bounce degrees of freedom. The example provides a
% description of the model to show how simulation can be used to
% investigate ride characteristics. You can use this model in conjunction
% with a powertrain simulation to investigate longitudinal shuffle
% resulting from changes in throttle setting. 

% Copyright 1990-2012 The MathWorks, Inc.

%% Analysis and Physics
%
% <<../sldemo_suspn_figure1.png>>
%
% Free-body diagram of the half-car model
%
% The illustration shows the modeled characteristics of the half-car. The
% front and rear suspension are modeled as spring/damper systems. A more
% detailed model would include a tire model, and damper nonlinearities such
% as velocity-dependent damping (with greater damping during rebound than
% compression). The vehicle body has pitch and bounce degrees of freedom.
% They are represented in the model by four states: vertical displacement,
% vertical velocity, pitch angular displacement, and pitch angular
% velocity. A full model with six degrees of freedom can be implemented
% using vector algebra blocks to perform axis transformations and
% force/displacement/velocity calculations. *Equation 1* describes the
% influence of the front suspension on the bounce (i.e. vertical degree of
% freedom):
%
% $$F_{f} = 2K_f (L_f \theta - (z + h)) + 2C_f(L_f \dot{\theta} -\dot{z})$$
%
% where:
%
% $$F_{f}, F_{r} = \mbox{ upward force on body from front/rear suspension}$$
%
% $$K_f, K_r = \mbox{ front and rear suspension spring constant}$$
%
% $$C_f, C_r = \mbox{ front and rear suspension damping rate}$$
%
% $$L_f, L_r = \mbox{ horizontal distance from gravity center to front/rear suspension}$$
%
% $$\theta, \dot{\theta} = \mbox{ pitch (rotational) angle and its rate of change}$$
%
% $$z, \dot{z} = \mbox{ bounce (vertical) distance and its rate of change}$$
%
% $$h = \mbox{ road height }$$

%%
%
% *Equations 2* describe pitch moments due to the
% suspension.
%
% $$M_{f} = -L_{f}F_{f}$$
%
% $$F_{r} = -2K_r (L_r\theta + (z + h)) -2C_r ( L_r \dot{\theta} + \dot{z})$$
% 
% $$M_{r} = L_r F_{r}$$
%
% where:
%
% $$M_{f}, M_{r} = \mbox{ Pitch moment due to front/rear suspension}$$
%

%%
%
% *Equations 3* resolves the forces and moments result in body motion,
% according to Newton's Second Law:
%
% $$m_b\ddot{z} = F_{f} + F_{r} - m_b g$$
%
% $$I_{yy} \ddot{\theta} = M_{f} + M_{r} + M_y $$
%
% where:
%
% $$ m_b = \mbox{ body mass}$$
% 
% $$ M_y = \mbox{ pitch moment induced by vehicle acceleration}$$
%
% $$I_{yy} = \mbox{ body moment of inertia about gravity center}$$

%% Model
% 
% To open the model, type |sldemo_suspn| in the MATLAB(R) command window.
open_system('sldemo_suspn');
%%
%
% Top-level diagram of the suspension model
%%
%
% The suspension model has two inputs, and both input blocks are blue on
% the model diagram. The first input is the road height. A step input here
% corresponds to the vehicle driving over a road surface with a step change
% in height. The second input is a horizontal force acting through the
% center of the wheels that results from braking or acceleration maneuvers.
% This input appears only as a moment about the pitch axis because the
% longitudinal body motion is not modeled.
%
open_system('sldemo_suspn/Front Suspension','force'); %look under the mask
%%
%
% The Spring/Damper model used in FrontSuspension and RearSuspension
% subsystems
%%
%
% The spring/damper subsystem that models the front and rear suspensions is
% shown above. Right click on the Front/Rear Suspension block and select
% *Mask* > *Look Under Mask* to see the front/rear suspension subsystem.
% The suspension subsystems are used to model Equations 1-3. The equations
% are implemented directly in the Simulink(R) diagram through the
% straightforward use of Gain and Summation blocks.
%
% The differences between front and rear are accounted for as follows.
% Because the subsystem is a masked block, a different data set (|L|, |K|
% and |C|) can be entered for each instance. Furthermore, |L| is thought of
% as the Cartesian coordinate x, being negative or positive with respect to
% the origin, or center of gravity. Thus, |Kf|, |Cf|, and |-Lf| are used
% for the front suspension block whereas |Kr|, |Cr|, and |Lr| are used for
% the rear suspension block.
%% Run the Simulation
%
% To run this model, on the *Simulation* tab, click *Run*. Initial
% conditions are loaded into the model workspace from the
% |sldemo_suspdat.m| file. To see the contents of the model workspace, in
% the Simulink Editor, on the *Modeling* tab, under *Design*, select *Model
% Explorer*. In the Model Explorer, look under the contents of the
% |sldemo_suspn| model and select "Model Workspace". Loading initial
% conditions in the model workspace prevents any accidental modifications
% of parameters and keeps MATLAB workspace clean.
%
% Note that the model logs relevant data to MATLAB workspace in a data structure
% called |sldemo_suspn_output|. Type the name of the structure to see what data
% it contains.
evalc('sim(''sldemo_suspn'')');
%%
%
% Simulation results
%%
%
% Simulation results are displayed above. The results are plotted by the
% |sldemo_suspgraph.m| file. The default initial conditions are given in
% Table 1.
%
% *Table 1:* Default initial conditions
%
%  Lf = 0.9;    % front hub displacement from body gravity center (m)
%  Lr = 1.2;    % rear hub displacement from body gravity center (m)
%  Mb = 1200;   % body mass (kg)
%  Iyy = 2100;  % body moment of inertia about y-axis in (kg m^2)
%  kf = 28000;  % front suspension stiffness in (N/m)
%  kr = 21000;  % rear suspension stiffness in (N/m)
%  cf = 2500;   % front suspension damping in (N sec/m)
%  cr = 2000;   % rear suspension damping in (N sec/m)
%
%% Close the Model
%
% Close the model and delete generated data from MATLAB workspace.

close_system('sldemo_suspn',0); %close, don't save any changes
clear sldemo_suspn_output;

% close the plot is it exists
if ~isempty( findobj('Tag','SimulationResultsPlot') )
    close( findobj('Tag','SimulationResultsPlot') );
end
%% Conclusions
%
% This model allows you to simulate the effects of changing the suspension
% damping and stiffness, thereby investigating the tradeoff between comfort
% and performance. In general, racing cars have very stiff springs with a
% high damping factor, whereas passenger vehicles have softer springs and a
% more oscillatory response.