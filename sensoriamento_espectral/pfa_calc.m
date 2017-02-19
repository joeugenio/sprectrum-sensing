function [ pfa ] = pfa_calc( m,n,l,mc,met,Pn_dB )
%PFA_CALC P(fa) pelo método de Monte Carlo.
%   PFA = pfa_calc(m,n,l,mc,met,Pn_dB) Calcula a probabilidade falso alarme
%   (FA) pelo método de Monte Carlo, onde m e n são respectivamente,
%   o número de linhas e colunas da matriz de ruído N. Onde m é a 
%   quantidade de RCs e n o número de amostras coletadas. A variável l é um
%   vetor com uma faixa de valores para o limiar, mc é o número de eventos 
%   de Monte Carlo, met é o método de detecção utilizado (ED, RLRT, ERD,
%   GLRT), e Pn_dB é a potência do ruído em decibeis. Essa função retorna 
%   um vetor com o valor de Pfa para cada valor do vetor limiar.
%
%
%   @Author: Joel E. Cordeiro Jr
%   @Version: 1.0

%--------------------------------------------------------------------------

% tamanho do vetor de limiar L
l_size = size(l,2);
% vetor Pfa
pfa = zeros(1,l_size);

for i=1:l_size
    
    % número eventos Pfa
    num_pfa = 0;
    
    for k = 1:mc
        
        % gera matriz de ruído AWGN
        % com potência de 1Watts (0 dB) e impedância de 1 Ohm
        N = noise_wgn(m,n,Pn_dB);
        
        % calcula matriz de recepção Y
        Y = N;
        
        % calcula variável de descisão: máximo autovalor dividido pela
        % potência do ruído (1W), variância = 1.
        T = threshold(Y,met,m,Pn_dB);
        
        % decide se FA ocorreu
        if(T > l(i))
            num_pfa = num_pfa + 1;
        end
        
    end
    
    % armazena o valor Pfa para o limiar i
    pfa(i) = num_pfa/mc;
end

end

