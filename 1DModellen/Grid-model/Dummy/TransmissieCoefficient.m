function [ Kt_Bc, Kt_T ] = TransmissieCoefficient()
%% All Transmission Coefficients:

cd('..')
currentDirectory = pwd;
[upperPath, deepestFolder, ~] = fileparts(currentDirectory);
Bc_j = deepestFolder;

cd('../..')
load('var')

N = irun - 1;
L_Bc = length(Bc);
n = ceil(N/L_Bc);

Hs_i = zeros(1,n);
Hs_t = zeros(1,n);
Kt_Bc = zeros(1,n);
Kt_T = zeros(1,n);

for Bc_index = 1:L_Bc
    if Bc(Bc_index) == str2num(Bc_j)
        break
    end
    Bc_index = Bc_index + 1;
end

B = Bc_index * n; % End interval
A = B - n + 1;    % Begin interval
k = 1;

for i = A:B
    i_run = num2str(i,'%3.3i');
    if exist([pwd '/SwanRuns/' Bc_j '/Data/dam_' Bc_j '_RUN' i_run '.tab'], 'file') == 2
        dam = load([pwd '/SwanRuns/' Bc_j '/Data/dam_' Bc_j '_RUN' i_run '.tab']);
    end
    if exist([pwd '/SwanRuns/' Bc_j '/Runs/RUN' i_run '/dam_' Bc_j '_RUN' i_run '_var2.mat'], 'file') == 2
        load([pwd '/SwanRuns/' Bc_j '/Runs/RUN' i_run '/dam_' Bc_j '_RUN' i_run '_var2.mat']);
    end
    %Reflection:
    tan_alpha = Alpha; % Definition
    xi = tan_alpha / sqrt(Hi/L0);
    a = 1;
    b = 5.5;
    Kr_0 = a * xi^2 / (b + xi^2);
    Kr_1 = a * tanh(0.1*xi^2);
    Kr = min(Kr_0,Kr_1);
    
    %Incident:
    hs = dam(:,4);     
    Hs_i(1, k) = hs(uint16(xb(Bc_index,2)*length(hs)/xlen)-1);
    %Hs_i(1, k) = Hs_i(1, k) / (Kr + 1);
    Hs_t(1, k) = hs(uint16(xb(Bc_index,5)*length(hs)/xlen)+1);
    
    %Transmission:
    Kt_Bc(1, k) = Hs_t(1, k) / Hs_i(1, k);
    
    %Wave period:
    T = dam(:,7);
    Ti = T(uint16(xb(Bc_index,2)*length(T)/xlen)-1);
    Tt = T(uint16(xb(Bc_index,5)*length(T)/xlen)+1);
    Kt_T(1, k) = Tt/Ti;
    k = k + 1;
end

%% Plots
%{
disp('Transmission coefficient (Kt_Bc): ');
disp(Kt_Bc);

% Plot irun v.s. Kt_Bc
%close
subplot(2,1,1)
irun_number = 1:(irun-1)/length(Bc);
plot(irun_number, Kt_Bc, 'dr-')
grid on
%set(gca,'ylim',[-0.01 0.5])
ylabel('Kt_{Bc} (-)')
xlabel('irun'' (-)')
title(['Transmissie-coefficienten voor Bc = ' Bc_j 'm'])

subplot(2,1,2)
plot(Hs_i, Hs_t, 'b--*')
grid on
%set(gca,'ylim',[0 5])
%set(gca,'xlim',[0 5])
ylabel('hs_t (m)')
xlabel('hs_i (m)')
title('Golfhoogtes')
%}

end

