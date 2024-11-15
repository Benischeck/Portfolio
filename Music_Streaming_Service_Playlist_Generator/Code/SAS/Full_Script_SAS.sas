/****************************************************************************************************/
/* Music Streaming Service Playlist Generator - Full Code                                           */
/*                                                                                                  */
/* Version:      1.0                                                                                */
/* Coded using:  SAS 9.4                                                                            */
/* Last Updated: 03/01/2015                                                                        */
/* Updated by:   Jack Benischeck                                                                    */
/****************************************************************************************************/


/****************************************************************************************************/
/* PART 0 - Global Variables                                                                        */
/*                                                                                                  */
/* Set up global variables to be called in the script.                                              */
/****************************************************************************************************/

files_in = "Insert your file location here"

files_out = "Insert your file location here"





/****************************************************************************************************/
/* PART 1 - IMPORT DATA                                                                             */
/*                                                                                                  */
/* Import the raw datasets, which includes the sumations of words used to describe                  */
/*     on a per artist basis.                                                                       */
/****************************************************************************************************/


/* Words */

proc import datafile = files_in + "\Male Sum of Words by Artist.xlsx"
	DBMS = xlsx
	Out = Male;
run;

proc import datafile = files_in + "\Female Sum of Words by Artist.xlsx"
	DBMS = xlsx
	Out = Female;
run;

proc import datafile = files_in + "\Sum Of Words Per Artist Raw.xlsx"
	DBMS = xlsx
	Out = Combined;
run;

proc import datafile = files_in + "\Sum Of Words Per Artist Raw.xlsx"
	DBMS = xlsx
	Out = transposed_words_raw;
	sheet = 'Words_Transposed';
	run;



/* weights */

proc import datafile = files_in + "\Average Cluster Weight by Age Group.xlsx"
	DBMS = xlsx
	Out = Averages;
	sheet = 'Averages';
	run;

proc import datafile = files_in + "\Average Cluster Weight by Age Group.xlsx"
	DBMS = xlsx
	Out = Avg_Male;
	sheet = 'Avg_Male';
	run;

proc import datafile = files_in + "\Average Cluster Weight by Age Group.xlsx"
	DBMS = xlsx
	Out = Avg_Female;
	sheet = 'Avg_Female';
	run;



/* artists */

proc import datafile = "files_in + "\Average Cluster Weight by Age Group.xlsx"
	DBMS = xlsx
	Out = Combined_Weight;
	sheet = 'Combined';
	run;

proc import datafile = files_in + "\Average Cluster Weight by Age Group.xlsx"
	DBMS = xlsx
	Out = Artist_Male;
	sheet = 'Male';
	run;

proc import datafile = files_in + "\Average Cluster Weight by Age Group.xlsx"
	DBMS = xlsx
	Out = Artist_Female;
	sheet = 'Female';
	run;



/****************************************************************************************************/
/* PART 2 - CLUSTER ANALYSIS                                                                        */
/*                                                                                                  */
/* Perform a cluster analysis on how close each word is to another based on the artists.            */
/*                                                                                                  */
/****************************************************************************************************/

proc cluster data = transposed_words_raw method = Ward  outtree = Word_Clusters;
var a00 a01 a02 a03 a04 a05 a06 a07 a08 a09 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20
a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 a32 a33 a34 a35 a36 a37 a38 a39 a40 a41 a42
a43 a44 a45 a46 a47 a48 a49;
id words;
run; 

proc tree data = Word_Clusters;
run;



/****************************************************************************************************/
/* PART 3 - Explore the clusters, and the percentage of words in each cluster to the                */
/*      overall number of words per each artist, as a whole, and by gender.                         */
/****************************************************************************************************/


/*************************************************************************/
/* Create a new dataset which sums the clusters of words for each artist */
/*************************************************************************/

/* Overall */

data Groups_Overall;
	set Combined;
