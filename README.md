# Comparative Analysis of the Relationship Between Democracy and Economic Growth

This repository contains the complete analytical workflow and codebase for my Licentiate Degree thesis. The core objective of this research is to empirically demonstrate the positive correlation between democratic regimes and global economic development. 

In an era marked by a global wave of autocratization and severe political polarization, this project pushes past anti-democratic rhetoric. By analyzing a comprehensive 2024 dataset of **160 countries across 30 democratic indicators**, the research explores the latent dimensions of democracy, clusters nations based on political realities rather than formal constitutional labels, and maps these regime types directly to national income categories.

The database used is the V-Dem (Varieties of Democracy Institute of University of Gothenburg, Sweden) Project 2025 V15 of democratic indicators. For measuring economic development I have used GDP per capita from the World Bank database at Purchasing Power Parity using the 2021 price benchmark in international dollars to account for inflation and exchange rate fluctuations.

## Repository Structure and Tech Stack

The analysis is divided into two main technical pipelines, leveraging the strengths of both Python and R:

### Python (Data Processing & Exploratory Visualization)
* **Data Cleaning & Manipulation:** Scripts to clean, transform, and normalize the raw dataset containing the 30 democratic indicators and economic metrics.
* **Exploratory Data Analysis (EDA):** Code for initial descriptive statistics, distribution mapping, and generating foundational graphs to understand missing values, outliers, and data shapes.

### R (Multivariate Statistical Analysis & Advanced Plotting)
* **Factorial Analysis:** Scripts to extract latent dimensions of democracy governing global political systems.
* **Ward and K-Means Clustering:** Unsupervised machine learning models to group the 160 countries into distinct regime types based on empirical similarities.
* **Correspondence Analysis:** Advanced statistical algorithm to map the geometric association between political regimes and economic performance categories.
* **Statistical Visualizations:** Generation of advanced plots corresponding to the multivariate analyses (for example, spatial factor maps, cluster visualizations).

## Key Findings

The multivariate statistical analysis yielded several critical insights into the state of global politics and economics in 2024:

* **High Global Polarization:** Descriptive analysis confirmed a climate of severe political and social turmoil. Nearly a third of the democratic indicators (particularly regarding institutional quality and checks & balances) showed bimodal distributions, highlighting societies divided into hostile political camps.
* **The Three Pillars of Democracy:** Factor analysis reduced the 30 indicators into three main latent dimensions explaining 64% of the variance: **Freedom of Expression** (33%), **State Apparatus Integrity** (19%), and **Social Cohesion** (12%).
* **Accurate Regime Clustering:** Using K-Means clustering, countries were organically categorized into 4 balanced groups that perfectly align with modern political literature: *Liberal Democracies, Electoral Democracies, Electoral Autocracies,* and *Closed Autocracies*.
* **The Democratic Economic Dividend:** Correspondence analysis revealed a definitive geometric association between democracies and upper-middle to high-income categories. This empirically supports the institutional economic theories championed by the 2024 Nobel Laureates in Economics (Acemoglu, Johnson, and Robinson).
* **The "Autocracy Trap":** 
  * Interestingly, *Electoral Autocracies* are associated with the lowest income levels due to permanent political instability, corruption, and an inability to foster long-term capital investment. 
  * *Closed Autocracies* (like China) associate with lower-middle incomes. While their lack of civil liberties creates a predictable environment for basic macroeconomic stability, their regime architecture—which prevents a truly free market and robust intellectual property protection—inherently caps their growth. In 2024, the average GDP per capita (PPP) of Liberal Democracies ($42,806) remained nearly double that of China ($23,845), proving that the economic ceiling of authoritarianism remains fundamentally lower than that of liberal democracies.

## How to Run the Code

The Google Colab links are included in each of the Python files and the code can be run from there. After running the Python files, the .R files should be run on RStudio (recent version) and the working directory should be changed inside the setwd() command.
