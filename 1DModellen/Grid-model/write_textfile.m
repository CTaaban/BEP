function write_textfile(fname,tfile,itype)
%
% script to write a cell array to a text file
%
% write_textfile(fname,tfile[,itype])
%
% fname      Name of output file
% tfile      Name of text cell array
% itype = 1  Write in same order
%         2  Write file in reverse order
%         11 Write in same order with row number
%         12 Write in reverse order with row number
%
% Gerbrant van Vledder
% Van Vledder Consulting
%
% Initial version: 25 February 2008
%
% Update history
%   3 Nov 2009   Type of output added
%  15 Dec 2014   Option 11 added
%  03 Sep 2015   Conversion from cell array to textile with char
%                in view of Matlab R2015
%  12 Feb 2016   Write statement extended with /r to enable
%                Notepad Windows line breaks
%
if nargin==2
  itype = 1;
end
%
cfname = char(fname);
%
fid   = fopen(cfname,'w');
ncell = length(tfile);
ic1   = 1;
ic2   = ncell;
ics   = 1;
%
if itype==2 || itype==12
  ic1 = ncell;
  ic2 = 1;
  ics = -1;
end
%
irow = 0;
for icell=ic1:ics:ic2
  irow = irow+1;  
  if itype<10  
    textline = tfile{icell};
  else
    textline = [num2str(irow,'%5i') '  '  tfile{icell}];
  end
  fprintf(fid,'%s\\n',char(textline));
end
%
fclose(fid);
