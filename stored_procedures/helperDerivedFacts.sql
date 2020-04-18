CREATE FUNCTION intlist_to_tbl (@list nvarchar(MAX))
   RETURNS @tbl TABLE (number int NOT NULL) AS
BEGIN
   DECLARE @pos        int,
           @nextpos    int,
           @valuelen   int

   SELECT @pos = 0, @nextpos = 1

   WHILE @nextpos > 0
   BEGIN
      SELECT @nextpos = charindex(',', @list, @pos + 1)
      SELECT @valuelen = CASE WHEN @nextpos > 0
                              THEN @nextpos
                              ELSE len(@list) + 1
                         END - @pos - 1
      INSERT @tbl (number)
         VALUES (convert(int, substring(@list, @pos + 1, @valuelen)))
      SELECT @pos = @nextpos
   END
   RETURN
END


CREATE FUNCTION conceptCodeFromPath (@conceptPath nvarchar(MAX))
    RETURNS  TABLE (concept_cd varchar(50)) AS
BEGIN
    DECLARE @tbl TABLE(concept_cd varchar(50))
    SELECT @tbl=dbo.concept_dimension
    WHERE  concept_path LIKE @conceptPath
    RETURN
END


use i2b2demodata

CREATE FUNCTION dbo.conceptCodeFromPath (
    @conceptPath varchar(50)
)
RETURNS  TABLE  
AS
RETURN
    SELECT concept_cd
    FROM dbo.concept_dimension
    WHERE  concept_path LIKE @conceptPath

GO

use i2b2demodata
SELECT  * from dbo.conceptCodeFromPath('%')  
GO