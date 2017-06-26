/*******************************************************************************
*	File name:		Michael_02_clean.do
*  	Author(s):		Michael Petruzzelli
*  	Written:       	06/22/2017 (of latest version)
*
*	Inputs:			Raw_File1.dta, Raw_File2.dta
*	Outputs:		CleanedFile.dta, MainResults.log, FinalPaper.pdf
*	
*	Description: 
*
*  	1. This is a template for your Do-file. Just "Save as" your new Do-file, 
*	then write over the relevant fields! 
*
*	2. The description should say what the goal of the Do-file is. 
*
*	3. Make your code legible, not just functional. 
*		a) Indent your loops, conditionals, preserve/restores, other code chunks
*		b) Line up your punctuation: braces ("{" and "}"), equal signs ("="), 
		colons (":"), quote marks (`" "'), etc.
*		c) Use "///" to break up lines of code that extend beyond the line break
*		d) Make clear section headers
*		e) Comment on everything that is not inherently clear to a first-time 
*		reader! Comments should explain why not how. 
*
*	3. Don't over-abbreviate commands and variable names, e.g. "summarize" = 
*	"summ" (ok), "sum" (ok), "su" (not ok)!
*
*	4. Avoid spaces in file names! Use underscore instead, e.g. "new_file".
* 
*******************************************************************************/
 
/********************** Section 1: Preliminaries ******************************/

version 14.1
clear all
clear mata
set more off
cap log close

local input_dir  "/Users/Michael/Desktop/Michael Stata Practice/temp" //"$repository/build_dataset/label_data/input"
local temp_dir   "/Users/Michael/Desktop/Michael Stata Practice/temp" //"$repository/build_dataset/label_data/temp"
//local output_dir "$repository/build_dataset/label_data/output"

local name_of_this_file Michael_02_clean

log using "`temp_dir'/`name_of_this_file'", text replace

/********************** Section 1: Import raw data ****************************/
//import delimited needs "input_dir" after import
cd "`input_dir'"

use Appended_Data
/********************** Section 2: Clean data *********************************/

//***************** Subsection 1: Keeping what we want ************************/
keep competition_month competition_year home_city home_state points rank

replace home_state="Missing" if home_state==""  | home_state==" "

replace home_state="Foreign" if home_state!="Missing" & home_state!="AL" & home_state!="AK" & home_state!="AZ" & home_state!="AR" & home_state!="CA" & home_state!="CO" & home_state!="CT" & home_state!="DE" & home_state!="DC" & home_state!="FL" & home_state!="Fl" & home_state!="GA" & home_state!="HI" & home_state!="ID" & home_state!="IL" & home_state!="IN" & home_state!="IA" & home_state!="KS" & home_state!="KY" & home_state!="LA" & home_state!="ME" & home_state!="MD" & home_state!="MA" & home_state!="MI" & home_state!="MN" & home_state!="MS" & home_state!="MO" & home_state!="MT" & home_state!="NE" & home_state!="NV" & home_state!="NH" & home_state!="NJ" & home_state!="NM" & home_state!="NY" & home_state!="NC" & home_state!="ND" & home_state!="MP" & home_state!="OH" & home_state!="OK" & home_state!="OR" & home_state!="PA" & home_state!="RI" & home_state!="SC" & home_state!="TN" & home_state!="TX" & home_state!="UT" & home_state!="VT" & home_state!="VA" & home_state!="WA" & home_state!="WV" & home_state!="WI" & home_state!="WY" & home_state!="PR" & home_state!="MH" & home_state!="AS" & home_state!="FM" & home_state!="GU" & home_state!="MP" & home_state!="VI" & home_city!="Guam"
// replace home_state="Foreign" if !inlist("Missing", "CA")  *** This is also completely butchering the entire dataset for some reason

replace home_state = "US Territory" if home_state=="PR" | home_state=="MH" | home_state=="AS" | home_state=="FM" | home_state=="GU" | home_state=="MP" | home_state=="VI" | home_city=="Guam"

generate has_hill = 0/1
replace has_hill=1 if regexm(home_city, "Hill")

egen n_points_state = total(points), by(home_state)
egen count_state = count(home_state), by (home_state)
generate average_points_state = n_points_state/count_state

save "cleaned_data"

clear

use Appended_Data

egen section_count = count(home_section), by (home_section)

keep home_section section_count
/********************** Section 2: Save and Close *****************************/

save "home_section_data"

log close
