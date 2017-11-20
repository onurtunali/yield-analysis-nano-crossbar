Crossbar Size Finder Tool for Defect Tolerant Logic Mapping

Info:

	This program calculates the crossbar size according to given logic function and a defect rate in the first step. A crossbar array having the determined size can be used for a valid physical implementation of the logic function. As a following step, established crossbar size is shown to be sufficient for a 100% success rate using Monte Carlo simulation by randomly generating defective crossbars with the given defect rate (a sample size of 100) and finding a valid mapping for each case. Logic function are stored in an excel file named "function.xlsx". An example file added to the distribution.
	
	For every function required for program, detailed explanations are given inside the individual code as a docstring.
	
Parameters:

     Defect rate (P) : Decimal e.g 20 is 0.20
     Function file : function.xlsx, the name of the excel file contaning
     the logic function showing the inclusion of a literal with +1 and
     exclusion with-1.

Example:

   Function Matrix                                             			Crossbar Matrix

   f = P1    +   P2    + P3 (Sum-of-Products form)
   f = x1 x2 + x2 x3 + x1 x4
   1: Literal inclusion -1: Literal exclusion         				0: functional  -1 : Defects

                    x1  x2  x3  x4                                               I1  I2  I3  I4
           P1     1    1   -1   -1                                 	O1      0  0  1  -1
           P2    -1    1    1   -1                                 	O2     -1  0  0   1
           P3     1   -1   -1    1                                 	O3      0  1  0   0

		   
Usage:
	
	1) Change the "function.xlsx" file with the desired logic function file or just modify the first sheet.
	2) Run "main_program.m" script. 	
	3) Results of crossbar size and monte carlo simulation are shown in command window. 
	
Requirements:

	Program works on MATLAB paltform and is tested on versions 2013 through 2017. Only core built-in functions are used so no simulink package is necessary. 

Further questions: 

	onur.tunali@itu.edu.tr
	www.ecc.itu.edu.tr


