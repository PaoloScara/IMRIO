% Caricamento dati
clc
clear;
close all;

addpath(genpath('00_Dataset')); addpath('01_FunzioniSpread'); addpath('02_FunzioniGrafiche');

name = 'Hamster_TR';

name_complete = strcat(name,'.mat');
load(name_complete)

% Settings
K = 50;
Km = 10000; % Numero iterazioni monte carlo
param = 0.01;

% Simulazioni pesanti (1 = versione veloce)
veloce = 1;

% cln2 = 'LT';
cln2 = 'IC';

if cln2 == 'LT'
    for i = 1:size(P,1)
        if sum(P(:,i),'all') > 0
            P(:,i) = (P(:,i)/(sum(P(:,i),'all')))*rand;
        end
    end
end

% Simulazione
listAlg

disp('validazione');
% VALIDAZIONE
for it = 1:size(TIME,2)
    disp(it);
    for i = 1:K
        [~, Paragone(i,it)] = f01_MonteCarlo(Km, cln2, P, IndiceMaxK(it,1:i));
    end
end

save(strcat(name,'_','_results',cln2))
% system('shutdown -s');

%%
clc
close all

% load(strcat(name,'_','_results',cln2))
printResults(Paragone,TIME,K,cln2,cod,name,star)
