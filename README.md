# fuzzy-monument-lighting
Fuzzy logic controller for adaptive monument lighting (MATLAB/Simulink), 38.8% simulated energy saving
# Smart Adaptive Energy-Efficient Monument Illumination System

A fuzzy logic controller built in MATLAB and Simulink that adjusts monument lighting brightness based on ambient light (lux) and time of night, instead of running at full brightness all night.

Academic project for EEE111 (Electrical Power Generation & Utilization), NMAMIT. Software simulation only; no hardware was built.

## How it works
- Mamdani fuzzy controller: 2 inputs (Lux, Hour of night), 1 output (Brightness), 9 rules, triangular membership functions
- Simulink model validates the controller over a 24-hour cycle
- MATLAB script runs the controller against a simulated dusk-to-dawn lux profile and compares energy use with constant 100% lighting

## Result
38.8% less energy than constant full brightness, in simulation. The lux profile is synthetic, not measured field data.

## Files
- monument_lighting.fis: the fuzzy controller
- monument_lighting_model.slx: Simulink model
- monument_analysis.m: energy analysis and plots

## Run it
Open MATLAB with the Fuzzy Logic Toolbox, put the files in one folder, and run monument_analysis.

## Author
Manvith U M, Electrical and Electronics Engineering, NMAMIT, Nitte
Guide: Gururaj K, Assistant Professor Gd-II, NMAMIT, Mangalore