format Group01 6. Group02 6. Group03 6. Group04 6. Group05 6. Group06 6. Group07 6. Group08 6. Group09 6. Group10 6.;
	Keep Artist Group01 Group02 Group03 Group04 Group05 Group06 Group07 Group08 Group09 Group10 Sums;

		Group01 = Timeless + Classic;
		Group02 = distinctive + good_lyrics + talented + original + authentic;
		Group03 = dated + depressing + inspiring + sensitive + serious;
		Group04 = calm + warm + beautiful + approachable + credible + stylish + passionate + thoughtful;
		Group05 = catchy;
		Group06 = energetic + upbeat + fun +current + youthful + boring + cool + confident + none_of_these + edgy;
		Group07 = Annoying +  Sexy + Playful + Outgoing + Unoriginal +cheesy +superficial + fake + cheap + unattractive + noisy + arrogant + aggressive;
		Group08 = Popular + free+ rebellious +outspoken +genius + intriguing + exciting + colourful + uplifting + sociable + emotional + heartfelt + soulful + relaxed + laid_back + background + sophisticated;
		Group09 = iconic + nostalgic + dark + legendary + superstar + way_out + progressive + pioneer + old + worldly + wholesome;
		Group10 = unapproachable + over + relatable + intrusive + not_authentic + irrelevant + mainstream + uninspired;
		Sums = (Group01 + Group02 + Group03 + Group04 + Group05 + Group06 + Group07 + Group08 + Group09 + Group10);


Run;



/* Males */

data Groups_Male;
	set Male;
format Group01 6. Group02 6. Group03 6. Group04 6. Group05 6. Group06 6. Group07 6. Group08 6. Group09 6. Group10 6.;
	Keep Artist Group01 Group02 Group03 Group04 Group05 Group06 Group07 Group08 Group09 Group10 Sums;

		Group01 = Timeless + Classic;
		Group02 = distinctive + good_lyrics + talented + original + authentic;
		Group03 = dated + depressing + inspiring + sensitive + serious;
		Group04 = calm + warm + beautiful + approachable + credible + stylish + passionate + thoughtful;
		Group05 = catchy;
		Group06 = energetic + upbeat + fun +current + youthful + boring + cool + confident + none_of_these + edgy;
		Group07 = Annoying +  Sexy + Playful + Outgoing + Unoriginal +cheesy +superficial + fake + cheap + unattractive + noisy + arrogant + aggressive;
		Group08 = Popular + free+ rebellious +outspoken +genius + intriguing + exciting + colourful + uplifting + sociable + emotional + heartfelt + soulful + relaxed + laid_back + background + sophisticated;
		Group09 = iconic + nostalgic + dark + legendary + superstar + way_out + progressive + pioneer + old + worldly + wholesome;
		Group10 = unapproachable + over + relatable + intrusive + not_authentic + irrelevant + mainstream + uninspired;
		Sums = (Group01 + Group02 + Group03 + Group04 + Group05 + Group06 + Group07 + Group08 + Group09 + Group10);

Run;



/* Females */

data Groups_Female;
	set Female;
format Group01 6. Group02 6. Group03 6. Group04 6. Group05 6. Group06 6. Group07 6. Group08 6. Group09 6. Group10 6.;
	Keep Artist Group01 Group02 Group03 Group04 Group05 Group06 Group07 Group08 Group09 Group10 Sums;

		Group01 = Timeless + Classic;
		Group02 = distinctive + good_lyrics + talented + original + authentic;
		Group03 = dated + depressing + inspiring + sensitive + serious;
		Group04 = calm + warm + beautiful + approachable + credible + stylish + passionate + thoughtful;
		Group05 = catchy;
		Group06 = energetic + upbeat + fun +current + youthful + boring + cool + confident + none_of_these + edgy;
		Group07 = Annoying +  Sexy + Playful + Outgoing + Unoriginal +cheesy +superficial + fake + cheap + unattractive + noisy + arrogant + aggressive;
		Group08 = Popular + free+ rebellious +outspoken +genius + intriguing + exciting + colourful + uplifting + sociable + emotional + heartfelt + soulful + relaxed + laid_back + background + sophisticated;
		Group09 = iconic + nostalgic + dark + legendary + superstar + way_out + progressive + pioneer + old + worldly + wholesome;
		Group10 = unapproachable + over + relatable + intrusive + not_authentic + irrelevant + mainstream + uninspired;
		Sums = (Group01 + Group02 + Group03 + Group04 + Group05 + Group06 + Group07 + Group08 + Group09 + Group10);


Run;



/****************************************************************************/
* create another dataset that shows the portion of each cluster per artist */
/****************************************************************************/

