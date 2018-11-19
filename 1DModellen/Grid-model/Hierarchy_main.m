function [] = Hierarchy_main()
% Run all hierarchy files from Main Hierarchy
load('var')
disp('Busy, just a few moments...')
for j=1:length(Bc)
    cd([pwd '/SwanRuns/' num2str(Bc(j))])
    if exist('Hierarchy.m', 'file') == 2
        rh = str2func('Hierarchy');
        rh();
    end
    cd('../..')
end
cd(pwd);
disp('Finshed!')

end

