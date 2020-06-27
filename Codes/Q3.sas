/* 1.1 Load dataset */
data bankData;
	infile "/home/u41080493/Udeshika/Swiss Bank data.csv" delimiter=',' missover 
		firstobs=1;
	input Class $ Length Left Right Bottom Top Diagonal;
run;

/* 3.1 Print the dataset */
proc print data=bankData(obs=7);
run;

/* 3.2 mean and variance-covariance matrix for genuine notes */
proc corr data=bankData outp=CorrOut COV noprint;
	by Class notsorted;
	var Length Left Right Bottom Top Diagonal;
run;

proc print data=CorrOut(where=(_TYPE_ in ("N", "MEAN", "COV"))) noobs;
	where Class="genuine";

	/* just view information for one group */
	by Class _Type_ notsorted;
	var _NAME_ Length Left Right Bottom Top Diagonal;
run;

/* 3.3 mean, STD and variance-covariance matrix for counterfeit notes */
proc print data=CorrOut(where=(_TYPE_ in ("N", "MEAN", "STD", "COV"))) noobs;
	where Class="counterf";

	/* just view information for one group */
	by Class _Type_ notsorted;
	var _NAME_ Length Left Right Bottom Top Diagonal;
run;

/* 3.4 Correlation matrix for genuine notes */
proc corr data=bankData outp=CorrOut2 noprint;
	by Class notsorted;
	var Length Left Right Bottom Top Diagonal;
run;

proc print data=CorrOut2(where=(_TYPE_ in ("CORR"))) noobs;
	where Class="genuine";

	/* just view information for one group */
	by Class _Type_ notsorted;
	var _NAME_ Length Left Right Bottom Top Diagonal;
run;

proc sgscatter data=bankData;
	where Class="genuine";
	title "Scatterplot Matrix for genuine notes";
	matrix Length Left Right Bottom Top Diagonal/DIAGONAL=(HISTOGRAM);
run;

/* 3.5 Correlation matrix for counterfeit notes */
proc corr data=bankData outp=CorrOut2 noprint;
	by Class notsorted;
	var Length Left Right Bottom Top Diagonal;
run;

proc print data=CorrOut2(where=(_TYPE_ in ("CORR"))) noobs;
	where Class="counterf";

	/* just view information for one group */
	by Class _Type_ notsorted;
	var _NAME_ Length Left Right Bottom Top Diagonal;
run;

proc sgscatter data=bankData;
	where Class="counterf";
	title "Scatterplot Matrix for fake notes";
	matrix Length Left Right Bottom Top Diagonal/DIAGONAL=(HISTOGRAM);
run;

/* 3.6 Discriminant Analysis */
data test;
	input Length Left Right Bottom Top Diagonal;
	cards;
214.9 130.1 129.9 9 10.6 140.5;
run;

proc discrim data=bankData pool=test crossvalidate testdata=test testout=a;
	class Class;
	var Length Left Right Bottom Top Diagonal;
	priors "genuine"=0.99 "counterf"=0.01;
run;

proc print;
run;