
/*1*/
-- SELECT MIN(dateScanned), MAX(dateScanned) FROM receipts
-- where dateScanned >'0000-00-00' 

/*since we do not enough data(i.e.brandCode) for the month of MARCH I have tried running the same query for the month of FEB. So here I have considered February as my previous month*/

SELECT a.dateScanned, b.brandCode,
RANK() over (order by b.brandCode) ranking
FROM receipts a join rewardsreceiptitemlist b on a._id = b.oid 
where brandCode is not null and a.dateScanned between '2021-02-01' and '2021-02-28'
group by b.brandCode

 -- ###################################################################################################
/*2*/

/*Here since we have a less values in for brandCode in rewardsreceiptitemlist table for the month of FEB our results are restricted to just first two rows*/

select t2.brandCode,t2.ranked_FEB, t1.brandCode, t1.ranked_JAN from 
(SELECT a.dateScanned, b.brandCode, 
RANK() over (order by b.brandCode desc) ranked_JAN
FROM receipts a join rewardsreceiptitemlist b on a._id = b.oid 
where brandCode is not null and a.dateScanned between '2021-01-01' and '2021-01-31'
group by b.brandCode
order by ranked_JAN desc) t1 join 
(SELECT a.dateScanned, b.brandCode, 
RANK() over (order by b.brandCode) ranked_FEB
FROM receipts a join rewardsreceiptitemlist b on a._id = b.oid 
where brandCode is not null and a.dateScanned between '2021-02-01' and '2021-02-28'
group by b.brandCode) t2 
on t1.brandCode=t2.brandCode 
having t1.brandcode=t2.brandCode

-- ################################################################################################## 
/*3*/

/* Our rewardsReceiptStatus column does not have 'ACCEPTED' as a value,so I have used 'FINISHED' */

select a.rewardsReceiptStatus, round(avg(a.totalSpent),1) AverageSpend,
RANK() over (order by count(a.totalSpent) desc) ranked
FROM receipts a 
where a.rewardsReceiptStatus in ('FINISHED','REJECTED')
group by a.rewardsReceiptStatus

-- ################################################################################################
/*4*/

/* Our rewardsReceiptStatus column does not have 'ACCEPTED' as a value,so I have used 'FINISHED' again */

select a.rewardsReceiptStatus, count(a.purchasedItemCount) TotalItemsPurchased,
RANK() over (order by count(a.purchasedItemCount) desc) ranking
FROM receipts a join rewardsreceiptitemlist b on a._id = b.oid
where a.rewardsReceiptStatus in ('FINISHED','REJECTED')
group by a.rewardsReceiptStatus
-- ###################################################################################################
/*5*/

-- SELECT MIN(purchaseDate), MAX(purchaseDate) FROM receipts
-- where purchaseDate >'0000-00-00' 

/*Here I have taken purchase date as '2020-9-08' because maximum purchase date is 2020-3-08*/

select b.brandcode, sum(totalSpent)	
FROM receipts a join rewardsreceiptitemlist b on a._id = b.oid
where b.brandCode is not null and a.purchaseDate > '2020-9-08'
group by b.brandCode
order by sum(totalSpent) desc limit 1; 


-- ###############################################################################################
/*6*/

select b.brandcode, count(distinct a._id) as Transactions
FROM receipts a join rewardsreceiptitemlist b on a._id = b.oid
where b.brandCode is not null and a.createDate > '2020-9-08'
group by b.brandCode 
order by count(distinct a._id) desc;

-- ###################################################################################################
