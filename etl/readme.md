Store your ETL scripts/ programs here

# dbt
1. Open terminal and change working directory to /etl
```
cd etl
```

2. Activate the venv (Check `environment_<latest venv>.yml`)
```
call "C:\Users\<Your user name>\Anaconda3\Scripts\activate.bat" <latest venv>
```

3. Initialize dbt project <br>
[More info from dbt official website](https://docs.getdbt.com/reference/commands/init)
```
dbt init
```

4. Check your dbt connect from `C:\Users\<your user name>\.dbt\profiles.yml` <br>
!! DO NOT SHARE THIS FILE or COMMIT TO GITHUB <br>
Here is an example: <br>
```yaml
<Your dbt project name>:
  target: dev
  outputs:
    dev:
      type: sqlserver
      driver: 'ODBC Driver 17 for SQL Server'
      server:<Your target server> #e.g. gw6-dev.gateway.net
      database:<Your target DB>   #e.g. ON_Event_Stg 
      schema: dbo
      user: <Your Credientials>
      password: <Your Credientials>
```

5. Copy & Paste the files from `etl/dbt_custom_files` to your dbt project folder
   1. Copy & Paste the followings to `<your dbt prject folder>/dbt_project.yml` after config value `config-version: 2`
   ```yaml
   # Global Variables
   # https://docs.getdbt.com/docs/building-a-dbt-project/building-models/using-variables
   vars:
     is_debug: true
     dbt_utils_dispatch_list: ['tsql_utils']
     tsql_utils_surrogate_key_col_type: 'nvarchar(255)'
     tsql_utils_surrogate_key_use_binary_hash: False
   
   # Check the level of support for the utility functions [here](https://github.com/dbt-msft/tsql-utils#macro-support)
   # Why need to add this piece of code? [related issue] (https://github.com/dbt-msft/tsql-utils/issues/30)
   dispatch:
     - macro_namespace: dbt_utils
       search_order: ['tsql_utils', 'dbt_utils']
     - macro_namespace: dbt_date
       search_order: ['tsql_utils', 'dbt_date']
     - macro_namespace: dbt_expectations
       search_order: ['tsql_utils', 'dbt_expectations']
     - macro_namespace: audit_helper
       search_order: ['tsql_utils', 'audit_helper']
   ```

   2. Install dbt packages from `<your dbt project folder>/packages.yml`
   ```
   dbt deps
   ```

   3. Copy files from `etl/dbt_custom_files/macros` to your dbt project folder `<your dbt prject folder>/macros`