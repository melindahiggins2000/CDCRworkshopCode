DATA LIST FILE= "dataspss.txt"  free (",")
/ SubjctID Age WeghtPRE WghtPOST Height SES GendrSTR GendrCdd bmiPRE bmiPOST diff2 diff  .

VARIABLE LABELS
SubjctID "SubjectID" 
 Age "Age" 
 WeghtPRE "WeightPRE" 
 WghtPOST "WeightPOST" 
 Height "Height" 
 SES "SES" 
 GendrSTR "GenderSTR" 
 GendrCdd "GenderCoded" 
 bmiPRE "bmiPRE" 
 bmiPOST "bmiPOST" 
 diff2 "diff2" 
 diff "diff" 
 .

VALUE LABELS
/
GendrSTR 
1 "" 
 2 "f" 
 3 "F" 
 4 "female" 
 5 "m" 
 6 "M" 
 7 "male" 
 8 "Male" 
.

EXECUTE.
