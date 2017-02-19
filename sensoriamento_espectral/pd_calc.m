function [ pd ] = pd_calc( p,m,n,l,mc,met,Pn_dB,SNR )
%PD_CALC P(d) pelo método de Monte Carlo.
%   PD = pd_calc(p,m,n,l,mc,met,Pn_dB,SNR) Calcula a probabilidade de
%   detecção (PD) pelo método de Monte Carlo, onde p é o número de
%   transmissores primários, m é o numero de receptores RC e n o número de
%   amostras coletadas. A variável l é um vetor com uma faixa de valores
%   para o limiar, mc é o número de eventos de Monte Carlo, met é o método 
%   de detecção utilizado (ED, RLRT, ERD, GLRT), Pn_dB é a potência do
%   ruído em decibeis, e SNR é a relação sinal ruído.
%   Retorna um vetor com o valor de Pfa para cada valor do vetor limiar.
%
%   @Author: Joel E. Cordeiro Jr
%   @Version: 1.0

%--------------------------------------------------------------------------

% tamanho do vetor de limiar L
l_size = size(l,2);
% vetor Pfa
pd = zeros(1,l_size);

for i=1:l_size
    
    % número de eventos Pfa e numero de eventos total
    num_pd = 0;
    
    for k = 1:mc
        
        % calcula a potência do sinal a partir do SNR
        Ps_dB = SNR + Pn_dB;
        
        % gera matriz de ruído AWGN
        % com potência de 1 Watts (0 dB) e impedância de 1 Ohm
        N = noise_wgn(m,n,Pn_dB);
        
        % gera canal Rayleigh
        H = channel_rayleigh(m,p);
        
        % gera matriz de sinal de transmissão
        X = signal_gen(p,n,Ps_dB);
        
        % calcula matriz de recepção Y
        Y = H*X + N;
        
        % calcula variável de descisão: máximo autovalor dividido pela
        % potência do ruído (1W), variância = 1.
        T = threshold(Y,met,m,Pn_dB);
        
        % decide se PD ocorreu
        if(T > l(i))
            num_pd = num_pd + 1;
        end
     
    end
    
    % armazena o valor Pfa para o limiar i
    pd(i) = num_pd/mc;
end

end
