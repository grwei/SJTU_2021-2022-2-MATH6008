%% hw1.m
% Matlab code for 2022 Spring MATH6008-M01 Homework 1
% Author: Guorui Wei (危国锐) (weiguorui@sjtu.edu.cn; 313017602@qq.com)
% Student ID: 120034910021
% Created: 2022-02-28
% Last modified: 2022-03-01

%% Initialize project

clc; clear; close all
init_env();

%% FDM for the advection equation (two-level explicit scheme)

%%% Parameters definition.
hw1_tau = 4e-3; % time step

%%% 
t_TCL = tiledlayout(2,2,"TileSpacing","compact","Padding","tight");
xlabel(t_TCL,"$x$","Interpreter",'latex');
ylabel(t_TCL,"$t$","Interpreter",'latex');
[t_title_t,t_title_s] = title(t_TCL,"\bf 2022 Spring MATH6008 Hw1 Q5","Guorui Wei 120034910021","Interpreter",'latex');
set(t_title_s,'FontSize',8)

%%% Two-level explicit scheme for the advection equation.
% Backward (left-) one-sided difference for space.
hw1_results_09_left = hw1_FDM(hw1_tau,0.9,"leftward",t_TCL,1,"\bf $\lambda = 0.9$, leftward");
hw1_results_20_left = hw1_FDM(hw1_tau,2.0,"leftward",t_TCL,2,"\bf $\lambda = 2.0$, leftward");
% Forward (right-) one-sided difference for space.
hw1_results_09_right = hw1_FDM(hw1_tau,0.9,"rightward",t_TCL,3,"\bf $\lambda = 0.9$, rightward");
hw1_results_20_right = hw1_FDM(hw1_tau,2.0,"rightward",t_TCL,4,"\bf $\lambda = 2.0$, rightward");

%% Figure.

%
exportgraphics(t_TCL,"..\\doc\\fig\\hw1_Q3.png",'Resolution',800,'ContentType','auto','BackgroundColor','none','Colorspace','rgb')
% exportgraphics(t_TCL,"..\\doc\\fig\\hw1_Q3.emf",'Resolution',800,'ContentType','auto','BackgroundColor','none','Colorspace','rgb')

%% local functions

function [hw1_results] = hw1_FDM(hw1_tau,hw1_lambda,space_diff_type,t_TCL,tile_num,tile_title)
%% hw1_FDM
%%% two-level explicit scheme for the advection equation
% hw1_tau: time step
% hw1_lambda: time step/space step
% space_diff_type: direction of one-sided difference for space
    arguments
        hw1_tau
        hw1_lambda
        space_diff_type
        t_TCL
        tile_num
        tile_title
    end

    %%% parameters definition
    hw1_N_t = floor(4/hw1_tau);
    hw1_h = hw1_tau / hw1_lambda;
    hw1_N_x = floor(5/hw1_h);
    if 4/hw1_tau ~= hw1_N_t
        warndlg("N_t should be positive integer!","invalid parameters");
    end
    
    %%% two-level explicit scheme for the advection equation
    hw1_x_val_vector = linspace(-5,5,2*hw1_N_x+1); % x-value vector of the solving region
    hw1_t_val_vector = linspace(0,4,hw1_N_t+1); % t-value vector of the solving region
    [hw1_x_grid,hw1_t_grid] = meshgrid(hw1_x_val_vector,hw1_t_val_vector);
    hw1_results = zeros(size(hw1_t_grid)); % numerical results
    % Assign the initial and boundary conditions.
    hw1_results(1,:) = hw1_x_val_vector >= 0; % Initial conditions.
    hw1_results(:,1) = 0; % Boundary conditions.
    hw1_results(:,end) = 1; % Boundary conditions.
    % Solve level by level.
    for n = 1:(hw1_N_t)
        for j = 2:(2*hw1_N_x)
            if space_diff_type == "leftward"
                % backward (left-) one-sided difference for space
                hw1_results(n+1,j) = (1-hw1_lambda)*hw1_results(n,j) + hw1_lambda*hw1_results(n,j-1);
            else
                % forward (right-) one-sided difference for space
                hw1_results(n+1,j) = (1+hw1_lambda)*hw1_results(n,j) - hw1_lambda*hw1_results(n,j+1);
            end
        end
    end

    %%% Figure.
    %
    t_Axes = nexttile(t_TCL,tile_num);
    s = pcolor(t_Axes,hw1_x_grid,hw1_t_grid,hw1_results);
    set(s,'EdgeColor','flat','FaceColor','flat','EdgeColor','interp','FaceColor','interp')
    title(t_Axes,tile_title,'Interpreter','latex')
    caxis(t_Axes,[-1 2]); % Hold Color Limits for Multiple Plots
    colormap(t_Axes,"parula")
    set(t_Axes,'YDir',"normal",'TickLabelInterpreter','latex','FontSize',10)
    if ~mod(tile_num,2)
        set(t_Axes,'YTickLabel',{});
    end
    % share colorbar
    if tile_num == 1
        cb = colorbar;
        set(cb,"TickLabelInterpreter",'latex');
        set(cb.Label,'Interpreter','latex','String','$u(x,t)$');
        cb.Layout.Tile = 'east';
    end

end % end of function definition

%% Initialize environment
function [] = init_env()
%% init_env
% Description.
    arguments
    
    end
    % set up project directory
    if ~isfolder("../doc/fig/")
        mkdir ../doc/fig/
    end
    % configure searching path
    mfile_fullpath = mfilename('fullpath'); % the full path and name of the file in which the call occurs, not including the filename extension.
    mfile_fullpath_without_fname = mfile_fullpath(1:end-strlength(mfilename));
    addpath(genpath(mfile_fullpath_without_fname + "../data"), ...
            genpath(mfile_fullpath_without_fname + "../inc")); % adds the specified folders to the top of the search path for the current MATLAB® session.
end
