Declare @JSON varchar(max)
SELECT @JSON = BulkColumn
FROM OPENROWSET (BULK 'C:\Users\Aniket Kute\OneDrive - The University of Texas at Dallas\Desktop\Fetch Rewards\json\receipts.JSON', SINGLE_CLOB) as j

select
	JSON_VALUE (c.value,'$._id.oid') as oid,
	JSON_VALUE (p.value,'$.barcode') as barcode,
	JSON_VALUE (p.value,'$.brandCode') as brandCode,
	JSON_VALUE (p.value,'$.competitorRewardsGroup') as competitorRewardsGroup,
	JSON_VALUE (p.value,'$._description') as _description,
	JSON_VALUE (p.value,'$.discountedItemPrice') as discountedItemPrice,
	JSON_VALUE (p.value,'$.finalPrice') as finalPrice,
	JSON_VALUE (p.value,'$.itemPrice') as _itemPrice,
	JSON_VALUE (p.value,'$.originalReceiptItemText') as originalReceiptItemText,
	JSON_VALUE (p.value,'$.needsFetchReview') as needsFetchReview,
	JSON_VALUE (p.value,'$.needsFetchReviewReason') as needsFetchReviewReason,
	JSON_VALUE (p.value,'$.partnerItemId') as partnerItemId,
	JSON_VALUE (p.value,'$.pointsNotAwardedReason') as pointsNotAwardedReason,
	JSON_VALUE (p.value,'$.pointsPayerId') as pointsPayerId,
	JSON_VALUE (p.value,'$.preventTargetGapPoints') as preventTargetGapPoints,
	JSON_VALUE (p.value,'$.quantityPurchased') as quantityPurchased,
	JSON_VALUE (p.value,'$.rewardsGroup') as rewardsGroup,
	JSON_VALUE (p.value,'$.rewardsProductPartnerId') as rewardsProductPartnerId,
	JSON_VALUE (p.value,'$.userFlaggedBarcode') as userFlaggedBarcode,
	JSON_VALUE (p.value,'$.userFlagged_description') as userFlagged_description,
	JSON_VALUE (p.value,'$.userFlaggedNewItem') as userFlaggedNewItem,
	JSON_VALUE (p.value,'$.userFlaggedPrice') as userFlaggedPrice,
	JSON_VALUE (p.value,'$.userFlaggedQuantity') as userFlaggedQuantity
from OPENJSON (@JSON,'$.receipts')as c
CROSS APPLY OPENJSON (c.value,'$.rewardsReceiptItemList') as p