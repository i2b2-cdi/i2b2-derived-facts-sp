DROP PROCEDURE dbo.spCreateL2DerivedFacts

USE i2b2demodata;

GO  
CREATE PROCEDURE dbo.spCreateL2DerivedFacts 
    @DerivedConceptCode VARCHAR(50),  
    @factResultSet NVARCHAR(4000)  
AS  
    DECLARE @factLevel NVARCHAR(5)
    SET @factLevel='LEVEL2'
    EXECUTE dbo.spCreateDerivedFacts @DerivedConceptCode, @factResultSet, @factLevel
GO
