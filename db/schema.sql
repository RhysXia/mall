DROP TABLE IF EXISTS `user_role`;
DROP TABLE IF EXISTS `role_permission`;
DROP TABLE IF EXISTS `order_product`;
DROP TABLE IF EXISTS `permission`;
DROP TABLE IF EXISTS `role`;
DROP TABLE IF EXISTS `user`;
DROP TABLE IF EXISTS `order`;
DROP TABLE IF EXISTS `product`;
DROP TABLE IF EXISTS `category`;
DROP TABLE IF EXISTS `comment`;
DROP TABLE IF EXISTS `cart_product`;
DROP TABLE IF EXISTS `admin`;
DROP TABLE IF EXISTS `address`;
DROP TABLE IF EXISTS `product_description`;


CREATE TABLE `permission` (
  id   INT(20)     NOT NULL AUTO_INCREMENT
  COMMENT 'id',
  name VARCHAR(32) NOT NULL
  COMMENT '权限名',
  PRIMARY KEY `id`(`id`)
)
  COMMENT '权限表';

CREATE TABLE `role` (
  id        INT(20)     NOT NULL AUTO_INCREMENT
  COMMENT 'id',
  name      VARCHAR(32) NOT NULL
  COMMENT '角色名',
  create_at DATETIME    NOT NULL
  COMMENT '创建时间',
  PRIMARY KEY `id`(`id`)
)
  COMMENT '角色表';

CREATE TABLE `role_permission` (
  role_id       INT(20) NOT NULL
  COMMENT '角色id',
  permission_id INT(20) NOT NULL
  COMMENT '权限id',
  KEY `role_id`(`role_id`),
  KEY `permission_id`(`permission_id`)
)
  COMMENT '角色权限关系表';

CREATE TABLE `user` (
  id            INT(20)     NOT NULL AUTO_INCREMENT
  COMMENT 'id',
  username      VARCHAR(32) NOT NULL
  COMMENT '用户名',
  password      VARCHAR(20) NOT NULL
  COMMENT '密码',
  email         VARCHAR(32)          DEFAULT NULL
  COMMENT '邮箱',
  nickname      VARCHAR(40) NOT NULL
  COMMENT '昵称',
  gender        CHAR(8)     NOT NULL
  COMMENT '性别',
  telephone     CHAR(20)             DEFAULT NULL
  COMMENT '电话',
  birthday      DATETIME             DEFAULT NULL
  COMMENT '出生日期',
  avatar        VARCHAR(128)         DEFAULT NULL
  COMMENT '头像url',
  create_at     DATETIME    NOT NULL
  COMMENT '注册时间',
  last_login_at DATETIME             DEFAULT NULL
  COMMENT '上次登录时间',
  last_login_ip CHAR(40)             DEFAULT NULL
  COMMENT '上次登录ip',
  status        CHAR(10)    NOT NULL
  COMMENT '状态',
  PRIMARY KEY `id`(`id`)
)
  COMMENT '用户表';


CREATE TABLE `user_role` (
  user_id INT(20) NOT NULL
  COMMENT '用户id',
  role_id INT(20) NOT NULL
  COMMENT '角色id',
  KEY `user_id`(`user_id`),
  KEY `role_id`(`role_id`)
)
  COMMENT '用户角色表';

CREATE TABLE `category` (
  id        INT(20)     NOT NULL  AUTO_INCREMENT
  COMMENT 'id',
  name      VARCHAR(64) NOT NULL
  COMMENT '分类名称',
  parent_id INT(20)               DEFAULT NULL
  COMMENT '上级分类',
  PRIMARY KEY `id`(`id`),
  KEY `parent_id`(`parent_id`)
)
  COMMENT '商品分类表';

CREATE TABLE `product` (
  id                     INT(20)        NOT NULL AUTO_INCREMENT
  COMMENT 'id',
  name                   VARCHAR(32)    NOT NULL
  COMMENT '商品名称',
  price                  DECIMAL(10, 2) NOT NULL
  COMMENT '价格',
  discount               DECIMAL(10, 2)          DEFAULT NULL
  COMMENT '折扣后的价格',
  status                 CHAR(20)       NOT NULL
  COMMENT '商品状态',
  category_id            INT(20)        NOT NULL
  COMMENT '商品类型id',
  root_category_id       INT(20)        NOT NULL
  COMMENT '根分类的id',
  store_num              INT(20)                 DEFAULT 0
  COMMENT '库存',
  sale_num               INT(20)                 DEFAULT 0
  COMMENT '销量',
  image_urls             VARCHAR(512)   NOT NULL
  COMMENT '商品图片url',
  comment_num            INT(20)                 DEFAULT 0
  COMMENT '评论数',
  sale_date              DATETIME       NOT NULL
  COMMENT '上架时间',
  KEY `category_id`(`category_id`),
  PRIMARY KEY `id`(`id`)
)
  COMMENT '商品表';

