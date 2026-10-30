-- ds_sum：三张指标卡的数据源（聚合下沉到 SQL，只返回 1 行 3 列）
-- 富文本「插入动态值」绑定字段时只取第一行，所以必须先在 SQL 里聚合好
select
    sum(quantity)          as sum_qty,    -- 总销量
    sum(total_amount)      as sum_amt,    -- 总销售额
    count(distinct order_id) as order_cnt -- 总订单数
from orders_detail
where ('${p_city}' = '' or city = '${p_city}')
