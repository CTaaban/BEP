function t_output=mod_textfile(t_input,told,tnew,klines)
%
%  t_output=mod_textfile(t_input,str_old,str_new[,kline])
%
%  t_input   i    Cell array
%  t_old     i    String to be replace
%  t_new     i    New string to insert
%  klines    i    Specific line number range
%  t_output  o    Modified cell array
%
%  Gerbrant van Vledder
%  
%  25/02/2008   Created
%   1/05/2014   routine findstr replaced by strfind     
%  27/01/2015   Option klines added (Optional)
%
ncell = length(t_input);
icell1 = 1;
icell2 = ncell;
%
if nargin==4
  icell1 = min(klines);
  icell2 = max(klines);
  if icell2>ncell
    disp('Upper limit exceeds number of lines');
    pause(2)
    icell2 = ncell;
  end
end
%
t_output = t_input;
%
%for icell=1:ncell
for icell=icell1:icell2
%
  tline = t_input{icell};
  ifind = strfind(tline,told);
%   if nargin==4
%     ['>' tline '<']
%     ['>' told '<']
%     ['>' tnew '<']
%     ifind
%     pause(2)
%   end
  if isempty(ifind)==0
%     tline
%     told
%     tnew
%     whos tline told tnew
    tline_new = strrep(tline,told,tnew);
    t_output{icell} = tline_new;
  end
end