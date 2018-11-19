function [] = Hierarchy()
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

currentDirectory = pwd;
[upperPath, deepestFolder, ~] = fileparts(currentDirectory);
load('../../var', 'irun0', 'irun');
%cd(currentDirectory);

%% Copy Data.tab to Data directory:
%Copy Data.tab files to /Data
if copyfile('*.tab', 'Data');
end

% Move files related to one run to /Runs/RUNNUM
for i=irun0:(irun-1)
    crun = ['RUN' num2str(i,'%3.3i')];
    if movefile([['dam_' deepestFolder] '_' crun '*'], ['Runs/' crun])
    end
end

% move servicescript files to /ServiceScripts
if movefile(['dam_' deepestFolder '*'], 'ServiceScripts/')
end
if  movefile('Hierarchy.m', 'ServiceScripts/')
end
if movefile('TransmissieCoefficient.m', 'ServiceScripts/')
end

% move other files to /Other
if movefile('input*', 'Other/')
   movefile('norm_end*', 'Other/')
   movefile('PRINT*', 'Other/')
   movefile('swaninit*', 'Other/')
end

%cd('../..')

%{
%%
% Organize hierarchy of Main directory
movefile(['dam_' num2str(Bc) '.*'], ['SwanRuns/' num2str(Bc)]);
movefile('dam_RUN*', 'SwanRuns')  
%% Copy Data.tab to Data directory:
disp('Busy, just a few moments...')
copyfile('*.tab', 'Data');
for i=irun0:(irun-1)/(Bc_i-1)
    crun = ['RUN' num2str(i,'%3.3i')];
    cfname = char(crun);
    copyfile([['dam_' num2str(Bc)] '_' crun '*'], ['SwanRuns/' num2str(Bc) '/' crun]); 
end

%{
%%
% Organize hierarchy of Main directory
movefile(['dam_' num2str(Bc) '.*'], ['SwanRuns/' num2str(Bc)]);
movefile('dam_RUN*', 'SwanRuns')  

%Pause; so that files are replaced
%Pause(5);


%%
% Organize hierarchy of directory: SwanRuns

currentDirectory = pwd;
cd([currentDirectory '/SwanRuns']);

for j=irun0:irun-1
    crun = ['RUN' num2str(j,'%3.3i')];
    cfname = char(crun);
    movefile(['dam_' crun '*'], ['dam_' crun]); 
end
disp('Finished!')
%}

%Pause; so that files are replaced
%Pause(5);


%%
% Organize hierarchy of directory: SwanRuns

currentDirectory = pwd;
cd([currentDirectory '/SwanRuns']);

for j=irun0:irun-1
    crun = ['RUN' num2str(j,'%3.3i')];
    cfname = char(crun);
    movefile(['dam_' crun '*'], ['dam_' crun]); 
end
disp('Finished!')
%}

end

