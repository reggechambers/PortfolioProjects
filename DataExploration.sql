--Calculate the total estimated market value and total property tax.
SELECT 
    SUM(emv) AS TotalEstimatedMarketValue, 
    SUM(propertytax) AS TotalPropertyTax 
FROM 
    tax_bills_june15_bbls;
    

--Find the total exemption and abatement amount:
SELECT 
    SUM(amount) AS TotalExemptionAbatement 
FROM 
    june15exab
WHERE 
    type IN ('exemption', 'abatement');
    
    
--Get the total estimated market value and total property tax per tax class:
SELECT 
    taxclass, 
    SUM(emv) AS TotalEstimatedMarketValue, 
    SUM(propertytax) AS TotalPropertyTax 
FROM 
    tax_bills_june15_bbls 
GROUP BY 
    taxclass;
    
 
--Find the total exemption and abatement amount per type:
SELECT 
    type, 
    SUM(amount) AS TotalAmount 
FROM 
    june15exab 
GROUP BY 
    type;
    

--Join both tables and find the total property tax and exemption/abatement amount for each property:
SELECT 
    t.bbl, 
    t.propertytax, 
    SUM(e.amount) AS TotalExemptionAbatement 
FROM 
    tax_bills_june15_bbls AS t
LEFT JOIN 
    june15exab AS e
ON 
    t.bbl = e.bbl 
GROUP BY 
    t.bbl, 
    t.propertytax;
    
    
 --Find the properties with the highest tax due:
SELECT TOP 10
    bbl, 
    propertytax 
FROM 
    tax_bills_june15_bbls 
ORDER BY 
    propertytax DESC;
    
    
--Find the properties with the highest exemptions and abatements:
  SELECT TOP 10
    bbl, 
    SUM(amount) as TotalExemptionAbatement 
FROM 
    june15exab 
GROUP BY 
    bbl 
ORDER BY 
    TotalExemptionAbatement DESC;



