-- 01_create_table.sql：达梦 DM8 建表（订单明细）
-- 用法：DM 管理工具 → 新建查询 → 全选执行
-- 说明：日期字段这里用 VARCHAR 存，是为了导入零折腾；
--       真实项目请改成 DATE 类型（达梦 DATE 完全支持 '2024-07-01' 这种格式）

CREATE TABLE orders_detail (
    order_id       VARCHAR(50) PRIMARY KEY,
    user_id        VARCHAR(50),
    product_id     VARCHAR(50),
    user_name      VARCHAR(100),
    gender         VARCHAR(10),
    age            INT,
    city           VARCHAR(50),
    quantity       INT,
    order_price    DEC(18,2),
    user_date      VARCHAR(20),
    order_date     VARCHAR(20),
    product_name   VARCHAR(200),
    category       VARCHAR(50),
    product_price  DEC(18,2),
    total_amount   DEC(18,2)
);
