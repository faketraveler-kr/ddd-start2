create table purchase_order
(
    order_number      varchar(50) not null primary key,
    version           bigint,
    orderer_id        varchar(50),
    orderer_name      varchar(50),
    total_amounts     int,
    shipping_zip_code varchar(6),
    shipping_addr1    varchar(100),
    shipping_addr2    varchar(100),
    shipping_message  varchar(200),
    receiver_name     varchar(50),
    receiver_phone    varchar(50),
    state             varchar(20),
    order_date        datetime
);

create table order_line
(
    order_number varchar(50) not null,
    line_idx     int         not null,
    product_id   varchar(50) not null,
    price        int,
    quantity     int,
    amounts      int
);

create index order_line_idx ON order_line (order_number, line_idx);

create table category
(
    category_id bigint not null primary key,
    name        varchar(100)
);

create table product
(
    product_id varchar(50) not null primary key,
    name       varchar(100),
    price      int,
    detail     text
);

create table product_category
(
    product_id  varchar(50) not null,
    category_id bigint      not null,
    PRIMARY KEY (product_id, category_id)
);

create table image
(
    image_id    int not null auto_increment primary key,
    product_id  varchar(50),
    list_idx    int,
    image_type  varchar(10),
    image_path  varchar(255),
    upload_time datetime
);

create table member
(
    member_id varchar(50) not null primary key,
    name      varchar(50),
    password  varchar(255),
    blocked   boolean,
    emails    varchar(200)
);

create table member_authorities
(
    member_id varchar(50) not null,
    authority varchar(50) not null,
    primary key (member_id, authority)
);

create table article
(
    id    int not null auto_increment primary key,
    title varchar(255)
);

create table article_content
(
    id           int not null primary key,
    content      varchar(255),
    content_type varchar(255)
);

create table evententry
(
    id             int not null AUTO_INCREMENT PRIMARY KEY,
    `type`         varchar(255),
    `content_type` varchar(255),
    payload        MEDIUMTEXT,
    `timestamp`    datetime
);

create table locks
(
    `type`          varchar(255),
    id              varchar(255),
    lockid          varchar(255),
    expiration_time datetime,
    primary key (`type`, id)
);

create unique index locks_idx ON locks (lockid);

insert into member (member_id, name, password, blocked) values ('user1', '사용자1', '1234', false);
insert into member (member_id, name, password, blocked) values ('user2', '사용자2', '5678', false);
insert into member (member_id, name, password, blocked) values ('admin', '운영자', 'admin1234', false);
insert into member_authorities values ('user1', 'ROLE_USER');
insert into member_authorities values ('user2', 'ROLE_USER');
insert into member_authorities values ('admin', 'ROLE_ADMIN');

insert into category values (1001, '전자제품');
insert into category values (2001, '필기구');

insert into product values ('prod-001', '라즈베리파이3 모델B', 56000, '모델B');
insert into image (product_id, list_idx, image_type, image_path, upload_time)
values ('prod-001', 0, 'II', 'rpi3.jpg', now());

insert into image (product_id, list_idx, image_type, image_path, upload_time)
values ('prod-001', 1, 'EI', 'http://external/image/path', now());

insert into product_category values ('prod-001', 1001);

insert into product values ('prod-002', '어프로치 휴대용 화이트보드 세트', 11920, '화이트보드');
insert into image (product_id, list_idx, image_type, image_path, upload_time)
values ('prod-002', 0, 'II', 'wbp.png', now());

insert into product_category values ('prod-002', 2001);

insert into product values ('prod-003', '볼펜 겸용 터치펜', 9000, '볼펜과 터치펜을 하나로!');
insert into image (product_id, list_idx, image_type, image_path, upload_time)
values ('prod-003', 0, 'II', 'pen.jpg', now());

insert into image (product_id, list_idx, image_type, image_path, upload_time)
values ('prod-003', 1, 'II', 'pen2.jpg', now());

insert into product_category values ('prod-003', 1001);
insert into product_category values ('prod-003', 2001);