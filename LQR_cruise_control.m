m = 1000; % mass of the vehicle 
b = 50; % damping factor

A = [0, 1; 0, -b/m]; % A matrix, use math to deduce
B = [0; 1/m]; % same with A matrix

C = [1 0]; % mesure the vehicle's position x

eig(A); % check if the system is stable
rank(ctrb(A,B)); %check if the system is controllable

%% Design LQR controller

%The cost function J = integral(xTQx + uTRu)
Q = [1, 0; 0, 1]; % this indicates how bad the penalty is if x does
                   % not have the best set of poles (eigen values)

R = 0.0001; % arbitrarily set this to 1 to reduce complexity
K = lqr(A,B,Q,R); % find the best K such that u = -Kx and u is the control knob

%% Augment system with disturbance and noise

Vd = 0.001 * eye(2); % disturbance covariance
Vn = 0.001; % noise covariance

B_augment = [B, Vd, 0*B] % B matrix of thix augment system takes B, disturbance and 0 noise

sysC = ss(A,B_augment,C,[0,0,0,Vn]) % build the state space system with a single output

sysFullOutput = ss(A,B_augment,eye(2),zeros(2,size(B_augment,2)))

%% Build Kalman filter

[L,P,E] = lqe(A,Vd,C,Vd,Vn)
Kalmanf = (lqr(A',C',Vd,Vn))'

sysKalman = ss(A-Kalmanf*C, [B, Kalmanf], eye(2), 0*[B Kalmanf])
