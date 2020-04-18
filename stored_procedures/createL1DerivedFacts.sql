DROP PROCEDURE dbo.spCreateL1DerivedFacts

USE i2b2demodata;

GO  
CREATE PROCEDURE dbo.spCreateL1DerivedFacts 
    @DerivedConceptCode VARCHAR(50),  
    @factResultSet NVARCHAR(4000)
    
AS  
    DECLARE @factLevel NVARCHAR(5)
    SET @factLevel='LEVEL1'
    EXECUTE dbo.spCreateL1DerivedFacts @DerivedConceptCode, @factResultSet, @factLevel
GO
