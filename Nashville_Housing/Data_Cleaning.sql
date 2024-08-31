SELECT * FROM Nashville_Housing;

Select SaleDate,YEAR(SaleDate)
From Nashville_Housing;


ALTER TABLE Nashville_Housing
DROP COLUMN SaleYear;

ALTER TABLE Nashville_Housing
ADD SaleYear Int;

UPDATE Nashville_Housing
SET SaleYear = YEAR(SaleDate);

ALTER TABLE Nashville_Housing
DROP COLUMN SaleYear;


-- Populate Property Address data

Select *
From Nashville_Housing
Where PropertyAddress is null
order by ParcelID;

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From Nashville_Housing a
JOIN Nashville_Housing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null


UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From Nashville_Housing a
JOIN Nashville_Housing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null;

-- Breaking out Address into Individual Columns (Address, City, State)


Select PropertyAddress
From Nashville_Housing


SELECT PropertyAddress,
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

From Nashville_Housing;

ALTER TABLE Nashville_Housing
Add PropertySplitAddress Nvarchar(255);

UPDATE Nashville_Housing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )

ALTER TABLE Nashville_Housing
Add PropertySplitCity Nvarchar(255);

Update Nashville_Housing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))

SELECT * FROM Nashville_Housing;

Select OwnerAddress
From Nashville_Housing


Select OwnerAddress,
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From Nashville_Housing



ALTER TABLE Nashville_Housing
Add OwnerSplitAddress Nvarchar(255);

Update Nashville_Housing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE Nashville_Housing
Add OwnerSplitCity Nvarchar(255);

Update Nashville_Housing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE Nashville_Housing
Add OwnerSplitState Nvarchar(255);

Update Nashville_Housing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)



Select *
From Nashville_Housing

-- Change 1 and 0 to Yes and No in "Sold as Vacant" field


Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From Nashville_Housing
Group by SoldAsVacant
order by 2

SELECT
    SoldAsVacant,
    CASE
        WHEN SoldAsVacant = 1 THEN 'Yes'
        WHEN SoldAsVacant = 0 THEN 'No'
        ELSE ''
    END
FROM
    Nashville_Housing;


ALTER TABLE Nashville_Housing
ALTER COLUMN SoldAsVacant VARCHAR(3); -- Change data type to VARCHAR


UPDATE Nashville_Housing
SET SoldAsVacant = CASE
    WHEN SoldAsVacant = 1 THEN 'Yes'
    WHEN SoldAsVacant = 0 THEN 'No'
    ELSE SoldAsVacant
END;

SELECT * FROM Nashville_Housing;


-- Remove Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From Nashville_Housing)

DELETE
From RowNumCTE
Where row_num > 1
--Order by PropertyAddress


-- Delete Unused Columns



Select *
From Nashville_Housing


ALTER TABLE Nashville_Housing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate

