%==========================================================================
% Script principal - Simulação de Técnicas de Sensoriamento Espectral
% Cooperativas em Redes Cognitivas.
%
% Universidade Federal do Recôncavo da Bahia - UFRB
% Centro de Ciências Exatas e Tecnológicas - CETEC
% Bacharelado em Engenharia de Computação
%
% Projeto de Iniciação Científica (PIBIC/CNPq): Avaliação de Técnicas de
%   Sensoriamento Espectral Cooperativas em Rádios Cognitivos
%
% Autor: Joel Eugênio Cordeiro Junior
% Versão: 1.0 
%
% See also channel_rayleigh, noise_wgn, sample_cov, signal_gen, threshold,
% pfa_calc, pd_calc.

% 18/05/2014.
%==========================================================================
% fecha figuras abertas e limpa variáveis locais, limpa display
close all;
clear all;
clc;
%
%                  PARÂMETROS DO CENÁRIO DE SIMULAÇÃO
%
% p é o número de transmissores primários que utilizam o meio.
% m é o número de receptores (Rádios Cognitivos - RC) que escutam o meio.
% n número de amostras coletadas por cada receptor (RC).
% l,l_1,l_2,l_n são os vetores com valor para o limiar de decisão.
% mc número de eventos de Monte Carlo.
% SNR é a relação sinal ruído.
% Pn_dB é a potência do ruído em decibéis, por padrão definida como 0dB.
% =========================================================================
% -10 dB ------------------------------------------------------------------
% p = 1; m = 5; n = 50;
% l_1 = .8:.012:1.5; l_2 = 1:.056:2.8; l_3 = 1.5:.07:5; l_4 = 1:.03:2.5;
% =========================================================================
% -10 dB ------------------------------------------------------------------
% p = 1; m = 15; n = 50;
% l_1 = .8:.01:1.3; l_2 = 1.5:.07:5; l_3 = 5:.3:20; l_4 = 1.5:.05:4;
% =========================================================================
% -10 dB ------------------------------------------------------------------
% p = 1; m = 30; n = 50;
% l_1 = .9:.007:1.25; l_2 = 2:.12:8; l_3 = 20:2:120; l_4 = 2:.09:6.5;
% =========================================================================
% -10 dB ------------------------------------------------------------------
% p = 5; m = 5; n = 50;
% l_1 = .5:.03:2; l_2 = 0.5:.07:4; l_3 = 1:.12:7; l_4 = 1:.03:2.5;
% =========================================================================
% -10 dB ------------------------------------------------------------------
% p = 15; m = 5; n = 50;
% l_1 = .5:.06:3.5; l_2 = 0:.14:7; l_3 = 1:.12:7; l_4 = 1:.03:2.5;
% =========================================================================
% -10 dB ------------------------------------------------------------------
%  p = 1; m = 5; n = 100;
%  l_1 = .8:.014:1.5; l_2 = .8:.04:2.8; l_3 = 1:.06:4; l_4 = 1:.02:2;
% =========================================================================
% -10 dB ------------------------------------------------------------------
% p = 5; m = 15; n = 100;
% l_1 = .8:.02:1.8; l_2 = 1:.12:7; l_3 = 2:.24:14; l_4 = 1:.06:4;
% -20 dB ------------------------------------------------------------------
%p = 5; m = 15; n = 100;
%l_1 = .8:.02:1.8; l_2 = 1:.12:7; l_3 = 2:.24:14; l_4 = 1:.06:4;
% AJUSTAR OS LIMITES DO VETOR DE LIMIAR
% =========================================================================
% -10 dB ------------------------------------------------------------------
p = 15; m = 30; n = 100;
l_1 = .5:.05:3; l_2 = 0:.3:15; l_3 = 0:1:50; l_4 = 1.5:.08:5.5;
% -24 dB ------------------------------------------------------------------
% p = 15; m = 30; n = 100;
% l_1 = .9:.006:1.2; l_2 = 1.5:.03:3; l_3 = 7:.12:13; l_4 = 1.8:.018:2.7;
% =========================================================================

