function [Pi_fin, Sigma_fin] = f00_Sss(errMax, cln, P, init)

Pi = zeros(size(P,1),1); % matrice probabilità iniziali
err = 10; %errore iniziale, valore random maggiore di 0.1
k = 1;

while err > errMax
    for i = 1:size(P,1)
        if ismember(i,init)
            Pi(i,k+1) = 1; % ad ogni iterazione la prob dei nodi iniziali è 1
        else
            if cln == 'IC'
                Pi(i,k+1) = 1 - prod(1 - P(:,i).*Pi(:,k));
            elseif cln == 'LT'
                Pi(i,k+1) = sum(P(:,i).*Pi(:,k),'all');
            end
        end
    end
    err = norm(Pi(:,k+1) - Pi(:,k)); % calcolo l'errore di convergenza
    k = k+1;
end

Pi_fin = Pi(:,k);
Sigma_fin = sum(Pi_fin);
end
