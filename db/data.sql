/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.5.57-log : Database - mall
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`mall` /*!40100 DEFAULT CHARACTER SET utf8 */;

/*Data for the table `cart_product` */

LOCK TABLES `cart_product` WRITE;

insert  into `cart_product`(`id`,`product_id`,`user_id`,`product_num`) values (1,1,1,2);
insert  into `cart_product`(`id`,`product_id`,`user_id`,`product_num`) values (2,2,1,1);
insert  into `cart_product`(`id`,`product_id`,`user_id`,`product_num`) values (3,3,1,3);
insert  into `cart_product`(`id`,`product_id`,`user_id`,`product_num`) values (4,4,1,4);

UNLOCK TABLES;

/*Data for the table `category` */

LOCK TABLES `category` WRITE;

insert  into `category`(`id`,`name`,`parent_id`) values (1,'女装',NULL);
insert  into `category`(`id`,`name`,`parent_id`) values (2,'男装',NULL);
insert  into `category`(`id`,`name`,`parent_id`) values (3,'家电',NULL);
insert  into `category`(`id`,`name`,`parent_id`) values (4,'家居',NULL);
insert  into `category`(`id`,`name`,`parent_id`) values (5,'饰品',NULL);
insert  into `category`(`id`,`name`,`parent_id`) values (6,'箱包',NULL);
insert  into `category`(`id`,`name`,`parent_id`) values (7,'连衣裙',1);
insert  into `category`(`id`,`name`,`parent_id`) values (8,'上装',1);
insert  into `category`(`id`,`name`,`parent_id`) values (9,'下装',1);
insert  into `category`(`id`,`name`,`parent_id`) values (10,'外套',1);
insert  into `category`(`id`,`name`,`parent_id`) values (11,'上装',1);
insert  into `category`(`id`,`name`,`parent_id`) values (12,'下装',1);
insert  into `category`(`id`,`name`,`parent_id`) values (13,'外套',1);
insert  into `category`(`id`,`name`,`parent_id`) values (14,'衬衫连衣裙',7);
insert  into `category`(`id`,`name`,`parent_id`) values (15,'雪纺连衣裙',7);
insert  into `category`(`id`,`name`,`parent_id`) values (16,'针织连衣裙',7);
insert  into `category`(`id`,`name`,`parent_id`) values (17,'衬衫',8);
insert  into `category`(`id`,`name`,`parent_id`) values (18,'卫衣',8);
insert  into `category`(`id`,`name`,`parent_id`) values (19,'衬衫',8);

UNLOCK TABLES;

/*Data for the table `comment` */

LOCK TABLES `comment` WRITE;