mc = 20000;
SNR = -10;
Pn_dB = 0;
%% ------------------------------------------------------------------------
% inicia time;
tic;
fprintf('Processando...\n');

%%              Hipótese H_0: Ausência de sinal transmitido
%              Calculo da probalidade de falso alarme (Pfa)

% calcula a probalidade de falso alarme para a técnica ED
PFA_ED = pfa_calc(m,n,l_1,mc,'ED',Pn_dB);
% calcula a probalidade de falso alarme para a técnica RLRT
PFA_RLRT = pfa_calc(m,n,l_2,mc,'RLRT',Pn_dB);
% calcula a probalidade de falso alarme para a técnica ERD
PFA_ERD = pfa_calc(m,n,l_3,mc,'ERD',Pn_dB);
% calcula a probalidade de falso alarme para a técnica GRLT
PFA_GLRT = pfa_calc(m,n,l_4,mc,'GLRT',Pn_dB);

%%              Hipótese H_1: Presença de sinal transmitido
%              Calculo da probalidade de detecção (PD)

% calcula a probalidade de detecção para a técnica ED
PD_ED = pd_calc(p,m,n,l_1,mc,'ED',Pn_dB, SNR);
% calcula a probalidade de detecção para a técnica RLRT
PD_RLRT = pd_calc(p,m,n,l_2,mc,'RLRT',Pn_dB, SNR);
% calcula a probalidade de detecção para a técnica ERD
PD_ERD = pd_calc(p,m,n,l_3,mc,'ERD',Pn_dB, SNR);
% calcula a probalidade de detecção para a técnica GLRT
PD_GLRT = pd_calc(p,m,n,l_4,mc,'GLRT',Pn_dB, SNR);

%% imprime mensagem de conclusão e tempo decorrido
fprintf('Concluído \n');
toc

% avisa com sinal sonoro o fim da simulação
tom(1000);

%% plota gráfico com resultados

subplot(2,2,1);
plot(l_1,PFA_ED,'d--',l_1,PD_ED,'o-');
grid on;
title('{\bfED} \newlineProbabilidades de falso alarme e de detecção {\itversus} o limiar de decisão.');
xlabel('Limiar ({\gamma})');
ylabel('Probabilidade: (P_{FA}, P_{D})');
legend('PFA','PD');

subplot (2,2,2);
plot(l_2,PFA_RLRT,'d--',l_2,PD_RLRT,'o-');
grid on;
title('{\bfRLRT} \newlineProbabilidades de falso alarme e de detecção {\itversus} o limiar de decisão.');
xlabel('Limiar ({\gamma})');
ylabel('Probabilidade: (P_{FA}, P_{D})');
legend('PFA','PD');

subplot(2,2,3);
plot(l_3,PFA_ERD,'d--',l_3,PD_ERD,'o-');
grid on;
title('{\bfERD} \newlineProbabilidades de falso alarme e de detecção {\itversus} o limiar de decisão.');
xlabel('Limiar ({\gamma})');
ylabel('Probabilidade: (P_{FA}, P_{D})');
legend('PFA','PD');

subplot(2,2,4);
plot(l_4,PFA_GLRT,'d--',l_4,PD_GLRT,'o-');
grid on;
title('{\bfGLRT} \newlineProbabilidades de falso alarme e de detecção {\itversus} o limiar de decisão.');
xlabel('Limiar ({\gamma})');
ylabel('Probabilidade: (P_{FA}, P_{D})');
legend('PFA','PD');

figure (2);
plot(PFA_ED,PD_ED,'o-',PFA_RLRT,PD_RLRT,'>-',PFA_ERD,PD_ERD,'s-',PFA_GLRT,PD_GLRT,'p-','LineWidth',2,'MarkerSize',8);
grid on;
%title('{\bfROC} - Receiver Operating Characteristic \newlineProbabilidades de falso alarme {\itversus} probabilidade de detecção','fontsize',14);
xlabel('P_{FA}','fontsize',14,'fontweight','b');
ylabel('P_{D}','fontsize',14,'fontweight','b');
legend('ED','RLRT','ERD','GLRT','Location','SouthEast');
