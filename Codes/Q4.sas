/**proc import datafile = '/home/u41080493/Udeshika/test.csv'
out = work.nutri
dbms = CSV
missover
FIRSTOBS=1

input Calcium x2 x3 x4 x5;
run;
proc iml;
use work.nutri;
reset print;
read all var _all_ into x;*/



/* (a) Read the dataset */
data question4;
	infile "/home/u41080493/Udeshika/nutrient.csv"
		delimiter=','
		missover 
		firstobs=1;
	input id Calcium Iron Protein VitaminA VitaminC;
run;

/* Reading variables into column matrix */
proc iml;
	use question4;
	reset print;
	read all var {Calcium Iron Protein VitaminA VitaminC} into x;

* (b) Univariate descriptive statistics for each variable */
proc means data=question4 (drop=id) maxdec=3;


/* (c) Scatter matrix */
proc sgscatter data=question4;
  title "Scatterplot Matrix for Nutrient Data";
  matrix Calcium Iron Protein VitaminA VitaminC/DIAGONAL = (HISTOGRAM);

run;
title;

/* (c) Box plots */
proc sort data=question4;
by id;
run;

proc transpose data=question4 out=plotdata;
by id;
run;

data plotdata;
set plotdata;
label _name_ = "Variable";
label col1 = "Value";
run;

ods html;
title "Box Plots for Nutrient Data";
proc sgplot data=plotdata;
vbox col1 / group=_name_ ;
yaxis grid values=(-50 to 2000 by 50);
ods graphics on / width=10in height=8in;
run;
ods html close;

/* (d) Producing covariance matrix for the dataset */


