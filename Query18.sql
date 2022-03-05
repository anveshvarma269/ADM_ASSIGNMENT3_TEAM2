--Query18--

SELECT i_item_id, 

               ca_country, 

               ca_state, 

               ca_county, 

               Avg(Cast(cs_quantity AS NUMERIC(12, 2)))      agg1, 

               Avg(Cast(cs_list_price AS NUMERIC(12, 2)))    agg2, 

               Avg(Cast(cs_coupon_amt AS NUMERIC(12, 2)))    agg3, 

               Avg(Cast(cs_sales_price AS NUMERIC(12, 2)))   agg4, 

               Avg(Cast(cs_net_profit AS NUMERIC(12, 2)))    agg5, 

               Avg(Cast(c_birth_year AS NUMERIC(12, 2)))     agg6, 

               Avg(Cast(cd1.cd_dep_count AS NUMERIC(12, 2))) agg7 

FROM   catalog_sales, 

       customer_demographics cd1, 

       customer_demographics cd2, 

       customer, 

       customer_address, 

       date_dim, 

       item 

WHERE  cs_sold_date_sk = d_date_sk 

       AND cs_item_sk = i_item_sk 

       AND cs_bill_cdemo_sk = cd1.cd_demo_sk 

       AND cs_bill_customer_sk = c_customer_sk 

       AND cd1.cd_gender = 'F' 

       AND cd1.cd_education_status = 'Unknown' 

       AND c_current_cdemo_sk = cd2.cd_demo_sk 

       AND c_current_addr_sk = ca_address_sk 

       AND c_birth_month IN ( 1, 6, 8, 9, 

                              12, 2 ) 

       AND d_year = 1998 

       AND ca_state IN ( 'MS', 'IN', 'ND', 'OK', 

                         'NM', 'VA', 'MS' ) 

GROUP  BY rollup ( i_item_id, ca_country, ca_state, ca_county ) 

ORDER  BY ca_country, 

          ca_state, 

          ca_county, 

          i_item_id

LIMIT 10000; 
