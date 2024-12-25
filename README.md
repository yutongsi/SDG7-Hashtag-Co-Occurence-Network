# SDG7-Hashtag-Co-Occurrence-Network

This repository contains code and resources for analyzing the co-occurrence network of #sdg7 (Sustainable Development Goal 7). The repository contains three main components, each associated with a specific script:

### Contents

1. **Tweet Extraction (P.1)**  
   - This script extracts tweets containing the hashtag "#sdg7" published between January 1, 2022, and July 1, 2022.  
   - The data was collected when the Twitter API was freely accessible.

2. **Adjacency List Creation (P.2)**  
   - This script processes the extracted tweet data from a CSV file to generate an adjacency list for network analysis. It also includes the necessary steps for excluding error data.
   - The adjacency list is essential for identifying co-occurrence relationships between hashtags.

3. **Network Analysis (P.3)**  
   - This R script performs network analysis.
   - Outputs include key network metrics and visualizations.

### How to Use

**Prerequisites:**  
   - Ensure you have access to the required programming environments (e.g., Jupyter Notebook for P.1 and P.2, R for P.3).  
   - Install the necessary dependencies (e.g., Tweepy, igraph).


### Notes

- This project uses data collected under Twitter's free API policy as of mid-2022. Access to similar data may now require paid API access.
- The analysis focuses on understanding SDG7 discourse on social media.

### License  
Feel free to adapt or expand upon this work for academic or research purposes. Proper attribution is appreciated.

---

For questions or further details, please reach out.
