# CryptoStream Analytics Pipeline

## Overview
This repository contains the complete codebase for building a cryptocurrency analytics pipeline. The system integrates CoinAPI.io, Snowflake, dbt, Apache Airflow, and Apache Superset, all running in a Dockerized environment. The pipeline enables seamless ETL (Extract, Transform, Load) and ELT (Extract, Load, Transform) processes to extract cryptocurrency data, perform advanced transformations, and visualize insights for decision-making.

---

## Architecture

The pipeline is designed as follows:
1. **Data Source**: 
   - **CoinAPI.io**: Serves as the data provider, offering cryptocurrency market data via API.

2. **ETL Process**:
   - Managed by **Apache Airflow**.
   - Extracts, transforms, and loads raw cryptocurrency data into **Snowflake**.

3. **ELT Process**:
   - Powered by **dbt** (Data Build Tool).
   - Transforms staged data in Snowflake, runs models, and outputs analytics-ready tables.

4. **Visualization**:
   - **Apache Superset** visualizes the processed data to provide actionable insights.

5. **Containerization**:
   - Entire pipeline is packaged using **Docker** for consistent and reproducible deployments.

---

## Features
- Automated data ingestion from CoinAPI.io using an API key.
- Scalable ETL and ELT processes with Airflow and dbt.
- Cloud data warehousing using Snowflake.
- Interactive visualizations and dashboards in Apache Superset.
- Fully Dockerized environment for seamless deployment.

---

## Repository Structure
```
├── airflow/                 # Apache Airflow configuration and DAGs
├── dbt/                     # dbt project for data transformations
├── superset/                # Apache Superset dashboards and configs
├── docker-compose.yml       # Docker Compose configuration
├── README.md                # Project documentation
└── requirements.txt         # Python dependencies
```

---

## Getting Started

### Prerequisites
- **Docker** and **Docker Compose** installed on your system.
- A Snowflake account for data warehousing.
- CoinAPI.io API key for data extraction.

### Setup Instructions
1. **Clone the repository**:
   ```bash
   git clone <repo-url>
   cd <repo-directory>
   ```

2. **Set up environment variables**:
   Create an `.env` file in the root directory with the following:
   ```
   COINAPI_KEY=<your_coinapi_key>
   SNOWFLAKE_USER=<your_snowflake_user>
   SNOWFLAKE_PASSWORD=<your_snowflake_password>
   SNOWFLAKE_ACCOUNT=<your_snowflake_account>
   ```

3. **Build and run Docker containers**:
   ```bash
   docker-compose up --build
   ```

4. **Access the services**:
   - **Airflow**: [http://localhost:8080](http://localhost:8080)  
   - **Superset**: [http://localhost:8088](http://localhost:8088)

---

## Workflow

1. **Data Extraction**: Apache Airflow schedules and executes tasks to fetch raw data from CoinAPI.io.
2. **Data Loading**: Transformed data is loaded into Snowflake.
3. **Data Transformation**: dbt models refine the data into analytics-ready tables.
4. **Visualization**: Apache Superset visualizes metrics, trends, and insights.

---

## Contributing
Sadhvi Singh, Varshini Rao
