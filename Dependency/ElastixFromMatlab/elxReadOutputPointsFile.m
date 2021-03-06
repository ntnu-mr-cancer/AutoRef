%% elxReadOutputPointsFile
%
% Convert point file written by transformix into a MATLAB structure.
%
%% Syntax
%
% |[Pts, Success, Message] = elxReadOutputpointsFile(Filename)|
%
%% Input arguments
%
% * |Filename| (character array): Points file written by transformix
%
%% Output arguments
%
% * |Pts| (structure): the points.  It has three fields: |Input| and
% |Output| are <StrPointSet_help.html StrPointSet> structures and 
% |Deformation| is an numeric array.
% * |Success| (boolean): True if ok.
% * |Message| (character array): Error message 
%
%% Description
%
% Convert point file written by transformix into a MATLAB structure.
%
%% See also 
%
% <elxTransformix.html |elxTransformix|>
%
%% License
%
% Copyright (C) CNRS and Riverside Research 
% Contributors: Alain CORON, Jonathan MAMOU (2010)
% 
% <alain.coron@upmc.fr>, <JMamou@riversideresearch.org>
% 
% This software is a computer program whose purpose is to 
% effectively register images within Matlab (http://www.mathworks.com) 
% with elastix (http://elastix.isi.uu.nl/), an open-source image-registration
% software.
%
% This software was supported in part by NIH Grant CA100183, the Riverside 
% Research Biomedical Engineering Research Fund, and CNRS.
%
% This software is governed by the CeCILL-B license under French law and
% abiding by the rules of distribution of free software.  You can  use, 
% modify and/ or redistribute the software under the terms of the CeCILL-B
% license as circulated by CEA, CNRS and INRIA at the following URL
% "http://www.cecill.info". 
%
% As a counterpart to the access to the source code and  rights to copy,
% modify and redistribute granted by the license, users are provided only
% with a limited warranty  and the software's author,  the holder of the
% economic rights,  and the successive licensors  have only  limited
% liability. 
%
% In this respect, the user's attention is drawn to the risks associated
% with loading,  using,  modifying and/or developing or reproducing the
% software by the user in light of its specific status of free software,
% that may mean  that it is complicated to manipulate,  and  that  also
% therefore means  that it is reserved for developers  and  experienced
% professionals having in-depth computer knowledge. Users are therefore
% encouraged to load and test the software's suitability as regards their
% requirements in conditions enabling the security of their systems and/or 
% data to be ensured and,  more generally, to use and operate it in the 
% same conditions as regards security. 
% 
% The fact that you are presently reading this means that you have had
% knowledge of the CeCILL-B license and that you accept its terms.
%
% $Id: elxReadOutputPointsFile.m 4 2012-05-25 20:09:12Z coron $
function [Pts, Success, Message] = elxReadOutputPointsFile(Filename)

RegexValue = '\[([^\]]+)\]\s*';
RegexLine = ['Point\s+(\d+)\s+' ...
  '; InputIndex = ' RegexValue, ...
  '; InputPoint = ' RegexValue, ...
  '; OutputIndexFixed = ' RegexValue, ...
  '; OutputPoint = ' RegexValue, ...
  '; Deformation = ' RegexValue];

Pts = struct();
[Fid, Message] = fopen(Filename, 'r');
if Fid == -1
  Success = false;
  return;
end

Line = fgetl(Fid);
NumLine = 1;
while ischar(Line)
  Res = regexp(Line, RegexLine, 'tokens', 'once');
  Pts.Input.Indices(NumLine,:) = sscanf(Res{2}, '%i').';
  Pts.Input.Points(NumLine,:) = sscanf(Res{3}, '%f').';
  Pts.Output.Indices(NumLine,:) = sscanf(Res{4}, '%i').';
  Pts.Output.Points(NumLine,:) = sscanf(Res{5}, '%f').';
  Pts.Deformation(NumLine,:) = sscanf(Res{6}, '%f').';

  Line = fgetl(Fid);
  NumLine = NumLine + 1;
end
fclose(Fid);
