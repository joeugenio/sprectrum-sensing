function [] = tom( f )
%TOM Sinal sonoro de um tom puro
%   tom (f) Gera um sinal sonoro de um tom puro na frequência especificada
%   por f.
%
%   Ex: tom(1000) Gera um tom de 1kHz
%
%   See also beep, sound.
%
%   @Author: Joel E. Cordeiro Jr
%   @Version: 1.0

%% ------------------------------------------------------------------------

t=(0:10000)/8192;
y=sin(2*pi*f*t);
sound(y,8192);

end

