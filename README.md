# Interactions on Twitter

## Description
* To hypothesize potential trends across the datasets and programatically prove or disprove that hypothesis in order to find graph properties and the most influential node in the graph.


## Dataset Used
* https://www.kaggle.com/c/predict-who-is-more-influential-in-a-social-network/data


## Results

* Number of nodes: 1172
* Number of edges: 5107
* Clustering coefficient: 0.1535
* Graph density: 0.0074
* Average degree: 8.715

## Evaluating hypothesis 
* The ratio of (number of followers of A)/(number of people followed by A) could be indicative in calculating influence
There were 3866 matches out of 5500 i.e. 70.29% match giving a p-value of 0.9907 indicating that the two are homogeneous and hence we cannot reject the null hypothesis i.e The ratio of (number of followers of A)/(number of people followed by A) could be indicative in calculating influence
* The listed count shows a higher correlation with the influence.
There were 4178 matches out of 5500 i.e. 75.9% match giving a p-value of 0.9957 indicating that two are homogenous and hence we cannot reject the null hypothesis and hence we cannot reject the null hypothesis i.e. The listed count shows a higher correlation with the influence.
* Most influential node can be judged by the betweenness i.e. maximum number of shortest paths go through this node. Higher the betweenness, more influential node is. In this case maximum betweenness was 19029.29 of node with user ID 253 (User ID is a self-defined entity for each node)


