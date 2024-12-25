###### Network Analysis SDG7 Project #######

#clear the environment
rm(list = ls())

# set working directory
setwd("~/")

#read the csv file as an adjacency list
hashtag_adjmat <- read.csv("sdg7_adjlist.csv", header = T) # CSV contains data in first row
#hashtag_adjmat[hashtag_adjmat == ""] <- NA 
head(hashtag_adjmat) # Here NAs indicate no data.
class(hashtag_adjmat)

# import libraries that we need
install.packages("reshape2")
library(reshape2) # The reshape2 package has a function called melt that will enable us to reshape this adjacency matrix into an edge list.
library(igraph)

# The melt function reshapes data from "short" to "long" form.
# What this means in our case is that we are going to take each row and turn it 
# into a series of rows.
hashtag_edge_list <- melt(hashtag_adjmat, # a data frame with you adjacency list
                          measure.vars = c("hashtag1", "hashtag2","hashtag3", "hashtag4","hashtag5","hashtag6","hashtag7","hashtag8","hashtag9","hashtag10","hashtag11", "hashtag12","hashtag13", "hashtag14","hashtag15","hashtag16","hashtag17","hashtag18","hashtag19","hashtag20","hashtag21", "hashtag22","hashtag23", "hashtag24","hashtag25","hashtag26","hashtag27","hashtag28","hashtag29","hashtag30","hashtag31"), # include a vector of the names of columns 2 - g
                          value.name = "hashtag", # what your third column will be named
                          variable.name = "order") # what your second column will be named
hashtag_edge_list

# This is starting to resemble an edge list! But there are a couple additional thing we need to do to clean up this data. First,
# let's drop this information in the second column, we don't need this any more.
hashtag_edge_list <- hashtag_edge_list[,-2]
hashtag_edge_list

# Next, we can delete all rows where the hashtag is listed as NA. All this indicates is that the tweet did not include the additional hashtags.
# We can get rid of these NAs with a built-in R function called na.omit. This function will return a new data frame where all NAs
# are excluded.
hashtag_edge_list<- na.omit(hashtag_edge_list)
hashtag_edge_list

# We can turn this edge list into an igraph object.
hashtag_igraph <- graph.data.frame(hashtag_edge_list, directed = FALSE)
hashtag_igraph 

V(hashtag_igraph)$name # nodes' names including articles and authors

V(hashtag_igraph)$type <- V(hashtag_igraph)$name %in% hashtag_edge_list[,1] 
# here the %in% operator goes through every vertex name in our graph object and assigns a value of TRUE if the vertex name is also
# listed in the first column of the original edge list, representing articles. If the vertex name does not appear in that 
# column, then the node is assigned a value of FALSE. So, here authors = False, articles = True

V(hashtag_igraph)$type #The "type" attribute indicates which mode each node belongs to. 

hashtag_igraph

# The bipartite.projection function will take a two-mode
# igraph object and convert it into two one-mode igraph objects.
hashtag_igraph
hashtag_projection <- bipartite.projection(hashtag_igraph, # Your two-mode igraph object
                                           multiplicity = TRUE) # binary is false, otherwise true

#multiplicity	 If TRUE, then igraph keeps the multiplicity of the edges as an edge attribute called ‘weight’. 
#E.g. if there is an A-C-B and also an A-D-B triple in the bipartite graph (but no more X, such that A-X-B is also in the graph), then the multiplicity of the A-B edge in the projection will be 2.
hashtag_projection
#IGRAPH d8ca5a7 UNW- 2769 22667 -- one mode of hashtags
#IGRAPH c2cb2ef UNW- 6059 1852711 -- one mode of tweets

# The bipartite.projection function will create a list that includes 2 igraph objects. Here, our first igraph object is a one-mode projection
# of authors and our second is a one-mode projection of articles. Let's use indexing to pull out these two igraph objects.
hashtag <- hashtag_projection$proj1

hashtag # 

get.edge.attribute(hashtag)

# pull nodes and edge weights
edgeweight <- as.data.frame(get.edge.attribute(hashtag))
write.csv(edgeweight,
          file = "edgeweight.csv")

# Adjacency matrices for the one-mode projections:
hashtag[]
#class(hashtag) #igraph object

###### Preparing for plotting the network using Gephi #######
#save the edge_list to csv. file on your computer in order to plot it in Gephi
??as.edgelist
hashtag_edgelist <- as_edgelist(hashtag, names = TRUE)
write.csv(hashtag_edgelist,
          file = "hashtag_edgelist.csv")

#combine the edgelist and weight by hand in the folder

###### Actor-Level Degree Centrality #######
detach(package:igraph)
install.packages("statnet")
library(statnet)
install.packages("intergraph")

library(intergraph)
hashtag_net <- asNetwork(hashtag)

# Degree centrality counts the number of edges that are connected to each node. It is an actor-level measure that
# will give us the number of nodes adjacent to each focal node.
# In statnet we use the degree function to calculate actor-level degree. In this function, you need to first include
# the name of your network object. Then, this will be followed by a couple arguments. You should always include the 
# gmode argument to specify whether you are working with a directed network ("digraph") or symmetric network ("graph")

degree<-degree(hashtag_net, gmode = "graph")
degree
hashtag_net %v% "degree" <- degree

hashtag_net %v% "degree" 
hashtag_net %v% "vertex.names"
degree<-data.frame(hashtag = hashtag_net %v% "vertex.names",# %v% pulls out vertex data from our network object
           degree = degree)

write.csv(degree,
          file = "degree_unsorted.csv")

hashtag_net
