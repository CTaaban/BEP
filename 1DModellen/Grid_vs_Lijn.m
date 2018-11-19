% Plot Kt_Grid v.s. Kt_Lijn
load('Grid-model/var');

% Set bc = true for sorting on Bc, bc = false -> sort on Bc/Hs
bc = false;%true 

% Plot intervals for legend
if bc
    a = Bc; % Bc as interval
else
    a = [10, 20, 40, 80];
    %a = [5, 8, 10, 20];
    %a = [12, 25, 50, 80];
    %a = [2, 5, 10, 20];
    %a = [20, 40, 60, 80];
end

N = irun-1;
n = N /length(Bc);

Bc_rel = zeros(length(Bc),n);

if bc
    range = ones(length(hs)); % Bc as interval
else
    range = hs;
end

for m=1:length(alpha)
    for i=1:length(Bc)
        index = 1;
        for j = 1:length(hs)
            for k =1:length(tp)
                for l = 1:length(level)
                    Bc_rel(i, index)= Bc(i)/range(j);
                    index = index + 1;
                end
            end
        end
    end
end


%store kt per plot interval
Kt_Grid_range = zeros(length(a)+1,N);
Kt_Lijn_range = zeros(length(a)+1,N);

%Plots
% Line specifications
%{
spec1 = 'pr-';
spec2 = 'xg-';
spec3 = 'ob-';
spec4 = 'dm-';
spec5 = '+k-';
%}
%{
spec1 = 'pk'; 
spec2 = 'pb';
spec3 = 'pc';
spec4 = 'pg';
spec5 = 'pm';
%}
spec1 = '.k'; 
spec2 = '.b';
spec3 = '.c';
spec4 = '.g';
spec5 = '.m';
linewidth=20;
markersize=20;
thinDown = 1;
tot = 0;
check = false;
a1 = 0; a2 =0; a3 =0; a4 =0; a5 =0; 
figure();
for i=1:length(Bc)
    check = false;
    for j=1:n
        if rand < thinDown
            for z5=1:1
                if bc
                    check = (Bc_rel(i, j) == a(5)); %Bc as range
                else
                    check = (Bc_rel(i, j) >= a(4));
                end
                if check
                        p5 = plot(Kt_Lijn(i,j), Kt_Grid(i,j), spec5, 'linewidth', linewidth,'markersize',markersize);
                        hold on;
                        Kt_Grid_range(5,j) = Kt_Grid(i,j);
                        Kt_Lijn_range(5,j) = Kt_Lijn(i,j);
                        a5 = a5 + 1;
                        tot = tot + 1;
                        check = false;
                end
            end

            for z4=1:1
                if bc
                    check = (Bc_rel(i, j) == a(4)); %Bc as range
                else
                    check = (Bc_rel(i, j) < a(4) && Bc_rel(i, j)>= a(3));
                end
                if check
                        p4 = plot(Kt_Lijn(i,j), Kt_Grid(i,j), spec4, 'linewidth', linewidth,'markersize',markersize);
                        hold on;
                        Kt_Grid_range(4,j) = Kt_Grid(i,j);
                        Kt_Lijn_range(4,j) = Kt_Lijn(i,j);
                        a4 = a4 + 1;
                        tot = tot + 1;
                        check = false;
                end
            end

            for z3=1:1
                if bc
                    check = (Bc_rel(i, j) == a(3)); %Bc as range
                else
                    check = (Bc_rel(i, j) < a(3) && Bc_rel(i, j) >= a(2));
                end
                if check
                        p3 = plot(Kt_Lijn(i,j),  Kt_Grid(i,j), spec3, 'linewidth', linewidth,'markersize',markersize);
                        hold on;
                        Kt_Grid_range(3,j) = Kt_Grid(i,j);
                        Kt_Lijn_range(3,j) = Kt_Lijn(i,j);
                        a3 = a3 + 1;
                        tot = tot + 1;
                        check = false;
                end
            end

            for z2=1:1
                if bc
                    check = (Bc_rel(i, j) == a(2)); %Bc as range
                else
                    check = (Bc_rel(i, j) < a(2) && Bc_rel(i, j) >= a(1));
                end
                if check
                        p2 = plot(Kt_Lijn(i,j),  Kt_Grid(i,j), spec2, 'linewidth', linewidth,'markersize',markersize);
                        hold on;
                        Kt_Grid_range(2,j) = Kt_Grid(i,j);
                        Kt_Lijn_range(2,j) = Kt_Lijn(i,j);
                        a2 = a2 + 1;
                        tot = tot + 1;
                        check = false;
                end
            end

            for z1=1:1
                if bc
                    check = (Bc_rel(i, j) == a(1)); %Bc as range
                else
                    check = (Bc_rel(i, j) < a(1));
                end
                if check
                        p1 = plot(Kt_Lijn(i,j),  Kt_Grid(i,j), spec1, 'linewidth', linewidth,'markersize',markersize);
                        hold on;
                        Kt_Grid_range(1,j) = Kt_Grid(i,j);
                        Kt_Lijn_range(1,j) = Kt_Lijn(i,j);
                        a1 = a1 + 1;
                        tot = tot + 1;
                        check = false;
                end
            end
        end
    end
