The run_analysis.R script downloads the raw data from the URL, uncompress it,
and filters the dataframe and reduces the columns. 
The script keeps just the variables that are related to the mean and the standard 
deviation of the base dataset (meanFreq is excluded). 
The final dataframe has 66 variables, plus the variables ActivityID, ActivityName
and the Subject (69 variables in total). From the R
command line or RStudio, you need to load the script as: 
	
	source("run_analysis.R")

As result and if there is no error, it outputs the tidy data into a file named
tidyData.txt.
