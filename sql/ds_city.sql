-- ds_city：喂下拉框的城市选项（8 行）
-- 注意：这里绝不能加 where ${p_city}
-- 否则选完城市后选项会被过滤成只剩一个，下拉框就废了
select distinct city
from orders_detail
