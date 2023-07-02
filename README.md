# SAS Case Study: Weight Loss Analysis
[![GitHub](https://badgen.net/badge/icon/GitHub?icon=github&color=black&label)](https://github.com/MaxineXiong)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform - SAS 9.4](https://img.shields.io/badge/Platform-SAS_9.4-0766d1)](https://documentation.sas.com/doc/en/pgmsascdc/9.4_3.5/whatsnew/p07ec8vqwrr6i9n1ptnai8ui5ebo.htm)

<br>

## Case Study Descriptions

### **Objective**

Generating simple cross-tab in `PROC FREQ` to exam possible trend of weight loss (in lb) in response to daily walking steps.

### **Data**

**Weight_loss.xlsx**: contains 19 participants/observations.

### Variables

- **Pid**: participant id.
- **Gender**: participant gender.
- **Weight0**: weight at the beginning of the program.
- **Weight1**: weight at the end of 1st month of the program.	
- **Weight2**: weight at the end of 2nd month of the program.
- **walk_steps**: walking steps daily.

### **Steps**

- Import Excel data file into SAS, create SAS data set named as **WL0**.
- Data management:
   1. Check Data using `PROC MEANS` and `PROC FREQ`. Create a new data set **WL1** using a data step program including the following steps: step (i) and (ii).
   2. Clean data: change value ‘9999’ to missing using Array statement.
   3. Create weight difference variables:
     ```
      wd1 = weight0 - weight1;
      wd2 = weight0 - weight2;
      wd12 = weight1 - weight2;
     ```
   4. Using `PROC MEANS` and `PROC FREQ`, check weight difference variables (only pick **wd2** for this project, you may use others for practice) and **walk_steps** var for making groups from these var. Create a new data set **WL2** using a data step program including the following steps: step (v) and (vi).
   5. Create groups for **walk_steps**: create new var **ws_group**.
      The new group var should have 3 categories:
        - “less than 5000”
        - “5000-10000”
        - “greater than 10000”
   6. Create groups for wd2: create new var wd2_group
      The new group var should have 3 categories:
         - “not losing weight”
         - “losing <= 5 lb”
         - “losing > 5 lb”
- Create permanent data set from data set **WL2**: **projectd.weight_loss**.
- Create cross-tab using `PROC FREQ` for walk steps' groups (**ws_group**) and weight loss groups (**wd_group**) to exam the possible trend.

<br>

## **Repository Structure**

This repository is structured as follows:

```
Weight-Loss-Analysis
├── Weight_Loss_Analysis.sas
├── Weight_loss.xlsx
├── README.md
└── LICENSE
```

- **Weight_Loss_Analysis.sas**: This SAS program file addresses all requirements in the weight loss analysis case study. It is the main file for conducting the data preparation and analysis based on the provided dataset.
- **Weight_loss.xlsx**: This Excel file contains the raw dataset that is imported and utilized in the SAS program for the weight loss analysis.
- **README.md**: This file provides an overview of the repository, including descriptions of the case study and relevant information for usage.
- **LICENSE**: The license file for the project.

Please note that the **Weight_Loss_Analysis.sas** program should be used as the primary entry point for conducting the weight loss analysis, and the **Weight_loss.xlsx** dataset serves as the input data for the analysis.

<br>

## Prerequisites

To run the TSA Claims Data Analysis program, you need an active account for either [**SAS® OnDemand for Academics**](https://welcome.oda.sas.com/) or **[SAS® Viya](https://www.sas.com/en_au/software/viya.html)**. These platforms provide the necessary environment for executing SAS programs and analysing the data.

<br>

## **Usage**

Follow the steps below to use the Weight Loss Analysis program:

1. Download this repository to your local machine.
2. Start **SAS Studio** from your SAS software.
3. Within SAS Studio, create a new folder named **data** to store the dataset.
4. Select the **data** folder and click on the **Upload** button.
5. In the Upload File window, click **Choose Files** and browse to locate the **Weight_loss.xlsx** file on your computer. Select the file and click **Open**. Click **Upload**. The **Weight_loss.xlsx** file is added to the **data** folder on the SAS server. You should now have the dataset ready for use in the **Weight_Loss_Analysis.sas** program.

By following these steps, you can ensure that the necessary dataset is available for the Weight Loss Analysis program to run successfully.

<br>

## **License**

This project is licensed under the **[MIT License](https://choosealicense.com/licenses/mit/)**.
