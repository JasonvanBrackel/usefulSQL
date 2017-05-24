/****** 
    ########### Clear Log Management Values ########### 
******/
DELETE FROM [SaaSGrid Core].[dbo].[Log_Override_Aggregate_Tracking]
DELETE FROM [SaaSGrid Core].[dbo].[Log_Override]
DELETE FROM [SaaSGrid Core].[dbo].[Log_Filter]
DELETE FROM [SaaSGrid Core].[dbo].[Log_Manager_Meta]


/****** 
    ########### INSERT DEFAULT LOG MANAGEMENT VALUES ########### 
******/
DECLARE @metaId [uniqueidentifier]

INSERT INTO [SaaSGrid Core].[dbo].[Log_Manager_Meta] ([name], [description], [log_level], [allow_overrides]) 
VALUES ('Logging Configuration',null,4,'True')

SET @metaId = (SELECT TOP 1 [id] FROM [SaaSGrid Core].[dbo].[Log_Manager_Meta])

INSERT INTO [SaaSGrid Core].[dbo].[Log_Filter] ([log_manager_id], [is_regex], [pattern], [replacement]) 
VALUES (@metaId,'False','User=${SystemAdministratorUsername}$, Domain=${SystemAdministratorDomain}$, Password=${SystemAdministratorPassword}$', '[********]')

INSERT INTO [SaaSGrid Core].[dbo].[Log_Override] ([log_manager_id], [type], [log_level] ,[application_id] ,[customer_id] ,[subscriber_id] ,[tag])
VALUES (@metaId, 1,4 , '3E463578-5D90-49C1-B6B6-2C8EAB76FA51', NULL, NULL, NULL)

GO