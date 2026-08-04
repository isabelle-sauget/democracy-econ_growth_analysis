
library(factoextra)
library(FactoMineR)
library(corrplot)
library(cluster)

setwd("D:/LICENTA/ANALYSIS")
scoruri<-read.csv("coordonate_tari.csv", row.names = 1)
View(scoruri)
d<-dist(scoruri, method="euclidean")

#centroid
cluster_centroid<-hclust(d, method="centroid")
windows()
plot(cluster_centroid, main="Metoda Centroid")

#ward
cluster_ward<-hclust(d, method="ward.D2")
windows()
plot(cluster_ward, main="Dendrogramă - Metoda Ward",
     labels = FALSE)
cluster_ward$height
cluster_ward$merge
#taeitura la 2, 3 si 4 clustere
?cutree()
solutie_2c<- cutree(cluster_ward, k=2)
table(solutie_2c)
solutie_3c<- cutree(cluster_ward, k=3)
table(solutie_3c)

solutie_4c<- cutree(cluster_ward, k=4)
table(solutie_4c)
aggregate(scoruri, list(solutie_4c), mean)
windows()
fviz_cluster(list(data=scoruri, cluster=solutie_4c))
aggregate(scoruri, list(solutie_3c), mean)
windows()
fviz_cluster(list(data=scoruri, cluster=solutie_3c))
#silhouette negative nu au fost bine incadrate
s_plot_2c<-silhouette(solutie_2c, d)
windows()
plot(s_plot_2c)
s_plot_3c<-silhouette(solutie_3c, d)
windows()
plot(s_plot_3c)
s_plot_4c<-silhouette(solutie_4c, d)
windows()
plot(s_plot_4c)
windows()
par(mfrow = c(1,3))
plot(s_plot_2c)
plot(s_plot_3c)
plot(s_plot_4c)

# grafic silhouette ward ------------------------------------------------
culori <- c("#8FB2C9",  
                  "#E1B18A",  
                  "#9FB898",  
                  "#C3B1C5")  
windows()
par(mfrow = c(1, 3), oma = c(0, 0, 3, 0))
plot(s_plot_2c, main = "2 clustere", col = culori_calme[1:2], border = NA)
plot(s_plot_3c, main = "3 clustere", col = culori_calme[1:3], border = NA)
plot(s_plot_4c, main = "4 clustere", col = culori_calme[1:4], border = NA)

mtext("Grafice Silhouette pentru 2, 3 și 4 clustere - Metoda Ward", 
      side = 3, outer = TRUE, cex = 1.5, font = 2)
par(mfrow = c(1, 1), oma = c(0, 0, 0, 0))

#clustering ierarhic cu factoextra
solutie_3c_f<-hcut(scoruri, k=3, hc_method = "ward.D2")
windows()
fviz_cluster(solutie_3c_f)
?hcut()

# K-Means -----------------------------------------------------------------

# 2 clustere
KM_2c<- kmeans(scoruri,2)
clase2<-KM_2c$cluster
windows()
fviz_cluster(KM_2c, scoruri, main="K-Means 2 clustere")
sil_KM_2c<- silhouette(clase2, d)
windows()
plot(sil_KM_2c)
# 3 clustere
KM_3c<- kmeans(scoruri,3)
clase3<-KM_3c$cluster
windows()
fviz_cluster(KM_3c, scoruri, main="Clusterizare K-Means 3 clustere")
sil_KM_3c<- silhouette(clase3, d)
windows()
plot(sil_KM_3c)
# 4 clustere
KM_4c<- kmeans(scoruri,4)
clase4<-KM_4c$cluster
windows()
fviz_cluster(KM_4c, scoruri, main="Clusterizare K-Means 4 clustere")
sil_KM_4c<- silhouette(clase4, d)
windows()
plot(sil_KM_4c)
windows()
par(mfrow = c(1,3))
plot(sil_KM_2c)
plot(sil_KM_3c)
plot(sil_KM_4c)

library(ggplot2)
set.seed(9999)
KM_4c <- kmeans(scoruri, 4, nstart = 50)
png("kmeans_9999.png", width = 5000, height = 3000, res = 300)
fviz_cluster(KM_4c, data = scoruri, 
             main = "Clusterizare K-Means (4 clustere)",
             repel = TRUE,        
             labelsize = 10,       
             pointsize = 2,        
             geom = c("point", "text"),
             ggtheme = theme_minimal() 
) +
 
  theme(
    plot.title = element_text(size = 24, face = "bold"),
    axis.title = element_text(size = 18),
    axis.text = element_text(size = 14),
    legend.text = element_text(size = 14),
    legend.title = element_text(size = 16, face = "bold")
  )
dev.off()
set.seed(9999)

KM_3c <- kmeans(scoruri, 3, nstart = 50)
png("kmeans_3clustere_lizibil.png", width = 5000, height = 3000, res = 300)
fviz_cluster(KM_3c, data = scoruri, 
             main = "Clusterizare K-Means (3 clustere)",
             repel = TRUE,          
             labelsize = 10,        
             pointsize = 2,         
             geom = c("point", "text"),
             ggtheme = theme_minimal() 
) +
  theme(
    plot.title = element_text(size = 24, face = "bold"),
    axis.title = element_text(size = 18),
    axis.text = element_text(size = 14),
    legend.text = element_text(size = 14),
    legend.title = element_text(size = 16, face = "bold")
  )
dev.off()

# grafic silhouette kmeans ------------------------------------------------
windows()
par(mfrow = c(1, 3), oma = c(0, 0, 3, 0))
plot(sil_KM_2c, main = "2 clustere", col = culori_calme[1:2], border = NA)
plot(sil_KM_3c, main = "3 clustere", col = culori_calme[1:3], border = NA)
plot(sil_KM_4c, main = "4 clustere", col = culori_calme[1:4], border = NA)
mtext("Grafice Silhouette pentru 2, 3 și 4 clustere - Metoda K-Means", 
      side = 3, outer = TRUE, cex = 1.5, font = 2)
par(mfrow = c(1, 1), oma = c(0, 0, 0, 0))
