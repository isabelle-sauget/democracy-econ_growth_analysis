
library(psych)
setwd("D:/LICENTA/ANALYSIS")
date<-read.csv("FA.csv",header=TRUE, sep=",", row.names = 2) 
View(date)
X<-date[,3:32]
R<-cor(X)
R
set.seed(9999)
nr_obs<-dim(X)[1]
KMO(R)
cortest.bartlett(R, n=nr_obs)
XS<-scale(X)
#verificam numarul de factori recomandat in urma simularilor efectuate de parallel()
png("parallel.png", width=2400, height=2400, res=300)
paralel<- fa.parallel(X, fa="fa", main="Scree Plot al Analizei Paralele")
dev.off()
paralel$nfact
# 3 factori
windows()
#scree(X, factors = TRUE, pc = FALSE, main = "Scree Plot V-Dem", hline = 1)

# Estimarea Maximum Likelihood -------------------------------------------

#pachet built-in R
#fara rotatie
af1<-factanal(XS, factors = 3, scores = "regression",
              rotation = "none")
af1
#pachetul psych
af2<- fa(R, nfactors = 3, n.obs = nr_obs,
         rotate = "none", fm="ml")
View(af2)
windows()
fa.diagram(af4, cut=0.3)
#46% 12% 5%
#cu rotatie
af2_varimax<- fa(R, nfactors=3, n.obs= nr_obs, rotate="varimax", fm="ml")
af2_varimax
#33% 19% 12%
View(af2_varimax)
windows()
fa.diagram(af2_varimax)
#ptr a afla scorurile (coord tarilor)
af2_varimax_X<- fa(X, nfactors=3, n.obs= nr_obs, rotate="varimax", fm="ml")
View(af2_varimax_X)

# Estimarea PCA ----------------------------------------------------------

#fara rotatie
af_pca<- fa(R, nfactors=3, n_obs= nr_obs, rotate= "none", fm="pa")
af_pca
#proportion of variance explained by factors:
#47% 12% 5%
#cu rotatite
af_pca_varimax<- fa(R, nfactors=3, n_obs= nr_obs, rotate= "varimax", fm="pa")
af_pca_varimax
#34% 18% 12%
#comparatie PCA-uri
windows()
par(mfrow = c(2,1))
fa.diagram(af_pca)
fa.diagram(af_pca_varimax)
#comparatie MLE cu PCA, varimax aplicat
windows()
par(mfrow = c(2,1))
fa.diagram(af2_varimax)
fa.diagram(af_pca_varimax)
#aceleasi rezultate

# Extragere coordonate tari pentru analiza cluster ------------------------

coordonate<-as.data.frame(af2_varimax_X$scores)
write.csv(coordonate, file = "coordonate_tari.csv", row.names = TRUE)

# Grafice -----------------------------------------------------------------

fa.diagram(af_pca_varimax, 
           simple = TRUE, #legaturile puternice
           main = "Diagrama componentelor factorilor democrației")

		library(ggplot2)
library(ggrepel)
install.packages("showtext")
library(showtext)
library(showtext)
font_add_google(name = "Tinos", family = "Liberation Serif")

scoruri <- as.data.frame(af2_varimax_X$scores)
scoruri$Tara <- rownames(scoruri)
colnames(scoruri)[1:3] <- c("Factor1", "Factor2", "Factor3")
showtext_auto()
showtext_opts(dpi = 300)
grafic <- ggplot(data = scoruri, aes(x = Factor1, y = Factor2, label = Tara)) +
  geom_hline(yintercept = 0, color = "gray50", linetype = "dashed", linewidth = 0.7) + 
  geom_vline(xintercept = 0, color = "gray50", linetype = "dashed", linewidth = 0.7) + 
  geom_point(aes(color = Factor3), size = 4, alpha = 0.75) + 
  scale_color_gradient2(low = "#FF007F",         
                        mid = "#FFD580",         
                        high = "#00DD00",   
                        midpoint = 0, 
                        name = "Factorul 3\n(Coeziunea Socială)") +
  geom_text_repel(size = 4.5,                  
                  family = "Liberation Serif",
                  box.padding = 0.4, 
                  point.padding = 0.2,
                  force = 2,                 
                  segment.color = "grey60",  
                  segment.size = 0.4,
                  max.overlaps = 100) +
    scale_x_continuous(breaks = seq(-3, 3, 1), limits = c(-3.5, 2.5)) +
    scale_y_continuous(breaks = seq(-3, 3, 1), limits = c(-3.5, 2.5)) +
  theme_minimal() +
  theme(
    panel.grid.major = element_line(color = "gray95"), 
    panel.grid.minor = element_blank(),
    plot.title = element_text(family = "Liberation Serif", size = 24, hjust = 0.5, margin = margin(b = 15)),
    axis.title = element_text(family = "Liberation Serif", size = 18, color = "#333333"),
    axis.text = element_text(family = "Liberation Serif", size = 14),
    legend.title = element_text(family = "Liberation Serif", size = 16),
    legend.text = element_text(family = "Liberation Serif", size = 14),
    legend.position = "right"
  ) +
  labs(
    title = "Țările vizualizate în funcție de cei 3 factori ai democrației",
    x = "Factorul 1 (Libertatea de Exprimare)",
    y = "Factorul 2 (Integritatea și Imparțialitatea Aparatului de Stat)"
  )
ggsave(filename = "harta3.png", 
       plot = grafic, 
       width = 16,        
       height = 10,       
       dpi = 300,         
       bg = "white")
showtext_auto(FALSE)
