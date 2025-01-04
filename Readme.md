# Airline Data Optimization Project

## Project Overview

In this project, I take on the role of a consultant working for an airline carrier. My primary objective is to optimize the process of data retrieval and analysis. The project involves implementing a reporting and analytical system to streamline data delivery and reduce manual effort, enabling faster decision-making for the client.

The data used in this project is sourced from Kaggle, with a detailed description of its origins and the inspiration behind its generation. Due to its large volume (over 9 million rows), I reduced the dataset to facilitate easier handling and analysis.

---

## Business Context

Previously, the airline carrier relied on a manual process to retrieve data from an external application with limitations, such as row export limits. This led to inefficiencies in processing and analyzing the data, requiring significant employee involvement and causing delays in delivering insights and making critical decisions. 

Recently, the client gained access to a dedicated API for data retrieval. They tasked me with developing a solution to:

1. Automate data retrieval from the API.
2. Create a database for reporting and analytical purposes.
3. Load the retrieved data into the database.
4. Perform exploratory data analysis (EDA) on the dataset.
5. Generate an operational report.

The solution is expected to enable the client to quickly access reports on flight delays, analyze their causes, and propose preventive measures.

---

## Analytical Context

This project serves as a comprehensive exercise in data analysis, encompassing key elements from the Data Analyst course, such as data retrieval, database creation, data analysis, and visualization. Each step corresponds to specific roles and responsibilities in the data domain:

- **Data Engineer:** Responsible for retrieving data from the API, processing CSV files, and loading data into the database.
- **Data Analyst:** Focused on analyzing the dataset using Python and relevant libraries.
- **BI Developer:** Creates reports and visualizations using tools such as Pandas, Seaborn, Plotly, and Tableau.

---

## Project Structure

To facilitate the project, I divided the work into smaller, manageable notebooks that address specific tasks. 

```plaintext
project             <-- Root folder for the project
|____ data          <-- Folder containing data
|   |__ raw         <-- Folder for raw data (API-sourced)
|   |__ processed   <-- Folder for processed data
|   |___readme.txt  <-- Business and technical documentation of API data
|
|____ notebooks    <-- Folder for Jupyter notebooks (*.ipynb)

```


