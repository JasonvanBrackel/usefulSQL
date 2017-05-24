DECLARE @appAlias AS VARCHAR(40) = 'appAlias';

--set version(s) in core to deleted
update version set stage='Deleted' where application_id=(select id from [SaasGrid Core].[dbo].[Application] where alias=@appAlias)

--delete from dev portal
delete
FROM [316b32db-e812-40b8-9be0-9a4292bc95cc].[dbo_#SG#].[Application] where id=(select rowid from [application] where alias=@appAlias)

--delete presentation_partition rows
delete from presentation_partition where id in (
SELECT pp.id
FROM [SaaSGrid Core].[dbo].[Application] app
join [SaaSGrid Core].[dbo].[Version] v on v.application_id in (app.Id, app.RowId)
join [SaaSGrid Core].[dbo].[Artifacts] ar on ar.version_id in (v.id, v.rowId)
join [SaaSGrid Core].[dbo].[presentation_model] pm on pm.artifact_id in (ar.Id, ar.RowId)
join [SaaSGrid Core].[dbo].[presentation_partition] pp on pp.presentation_id in (pm.Id, pm.RowId)
   where app.alias = @appAlias)

--set undeploy_time on deployed artifacts
update deployed_artifact set undeploy_time=GETDATE() where undeploy_time is null and id in (select deployed_artifact_id from deployed_artifact_details where app_alias=@appAlias);
