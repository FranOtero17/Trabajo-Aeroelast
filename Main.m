%% VORTEX LATTICE METHOD





%%

clear all; close all;

setPlot;
%% MAIN PARAMETERS

% Wing parameter definition

Wing.Parameters.Chord     = 2.5;
Wing.Parameters.AR        = 7;
Wing.Parameters.Sweep     = 0;
Wing.Parameters.Sweepr    = deg2rad(Wing.Parameters.Sweep);
Wing.Parameters.Sw        = 28;
Wing.Parameters.lambda    = 0.6;
Wing.Parameters.b         = (Wing.Parameters.AR*Wing.Parameters.Sw)^0.5;
Wing.Parameters.dihedral  = 0;
Wing.Parameters.dihedralr = deg2rad(Wing.Parameters.dihedral);

Wing.Parameters.xoffset   = 0;            
Wing.Parameters.yoffset   = 0;            
Wing.Parameters.zoffset   = 0;            

Wing.Parameters.prof_R  = '0000';
Wing.Parameters.prof_T  = '0000';
% Wing.Parameters.PF      = 'trap';
Wing.Parameters.tor_d   = 0;
Wing.Parameters.theta0  = 0;
Wing.Parameters.theta0r = deg2rad(Wing.Parameters.theta0);
Wing.Parameters.tor     = @(y) Wing.Parameters.theta0r*(1-y^2/Wing.Parameters.b^2);

Wing.Parameters.Nc      = 20;                 %Número de elementos según la cuerda
Wing.Parameters.nx      = Wing.Parameters.Nc+1;            %Número de nodos según la cuerda
Wing.Parameters.Nss     = 30;      %Número de elementos según la semienvergadura
Wing.Parameters.ny      = Wing.Parameters.Nss*2+1; %Número de nodos según la envergadura
Wing.Parameters.Nt      = Wing.Parameters.Nc*Wing.Parameters.Nss*2;
Wing.Parameters.bias_x  = 3;
Wing.Parameters.bias_y  = 4;

% Flight Conditions

FC.aoa     = [3];
FC.aoar    = deg2rad(FC.aoa);
FC.beta    = 0;
FC.betar   = deg2rad(FC.beta);
FC.M       = 0.3;
FC.H       = 0;
[T,a,P,rho]= atmosisa(FC.H);
FC.U       = a*FC.M;
FC.q       = 0.5*rho*FC.U^2;
FC.naoa    = size(FC.aoar,2);

%% Wing Generation

[Wing]     = GenerateWing(Wing);
[Wing]     = GenerateMesh(Wing);

DisplayCase(Wing,FC);
%% Vortex Lattice Simulation

[Wing]     = VortexLattice(Wing,FC);

