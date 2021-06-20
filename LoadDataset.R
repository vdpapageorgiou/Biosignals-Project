#' LoadDataset
#'
#' H συνάρτηση αποσυμπιέζει το dataset αρχείο "HealthySubjectsBiosignalsDataSet.zip". 
#' Στη συνέχεια εισάγει τα δεδομένα κάθε ατόμου σε προσωρινά data frames, και τα ενώνει 
#' δημιουργώντας ένα dataframe για κάθε άτομο ("Subject1", "Subject2", κ.λπ.), 
#' που περιέχει το σύνολο των δεδομένων, δηλαδή τα features Acc, Temp, EDA, HR και SpO2.
#' Για να αντιμετωπιστεί η μη αντιστοιχία τιμών των δύο αρχείων, λόγω διαφορετικού 
#' ρυθμού δειγματοληψίας,επαναλαμβάνονται οι ιδιες τιμές των HR και SpO2 για τις 
#' αντίστοιχες χρονικές στιγμές των Acc, Temp και EDA.
#' Η συνάρτηση επιστρέφει λίστα με dataframes των features κάθε ατόμου.
#' 
LoadDataset <- function() {
    
    if(!dir.exists("HealthySubjectsBiosignalsDataSet"))
        unzip("HealthySubjectsBiosignalsDataSet.zip")
    setwd("HealthySubjectsBiosignalsDataSet")
    
    folder <-list.dirs(full.names = FALSE)
    folder<-folder[-1]
    
    SubjectList<-vector("list")
    
    counter = 1;
    
    for (x in folder)
    {
        setwd(x)
        files<-list.files()
        subject_A<-read.csv(files[1])
        subject_B<-read.csv(files[2])   
        
        df <- data.frame(HeartRate=numeric(), SpO2=numeric())
        
        i = 1;
        for (j in 1:nrow(subject_B)) {
            while ( i <=nrow(subject_A))
            {
                if ( (subject_A[i,"Hour"] == subject_B[j,"Hour"]) && (subject_A[i,"Minute"] == subject_B[j,"Minute"]) && (as.integer(subject_A[i,"Second"])==subject_B[j,"Second"]))
                {
                    df[i,"HeartRate"]<-subject_B[j,"HeartRate"]
                    df[i,"SpO2"]<-subject_B[j,"SpO2"]
                    i <- i + 1
                }
                else
                    break           
            }
        }
        #assign (x, cbind(subject_A,df))
        SubjectList[[counter]]<-cbind(subject_A,df)
        counter = counter + 1
        rm(df)
        rm(subject_A)
        rm(subject_B)
        
        setwd("..")
        
        
    }
    names(SubjectList)<-folder
    setwd("..")
    return(SubjectList)
}