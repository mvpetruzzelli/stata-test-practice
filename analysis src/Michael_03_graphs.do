/*******************************************************************************
*	File name:		Michael_03_graphs.do
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

local input_dir  "/Users/Michael/Desktop/Michael Stata Practice/temp"
local temp_dir   "/Users/Michael/Desktop/Michael Stata Practice/temp"
//local output_dir "$repository/build_dataset/label_data/output"

local name_of_this_file Michael_03_graphs

log using "`temp_dir'/`name_of_this_file'", text replace

/********************** Section 1: Import raw data ****************************/
cd "`input_dir'"

use cleaned_data
/******************** Section 2: Making Histograms ****************************/
encode home_state, gen(hs)
histogram hs, freq
/********************** Section 2: Save and Close *****************************/

clear

log close
