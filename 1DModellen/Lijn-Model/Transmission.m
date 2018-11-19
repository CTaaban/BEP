
%clear all; clc; close;
cd('..');
load('Grid-model/var');
cd([pwd '/Lijn-model']);


Kt_Lijn = zeros(length(Bc), ((irun-1)/length(Bc)));
Ht_Lijn = zeros(length(Bc), ((irun-1)/length(Bc)));

restrictions = true;

for m=1:length(alpha)
    for i=1:length(Bc)
        index = 1;
            for j = 1:length(hs)
                for k =1:length(tp)
                    for l = 1:length(level)
                        h = d0 + level(l);
                        g = 9.81;    
                        L0 = (g / (2 * pi)) * (tp(k)^2);
                        for z=1:20
                            K = 2 * pi / L0;
                            L0 = L0 * tanh(K * d0);
                        end
                        Rc = d + level(l);
                        s = hs(j)/L0;
                        Bc_L0 = Bc(i)/L0;
                        if restrictions
                            check = (s < 0.6 && hs(j)/h < 0.54 && Rc/hs(j) < 2.5 && Rc/hs(j) > -2.5 && s > 0.002);
                        else 
                            check = 1;
                        end
                        if check
                            a = DAngremond( Bc(i), hs(j), tp(k), level(l), alpha(m) );
                            Kt_Lijn(i, index) = a;
                            index = index + 1;
                        end
                    end
                end
            end
    end
end

cd('..');
save('Grid-model/var', 'Kt_Lijn', '-append');
cd([pwd '/Lijn-model']);

%Transmissiecoefficient 
Kt_Lijn;

% Plots
Plot()


