#matched_data : data.frame crée par matchit
#df_nomiss : data.frame donné à matchit (sans données manquantes)


summary(matched_data)
mdf <- data.frame(df_nomiss)
head(mdf)
matches <- data.frame(matched_data$match.matrix) #only gives matches for treated patients.
dim(matches)
head(matches)
colnames(matches) <- "matched_unit"
matches$matched_unit<- as.numeric(as.character(matches$matched_unit))
matches$treated_unit <- as.numeric(rownames(matches))
matches_noNA <- matches[!is.na(matches$matched_unit),]
matches_noNA$pairID <- 1:nrow(matches_noNA)
colnames(matches_noNA)[3] <- "pairID"
head(matches_noNA)
head(matched_data$match.matrix)

mdf[matches_noNA$matched_unit, "pairID"] <- matches_noNA$pairID
mdf[matches_noNA$treated_unit, "pairID"] <-matches_noNA$pairID
head(mdf)

mdf[!is.na(mdf$pairID) & mdf$pairID==1,]
mdf[!is.na(mdf$pairID) & mdf$pairID==2,]
mdf[!is.na(mdf$pairID) & mdf$pairID==3,]
mdf[!is.na(mdf$pairID) & mdf$pairID==4,]
mdf[!is.na(mdf$pairID) & mdf$pairID==5,]
#View(mdf %>% arrange(pairID)) #It looks like it works.
