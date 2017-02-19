function [N] = noise_wgn( m,n,Pn_dB)
%NOISE_WGN Gerador de ruído (Noise Generator - WGN).
%   N = noise_wgn(m,n,Pn_dB) Retorna uma matriz m por n com ruído gaussiano
%   branco (WGN) complexo. m é o número de receptores (RC), n é o número
%   de amostras e Pn_dB é a potência desejada do ruído em decibéis.
%
%   See also awgn, wgn.
%
%   @Author: Joel E. Cordeiro Jr
%   @Version: 1.0

%% ------------------------------------------------------------------------
    
% convete potência em dB para Watts.
    Pn = 10^(Pn_dB/10);
    
% Não utitilizar os dois métodos simultâneamentes
% Deixe sempre um dos métodos comentados
    
%% --------------------------- MÉTODO 1 -----------------------------------
% preenche vetor com uma distribuição normal aleatória
    N = (sqrt(Pn/2))*(randn(m,n)+1i*randn(m,n));
    
%% --------------------------- MÉTODO 2 -----------------------------------
% preenche vetor com uma distribuição normal aleatória
    %for i= 1:n
    %    N(:,i) = (sqrt(Pn/2))*(randn(m,1)+1i*randn(m,1));
    %end
end
