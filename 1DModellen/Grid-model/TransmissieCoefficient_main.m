% All Transmission Coefficients:

%Run hierarchy script:
%hr = str2func('Dummy/Hierarchy_main');
%hr();
Hierarchy_main();

cd(pwd)
disp('Busy, just a few moments...');
load('var')
Kt_Grid = zeros(length(Bc), ceil((irun-1)/length(Bc)));
Kt_T = zeros(length(Bc), ceil((irun-1)/length(Bc)));


for j=1:length(Bc)
    cd([pwd '/SwanRuns/' num2str(Bc(j)) '/ServiceScripts'])
    tc = str2func('TransmissieCoefficient');
    [temp1, temp2] = tc();
    Kt_Grid(j,:) = temp1;
    Kt_T(j,:) = temp2;
end
save('var', 'Kt_Grid', '-append')
disp('Done!');
Plot()
Kt_T;
Kt_max = max(max(Kt_Grid));
disp(['Kt_max = ' num2str(Kt_max)]);
