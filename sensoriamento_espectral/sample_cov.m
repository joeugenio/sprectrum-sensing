function R = sample_cov( Y )
%SAMPLE_COV Matriz de covariancia por media amostral (Sample Covariance 
%   Matrix).
%   R = sample_cov(Y) Calcula a matriz de covariancia por media amostral
%   dada uma matriz Y com n elementos, pela seguinte expressão:
%
%                   R = E(YY') = (1/n)(Y*Y'),
%
%   onde cada um dos n elementos é um vetor coluna de m posições, e o 
%   operador E() representa a expectativa estatística (esperança).
%   
%   See also COV.
%
%   @Author: Joel E. Cordeiro Jr
%   @Version: 1.0

%% ------------------------------------------------------------------------

    % número de colunas da matriz
    n = size(Y,2);
    % calcula a matriz de covariancia
    R = (1/n)*(Y*Y');
end
