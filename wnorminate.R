# 1. Install the package (only need to install it once).
install.packages("wnominate")

# 2. Load the library.
library(wnominate)


# 2. Load the csv data and convert it to Matrix format.
# 'UN' is a Test Data Set. (csv form)
# This data is UN voting data.
# 1) The first column is the name of the country.
# 2) The second column shows if the country belongs to a particular group.
# 3) From the third to the last column shows the voting results for each country in question.
# Voting results are favorable (1, 2, 3), opposing (4, 5, 6), abstention (7, 8, 9), missing (0).
# This maps from our data as follows:
# 1) Name of Lawmaker
# 2) Party
# 3) Voting for the applicable policy of the member of parliament
data(UN) 
UN<-as.matrix(UN) 
UN[1:5,1:6]  


# 4. Remove additional information except voting information.
# The wnominate Only voting data is required to obtain a value.
# Remove unnecessary Colunm.
# However, It will be needed to use it again later. Therefore, save it in another variable.
UNnames<-UN[,1] # Name of countries (or lawmakers) (index 1).
legData<-matrix(UN[,2],length(UN[,2]),1) # Party (index 2).
colnames(legData)<-"party" 
UN<-UN[,-c(1,2)]
show(UN)


# 5. Map voting information.
# In the test data, there is a Yea (1,2,3), the Nay (4,5,6), abstention (7,8,9), and a missing (0).
rc <- rollcall(UN, yea=c(1,2,3), nay=c(4,5,6), missing=c(7,8,9),notInLegis=0, 
               legis.names=UNnames, legis.data=legData, desc="UN Votes")


# 6. Calculate wnominate.
result<-wnominate(rc,polarity=c(1,1))
summary(result)
plot(result)

result$legislators[c('coord1D','coord2D')]
