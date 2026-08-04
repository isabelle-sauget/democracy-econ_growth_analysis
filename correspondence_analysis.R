setwd("D:/LICENTA/ANALYSIS")
library(FactoMineR)
library(factoextra)
date<-read.csv("FA.csv",header=TRUE, sep=",", row.names = 2) 
View(date)
X<-date[,3:33]
X
cuartile_pib <- quantile(X$GDPPC, probs = c(0, 0.25, 0.5, 0.75, 1))
X$Categorie_PIB <- cut(X$GDPPC, 
                       breaks = cuartile_pib, 
                       include.lowest = TRUE,
                       labels = c("venit inferior", "venit mediu-inferior", "venit mediu-superior", "venit superior"))
scoruri<-read.csv("coordonate_tari.csv", row.names = 1)
set.seed(9999)
KM_4c<- kmeans(scoruri,4, nstart=50)
clustere<-KM_4c$cluster
X$Clustere <- clustere[rownames(X)]
View(X)
# democratii electorale
rownames(X[X$Clustere == 1, ])
# autocratii inchise
rownames(X[X$Clustere == 2, ])
# autocratii electorale
rownames(X[X$Clustere == 3, ])
# democratii liberale
rownames(X[X$Clustere == 4, ])
tabel_ca <- table(X$Clustere, X$Categorie_PIB)
print(tabel_ca)

# Etichetarea regimurilor -------------------------------------------------

X$Regimuri <- factor(X$Clustere, 
                            levels = c(1, 2, 3, 4), 
                            labels = c("democrații electorale", 
                                       "autocrații închise", 
                                       "autocrații electorale", 
                                       "democrații liberale")) 
tabel_ca_final <- table(X$Regimuri, X$Categorie_PIB)
print(tabel_ca_final)
library(openxlsx)
write.xlsx(tabel_ca_final, "CONTINGENTA.xlsx")
rownames(X)[X$Cluster == 2 & X$Categorie_PIB == "venit superior"]
rownames(X)[X$Cluster == 2 & X$Categorie_PIB == "venit mediu-superior"]
rownames(X)[X$Cluster == 2 & X$Categorie_PIB == "venit mediu-inferior"]
rownames(X)[X$Cluster == 2 & X$Categorie_PIB == "venit inferior"]
#venituri superioare
X["RUS", "Categorie_PIB"]
#venituri medii-superioare
X["CHN", "Categorie_PIB"]
#venituri medii-inferioare
X["MEX", "Categorie_PIB"]
X["MDG", "Categorie_PIB"]
X["IRQ", "Categorie_PIB"]
X["IRQ", "Regimuri"]
X["NPL", "Categorie_PIB"]
X["PER", "Categorie_PIB"]
X["KEN", "Categorie_PIB"]
X["PAK", "Categorie_PIB"]
X["CHN", "GDPPC"]
View(X)
medii_pib <- aggregate(GDPPC ~ Regimuri, data = X, FUN = mean)
write.xlsx(medii_pib, "medii_pib.xlsx")

# Grafic ------------------------------------------------------------------

AC <- CA(tabel_ca_final, graph = FALSE)
library(ggplot2)
library(ggrepel)
library(showtext)
randuri <- get_ca_row(AC)$coord
coloane <- get_ca_col(AC)$coord
df_plot <- data.frame(
  Dim1 = c(randuri[, 1], coloane[, 1]),
  Dim2 = c(randuri[, 2], coloane[, 2]),
  Eticheta = c(rownames(randuri), rownames(coloane)),
  Tip = c(rep("Regim (Albastru)", nrow(randuri)), rep("PIB (Roșu)", nrow(coloane)))
)
font_add_google(name = "Tinos", family = "Liberation Serif")
showtext_auto()
showtext_opts(dpi = 300)
grafic <- ggplot(df_plot, aes(x = Dim1, y = Dim2, color = Tip, shape = Tip, label = Eticheta)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "black") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "black") +
  geom_point(size = 2.5) +
  geom_text_repel(family = "Liberation Serif", 
                  size = 5, 
                  box.padding = 0.8, 
                  point.padding = 0.5,
                  force = 10, 
                  max.overlaps = Inf, 
                  seed = 123, 
                  show.legend = FALSE) +
  scale_color_manual(values = c("Regim (Albastru)" = "#0047AB", "PIB (Roșu)" = "#D2042D")) +
  scale_shape_manual(values = c("Regim (Albastru)" = 16, "PIB (Roșu)" = 17)) +
  labs(title = "Analiza corespondențelor - Asocierea dintre regim politic și PIBpc(PPC 2021) pentru anul 2024",
       x = "Dim1 (85%)", 
       y = "Dim2 (9.8%)") +
  theme_minimal(base_family = "Liberation Serif") +
  theme(
    plot.title = element_text(hjust = 0.5, size = 20, face = "plain", margin = margin(b = 15)),
    axis.title = element_text(size = 12, face = "italic"),
    axis.text = element_text(size = 11),
    panel.grid.major = element_line(color = "gray90"),
    panel.grid.minor = element_blank(),
    legend.position = "none" 
  )
print(grafic)
ggsave("biplot_CA.png", plot = grafic, width = 14, height = 9, dpi = 300)
showtext_auto(FALSE)

