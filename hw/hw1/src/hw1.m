%% hw1.m
% Matlab code for 2022 Spring MATH6008-M01 Homework 1
% Author: Guorui Wei (危国锐) (weiguorui@sjtu.edu.cn; 313017602@qq.com)
% Student ID: 120034910021
% Created: 2022-02-28
% Last modified: 2022-

%% Initialize project

clc; clear; close all
init_env();

%% local functions

%% Initialize environment
function [] = init_env()
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
