# Data Catalog for Gold Layer

## Overview
The Gold Layer is the business-level data representation, structured to support analytical and reporting use cases. It consists of **dimension views** and **fact view** for specific business metrics.

---

### 1. **gold.dim_reviewer**
- **purpose:** Store taster details data.

| Column Name           | Data Type     | Description                                             |
|-----------------------|---------------|---------------------------------------------------------|
| reviewer_id           | INT           | Surrogate key uniquely identifying each taster record   |
| taster_name           | VARCHAR(255)  | The taster's name                                       |
| taster_twitter_handle | VARCHAR(255)  | The taster's twitter name                               |

---

### 2. **gold.dim_production_src**
- **purpose:** Stores geographical production information of wine.

| Column Name           | Data Type     | Description                                             |
|-----------------------|---------------|---------------------------------------------------------|
| prod_source_id        | INT           | Surrogate key for production location                   |
| country               | VARCHAR(255)  | Country of wine production                              |
| province              | VARCHAR(255)  | Province or state                                       |
| region_1              | VARCHAR(255)  | Primary wine region                                     |
| region_2              | VARCHAR(255)  | Secondary wine region                                   |

---

### 3. **gold.dim_wine_info**
- **purpose:** Stores wine product information.

| Column Name           | Data Type     | Description                                             |
|-----------------------|---------------|---------------------------------------------------------|
| wine_id               | INT           | Surrogate key identifying a wine                        |
| designation           | VARCHAR(255)  | Wine designaiton                                        |
| title                 | VARCHAR(255)  | Wine title                                              |
| variety               | VARCHAR(255)  | Grape variety                                           |
| winery                | VARCHAR(255)  | Winery name                                             |

---

### 4. **gold.dim_review**
- **purpose:** Stores textual review content.

| Column Name           | Data Type     | Description                                             |
|-----------------------|---------------|---------------------------------------------------------|
| review_txt_id         | INT           | Surrogate key identifying review text                   |
| description           | VARCHAR(1000) | Full textual wine review                                |

---

### 5. **gold.fact_review**
- **purpose:** Represents wine review events, combining wine, reviewer, location, and review text with measurable attributes.

| Column Name           | Data Type     | Description                                             |
|-----------------------|---------------|---------------------------------------------------------|
| reviews_id            | INT           | Primary key identifying the review event                |
| prod_source_id        | INT           | Foreign key to dim_production_src                       |
| review_txt_id         | INT           | Foreign key to dim_review                               |
| wine_id               | INT           | Foreign key to dim_wine_info                            |
| reviewer_id           | INT           | Foreign key to dim_reviewer                             |
| points                | INT           | Wine rating score                                       |
| price                 | INT           | Price of the wine                                       |
