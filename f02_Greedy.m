function [time, Indice_greedy] = f02_Greedy(compParm, cln1, cln2, P, K, Sigma0, time)

tic;
[~,Indice_greedy] = max(Sigma0);

for j =1:K-1
    Sigma = zeros(1,size(P,1));
    for pr = 1:size(P,1)
        init = [Indice_greedy pr];
        if cln1 == 'SS'
            [~, Sigma(pr)] = f00_Sss(compParm, cln2, P, init);
        elseif cln1 == 'MC'
            [~, Sigma(pr)]  = f01_MonteCarlo(compParm, cln2, P, init);
        elseif cln1 == 'HP'
            [~, Sigma(pr)]  = f00_HopPro(cln2, P, init);
        end
    end
    for pr = 1:size(P,1)
        if ismember(pr,Indice_greedy)
            Sigma(pr) = -Inf;
        end
    end
    
    [~,Indice_agg] = max(Sigma);
    Indice_greedy = [Indice_greedy, Indice_agg];
    time(j+1,1) = toc + time(1,1);
end
end

