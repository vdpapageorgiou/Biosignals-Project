#' MergeTime
#'
#' H συνάρτηση δέχεται ως είσοδο ένα dataframe με τα δεδομένα των features, 
#' όπως αυτά δομήθηκαν από την LoadDataset function. Δημιουργεί ένα νέο columnn
#' "Time" στο dataframe, που αποτελεί την ένωση των τριών πεδίων σχετικών με 
#' χρονική στιγμή ("Hour","Minute", "Second"), και διαγράφει τα παραπάνω πεδία 
#' από το dataframe.
#' 
#' Θα εφαρμοστεί μέσω της lapply(SubjectList, MergeTime)
#' όπου SubjectList η list των dataframes που δίνει η LoadDataset
#' 
MergeTime <-function(Subject) {
    
    options(digits = 12)
    options(digits.secs = 3)
    Subject$Time <- with(Subject, strptime(paste(Hour, Minute, Second,sep=":"),"%H:%M:%OS"))
    Subject <- subset(Subject, select = -c(Hour,Minute,Second))
    
}