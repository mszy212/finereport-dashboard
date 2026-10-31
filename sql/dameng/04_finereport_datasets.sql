-- 04_finereport_datasets.sql（v2，2026-10-31 实证修订版）
-- 帆软连达梦后各数据集的 SQL（F6_dashboard_dm.fvs 实际在用）
-- 用法：设计器 → 模板数据集 → 各数据集双击 → 粘进去 → 预览
--
-- ⚠️ v1 的"达梦 ''=NULL 所以用 IS NULL"说法已被实测推翻！
-- 实证（DM8 dm8_20260709 开发版，实例 DMSERVER）：
--   SELECT COUNT(*) FROM orders_detail WHERE '' IS NULL;      → 0 行
--   SELECT COUNT(*) FROM orders_detail WHERE '' IS NOT NULL;  → 198 行
-- 即：这个版本的达梦把 '' 当普通空串（Oracle 兼容行为随版本/配置变化）。
--
-- ⚠️ v2 曾把"联动失效"误归因于参数引号（当时 IS NULL→= '' 和去引号一次改了两处）。
-- 2026-10-31 用带引号版本回归证实：带引号 '${p_city}' 在达梦上完全正常，
-- 真凶只有 IS NULL（见上）。最终定版：与 SQLite 完全同款 SQL，一字不改，两库通用。
-- 跨版本最稳的防御性写法（备选）：nullif('${p_city}','') is null

-- ds_city（下拉框选项，8 行；绝不能带参数过滤）
SELECT DISTINCT city
FROM orders_detail;

-- ds_sql（主力明细：柱形图/饼图/明细表）
SELECT *
FROM orders_detail
WHERE ('${p_city}' = '' OR city = '${p_city}');

-- ds_sum_qty（指标卡·总销量）
SELECT SUM(quantity) AS total_qty
FROM orders_detail
WHERE ('${p_city}' = '' OR city = '${p_city}');

-- ds_sum_total（指标卡·总销售额，口径 = SUM(total_amount)，不是标价加和）
SELECT SUM(total_amount) AS sum_total
FROM orders_detail
WHERE ('${p_city}' = '' OR city = '${p_city}');

-- ds_count_orders（指标卡·总订单数）
-- order_id 是主键（G1 加的），天然不重复，count(order_id) 等价 count(distinct order_id)
SELECT COUNT(order_id) AS total_orders
FROM orders_detail
WHERE ('${p_city}' = '' OR city = '${p_city}');

-- 验收基准（与 SQLite 版逐项对数，已对账源文件 orders_detail.txt）：
--   不选城市：666 / 1,085,190.20 / 198
--   温州：    72  / 102,112.79  / 19（19 笔订单贡献 72 件销量）
--   杭州：    95  / 182,084.26  / 28

-- ============================================================
-- 其他达梦语法差异速记（遇到了再查，先有印象）
--   LIMIT n            → FETCH FIRST n ROWS ONLY
--   IFNULL(a,b)        → NVL(a,b)
--   GROUP_CONCAT       → LISTAGG(...) WITHIN GROUP(ORDER BY ...)
--   字符串拼接 ||      → 同 Oracle，|| 可用
--   反引号 `列名`      → 不支持，用双引号 "列名"（且大小写敏感）
-- ============================================================
