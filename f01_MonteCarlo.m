function [Pi_fin, Sigma_fin] = f01_MonteCarlo(Km, cln, P, init)

ACT = zeros(size(P,1),Km);
for i = 1:size(P,1)
    if ismember(i,init)
        ACT(i,:) = 1;
    end
end

if cln == 'IC'
    for k = 1:Km
        act = ACT(:,k);
        act_next = zeros(size(act));
        u = 1;
        
        while u == 1
            for i = 1:size(P,1)
                if act(i,1) == 1
                    for j = 1:size(P,1)
                        if ACT(j,k) == 0
                            r = rand;
                            if  r <= P(i,j)
                                act_next(j,1) = 1;
                                ACT(j,k) = 1;
                            end
                        end
                    end
                end
            end
            if sum(act_next,'all') == 0
                u = 2;
            else
                act = act_next;
                act_next = zeros(size(act));
            end
        end
    end
    
elseif cln == 'LT'
    for k = 1:Km
        
        At = ACT(:,k);
        At_1 = ACT(:,k);
        u = 1;
        
        while u == 1
            
            Ap = (At_1'*P)';
            At_1 = At_1*0;
            
            S = rand(size(P,1),1);
            
            for i = 1:size(Ap,1)
                if(Ap(i)>=S(i))  && (At(i) == 0)
                    At_1(i)=1;
                    At(i)=1;
                else
                    At_1(i)=0;
                end
            end
            if sum(At_1,'all') == 0
                u = 2;
            end
        end
        ACT(:,k) = At;
    end
end


Pi_fin = sum(ACT,2)./Km;
Sigma_fin = sum(Pi_fin,'all');
end







