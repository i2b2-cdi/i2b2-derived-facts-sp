use i2b2demodata
DECLARE @derivedConceptCode NVARCHAR(50)
DECLARE @resultSet VARCHAR(8000)
DECLARE @requisteConceptCodes VARCHAR(6000)

SET @derivedConceptCode='U07.1 Active'
SET @requisteConceptCodes='LOINC:94502-2 POSITIVE'

SET @resultSet=
    'select lastPositive.* from (
        select * from
        (
            select a.* , ROW_NUMBER() OVER (PARTITION BY [PATIENT_NUM] order by start_date)  as ROW_NUM
            from i2b2demodata.dbo.observation_fact a
            WHERE a.concept_cd = ''LOINC:94502-2 Positive''
        )a
        where ROW_NUM=1
    ) as lastPositive
    left join 
    (
        select b.* from (
            select a.* from
            (
                select a.* , ROW_NUMBER() OVER (PARTITION BY [PATIENT_NUM] order by start_date)  as ROW_NUM
                from i2b2demodata.dbo.observation_fact a
                WHERE a.concept_cd = ''LOINC:94502-2 Positive''
            )a
            where ROW_NUM=1
        )  b
    ) as lastNegative
    on lastPositive.patient_num=lastNegative.patient_num
    and lastPositive.start_date>lastNegative.start_date'


EXECUTE spCreateL1DerivedFacts @derivedConceptCode, @resultSet;

DECLARE @rowcount INT
SELECT @rowcount = @@ROWCOUNT

PRINT '@rowcount = ' + CAST(@rowcount AS VARCHAR(4))