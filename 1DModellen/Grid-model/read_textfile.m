function textfile =read_textfile(fname,ncell)
%
% textfile =read_textfile(fname[,ncell])
%
% script to read a text file in cell array
% fname  i   name of ASCII file
% n      i   Optional argument to initialize cell array
%
% Gerbrant van Vledder
%
% update history
%  25/02/2008  Initial version 
%  12/04/2013  Bug fixed when input consists of 1 line
%  09/10/2014  Optional input argument ncell added for pre-allocation
%
fid = fopen(fname);
if fid<0
  textfile = [];
  disp(['Requested file not found: ' fname])
  return
end
if nargin==1
  t = fgetl(fid);
  textfile{1} = t;
%
% read remaining lines by incrementally adding lines
%
  iend= feof(fid);
  while iend==0
    t = fgetl(fid);
    if iend==0
      textfile = [textfile cellstr(t)];
    end  
    iend= feof(fid);
  end
%  
elseif nargin==2
  disp('Initializing cell array')
  textfile = cell(ncell,1);
  t = fgetl(fid);
  k = 1;
  textfile{k} = t;
  iend        = feof(fid);
  h=waitbar(0,'Reading text file ...');
%  
  while iend==0 && k < (ncell)
    t = fgetl(fid);
    if iend==0
      k = k+1;
      textfile{k} = t;
    end
    waitbar(k/ncell,h);
    iend = feof(fid);
  end
  if k>=ncell
    disp('ERROR in READ_TEXTFILE, ncell < number of lines')  
  end
  close(h);
  if k<ncell
    disp('Resizing cell array') 
    textfile = textfile(1:k);
  end    
end  
%

%
fclose(fid);