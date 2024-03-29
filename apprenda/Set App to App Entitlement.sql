USE [SaaSGrid Core]
GO

DECLARE @VersionId uniqueidentifier
DECLARE @Name nvarchar(255)
DECLARE @SourceApplicationId uniqueidentifier

SET @VersionId = (SELECT v.RowId FROM [SaaSGrid Core].dbo.Version v INNER JOIN [SaaSGrid Core].dbo.Application a ON v.application_id = a.Id WHERE v.Alias = 'v6.5.1' AND a.alias = 'apprenda-container')
SET @SourceApplicationId = (SELECT a.RowId FROM [SaaSGrid Core].dbo.Application a INNER JOIN [SaaSGrid Core].dbo.Version v ON v.application_id = a.Id WHERE a.Alias = 'limitsapi' AND v.alias = 'v1' AND v.stage = 'Published')
SET @Name = 'limitsapi->apprenda-container'

EXECUTE [dbo].[AddApprendaEntitlement] 
   @VersionId
  ,@Name
  ,@SourceApplicationId
GO

