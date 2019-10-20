部门 D   部门号 dno  名称 dname  经理名  mname  地址 addr   电话号 tel
职员 W   职工号 wno  姓名 wname  年  龄  age    职务 duty   工  资 mon   部门号 dno

1、在hr/oracle用户模式下，根据以上关系模式创建部门和职工表，每个表各插入2条测试数据。(10分)


建表：
create table D (dno varchar2(20), dname varchar2(20), mname varchar2(20),  addr varchar2(20), tel int);
create table W (wno varchar2(20), wname varchar2(20), age int, duty varchar2(20), mon int, dno varchar2(20) );

插入数据:
insert into D values('D1','销售部门','经理柳永','湖北十堰',123456);
insert into D values('D2','开发部门','经理晏殊','上海浦东',246889);
insert into W values('W1','职工李清照',24,'销售员',4000,'D1');
insert into W values('W2','职工辛弃疾',35,'开发员',7000,'D2');
select *from D;
select *from W;

删除表
drop table W;
drop table D;

2、定义用户，用SQL的GRANT和REVOKE语句完成以下授权定义或存取控制功能。
⑴ 创建数据库本地用户test，密码为oracle，默认表空间为users，临时表空间为temp，
同时具有create session系统权限。用户test对两个表具有SELECT权力。(10分)

定义用户
create user test
identified by oracle
default tablespace users
temporary tablespace temp;

让用户具有创建回话的权利
grant create session to test;

授权
grant select on hr.D to test; 
grant select on hr.W to test;
撤回授权
revoke select on hr.D from test; 
revoke select on hr.W from test;



⑵ 用户王明对职工和部门表有INSERT和DELETE权力。(10分)

定义用户
create user wangming
identified by oracle
default tablespace users
temporary tablespace temp;

让用户具有创建回话的权利
grant create session to wangming;

授权
grant insert on hr.D to wangming; 
grant insert on hr.W to wangming;
grant delete on hr.D to wangming; 
grant delete on hr.W to wangming;



⑶ 用户李勇对职工表有SELECT权力，对工资字段具有更新权力。(10分)

定义用户
create user liyong
identified by oracle
default tablespace users
temporary tablespace temp;

让用户具有创建回话的权利
grant create session to liyong;

授权
grant select on hr.W to liyong;
grant update(mon) on hr.W to liyong;


⑷ 用户周平具有对两个表所有权力(读、插、改、删数据)，并具有给其他用户授权的权力。
提示：所有权力为ALL PRIVILEGES，在GRANT语句中使用WITH GRANT OPTION选项，被授权的用户就具有了再次将对象权限授予其他用户的能力。(15分)

定义用户
create user zhouping
identified by oracle
default tablespace users
temporary tablespace temp;

让用户具有创建回话的权利
grant create session to zhouping;

授权
grant all privileges on hr.D to zhouping;
grant all privileges on hr.W to zhouping WITH GRANT OPTION;



3、用户杨兰具有从每个部门职工中SELECT最高工资，最低工资，平均工资的权力，他不能查看每个人的工资。
提示：首先创建视图查询每个部门职工中的最高工资，最低工资和平均工资，然后授予用户查询视图的权限。(20分)

定义视图
create view v3 as select 
max(mon) as 最高工资,
min(mon) as 最低工资,
avg(mon) as 平均工资
from hr.W group by dno;

select * from v3;



定义用户
create user yanglan
identified by oracle
default tablespace users
temporary tablespace temp;

让用户具有创建回话的权利
grant create session to yanglan;

授权
grant select on hr.v3 to yanglan;



4、设计角色“student”，可以查看年龄在40岁以上（包括）职工的职工号、姓名、年龄。
将用户“liming”添加到角色“student”中。提示：用视图实现(20分)

定义视图
create view v4 as select wno,wname,age from hr.W where age>40 ;
select * from v4;

定义角色
create role student;

定义用户
create user liming
identified by oracle
default tablespace users
temporary tablespace temp;

让用户具有创建回话的权利
grant create session to liming;

给角色权利
grant select on hr.v4 to student;
把用户给相应的角色
grant student to liming;


