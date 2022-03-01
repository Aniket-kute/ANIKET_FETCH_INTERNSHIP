# ANIKET_FETCH_INTERNSHIP
Following were the steps that I used to complete the assessment 
1. First I analyzed the users.json data in jupyter to find for missing values and duplicate values. I cleaned the data in this .pynb file
2. I visualized the tree structure of all the JSON files using JSON FORMATTER (https://jsonformatter.org/) to get an idea about how the tree structure of the file looks like. This helped me to identify nested JSON file present in the receipts.json file
To create a structured relational diagram I listed down all the tables and I found that since the receipts.json had a lot of attributes I decided to make a new table rewardsreceiptsitemlist.json .Thereon, I made a realtional structure using these tables in MySQl Workbench.
To parse the receipts.json file into two separate tables I parsed the tables using SQL server. Following was the code for parsing in the code rewardreceipt_query

The table generated will be exported and then imported as a csv file in MySql. After creating the relational schema and populating all the tables, we run the queries from step 2
