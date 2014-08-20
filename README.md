Getting and Cleanning Data Course Project
=========================================
##Clean dataset
The resulting clean dataset contains:

* One row for each combination of subject and activity pair 
* Columns for subject, activity, and each feature (means and standard deviations from the original dataset created)


##Script
The run_analysis.R script does the following:

1. Reads the tables that are contained in the directory, test and train sets.
2. Combine the subject that has realized every observation with the corresponding activity and the corresponding features measured on every observation. For test and train sets.
3. Merges test and train dataframes to create one unique data set.
4. Subsets the features corresponding mean and standard deviation measuraments, and creates one new data set (shorter than the original one)
5. Renames the activity labels instead of the values of them.
6. Creates a tidy dataset with the average of each variable for each activity and each subject
7. Saves the tidy data into a file and creates the clean data
