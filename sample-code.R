library(ggplot2)
library(gridExtra)
source("LoadDataset.R")
source("MergeTime.R")
SubjectList<-LoadDataset()
SubjectList<-lapply(SubjectList, MergeTime)
n <- min(vapply(SubjectList, nrow, 0))
SubjectList<-lapply(SubjectList,head,n)

S1<-SubjectList$Subject1

breaks.major <- c(1200,3713,6226,9044,11861,14502,17059)
breaks.minor <- c(2401,5026,7427,10661,13062,15943,18175)
labels.minor <- c("Relax","Physical \nStress","Relax","Cognitive \nStress","Relax","Emotional \nStress","Relax")

plot1<-ggplot(S1, aes(x=as.numeric(row.names(S1)), y=HeartRate)) + geom_line(color="Blue") + scale_x_continuous(breaks = breaks.major, minor_breaks = breaks.minor, labels = labels.minor) + labs(x='Time') + theme(panel.grid.major.x = element_blank()) + theme(panel.grid.major.y = element_blank()) + theme(axis.ticks.x=element_blank()) +   theme(axis.title.x = element_blank())

plot2<-ggplot(S1, aes(x=as.numeric(row.names(S1)), y=SpO2)) + geom_line(color="Red") + scale_x_continuous(breaks = breaks.major, minor_breaks = breaks.minor, labels = labels.minor) + labs(x='Time') + theme(panel.grid.major.x = element_blank()) + theme(panel.grid.major.y = element_blank()) + theme(axis.ticks.x=element_blank()) +   theme(axis.title.x = element_blank())

plot3<-ggplot(S1, aes(x=as.numeric(row.names(S1)), y=AccX)) + geom_line(color="Green") + scale_x_continuous(breaks = breaks.major, minor_breaks = breaks.minor, labels = labels.minor) + labs(x='Time') + theme(panel.grid.major.x = element_blank()) + theme(panel.grid.major.y = element_blank()) + theme(axis.ticks.x=element_blank()) +   theme(axis.title.x = element_blank())

plot4<-ggplot(S1, aes(x=as.numeric(row.names(S1)), y=AccY)) + geom_line(color="Brown") + scale_x_continuous(breaks = breaks.major, minor_breaks = breaks.minor, labels = labels.minor) + labs(x='Time') + theme(panel.grid.major.x = element_blank()) + theme(panel.grid.major.y = element_blank()) + theme(axis.ticks.x=element_blank()) +   theme(axis.title.x = element_blank())

plot5<-ggplot(S1, aes(x=as.numeric(row.names(S1)), y=AccZ)) + geom_line(color="Magenta") + scale_x_continuous(breaks = breaks.major, minor_breaks = breaks.minor, labels = labels.minor) + labs(x='Time') + theme(panel.grid.major.x = element_blank()) + theme(panel.grid.major.y = element_blank()) + theme(axis.ticks.x=element_blank()) +   theme(axis.title.x = element_blank())

plot6<-ggplot(S1, aes(x=as.numeric(row.names(S1)), y=Temp)) + geom_line(color="Black") + scale_x_continuous(breaks = breaks.major, minor_breaks = breaks.minor, labels = labels.minor) + labs(x='Time') + theme(panel.grid.major.x = element_blank()) + theme(panel.grid.major.y = element_blank()) + theme(axis.ticks.x=element_blank()) +   theme(axis.title.x = element_blank())

plot7<-ggplot(S1, aes(x=as.numeric(row.names(S1)), y=EDA)) + geom_line(color="Blue") + scale_x_continuous(breaks = breaks.major, minor_breaks = breaks.minor, labels = labels.minor) + labs(x='Time') + theme(panel.grid.major.x = element_blank()) + theme(panel.grid.major.y = element_blank()) + theme(axis.ticks.x=element_blank()) +   theme(axis.title.x = element_blank())

grid.arrange(plot1, plot2, plot3, plot4, plot5, plot6, plot7, nrow=7)
