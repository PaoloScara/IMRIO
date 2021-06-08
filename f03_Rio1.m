function [time, IndicemaxK] = f03_Rio1(P, K, Sigma, Pi, time)

tic
Pi_new = Pi;
[~,Indice_sing] = max(Sigma);
Indice_new = Indice_sing;
Piadd = Pi_new(: ,Indice_sing);
SigmaADD(1,1) = sum(Piadd,'all');

for j = 1:K-1
    for pr = 1:size(P,1)
        if ismember(pr,Indice_new)
            Pi_new_prov(:,pr) = Pi_new(:,pr,j)*0;
        else
            Pi_new_prov(:,pr) = 1 -(1 -Piadd).*(1 -Pi_new(:,pr,1));
        end
    end
    Pi_new_prov(Pi_new_prov < 0) = 0;
    Pi_new(:,:,j+1) = Pi_new_prov;
    Sigma_new = sum(Pi_new(:,:,j+1),1);
    [~,Indice_sing] = max(Sigma_new);
    Piadd = Pi_new(:,Indice_sing,j+1);
    Indice_new = [Indice_new, Indice_sing];
    SigmaADD(j+1,1) = sum(Piadd,'all');
    
 time(j,1) = toc + time(j,1);
IndiceNEW = Indice_new;   
    
end
IndicemaxK = IndiceNEW;
end

