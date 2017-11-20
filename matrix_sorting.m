function [FM,CM] = matrix_sorting(FM,CM)

% MATRIX SORTING :
%
%   Matrix sorting is a common heuristic to increase
%   the matching probability of function and crossbar
%   matrices. Function matrix columns with the most
%   number of 1s are arranged such that crossbar matrix
%   columns with the least number of defects (-1) are aligned accordingly.
%

literal_degree = sum(FM ==1,1);
[~,idx] = sort(literal_degree,'descend');
FM = FM(:,idx);
defect_degree = sum(CM ==-1,1);
[~,idx] = sort(defect_degree,'ascend');
CM = CM(:,idx);

end