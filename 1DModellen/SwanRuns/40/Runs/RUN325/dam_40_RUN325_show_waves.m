%Show waves Script:
% Loading irun number:

currentDirectory = pwd;
[upperPath, deepestFolder, ~] = fileparts(currentDirectory);
i_run = deepestFolder;
cd(currentDirectory);

cd('..\..')
currentDirectory = pwd;
[upperPath, deepestFolder, ~] = fileparts(currentDirectory);
Bc_j = deepestFolder;
cd(currentDirectory);

% Load dam:
dam = load(['Runs\' i_run '\dam_' Bc_j '_' i_run '.tab']);

cd('..\..')
load('var')

for Bc_index = 1:length(Bc)
    if Bc(Bc_index) == str2num(Bc_j)
        break
    end
    Bc_index = Bc_index + 1;
end

Bc_1 = Bc(Bc_index);

xp    = dam(:,1);           % x-coordinates [m]
xp2 = linspace(0,xlen,length(xp));
dep   = dam(:,3);           % waterdepth [m]
hs    = dam(:,4);           % Wave height [m]
Tm01  = dam(:,7);           % Wave period [s]

% Energy dissipation:
S_diss_tot = dam(:,12);     % Total energy Dissipation: S_diss
S_surf     = dam(:,13);     % (SURF-)BREAKING; Dissipation rate (surf-)breaking: S_surf
S_bfr      = dam(:,14);     % BOTTOMFRICTION;  Dissipation rate bottom wriction: S_bfr
S_wcap     = dam(:,15);     % WAVECAPPING

% Energy generation:
S_gen_tot = dam(:,19);      % Total energy generation
S_wind    = dam(:,20);      % WIND

% Energy redistrubution:
S_redis_tot = dam(:,16);    % Total energy redistrubuted
S_nl3       = dam(:,17);    % TRIAD: non-linear wave-wave interaction 
S_nl4       = dam(:,18);    % QUADRUPLET: non-linear wave-wave interaction 

% Cumulative Energy Dissipation Magnitudes
S_diss_tot_cum = cumsum(S_diss_tot); 
S_surf_cum     = cumsum(S_surf); 
S_bfr_cum      = cumsum(S_bfr); 
S_wcap_cum     = cumsum(S_wcap);

% Cumulative Energy Generation Magnitudes
S_gen_tot_cum = cumsum(S_gen_tot); 
S_wind_cum  = cumsum(S_wind); 

% Cumulative Energy Redistibution Magnitudes
S_redis_tot_cum = cumsum(S_redis_tot); 
S_nl3_cum     = cumsum(S_nl3); 
S_nl4_cum     = cumsum(S_nl4);

% transmission coefficient:
% Kt_0 = H_BeginConstructie/H_EindConstructie:
Hs_i = hs(uint16(xb(Bc_index,2)*length(hs)/xlen));
Hs_t = hs(uint16(xb(Bc_index,5)*length(hs)/xlen));
Kt_0 = Hs_t / Hs_i; 
disp('Transmission coefficient (Kt_0): ');
disp(Kt_0);
Ti = Tm01(uint16(xb(Bc_index,2)*length(Tm01)/xlen)-1);
Tt = Tm01(uint16(xb(Bc_index,5)*length(Tm01)/xlen)+1);
Kt_T = Tt/Ti;


% Plots
% Plot dam [m]
%close
subplot(3,2,1)
plot(xp2,-dep,'k.')
grid on
ylabel('d (m)')
title(['Dam: Bc=' num2str(Bc_1) 'm, ' i_run ]);


%set(gca,'ylim',[depmin 0])

% Plot wave height [m]
subplot(3,2,3)
plot(xp2,hs,'b-')
ylabel('hs (m)')
grid on
title(['Golfhoogte: Kt=' num2str(Kt_0)]);

% Plot wave period [s]
subplot(3,2,5)
plot(xp2,Tm01,'b-')
ylabel('Tm01 (s)')
grid on
title(['Golfperiode: Kt_t=' num2str(Kt_T)]);

% Plot 'wave energy dissipation' [m^2/s]
subplot(3,2,2)
plot(xp2, S_diss_tot, 'k-', xp2, S_surf, 'm-', xp2, S_bfr, 'r-', xp2, S_wcap, 'g')
legend('S_{diss;tot}','S_{surf}', 'S_{bfr}', 'S_{wcap}', 'Location', 'Best')
grid on
%set(gca,'ylim',[-0.001 0.1])
ylabel('S (m^2/s)')
title('Maat voor Energiedissipatie')

% Plot Cumulative 'wave energy dissipation'  [m^2/s]
subplot(3,2,4)
plot(xp2, S_diss_tot_cum, 'k', xp2, S_surf_cum, 'm-', xp2, S_bfr_cum,'r-', xp2, S_wcap_cum,'g')
legend('S_{diss;tot}','S_{surf}', 'S_{bfr}', 'S_{wcap}', 'Location', 'Best')
grid on
%set(gca,'ylim',[-0.01 0.5])
ylabel('S (m^2/s)')
xlabel('x (m)')
title('Maat voor Cumulatieve Energiedissipatie')

%{
% Plot 'wave energy generation' [m^2/s]
subplot(4,2,2)
plot(xp2, S_gen_tot, 'k-', xp2, S_wind, 'm-')
legend('S_{gen;tot}','S_{wind}', 'Location', 'Best')
grid on
%set(gca,'ylim',[-0.001 0.1])
ylabel('S (m^2/s)')
title('Energie Toevoer')

% Plot Cumulative 'wave energy dissipation'  [m^2/s]
subplot(4,2,4)
plot(xp2, S_gen_tot_cum, 'k-', xp2, S_wind_cum, 'm-')
legend('S_{gen;tot}','S_{wind}', 'Location', 'Best')
grid on
%set(gca,'ylim',[-0.01 0.5])
ylabel('S (m^2/s)')
title('Cumulatieve Energie Toevoer')

% Plot 'wave energy redistrubution' [m^2/s]
subplot(4,2,6)
plot(xp2, S_redis_tot, 'k-', xp2, S_nl3, 'm-', xp2, S_nl4, 'r-')
legend('S_{redis;tot}','S_{nl3}', 'S_{nl4}' ,'Location', 'Best')
grid on
%set(gca,'ylim',[-0.001 0.1])
ylabel('S (m^2/s)')
title('Energie Redistrubutie')

% Plot Cumulative 'wave energy dissipation'  [m^2/s]
subplot(4,2,8)
plot(xp2, S_redis_tot_cum, 'k-', xp2, S_nl3_cum, 'm-', xp2, S_nl4_cum, 'r-')
legend('S_{redis;tot}','S_{nl3}', 'S_{nl4}' ,'Location', 'Best')
grid on
%set(gca,'ylim',[-0.01 0.5])
ylabel('S (m^2/s)')
xlabel('x (m)')
title('Cumulatieve Energie Redistrubutie')
%}


