#' LoadDataset
#'
#' The function decompresses the dataset file "HealthySubjectsBiosignalsDataSet.zip".
#' It then enters each person's data into temporary data frames, 
#  and merges them to create a dataframe for each person ("Subject1", "Subject2", etc.),
#' which contains all the data, ie the Acc, Temp, EDA, HR and SpO2.
#' To deal with the mismatch of the values of the two files,
#  due to different sampling rate, 
#  the same values of HR and SpO2 are repeated for the respective moments of Acc, Temp and EDA.
#' The function returns a list of dataframes of each person's features.
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
