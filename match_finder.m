function   [matching_matrix] = match_finder(FM,CM)

% MATCH FINDER:
%
%   Match finder function determines which rows
%   of function matrix can be matched with rows of
%  crossbar matrix. In this way, a cost matrix (named
%   as matching matrix in defect tolerant logic mapping
%  problem) can be found to pass to the munkres assignment algorithm.
%  If a matching is possible corresponding element in
%  the matching matrix is denoted with a zero.
%

[Mf, ~] = size(FM);
[Mc, ~] = size(CM);

matching_matrix = ones(Mc, Mf);

for i = 1:Mf    
    for j = 1:Mc        
        comp = FM(i,:).*CM(j,:);        
        if all( comp >= 0)
            matching_matrix(i, j) = 0;
        end        
    end    
end

end