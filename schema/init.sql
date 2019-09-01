create  table  test.user
(
	id bigint unsigned auto_increment
		primary key,
	name varchar(100) null,
	age int null
)
collate=utf8mb4_bin;

INSERT INTO test.user (id, name, age) VALUES (2, '测试用户931237535', 95);
INSERT INTO test.user (id, name, age) VALUES (3, '测试用户-993266589', 42);
INSERT INTO test.user (id, name, age) VALUES (4, '测试用户-1129243697', 23);
INSERT INTO test.user (id, name, age) VALUES (5, '测试用户631082338', 97);
INSERT INTO test.user (id, name, age) VALUES (6, '测试用户570788101', 77);
INSERT INTO test.user (id, name, age) VALUES (7, '测试用户245252503', 73);
INSERT INTO test.user (id, name, age) VALUES (8, '测试用户-395260143', 30);
INSERT INTO test.user (id, name, age) VALUES (9, '测试用户-1323382877', 73);
INSERT INTO test.user (id, name, age) VALUES (10, '测试用户1191452461', 52);
