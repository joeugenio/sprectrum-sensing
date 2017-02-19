function  [ H ] = channel_rayleigh( m,p )
%CHANNEL_RAYLEIGH Gerador de canal com distribuição Rayleigh
%   H = channel_rayleigh(m,p) Gera um canal de comunicação com distribuição
%   Rayleigh. m é o número de rádios congnitivos e p o número de
%   transmissores primários. H é uma matriz m por p.
%
%   See also RAYLEIGHCHAN.
%
%   @Author: Joel E. Cordeiro Jr
%   @Version: 1.0

%% ------------------------------------------------------------------------

    H = (sqrt(1./2))*(randn(m,p)+1i*randn(m,p));

%% descomentar linha para normalizar
% PH = (1/(m*p))*sum(diag(H'*H));
% H = H/sqrt(PH);

end