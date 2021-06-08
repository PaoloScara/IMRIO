function [time, IndiceMaxK,Pi, Sigma, time1] = f01_SelectTopK(compParm, cln1, cln2, P, K)

tic;
Pi = zeros(size(P,1));
Sigma  = zeros(1, size(P,1));
for init = 1:size(P,1) % Valuto tutti i nodi della rete
    if cln1 == 'SS'
        [Pi(:,init), Sigma(init)] = f00_Sss(compParm, cln2, P, init);
    elseif cln1 == 'MC'
        [Pi(:,init), Sigma(init)]  = f01_MonteCarlo(compParm, cln2, P, init);
    elseif cln1 == 'HP'
        [Pi(:,init), Sigma(init)]  = f00_HopPro(cln2, P, init);
    end
end
[~,IndiceMaxK] = maxk(Sigma,K);
time(:,1) = ones(K,1).*toc;
time1 = time;
end

