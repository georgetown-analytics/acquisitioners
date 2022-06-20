# acquisitioners
Cohort 26 Capstone Project for the Certificate of Data Science at Georgetown University School of Continuing Studies.

## Abstract
The Federal Government acknowledges the value of advanced analytics like machine learning and has a dedicated Data Science team to further capabilities for contract analysis. However, historical procurement data reporting is poor, data availability is limited, and not much groundwork has been completed.  Therefore, the Acquisitioners team decided to run clustering models on government contract data to surface meaningful trends, patterns and/or segmentation within the existing historical record. The resulting models found clearly identifiable market segments that will be valuable to business development teams and strategic decision-makers in the product development offices.

![alt text](https://github.com/georgetown-analytics/acquisitioners/blob/46f6efd98b2d3640c0eb541d00395802e309f387/images/Pipeline.png)

## Data Source

The team accessed data generally available from [sam.gov](https://sam.gov/content/contract-data) with some enrichments created by Federal Employees.

## Data Storage

Raw data was stored in an AWS RDS Postgres database.

## EDA and Wrangling

Data set contained a single continuous variable.  One-hot encoding was created using Pandas get_dummies and case statements in SQL.

## Models
The overall goal of the project was to test several different clustering algorithms.  The best performers over continuous data was KMeans and TSNE for text.

![alt text](https://github.com/georgetown-analytics/acquisitioners/blob/fcaa319120518f02faa8b5fad6df963f0e8b5050/images/ClusteringModels.png)

## Conclusion

### Hypothesis

#### The unsupervised learning models were able to clearly identify spending trends and market segments in FAS-ITC’s federal contracting activity.

### Lessons learned

#### Clustering is useful when attempting to understand chaotic data.
#### Be prepared to wrangle.

## Next Steps

### Deeper analyses of interesting clusters for business development.
### Selecting product or customer sectors to run supervised learning on for deeper tagging or product recommendation.
