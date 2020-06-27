/* 2.1 Prepare the dataset */
data SocioEconomics;
	input Population School Employment Services HouseValue;
	datalines;
    5700     12.8      2500      270       25000
    1000     10.9      600       10        10000
    3400     8.8       1000      10        9000
    3800     13.6      1700      140       25000
    4000     12.8      1600      140       25000
    8200     8.3       2600      60        12000
    1200     11.4      400       10        16000
    9100     11.5      3300      60        14000
    9900     12.5      3400      180       18000
    9600     13.7      3600      390       25000
    9600     9.6       3300      80        12000
	9400     11.4      4000      100       13000
run;

/* 2.1 Print the dataset */
proc print data=SocioEconomics;
run;

/* 2.2 Mean and standard deviation for the data */
proc means data=SocioEconomics maxdec=4 MEAN STD;
	/* 2.3 Factort analysis*/
proc factor data=SocioEconomics simple corr;
run;

/* 2.5 the scoring  coefficients as  eigenvalues*/
proc princomp data=SocioEconomics;
run;

/* 2.6 the component scores as linear combinations of the observed variable*/
proc factor data=SocioEconomics n=5 score;
run;