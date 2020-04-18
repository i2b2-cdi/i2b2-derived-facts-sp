DROP PROCEDURE dbo.spCreateDerivedFacts

USE i2b2demodata;

GO  
CREATE PROCEDURE dbo.spCreateDerivedFacts 
    @DerivedConceptCode VARCHAR(50),  
    @factResultSet NVARCHAR(4000),
    @factLevel NVARCHAR(5)='LEVEL2'
AS      
    DECLARE @wrapStatement NVARCHAR(4000)
    DECLARE @level1Wrapper1 NVARCHAR(1000)
    DECLARE @level1Wrapper2 NVARCHAR(1000)
    DECLARE @deleteStatement NVARCHAR(1000)
    DECLARE @msg NVARCHAR(1000)
    DECLARE @rowcount INT

    SET @level1Wrapper1=
        'insert into OBSERVATION_FACT
        select 
        innerStatement.ENCOUNTER_NUM as ENCOUNTER_NUM,     
        innerStatement.PATIENT_NUM as PATIENT_NUM,      
        '''

    SET @level1Wrapper2=
        ''' as CONCEPT_CD,
        innerStatement.PROVIDER_ID as PROVIDER_ID,
        innerStatement.START_DATE as START_DATE,
        innerStatement.MODIFIER_CD as MODIFIER_CD,
        innerStatement.INSTANCE_NUM as INSTANCE_NUM,
        innerStatement.VALTYPE_CD as VALTYPE_CD,
        innerStatement.TVAL_CHAR as TVAL_CHAR,
        innerStatement.NVAL_NUM as NVAL_NUM,
        innerStatement.VALUEFLAG_CD as VALUEFLAG_CD,
        innerStatement.QUANTITY_NUM as QUANTITY_NUM,
        innerStatement.UNITS_CD as UNITS_CD,
        innerStatement.END_DATE as END_DATE,
        innerStatement.LOCATION_CD as LOCATION_CD,
        innerStatement.OBSERVATION_BLOB as OBSERVATION_BLOB,    
        innerStatement.CONFIDENCE_NUM as CONFIDENCE_NUM,     
        CURRENT_TIMESTAMP as UPDATE_DATE,
        innerStatement.DOWNLOAD_DATE as DOWNLOAD_DATE,
        innerStatement.IMPORT_DATE as IMPORT_DATE,
        '''+@factLevel+''' as SOURCESYSTEM_CD,
        NULL as UPLOAD_ID
        from ('



    --check if the requsite concepts are defined in concept_dimension
    
    --delete old derived facts if they exist
    SET @deleteStatement='delete from dbo.observation_fact where concept_cd=''' + @DerivedConceptCode+''''

    EXECUTE sp_executesql @deleteStatement

    --execute computation of derived facts
    SET @wrapStatement=@level1Wrapper1+ @DerivedConceptCode+ @level1Wrapper2
                        +@factResultSet+ ')innerStatement'
    --PRINT @wrapStatement



    SELECT @rowcount = @@ROWCOUNT
    SET @msg='# Derived Facts created:'+CAST(@rowcount AS VARCHAR(4))
    PRINT @msg

    
    EXECUTE sp_executesql @wrapStatement
GO
