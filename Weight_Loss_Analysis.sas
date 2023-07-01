/*
SAS Case Study: Weight Loss

Objective:
Generating simple cross-tab in Proc Freq to exam possible trend of weight loss (in lb) in response to daily walking steps 

Data:
Weight_loss.xlsx: contains 19 participants/observations

Variables:
Pid: participant id
Gender: participant gender	
Weight0: weight at the beginning of the program
Weight1: weight at the end of 1st month of the program	
Weight2: weight at the end of 2nd month of the program
walk_steps: walking steps daily
*/


/*
Steps:
1. Import Excel data file into SAS, create SAS data set named as WL0
*/
proc import datafile = '~/data/Weight_loss.xlsx' DBMS = xlsx out = WL0 replace;
run;


/*
2. Data management: 
(1) Check Data using proc Means and proc Freq 
Create a new data set WL1 using a data step program including the following steps: step (2) and (3) 
(2) Clean data: change value ‘9999’ to missing using Array statement 
(3) Create weight difference variables
wd1 = weight0 - weight1;
wd2 = weight0 - weight2;
wd12 = weight1 - weight2;
(4) Using Proc Means and Proc Freq, check weight difference variables (only pick wd2 for this project, you may use others for practice) 
and walk_steps var for making groups from these var. 
Create a new data set WL2 using a data step program including the following steps: step (5) and (6) 
(5) create groups for walk_steps: create new var ws_group
the new group var should have 3 categories:
less than 5000
'5000-10000'
greater than 10000
(6) create groups for wd2: create new var wd2_group
the new group var should have 3 categories:
not losing weight
losing <= 5 lb
losing > 5 lb
*/

proc means data = WL0;
var weight0-weight2 walk_steps;
run;

proc freq data = wl0;
tables gender;
run;

data WL1;
set WL0;
ARRAY weights(3) weight0-weight2;
/* Clean data: change value ‘9999’ to missing using Array statement */
DO i = 1 TO 3;
	IF weights(i) = 9999 THEN weights(i) = .;
END;
/* Create weight difference variables */
wd1 = weight0 - weight1;
wd2 = weight0 - weight2;
wd12 = weight1 - weight2;
drop i;
run;

/* Declare a macro variable for weight difference */
%let wd = wd2;

proc means data = WL1;
var &wd walk_steps;
run;

proc freq data = WL1;
table &wd walk_steps;
run;

data WL2;
set WL1;
/* Create groups for walk_steps */
IF walk_steps > 10000 THEN ws_group = 'greater than 10000';
ELSE IF walk_steps >= 5000 THEN ws_group = '5000-10000';
ELSE IF walk_steps >= 0 THEN ws_group = 'less than 5000';
ELSE ws_group = 'missing';
/* Create groups for selected weight difference */
length wd_group$ 20;
IF &wd > 5 THEN wd_group = 'losing > 5 lb';
ELSE IF &wd > 0 THEN wd_group = 'losing <= 5 lb';
ELSE IF &wd = . THEN wd_group = 'missing';
ELSE wd_group = 'not losing weight';
run;


/*
3.	Create permanent data set from data set WL2: projectd.weight_loss
*/

LIBNAME projectd '/home/u50239782';

data projectd.weight_loss;
set WL2;
run;


/*
4.	create cross-tab using Proc Freq for walk steps' groups (ws_group) 
and weight loss groups (wd_group) to exam the possible trend
*/

proc freq data = WL2;
table ws_group * wd_group/missing nocol norow;
run;