insert  into `comment`(`id`,`product_id`,`order_id`,`user_id`,`content`,`create_at`) values (1,1,1,1,'真不错，已经迫不及待的穿上了，朋友们都说好，挺有气质的，就是上衣稍微有点肥，不过肉肉被藏起来了！有看上的赶紧下单吧！','2018-03-15 21:12:56');
insert  into `comment`(`id`,`product_id`,`order_id`,`user_id`,`content`,`create_at`) values (2,1,2,1,'真不错，已经迫不及待的穿上了，朋友们都说好，挺有气质的，就是上衣稍微有点肥，不过肉肉被藏起来了！有看上的赶紧下单吧！','2018-03-04 19:12:56');
insert  into `comment`(`id`,`product_id`,`order_id`,`user_id`,`content`,`create_at`) values (3,1,3,1,'真不错，已经迫不及待的穿上了，朋友们都说好，挺有气质的，就是上衣稍微有点肥，不过肉肉被藏起来了！有看上的赶紧下单吧！','2018-03-05 15:12:56');
insert  into `comment`(`id`,`product_id`,`order_id`,`user_id`,`content`,`create_at`) values (4,1,4,1,'真不错，已经迫不及待的穿上了，朋友们都说好，挺有气质的，就是上衣稍微有点肥，不过肉肉被藏起来了！有看上的赶紧下单吧！','2018-03-15 15:12:56');
insert  into `comment`(`id`,`product_id`,`order_id`,`user_id`,`content`,`create_at`) values (5,1,5,1,'真不错，已经迫不及待的穿上了，朋友们都说好，挺有气质的，就是上衣稍微有点肥，不过肉肉被藏起来了！有看上的赶紧下单吧！','2018-03-12 18:12:56');
insert  into `comment`(`id`,`product_id`,`order_id`,`user_id`,`content`,`create_at`) values (6,1,6,1,'真不错，已经迫不及待的穿上了，朋友们都说好，挺有气质的，就是上衣稍微有点肥，不过肉肉被藏起来了！有看上的赶紧下单吧！','2018-03-12 18:12:56');
insert  into `comment`(`id`,`product_id`,`order_id`,`user_id`,`content`,`create_at`) values (7,1,7,1,'真不错，已经迫不及待的穿上了，朋友们都说好，挺有气质的，就是上衣稍微有点肥，不过肉肉被藏起来了！有看上的赶紧下单吧！','2018-03-12 18:12:56');
insert  into `comment`(`id`,`product_id`,`order_id`,`user_id`,`content`,`create_at`) values (8,1,8,1,'真不错，已经迫不及待的穿上了，朋友们都说好，挺有气质的，就是上衣稍微有点肥，不过肉肉被藏起来了！有看上的赶紧下单吧！','2018-03-12 18:12:56');
insert  into `comment`(`id`,`product_id`,`order_id`,`user_id`,`content`,`create_at`) values (9,1,9,1,'真不错，已经迫不及待的穿上了，朋友们都说好，挺有气质的，就是上衣稍微有点肥，不过肉肉被藏起来了！有看上的赶紧下单吧！','2018-03-12 18:12:56');
insert  into `comment`(`id`,`product_id`,`order_id`,`user_id`,`content`,`create_at`) values (10,1,10,1,'真不错，已经迫不及待的穿上了，朋友们都说好，挺有气质的，就是上衣稍微有点肥，不过肉肉被藏起来了！有看上的赶紧下单吧！','2018-03-12 18:12:56');
insert  into `comment`(`id`,`product_id`,`order_id`,`user_id`,`content`,`create_at`) values (11,1,11,1,'商品：宝贝料子和手感都不错，是值这价，卖家很贴心的送了内衣带，5分好评是必须的。喜欢的可以 下手了','2018-03-12 18:12:56');
insert  into `comment`(`id`,`product_id`,`order_id`,`user_id`,`content`,`create_at`) values (12,1,12,1,'真不错，已经迫不及待的穿上了，朋友们都说好，挺有气质的，就是上衣稍微有点肥，不过肉肉被藏起来了！有看上的赶紧下单吧！','2018-03-12 18:12:56');
insert  into `comment`(`id`,`product_id`,`order_id`,`user_id`,`content`,`create_at`) values (13,1,13,1,'真不错，已经迫不及待的穿上了，朋友们都说好，挺有气质的，就是上衣稍微有点肥，不过肉肉被藏起来了！有看上的赶紧下单吧！','2018-03-12 18:12:56');
insert  into `comment`(`id`,`product_id`,`order_id`,`user_id`,`content`,`create_at`) values (14,1,14,1,'真不错，已经迫不及待的穿上了，朋友们都说好，挺有气质的，就是上衣稍微有点肥，不过肉肉被藏起来了！有看上的赶紧下单吧！','2018-03-12 18:12:56');
insert  into `comment`(`id`,`product_id`,`order_id`,`user_id`,`content`,`create_at`) values (15,1,15,1,'真不错，已经迫不及待的穿上了，朋友们都说好，挺有气质的，就是上衣稍微有点肥，不过肉肉被藏起来了！有看上的赶紧下单吧！','2018-03-12 18:12:56');
insert  into `comment`(`id`,`product_id`,`order_id`,`user_id`,`content`,`create_at`) values (16,1,16,1,'真不错，已经迫不及待的穿上了，朋友们都说好，挺有气质的，就是上衣稍微有点肥，不过肉肉被藏起来了！有看上的赶紧下单吧！','2018-03-12 18:12:56');
insert  into `comment`(`id`,`product_id`,`order_id`,`user_id`,`content`,`create_at`) values (17,1,17,1,'真不错，已经迫不及待的穿上了，朋友们都说好，挺有气质的，就是上衣稍微有点肥，不过肉肉被藏起来了！有看上的赶紧下单吧！','2018-03-12 18:12:56');
insert  into `comment`(`id`,`product_id`,`order_id`,`user_id`,`content`,`create_at`) values (18,1,18,1,'真不错，已经迫不及待的穿上了，朋友们都说好，挺有气质的，就是上衣稍微有点肥，不过肉肉被藏起来了！有看上的赶紧下单吧！','2018-03-12 18:12:56');
insert  into `comment`(`id`,`product_id`,`order_id`,`user_id`,`content`,`create_at`) values (19,1,19,1,'真不错，已经迫不及待的穿上了，朋友们都说好，挺有气质的，就是上衣稍微有点肥，不过肉肉被藏起来了！有看上的赶紧下单吧！','2018-03-12 18:12:56');
insert  into `comment`(`id`,`product_id`,`order_id`,`user_id`,`content`,`create_at`) values (20,1,20,1,'真不错，已经迫不及待的穿上了，朋友们都说好，挺有气质的，就是上衣稍微有点肥，不过肉肉被藏起来了！有看上的赶紧下单吧！','2018-03-12 18:12:56');
insert  into `comment`(`id`,`product_id`,`order_id`,`user_id`,`content`,`create_at`) values (21,1,21,1,'真不错，已经迫不及待的穿上了，朋友们都说好，挺有气质的，就是上衣稍微有点肥，不过肉肉被藏起来了！有看上的赶紧下单吧！','2018-03-12 18:12:56');
insert  into `comment`(`id`,`product_id`,`order_id`,`user_id`,`content`,`create_at`) values (22,1,22,22,'真不错，已经迫不及待的穿上了，朋友们都说好，挺有气质的，就是上衣稍微有点肥，不过肉肉被藏起来了！有看上的赶紧下单吧！','2018-03-12 18:12:56');

