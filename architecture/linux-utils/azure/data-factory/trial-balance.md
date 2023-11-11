This is a Pipeline called trial-balance
It use the mgsqlsvr-ir SSIS IR because it is faster to start and stop because it is on a Azure SQL Server that is completely managed by Microsoft.
the mgsqlsvr-ir has a related mgsqlsvr-shir, self-hosted, IR which enables Azure pipelines to run scripts internally.
these self-hosted IR run on alb-utl and alb-utl4.
I don't believe any of the Trial Balance SSIS scripts are set to run from a self-hosted IR.
The scripts were created on alb-utl and alb-utl4.
Once the scripts are created or updated they can be published from Visual Studio CE 2019 to the mysqlsvr database.
Once the scripts are published to an Azure SQL database they can be ran from the data factory using an SSIS type component.
There is a trigger that runs this script every day except for Monday.
This Pipeline uses a brute force method which deletes and inserts a whole years worth of accounting_balance records every time it runs.
Trial Balance Pipeline
Start mgsqlsvr IR
Execute AccountingYearCategoryType
Execute SSIS AccountingAccounts
Execute AccountingPeriod
Execute SSIS AccountingBalanceUpdatePeriodRange
Execute AccountingBalanceAppendPeriodRange
Execute AccountPeriodBalanceDeletePeriodRange
Execute AccountPeriodBalanceRecreatePeriodRange
Stop mgsqlsrv IR

Are SSIS script runs logged in the mgsqlmi database?

