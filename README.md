# Affordable Rental Housing Analysis

## Overview

This paper examines the trend in the number of approved Affordable Rental Housing (ARH) units across different wards in Toronto. We use the Affordable Housing Pipeline data and Ward Census data from the Open Data Toronto portal to look at the correlation between the number of ARH projects approved in a particular ward with its population, unemployment rate, and percentage of low-income residents. These findings highlight how social, economic, and geographical characteristics impact access to affordable housing within the city of Toronto and potentially inform policy-making on equitable housing distribution.

## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from Open Data Toronto.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `other` contains details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.

## Statement on LLM usage

Aspects of the code were written with the help of OpenAI's LLM GPT-4o. I have used the LLM as a tool to assist in understanding errors and building figures in `paper/paper.qmd`.