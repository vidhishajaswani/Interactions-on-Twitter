mydata=read.csv("C:/Users/Vidhisha/Desktop/fine.csv")
mydata$RowID <- seq.int(nrow(mydata))

#seperate A and B
A_details=mydata[,c(2:12,24)]
B_details=mydata[,c(13:24)]

#rename columns to merge
names(A_details) <- c("Followers","Following","Listed Count","Mentions Received","Retweets Received",
                      "Mentions Sent","Retweets Sent","Posts","Network Features 1", "Network Features 2", "Network Features 3","RowID")
names(B_details) <- c("Followers","Following","Listed Count","Mentions Received","Retweets Received",
                      "Mentions Sent","Retweets Sent","Posts","Network Features 1", "Network Features 2", "Network Features 3","RowID")
All_node=rbind(A_details,B_details)

#remove id from data
All_node = All_node[-c(12)]

#number of nodes
nodes=unique( All_node )
nrow(unique( All_node )) 
nodes$UserID <- seq.int(nrow(nodes))
nodes <- nodes[,c(12,1:11)]

#number of edges
nrow(unique( mydata[-c(1,24)] ))  #changes later

#lookup user id of a and b in nodes
A <-merge(A_details,nodes)
B <-merge(B_details,nodes)

A <- A[with(A, order(RowID)), ]
B <- B[with(B, order(RowID)), ]

#create edges
edges <- data.frame(A[,13],B[,13])

#create graph
net=graph_from_data_frame(edges, directed = F, nodes)
net <- simplify(net, remove.multiple = TRUE, remove.loops = TRUE)
ecount(net)
plot(net,edge.arrow.size=4,vertex.label=NA,color="Blue",size=0.22)

#clustering coefficient
t1 <- transitivity(net, type="global")

#graph density
graph.density(net,loop=TRUE)

#average degree
mean(degree(net))

#Hypothesis 1: The ratio of (number of followers of A)/(number of people followed by A) could be indicative in calculating influence.
mydata[,"A_ratio"]<-ifelse(mydata[,"A_following_count"]==0, mydata[,"A_follower_count"], mydata[,"A_follower_count"]/mydata[,"A_following_count"])
mydata[,"B_ratio"]<-ifelse(mydata[,"B_following_count"]==0, mydata[,"B_follower_count"], mydata[,"B_follower_count"]/mydata[,"B_following_count"])
mydata[,"My_Choice_hyp1"]<-ifelse(mydata[,"A_ratio"] > mydata[,"B_ratio"], 1, 0)
sum(mydata[,"My_Choice_hyp1"]==mydata[,"Choice"],na.rm=T)
var.test(mydata[,"My_Choice_hyp1"],mydata[,"Choice"])


#Hypothesis 2: The listed count shows a high correlation with the influence.
mydata[,"My_Choice_hyp2"]<-ifelse(mydata[,"A_listed_count"] > mydata[,"B_listed_count"], 1, 0)
sum(mydata[,"My_Choice_hyp2"]==mydata[,"Choice"],na.rm=T)
var.test(mydata[,"My_Choice_hyp2"],mydata[,"Choice"])


#Most influential node
nodes[,"Betweenness"] <- data.frame(betweenness(net,directed = F ))
max(nodes[,"Betweenness"]) #node with user id 253 is most influential