end

%disp(['Total plotted (should be 700): ' num2str(tot)]);
Kt_max = max(max(max(Kt_Grid)), max(max(Kt_Lijn)));
x = linspace(0,2,2);
grid on;
ylabel('Kt_{Grid} (-)')
xlabel('Kt_{Lijn} (-)');
p6 = plot(x, x, 'r-', 'linewidth', 3);hold on;
title('Kt_{Grid} v.s. Kt_{Lijn}')
set(gca,'fontsize',14)

legendInfo = {};
if bc
    for i=1:length(Bc)
          legendInfo{i} =['Bc = ' num2str(Bc(i)) 'm'];
    end
else
    legendInfo{1} = ['          Bc/Hs < ' num2str(a(1))];
    for i=2:length(a)
          legendInfo{i} =[num2str(a(i-1)) ' <= Bc/Hs < ' num2str(a(i))];
    end
    i = i + 1;
    legendInfo{i} = [num2str(a(length(a))) ' <= Bc/Hs' ];
end
legendInfo{length(legendInfo)+1} = 'Kt_{Grid} = Kt_{Lijn}';

legend([p1,p2,p3,p4,p5,p6], legendInfo, 'Location', 'best');
hold off;
set(gca,'ylim',[0, max(max(Kt_Grid))+0.1])
set(gca,'xlim',[0, max(max(Kt_Grid))+0.1])


%MSE:
rmse_total = power(immse(Kt_Grid,Kt_Lijn),0.5);
disp(['Total Root Mean-Squared Error: ' num2str(rmse_total)])

if bc
    rmse = zeros(length(Bc),1);
    for i=1:length(rmse)
        index = 0;
        for j=1:N
            if (Kt_Grid_range(i,j) ~=0)
                rmse(i) = rmse(i)+ (Kt_Grid_range(i,j)-Kt_Lijn_range(i,j))^2;
                index = index + 1;
                %mse(i) = immse(Kt_Grid_range(i,:),(Kt_Lijn_range(i,:)));
            end
        end
        rmse(i) = power(rmse(i)/index,0.5);
    end
else
    rmse = zeros(length(a)+1,2);
    for i=1:length(a)+1
        index = 0;
        for j=1:N
            if (Kt_Grid_range(i,j) ~=0)
                rmse(i) = rmse(i)+ (Kt_Grid_range(i,j)-Kt_Lijn_range(i,j))^2;
                index = index + 1;
                %mse(i) = immse(Kt_Grid_range(i,:),(Kt_Lijn_range(i,:)));
            end
        end
        rmse(i,1) = power(rmse(i)/index,0.5);
        rmse(i,2) = eval(['a' num2str(i)]);
      
    end
end


disp('Root Mean-Squared Error per range: ');
num2str(rmse)

%scatter(Kt_Grid(1,:),Kt_Lijn(1,:))
