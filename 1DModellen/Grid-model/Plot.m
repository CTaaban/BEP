% Plot irun v.s. Kt_Grid
%close
load('var');
legendInfo = {};
irun_number = 1:(irun-1)/length(Bc);

% For loop:
rows = 3;
columns = ceil((length(Bc)/rows));
%{
spec1 = 'pr-';
spec2 = 'xg-';
spec3 = 'ob-';
spec4 = 'dm-';
spec5 = '+k-';
%}
spec1 = '.r-';
spec2 = '.g-';
spec3 = '.b-';
spec4 = '.m-';
spec5 = '.k-';

%{
for i=1:length(Bc)
    subplot(rows,columns,i)
    % Line spec:
    if mod(i,4)==0
        spec = spec1;
    elseif mod(i,3)==0
        spec = spec2;
    elseif mod(i,2)==0
        spec = spec3;
    elseif mod(i,1)==0
        spec = spec4;
    end
       
    plot(irun_number, Kt_Grid(i,:), spec);hold on;
    grid on;
    xlabel('irun'' (-)')
    ylabel('Kt_Grid (-)');
    title(['Bc = ' num2str(Bc(i)) 'm']);
end
%}
figure();
for i=1:length(Bc)
    if mod(i,5)==0
        spec = spec1;
    elseif mod(i,4)==0
        spec = spec2;
    elseif mod(i,3)==0
        spec = spec3;
    elseif mod(i,2)==0
        spec = spec4;
    elseif mod(i,1)==0
        spec = spec5;
    end
    plot(irun_number, Kt_Grid(i,:), spec, 'linewidth', 0.2, 'markersize',20);hold on;
    grid on;
    xlabel('irun'' (-)')
    ylabel('Kt_{Grid} (-)');
    legendInfo{i} = ['Bc =' num2str(Bc(i)) 'm'];
end
legend(legendInfo);
title('1D Grid-model')
set(gca,'fontsize',14)

