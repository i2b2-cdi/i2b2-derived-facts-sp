use i2b2demodata
DECLARE @derivedConceptCode NVARCHAR(50)
DECLARE @resultSet VARCHAR(8000)
DECLARE @requisteConceptCodes VARCHAR(6000)

SET @derivedConceptCode='U07.1'
SET @requisteConceptCodes='LOINC:94502-2 POSITIVE'

SET @resultSet='
select b.* from
(
    select a.* , ROW_NUMBER() OVER (PARTITION BY [PATIENT_NUM] order by start_date desc)  as ROW_NUM
    from i2b2demodata.dbo.observation_fact a
    WHERE a.concept_cd = ''LOINC:94502-2 POSITIVE''
)b
where ROW_NUM=1'

select * from OBSERVATION_FACT

