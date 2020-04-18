
/*
{"description":"Positive test result for COVID PCR",
"author":"Kavishwar Wagholikar (waghsk@gmail.com)"
"dateCreated":"2020-04-18"
}
*/

use i2b2demodata
DECLARE @derivedConceptCode NVARCHAR(50)
DECLARE @resultSet VARCHAR(8000)
DECLARE @requisteConceptCodes VARCHAR(6000)

SET @derivedConceptCode='LOINC:94502-2 POSITIVE'
SET @requisteConceptCodes='MCSQ-COVID'

SET @resultSet='
select * from i2b2demodata.dbo.observation_fact a
WHERE  a.concept_cd = ''MCSQ-COVID''
and a.tval_char like ''%POSITIVE%''
'

EXECUTE spCreateL1DerivedFacts @derivedConceptCode, @resultSet;