/* Combined */

data Group_Percent_Combined; 
	set Groups_Overall;
	drop Group01 Group02 Group03 Group04 Group05 Group06 Group07 Group08 Group09 Group10 Sums;
		Timeless=Group01/sums;
		Talented=Group02/sums;
		Emotional=Group03/sums;
		Ambient=Group04/sums;
		Catchy=Group05/sums;
		Teenage=Group06/sums;
		Pop_Top_40=Group07/sums;
		Chang=Group08/sums;
		Classic_Rock=Group09/sums;
		Lame=Group10/sums;

run;



/* Males */
	
data group_Percent_Male; 
	set Groups_male;
	drop Group01 Group02 Group03 Group04 Group05 Group06 Group07 Group08 Group09 Group10 Sums;
		Timeless=Group01/sums;
		Talented=Group02/sums;
		Emotional=Group03/sums;
		Ambient=Group04/sums;
		Catchy=Group05/sums;
		Teenage=Group06/sums;
		Pop_Top_40=Group07/sums;
		Chang=Group08/sums;
		Classic_Rock=Group09/sums;
		Lame=Group10/sums;


run;



/* Females */

data group_Percent_Female; 
	set groups_Female;
	drop Group01 Group02 Group03 Group04 Group05 Group06 Group07 Group08 Group09 Group10 Sums;
		Timeless=Group01/sums;
		Talented=Group02/sums;
		Emotional=Group03/sums;
		Ambient=Group04/sums;
		Catchy=Group05/sums;
		Teenage=Group06/sums;
		Pop_Top_40=Group07/sums;
		Chang=Group08/sums;
		Classic_Rock=Group09/sums;
		Lame=Group10/sums;

run;




/* Export the dataset where the users are paird with their age */

/* Overall */

proc export data=work.Group_Percent_Combined 
	outfile= files_in + "\Group_Weights.xlsx" 
	dbms=xlsx 
	replace;
	sheet = "Combined";
	run;



/* Males */

proc export data=work.group_Percent_Male 
	outfile=files_in + "\Group_Weights.xlsx" 
	dbms=xlsx 
	replace;
	sheet = "Male";
	run;



/* Females */

proc export data=work.group_Percent_Female 
	outfile=files_in + "\Group_Weights.xlsx" 
	dbms=xlsx
	replace;
	Sheet = "Female";
	run;



/**************************************************************************/
/* Using data maximized for building constraints, build the contstraints  */
/**************************************************************************/

proc import datafile = files_in + "\Average Cluster Weight by Age Group.xlsx"
	DBMS = xlsx
	Out = cccc;
	sheet = 'Female';
	getnames=yes;
	run;

proc import datafile = files_in + "\Average Cluster Weight by Age Group.xlsx"
	DBMS = xlsx
	Out = word;
	sheet = 'sheet1';
	getnames=yes;
	run;

proc import datafile = files_in + "\Average Cluster Weight by Age Group.xlsx"
	DBMS = xlsx
	Out = average111;
	sheet = 'sheet2';
	getnames=yes;
	run;

data cccc1;
set cccc;
keep Artist;
run;

Proc optmodel;
set Age; 
set Gender;
set ARTIST;
set <string> word;

number Artist_female{artist,word};
number average{word};
*number Artist_male{artist,word};

age ={1..8};
gender = {1..2};
artist={1..50};
word={'Timeless','Talented','Emotional','Ambient','Catchy','Teenage','Pop_Top_40','Chang','Classic_Rock', 'Lame'};

var X{Age, Gender,Artist} binary;

read data work.cccc1 into Artist=[artist];
read data work.cccc into [artist] {w in word}< artist_female[artist,w] = col(w)> ;
read data work.average111 into word=[word] average;
*read data Artist_male into artist_male = [Artist] Timeless Talented Emotional Ambient Catchy Teenage Pop_Top_40 Chang Classic_Rock Lame;

minimize Age1_Female = sum {i in artist} artist_female[i,'Timeless'] * X[1,1,i];

con c1:sum{i in artist} X[1,1,i]=8;
con c2:sum{i in artist} X[1,1,i]*artist_female[artist,'Classic Rock'>= average['Classic Rock'];


solve;
print X.sol;
quit;