#' MergeTime
#'
#' The function accepts as input a dataframe with the feature data, 
#' as structured by the LoadDataset function. Creates a new column
#' "Time" in the dataframe, which is the union of the three fields related to
# 'time ("Hour", "Minute", "Second"), and deletes the above fields
# 'from the dataframe.
#' 
#' Will be implemented via lapply (SubjectList, MergeTime)
#' where SubjectList is the list of dataframes provided by LoadDataset
#' 
MergeTime <-function(Subject) {
    
    options(digits = 12)
    options(digits.secs = 3)
    Subject$Time <- with(Subject, strptime(paste(Hour, Minute, Second,sep=":"),"%H:%M:%OS"))
    Subject <- subset(Subject, select = -c(Hour,Minute,Second))
    
}
