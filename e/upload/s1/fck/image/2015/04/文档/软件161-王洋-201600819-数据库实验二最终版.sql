���� D   ���ź� dno  ���� dname  ������  mname  ��ַ addr   �绰�� tel
ְԱ W   ְ���� wno  ���� wname  ��  ��  age    ְ�� duty   ��  �� mon   ���ź� dno

1����hr/oracle�û�ģʽ�£��������Ϲ�ϵģʽ�������ź�ְ����ÿ���������2���������ݡ�(10��)


����
create table D (dno varchar2(20), dname varchar2(20), mname varchar2(20),  addr varchar2(20), tel int);
create table W (wno varchar2(20), wname varchar2(20), age int, duty varchar2(20), mon int, dno varchar2(20) );

��������:
insert into D values('D1','���۲���','��������','����ʮ��',123456);
insert into D values('D2','��������','��������','�Ϻ��ֶ�',246889);
insert into W values('W1','ְ��������',24,'����Ա',4000,'D1');
insert into W values('W2','ְ��������',35,'����Ա',7000,'D2');
select *from D;
select *from W;

ɾ����
drop table W;
drop table D;

2�������û�����SQL��GRANT��REVOKE������������Ȩ������ȡ���ƹ��ܡ�
�� �������ݿⱾ���û�test������Ϊoracle��Ĭ�ϱ�ռ�Ϊusers����ʱ��ռ�Ϊtemp��
ͬʱ����create sessionϵͳȨ�ޡ��û�test�����������SELECTȨ����(10��)

�����û�
create user test
identified by oracle
default tablespace users
temporary tablespace temp;

���û����д����ػ���Ȩ��
grant create session to test;

��Ȩ
grant select on hr.D to test; 
grant select on hr.W to test;
������Ȩ
revoke select on hr.D from test; 
revoke select on hr.W from test;



�� �û�������ְ���Ͳ��ű���INSERT��DELETEȨ����(10��)

�����û�
create user wangming
identified by oracle
default tablespace users
temporary tablespace temp;

���û����д����ػ���Ȩ��
grant create session to wangming;

��Ȩ
grant insert on hr.D to wangming; 
grant insert on hr.W to wangming;
grant delete on hr.D to wangming; 
grant delete on hr.W to wangming;



�� �û����¶�ְ������SELECTȨ�����Թ����ֶξ��и���Ȩ����(10��)

�����û�
create user liyong
identified by oracle
default tablespace users
temporary tablespace temp;

���û����д����ػ���Ȩ��
grant create session to liyong;

��Ȩ
grant select on hr.W to liyong;
grant update(mon) on hr.W to liyong;


�� �û���ƽ���ж�����������Ȩ��(�����塢�ġ�ɾ����)�������и������û���Ȩ��Ȩ����
��ʾ������Ȩ��ΪALL PRIVILEGES����GRANT�����ʹ��WITH GRANT OPTIONѡ�����Ȩ���û��;������ٴν�����Ȩ�����������û���������(15��)

�����û�
create user zhouping
identified by oracle
default tablespace users
temporary tablespace temp;

���û����д����ػ���Ȩ��
grant create session to zhouping;

��Ȩ
grant all privileges on hr.D to zhouping;
grant all privileges on hr.W to zhouping WITH GRANT OPTION;



3���û��������д�ÿ������ְ����SELECT��߹��ʣ���͹��ʣ�ƽ�����ʵ�Ȩ���������ܲ鿴ÿ���˵Ĺ��ʡ�
��ʾ�����ȴ�����ͼ��ѯÿ������ְ���е���߹��ʣ���͹��ʺ�ƽ�����ʣ�Ȼ�������û���ѯ��ͼ��Ȩ�ޡ�(20��)

������ͼ
create view v3 as select 
max(mon) as ��߹���,
min(mon) as ��͹���,
avg(mon) as ƽ������
from hr.W group by dno;

select * from v3;



�����û�
create user yanglan
identified by oracle
default tablespace users
temporary tablespace temp;

���û����д����ػ���Ȩ��
grant create session to yanglan;

��Ȩ
grant select on hr.v3 to yanglan;



4����ƽ�ɫ��student�������Բ鿴������40�����ϣ�������ְ����ְ���š����������䡣
���û���liming����ӵ���ɫ��student���С���ʾ������ͼʵ��(20��)

������ͼ
create view v4 as select wno,wname,age from hr.W where age>40 ;
select * from v4;

�����ɫ
create role student;

�����û�
create user liming
identified by oracle
default tablespace users
temporary tablespace temp;

���û����д����ػ���Ȩ��
grant create session to liming;

����ɫȨ��
grant select on hr.v4 to student;
���û�����Ӧ�Ľ�ɫ
grant student to liming;


