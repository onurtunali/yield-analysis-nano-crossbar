function [Kr,Kc] = yield_calculator(FM,P)

fprintf('Kr: row coefficient\nKc: column coefficient\nPr: matching probability\n\nCalculating the yield...\n\n')

[Mf,Nf] = size(FM);

IRVector = sort(sum(FM==1,2),'descend');
IRVector = IRVector / Nf;

Pr = 0;
Kr = 1;
Kc = 1;
flag = true;

while Pr<0.995
    
    Pr = 1;
    for i = 1:Mf-1
        Pmatch = (1 - P/Kc)^(IRVector(i)*Nf);
        temp = 1 - (1 - Pmatch)^(Mf*Kr-i);
        Pr = Pr*temp;
    end
    
    fprintf(' Kr = %0.1f and Kc = %0.1f, Pr = %0.3f\n', Kr,Kc,Pr)
    
    if flag
        Kr = Kr + 0.1;
        flag = false;
    else
        Kc = Kc + 0.1;
        flag = true;
    end
  
end