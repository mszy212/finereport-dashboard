-- ds_sql：看板主力数据集（明细）
-- 用途：指标卡 / 柱形图 / 饼图 / 表格 全部绑定它
-- 关键：参数为空时查全部，有值时按城市过滤
select *
from orders_detail
where ('${p_city}' = '' or city = '${p_city}')
