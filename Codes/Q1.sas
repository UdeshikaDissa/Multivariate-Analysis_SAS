/* READ DATA */
PROC IMPORT out= work.data
datafile='/home/u41080493/Udeshika/THC.csv'
	DBMS=CSV replce;
	GETNAMES=YES;
	DATAROW=2;
RUN;

%let variableList = chem1 chem2 chem3 chem4 chem5 chem6 chem7 chem8 chem9 chem10 chem11 chem12 chem13;


/** (1)Mean SD*/
proc means data=data maxdec=4 MEAN STD;
var &variableList;
run;

/* (2) correlation matrix and scatter matrix*/
proc corr data=data noprob;
var &variableList;
run;

proc sgscatter data=data;
  title "Scatterplot Matrix for THC Data";
  matrix chem1 chem2 chem3 chem4 chem5 chem6 chem7 chem8 chem9 chem10 chem11 chem12 chem13/DIAGONAL = (HISTOGRAM) ;
  

/* find principal components from covariance matrix */
proc princomp data=data cov;
var &variableList;
run;

/* find principal components from correlation matrix */
proc princomp data=data ;
var &variableList;
run;

