# DATAWareHouse-car-rental-agency
Car rental agency datawarehouse to analyse the financial factors of the agnecy (the turnover and the number of contracts).

 #The data base Scheam:
 ![shemaDB](https://user-images.githubusercontent.com/72862200/146969506-d314ef6d-ca6d-4a5f-adb5-96947bb68cc6.png)
 #The datamart logical schema:
![mcd_dw](https://user-images.githubusercontent.com/72862200/146969083-777a8e36-b069-497d-b303-eaf36e837aee.PNG)

# GUIDE:
You must have install ocarle G11 (community or entreprise version) that would be better used with SQLDevelopper, create a workspaces,
  
  And then please follow the order of the the files (create_db.sql to create the data base and fill it then using fill_db.sql,
    next use create_dw.sql and fill_dw.sql to create and fill the datamart designed by ROLAP convention,
    After that you could use the created dimensions and materialized vues to accelerate the queries process by executing the scirpts (Views_Dimensionis_queries.sql script).
    Finaly you can query the datamart to analyse the two factor along the different dimensions or do whatever a SQL Analaytics functions you want, you could use the queries.sql to see some practical examples.
    
