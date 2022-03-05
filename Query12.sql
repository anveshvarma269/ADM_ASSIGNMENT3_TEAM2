/*Query12*/

SELECT
         i_item_id , 
         i_item_desc , 
         i_category , 
         i_class , 
         i_current_price , 
         Sum(ws_ext_sales_price) AS itemrevenue ,
         Sum(ws_ext_sales_price)*100/Sum(Sum(ws_ext_sales_price)) OVER (partition BY i_class) AS revenueratio
FROM     web_sales, item, date_dim
WHERE    ws_item_sk = i_item_sk 
AND      i_category IN ('Home', 
                        'Sports', 
                        'Books') 
AND      ws_sold_date_sk = d_date_sk 
AND      d_date BETWEEN Cast('1999-02-22' AS DATE) AND (Cast('1999-02-22' AS DATE) + INTERVAL '30 day') 
GROUP BY i_item_id , 
         i_item_desc , 
         i_category , 
         i_class , 
         i_current_price 
LIMIT 10000; 