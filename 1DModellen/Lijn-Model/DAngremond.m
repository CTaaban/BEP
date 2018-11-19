function [Kt] = DAngremond(B_c, Hs, Tp, lvl, tan_alpha)
%%% calculates transmission coefficient 
cd('..');
load('Grid-model\var');
cd([pwd '\Lijn-model']);

%%%%%%%%%%%%%%%Parameters%%%%%%%%%%%%%%%
% Hs = Significant wave height [m]
% Rc = crest Freeboard [m]; negative if submerged case!
% Bc = crest width [m]
% Tp = mean wave period [s]
% alpha = construction slope angle [rad]
% tan_aplha = construction slope [-]
% L0 = deepwater wave length [m]
% xi = breaker/Ibarren parameter [-]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

g = 9.81;
%tan_alpha = tan(alpha);
L0 = (g / (2 * pi)) * (Tp^2);

if (d0/L0 < 1/2 && d0/L0 > 1/20)
    for z=1:20
        K = 2 * pi / L0;
        L0 = L0 * tanh(K * d0);
    end
end
Rc = d + lvl;
xi = tan_alpha / sqrt(Hs/L0);


%D'angremond1996: impermeable structures & 0.075 < Kt < 0.8:
Kt = (-0.4 * (-Rc / Hs) + power((B_c / Hs),-0.31) * (1 - exp(-0.5*xi)) * 0.80);

Kt_max = 0.8;
if Kt < 0.075
    Kt = 0.07;
elseif Kt > Kt_max
   Kt = Kt_max;
end


%vanderMeer2005: impermeable structures, xi < 3 & -0.075 < Kt < 0.8:
%Kt = -0.30 * (Rc / Hs) + 0.75 * (1 - exp(-0.5*xi));

%H = Hs * Kt;

end


    