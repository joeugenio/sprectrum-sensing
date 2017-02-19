function [ X ] = signal_gen( p,n,Ps_dB )
%SIGNAL_GEN Gerador da matriz de sinal com distribuição normal.
%   X = signal_gen(p,n,Ps_dB) Gera uma matriz X de amostras aleatórias de 
%   sinal com uma distribuição gaussiana. Essa distribuição modela vários
%   sinais utilizados na prática, como sinais OFDM.
%   A vairável p representa o número de transmissores primários, n é o
%   número de amostras e Ps_dB a potência desejada do sinal em decibéis.
%
%   See also signal, noise_wgn.
%
%   @Author: Joel E. Cordeiro Jr
%   @Version: 1.0

%% ------------------------------------------------------------------------

% convete potência em dB para Watts.
Ps = 10^(Ps_dB/10);
% sinal gaussiano
    X = (sqrt(Ps/2))*(randn(p,n)+1i*randn(p,n));
end