UNLOCK TABLES;

/*Data for the table `good_type` */

LOCK TABLES `good_type` WRITE;

UNLOCK TABLES;

/*Data for the table `goods` */

LOCK TABLES `goods` WRITE;

UNLOCK TABLES;

/*Data for the table `order` */

LOCK TABLES `order` WRITE;

UNLOCK TABLES;

/*Data for the table `order_goods` */

LOCK TABLES `order_goods` WRITE;

UNLOCK TABLES;

/*Data for the table `order_product` */

LOCK TABLES `order_product` WRITE;

UNLOCK TABLES;

/*Data for the table `permission` */

LOCK TABLES `permission` WRITE;

UNLOCK TABLES;

/*Data for the table `product` */

LOCK TABLES `product` WRITE;

insert  into `product`(`id`,`name`,`price`,`discount`,`status`,`category_id`,`root_category_id`,`store_num`,`sale_num`,`image_urls`,`comment_num`) values (1,'加绒卫衣帽衫加厚宽松','336.00','168.00','ON_SHELF',18,1,1086,688,'http://img02.static.yohobuy.com/product/2014/03/19/13/02b54572ff6c6e9bf3e72f2f412a31a47c.jpg;http://img02.static.yohobuy.com/product/2014/03/19/13/02b54572ff6c6e9bf3e72f2f412a31a47c.jpg;http://img02.static.yohobuy.com/product/2014/03/19/13/02b54572ff6c6e9bf3e72f2f412a31a47c.jpg',22);
insert  into `product`(`id`,`name`,`price`,`discount`,`status`,`category_id`,`root_category_id`,`store_num`,`sale_num`,`image_urls`,`comment_num`) values (2,'圆领印花卫衣女','188.00','78.00','ON_SHELF',18,1,1999,919,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3245716057,3112804808&fm=27&gp=0.jpg',0);
insert  into `product`(`id`,`name`,`price`,`discount`,`status`,`category_id`,`root_category_id`,`store_num`,`sale_num`,`image_urls`,`comment_num`) values (3,'休闲牛仔衬衫','288.00','208.00','ON_SHELF',17,1,46830,5930,'http://www.sc115.com/wenku/uploads/allimg/130313/21012322V-2.jpg;http://www.sc115.com/wenku/uploads/allimg/130313/21012322V-2.jpg;http://www.sc115.com/wenku/uploads/allimg/130313/21012322V-2.jpg',0);
insert  into `product`(`id`,`name`,`price`,`discount`,`status`,`category_id`,`root_category_id`,`store_num`,`sale_num`,`image_urls`,`comment_num`) values (4,'白色雪纺衬衫','179.00','169.00','ON_SHELF',17,1,530,123,'http://vogue.moonbasa.com/files/2011/8/24/32-059379855427.jpg;http://vogue.moonbasa.com/files/2011/8/24/32-059379855427.jpg;http://vogue.moonbasa.com/files/2011/8/24/32-059379855427.jpg',0);
insert  into `product`(`id`,`name`,`price`,`discount`,`status`,`category_id`,`root_category_id`,`store_num`,`sale_num`,`image_urls`,`comment_num`) values (5,'字母短袖T恤','99.00','69.00','ON_SHELF',19,1,0,0,'http://img.zcool.cn/community/018615577cd4070000012e7e89ab4d.jpg@900w_1l_2o_100sh.jpg;http://img.zcool.cn/community/018615577cd4070000012e7e89ab4d.jpg@900w_1l_2o_100sh.jpg;http://img.zcool.cn/community/018615577cd4070000012e7e89ab4d.jpg@900w_1l_2o_100sh.jpg',0);

UNLOCK TABLES;

/*Data for the table `role` */

LOCK TABLES `role` WRITE;

UNLOCK TABLES;

/*Data for the table `role_permission` */

LOCK TABLES `role_permission` WRITE;

UNLOCK TABLES;

/*Data for the table `user` */

LOCK TABLES `user` WRITE;

insert  into `user`(`id`,`username`,`password`,`email`,`nickname`,`gender`,`telephone`,`birthday`,`avatar`,`create_at`,`last_login_at`,`last_login_ip`,`status`) values (1,'111111','111111','11@qq.com','111','MALE',NULL,NULL,NULL,'2018-03-01 21:23:37',NULL,NULL,'ACTIVATED');
insert  into `user`(`id`,`username`,`password`,`email`,`nickname`,`gender`,`telephone`,`birthday`,`avatar`,`create_at`,`last_login_at`,`last_login_ip`,`status`) values (2,'123456','123456',NULL,'123456','UNKNOWN',NULL,NULL,NULL,'2018-03-03 21:40:47',NULL,NULL,'ACTIVATED');

UNLOCK TABLES;

/*Data for the table `user_role` */

LOCK TABLES `user_role` WRITE;

UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