CREATE TABLE `comment` (
  id         INT(20)  NOT NULL AUTO_INCREMENT
  COMMENT 'id',
  product_id INT(20)  NOT NULL
  COMMENT '商品id',
  order_id   INT(20)  NOT NULL
  COMMENT '订单id',
  user_id    INT(20)  NOT NULL
  COMMENT '用户id',
  content    TEXT     NOT NULL
  COMMENT '评论内容',
  create_at  DATETIME NOT NULL
  COMMENT '创建时间',
  KEY `product_id`(`product_id`),
  KEY `order_id`(`order_id`),
  KEY `user_id`(`user_id`),
  PRIMARY KEY `id`(`id`)
)
  COMMENT '商品评论表';

CREATE TABLE `order` (
  id          INT(20)        NOT NULL AUTO_INCREMENT
  COMMENT 'id',
  status      VARCHAR(20)    NOT NULL
  COMMENT '订单状态',
  identifier  CHAR(18)       NOT NULL
  COMMENT '订单编号',
  create_at   DATETIME       NOT NULL
  COMMENT '创建时间',
  pay_at      DATETIME                DEFAULT NULL
  COMMENT '支付时间',
  deliver_at  DATETIME                DEFAULT NULL
  COMMENT '发货时间',
  finish_at   DATETIME                DEFAULT NULL
  COMMENT '结束时间',
  total_price DECIMAL(10, 2) NOT NULL
  COMMENT '总价',
  express_num CHAR(18)       NULL
  COMMENT '快递单号',
  address_id     INT(20)   NULL
  COMMENT '收货信息id',
  user_id     INT(20)       NOT NULL
  COMMENT '订单对应的用户id',
  PRIMARY KEY `id`(`id`),
  KEY `user_id`(`user_id`),
  KEY `identifier`(`identifier`)
)
  COMMENT '订单表';

CREATE TABLE `order_product` (
  product_id  INT(20) NOT NULL
  COMMENT '商品id',
  order_id    INT(20) NOT NULL
  COMMENT '订单id',
  product_num INT(5)  NOT NULL
  COMMENT '商品数量',
  KEY `product_id`(`product_id`),
  KEY `order_id`(`order_id`)
)
  COMMENT '订单商品关系表';


CREATE TABLE `cart_product` (
  id          INT(20) NOT NULL AUTO_INCREMENT
  COMMENT 'id',
  product_id  INT(20) NOT NULL
  COMMENT '商品id',
  user_id     INT(20) NOT NULL
  COMMENT '用户id',
  product_num INT(5)  NOT NULL
  COMMENT '商品数量',
  PRIMARY KEY (`id`),
  KEY `product_id`(`product_id`),
  KEY `cart_id`(`user_id`)
)
  COMMENT '购物车商品关系表';


CREATE TABLE `admin` (
  id       INT(20)     NOT NULL AUTO_INCREMENT
  COMMENT 'id',
  username VARCHAR(32) NOT NULL
  COMMENT '管理员名',
  password VARCHAR(20) NOT NULL
  COMMENT '密码',
  PRIMARY KEY `id`(`id`)
)
  COMMENT '管理员表';


CREATE TABLE `address` (

  id                  INT(20)        NOT NULL AUTO_INCREMENT
  COMMENT 'id',
  postal_code         CHAR(6)        NOT NULL
  COMMENT '邮政编码',
  delivery_address    VARCHAR(128)   NULL
  COMMENT '收货地址',
  delivery_name       varchar(32)    NOT NULL
  COMMENT '收货人姓名',
  phone               char(20)       NOT NULL
  COMMENT '收货人电话',
  user_id             INT(20)        NOT NULL
  COMMENT '地址对应的用户id',
  PRIMARY KEY `id`(`id`),
  KEY `user_id`(`user_id`)

)
  COMMENT '地址表';

CREATE TABLE `product_description` (
  product_id            INT(20)       NOT NUll  AUTO_INCREMENT
  COMMENT '商品id',
  description           TEXT          DEFAULT NULL
  COMMENT '商品详情',
  PRIMARY KEY `product_id`(`product_id`)
)