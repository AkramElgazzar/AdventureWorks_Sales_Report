GO
CREATE VIEW  vw_FactSales AS

SELECT sd1.SalesOrderID 
      ,sd1.SalesOrderDetailID 
      ,sd1.ProductID
      ,sd1.OrderQty
      ,sd1.UnitPrice 
	  ,sd1.UnitPriceDiscount
      ,sd1.LineTotal 

     
      ,sh2.CustomerID
      ,sh2.TerritoryID 
      ,sh2.ShipMethodID 
	  ,sh2.SubTotal
	  ,sh2.TaxAmt
	  ,sh2.Freight

	  , CAST(FORMAT(sh2.OrderDate, 'yyyyMMdd') AS DATE) OrderDate
      , CAST(FORMAT(sh2.DueDate , 'yyyyMMdd') AS DATE) DueDate
      , CAST(FORMAT(sh2.ShipDate , 'yyyyMMdd') AS DATE) ShipDate
      
   
   FROM Sales.SalesOrderDetail sd1
   LEFT JOIN Sales.SalesOrderHeader sh2 ON sh2.SalesOrderID = sd1.SalesOrderID;
GO
-----------------------------------------------------------------------------------------
GO
CREATE VIEW vw_DimProducts AS
SELECT p.[ProductID]
      ,p.[Name] Product_Name
	  ,psub.[Name] Subcategory_Name
      ,pcat.[Name] Category_Name
	  ,p.ListPrice
	  ,p.StandardCost
	  ,p.ProductSubcategoryID
	  ,psub.ProductCategoryID
	  
	  ,p.Color
	  ,p.size

FROM Production.Product p
LEFT JOIN Production.ProductSubcategory psub ON psub.ProductSubcategoryID = p.ProductSubcategoryID
LEFT JOIN Production.ProductCategory pcat ON pcat.ProductCategoryID = psub.ProductCategoryID;
GO
--------------------------------------------------------------------------------------------
GO 
CREATE VIEW vm_DimCustomer AS
SELECT  c.CustomerID,
        c.PersonID,
        c.StoreID,
        c.TerritoryID,
        p.PersonType,
        p.Title,
        CONCAT(FirstName, ' ', COALESCE(MiddleName, ''), ' ', LastName) AS FullName,
        p.Suffix,
        s.Name  BusinessName
FROM Sales.Customer AS c
LEFT JOIN Person.Person AS p
ON c.PersonID = p.BusinessEntityID
LEFT JOIN Sales.Store AS s
ON c.StoreID = s.BusinessEntityID;
GO

--------------------------------------------------------------------------------------------------
GO
Create VIEW vw_DimShipMethods AS 
SELECT ShipMethodID
      ,Name ShipMethodName
FROM Purchasing.ShipMethod

GO
---------------------------------------------------------------------------------------------------
GO
Create View vw_DimTerritories As
SELECT TerritoryID
      ,[Name] TerritoryName
      ,CountryRegionCode
      ,[Group] 
FROM Sales.SalesTerritory

GO

-------------------------------------------------------------------------------------------------------





