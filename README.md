# Job Mobility in Germany’s Segmented Labour Market

**Topic:**  
Transitions from part-time employment to standard employment or inactivity in Germany.  
This project investigates how different aspects of **job quality** affect these transitions, using data from the **German Socio-Economic Panel (GSOEP)** between 2003 and 2017.

---

## Background

Over the last decades, Germany’s labour market has become increasingly **segmented**, with a growing share of atypical employment such as part-time work.  
In particular, *marginal part-time employment* (so-called *mini-jobs*) is concentrated in the low-pay sector and raises questions about long-term labour market integration.

This project explores how **job quality indicators** — such as further training, skill match, wage level, and contract duration — influence transitions from regular and marginal part-time work into full-time employment or inactivity.

---

## Research Design & Methodology

**Data Source:**  
German Socio-Economic Panel (SOEP), 2003–2017  

**Methods Applied:**  
- Descriptive analysis of employment transitions  
- Product-limit (Kaplan–Meier) estimator to measure survival time in part-time employment  
- Exponential transition rate model to estimate effects of job quality on transition probabilities 

**Key Variables:**  
- Training participation  
- Skill match  
- Hourly wage  
- Contract duration  
- Transition outcome: full-time work vs. inactivity  

---

## Key Findings

- **Job quality** increases the probability of transitioning to full-time employment, but the effects differ between regular and marginal part-time workers.  
- **Further training** has a significant positive effect for both groups.  
- **Marginal part-time employment** tends to keep workers in the *outsider segment* of the labour market, limiting mobility.  
- The results highlight the persistent duality of Germany’s labour market.

---

## Tools & Techniques

- **Software:** Stata  
- **Methods:** Survival analysis, regression modeling, data cleaning and restructuring  
- **Data Handling:** Longitudinal panel data (person-year observations)  

---

## Potential Extensions

- Reproducing the analysis in Python or R using `lifelines` (survival analysis) or `statsmodels`.  
- Visualizing transition probabilities with interactive dashboards.  
- Adding gender or sector-level analysis for deeper insights.

---

*Originally submitted as Master’s Thesis (M.Res. Sociology & Demography, University of Bamberg & Universitat Pompeu Fabra, 2019).*
