function [ T ] = threshold( Y, met, m, Pn_dB)
%THRESHOLD Gerador de limiar de decisão espectral.
%   T = threshold( Y,met,m,Pn_dB) Gera o limiar de decisão a partir da
%   matriz Y e do método de detecção informado em met (ED, RLRT, ERD, GLRT).
%   m é o número de receptores (RC), Pn é a potência do ruído.
%
%   @Author: Joel E. Cordeiro Jr
%   @Version: 1.1

%% ------------------------------------------------------------------------

% convete potência em dB para Watts.
Pn = 10^(Pn_dB/10);
% calcula matriz de covariância amostral
R = sample_cov(Y);
% calcula os autovalores da matriz de covariância
autovalor = eig(R);

% escolhe a técnica de detecção especificada
switch met
    case 'ED'
        % método ED por autovalor
        % calcula a variável de descisão.
        T = (sum(autovalor)/(m*Pn));
        
    case 'RLRT'
        % método RLRT ou MED
        % calcula a variável de descisão.
        T = abs(max(autovalor)/Pn);
        
    case 'ERD'
        % método ERD ou MMED
        % calcula a variável de descisão.
        T = max(autovalor)/min(autovalor);
        
    case 'GLRT'
        % método GLRT
        % calcula a variável de descisão.
        % método 1 
           T = max(autovalor)/(sum(autovalor)/m);
        % método 2   
        %   T = max(autovalor)/((sum(autovalor)-max(autovalor))/(m-1));
end

end

