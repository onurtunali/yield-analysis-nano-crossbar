%  CROSSBAR SIZE FINDER TOOL FOR DEFECT TOLERANT LOGIC MAPPING
%
%   Info:
%
%  This program calculates the crossbar size according to a given logic function and 
%	a defect rate in the first step. Afterwards, established crossbar size is shown
 %  to be sufficient for a 100% success rate using Monte Carlo simulation by
%  randomly generating defective crossbars (a sample size of 100) and finding
%   a valid mapping for each case.
%
%  Parameters :
%
%       Defect rate (P) : Decimal e.g 20% is 0.20
%       Function file : function.xlsx, the name of the excel file contaning
%       the logic function showing the inclusion of a literal with +1 and
%       exclusion with-1.
%
%   Example :
%
%   Function Matrix (FM)                                             Crossbar Matrix (CM)
%
%   f = x1 x2 + x2 x3 + x1 x4
%   1: Literal inclusion -1: Literal exclusion         0: functional  -1 : Defects
%
%                    x1  x2  x3  x4                                         I1  I2  I3  I4
%           p1     1    1   -1   -1                                 O1      0  0  1  -1
%           p2    -1    1    1   -1                                 O2     -1  0  0   1
%           p3     1   -1   -1    1                                 O3      0  1  0   0
%
%   Matching Conditions:
%
%     1: Literal inclusion can only be matched with 0: functional
%    -1: Literal exclusion can be matched with both 0: functional and -1: defects
%
%

clc
clear

% INPUTS

function_file = 'function.xlsx'; % the name of the excel file including the logic function
P = 0.15; % Defect rate

% INPUTS

SAMPLE_SIZE = 100;
TRIAL_LIMIT = 1000;
RUNTIME_LIMIT = 5; % Limit is in seconds
valid_mappings = 0;
time_vector = zeros(1,SAMPLE_SIZE);
FM =  xlsread(function_file,10); % Function matrix
[Mf , Nf] = size(FM); % Row and column size of the function matrix
IR = sum(sum(FM == 1)) / (Mf*Nf); % Logic inclusion ratio i.e. precentage of used switches

fprintf('__________YIELD CALCULATION__________\n\n')

[Kr,Kc] = yield_calculator(FM,P); % This function calculates the crossbar size for a valid mapping
Mc = ceil(Mf*Kr); % Row size of crossbar
Nc = ceil(Nf*Kc); % Column size of crossbar

fprintf('\nThe size of logic function is %d x %d and defect rate is %d %%\n',Mf,Nf,P*100)
fprintf('The size of crossbar sufficient for a valid mapping is %d x %d \n\n',ceil(Mf*Kr),ceil(Nf*Kc))



%  MONTE CARLO simulation starts

fprintf('__________MONTE CARLO SIMULATION_____________\n\n')

for sample_no=1:SAMPLE_SIZE
    
    mapping = false;
    trial = 1;
    
    CM = randsrc(Mc, Nc, [0 -1; 1-P P]); % Generating a random defective crossbar
    
    tic
    
    FM_padded = FM;
    temp = zeros(Mc,Nc);
    temp(1:Mf,1:Nf) = FM_padded; % Since crossbar size is not equal to function size, FM (function matrix) is padded with zeros.
    FM_padded = temp;
    
    [FM_padded,CM] = matrix_sorting(FM_padded,CM); % Matrices are sorted to increase the possiblitiy of a valid mapping
    
    
    while trial <= TRIAL_LIMIT && toc < RUNTIME_LIMIT
        
        [matching_matrix] = match_finder(FM_padded,CM);
        [assignment, cost] = munkres(matching_matrix); % Assignment algorithm to find zero cost meaning a valid mapping
        
        if cost == 0
            mapping = true;
            break
        end
        
        column_permutation = randperm(Nc);
        FM_padded = FM_padded(:,column_permutation);
        trial = trial +1;
    end
    
    runtime = toc;
    time_vector(1,sample_no) = runtime;
    
    if mapping
        valid_mappings = valid_mappings +1;
        fprintf('Sample no = %d Valid mapping is found\n\n',sample_no)
    else
        fprintf('Sample no = %d NO mapping is found\n\n',sample_no)
    end
    
end

%  MONTE CARLO simulation ends

fprintf('______________ RESULTS ______________________\n\n')

success_rate = valid_mappings*100 /SAMPLE_SIZE;
time_mean = sum(time_vector)/SAMPLE_SIZE;
fprintf('Success rate = %d %%\n', success_rate);
fprintf('Runtime mean = %0.2f (s)\n', time_mean);

% OUTPUTS

fprintf('Function Size (%d x %d) = %d\n', Mf, Nf, Mf*Nf)
fprintf('Crossbar Size (%d x %d) = %d\n', Mc, Nc, Mc*Nc)

% OUTPUTS