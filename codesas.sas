* Written by R;
*  write.foreign(data.csv, datafile = "datasas.txt", codefile = "codesas.sas",  ;

PROC FORMAT;
value GendrSTR 
     1 = "" 
     2 = "f" 
     3 = "F" 
     4 = "female" 
     5 = "m" 
     6 = "M" 
     7 = "male" 
     8 = "Male" 
;

DATA  rdata ;
INFILE  "datasas.txt" 
     DSD 
     LRECL= 99 ;
INPUT
 SubjectID
 Age
 WeightPRE
 WeightPOST
 Height
 SES
 GenderSTR
 GenderCoded
 bmiPRE
 bmiPOST
 diff2
 diff
;
FORMAT GenderSTR GendrSTR. ;
RUN;
