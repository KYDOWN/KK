��15��
��ϰ1
--1.����һ����ͼ��ͨ������ͼ���Բ�ѯ��������2000-5000�ڲ��������а�����A��Ա����ţ����������ʡ�
create view sal2_5 
as select empno Ա�����,ename ����,sal ���� from emp
where sal between 2000 and 5000
and ename like '%A%';
--2.ͨ��������������ͼ��ѯ����
select * from sal2_5;
��ϰ2
--1.����һ����ͼ��ͨ������ͼ���Բ�ѯ��������NEW YORK��CHICAGO��Ա����ţ����������ű�ţ���ְ���ڡ�
create or replace view dept_loc_ve(Ա�����,����,���ű��,��ְ����)
as select e.empno,e.ename,e.deptno,e.hiredate
from emp e,dept d
where e.deptno=d.deptno
and d.loc in('NEW YORK','CHICAGO');

--2.����һ����ͼ��ͨ������ͼ���Բ�ѯ��ÿ�����ŵĲ������Ƽ���͹��ʡ�
 create or replace view dept_minsal_ve(�������ƣ� ��͹���)
        as select d.dname, min(nvl(e.sal, 0))
             from emp e, dept d
            where e.deptno(+) = d.deptno
            group by d.dname;
--������3.ͨ��������ͼ����ѯÿ�����Ź�����͵�Ա����������������
select e.ename ����, m.�������� 
      from emp e, dept_minsal_ve m, dept d
     where e.deptno = d.deptno
       and d.dname = m.��������
       and m.��͹��� = e.sal;   -----��������
       
       
�κ���ҵ
---1.������ͼv_emp_20������20�Ų��ŵ�Ա����ţ���������н��(��н=12*(����+���𣩣�
create or replace view v_emp_20
as select empno,ename,12*(nvl(sal,0)+nvl(comm,0)) ��н
from emp;
select * from v_emp_20;
--2.����ͼv_emp_20�в�ѯ��н����1��ԪԱ������Ϣ��
 select * from v_emp_20 where ��н > 10000;
--3.��Ϊ���ʴ���2000��Ա��������ͼ��Ҫ����ʾԱ���Ĳ�����Ϣ��ְλ��Ϣ�������ص㣻
create view sal2_ve as
select e.deptno,e.job ,d.dname,d.loc from emp e ,dept d
where e.deptno=d.deptno and sal>2000;

--4.���������ͼִ��insert,update,delete,����ܷ�ɹ���Ϊʲô��
insert into v_emp_20 values(1214,'�Ǻ�',2000);--no ������������
update v_emp_20 set empno = 1214 where empno = 1234; --ok
    delete v_emp_20;--ok

    --  ��sal2_ve ��ͼִ�в���
    insert into sal2_ve values (12,'�ϰ�','����');--no ok
    --  1����ְλ������Ӳ�ѯʱ��Ϊ������������
    --  2����ʹ�ö������ʱ��Ϊ�޷�ͨ��������ͼ�޸Ķ������

    update sal2_ve set deptno = 20 where deptno = 10; --ok
    delete sal2_ve;--ok
    select * from emp;
    select * from dept;
    select * from sal2_ve;
��16��
��ϰ1
--1.����һ�����У���������ʼֵ��1��ʼ�������ֵ��������1����ѭ����
create sequence test3
start with 1
nomaxvalue
increment by 1
nocycle;
--2.��ѯ���еĵ�ǰֵ����һ��ֵ
select test3.currval from dual;-------��ѯ���еĵ�ǰֵ:currval
select test3.nextval from dual;-------��ѯ���е���һ��ֵ:nextval
--3.ʹ�õ�1�����������У����ű��в���������¼�����ű��ʹ������ֵ��
--�������Ʒֱ�Ϊ��Education��Market�����зֱ�Ϊ��DALLAS��WASHTON

insert into dept (deptno,dname,loc) values (test3.nextval,'Education','DALLAS');
insert into dept (deptno,dname,loc) values (test3.nextval,'Market','WASHTON');
��ϰ2
--1.ʹ���Ӳ�ѯ�ķ�ʽ������test��
 create table test as select * from emp;
--2.���ٸ���test���е����ݣ����Ƶ�100w������
insert into test select * from test;            ----һֱ��
--3.����test���е�empno�ֶ�Ϊrownum
update test set empno=rownum;
--4.��ѯtest��empnoΪ800000�ļ�¼ֵ����¼��ѯִ��ʱ�䡣
select * from test
where empno=800000
ִ��ʱ�䣺0.031
--5.��test���empno�ֶ��ϴ�������
create index index_empno
on test(empno);
--6.����ִ�е�4�⣬�ԱȲ�ѯʱ��
select * from test
where empno=800000
ִ��ʱ�䣺0.016

��ϰ3
--1.�����¹�ϵģʽ��
student(sno,sname,gender,birthday,email);--ѧ��
course(cno,cname,type,credit);--�γ�
sc��sno,cno,grade);--ѡ��
�Է�����Щ�����ʺϴ���������
 --  �﷨��create index ������ on ���� (����);
    son , cno
    
�κ���ҵ
--1.�������У���ʼλ1������Ϊ1����СֵΪ1�����ֵΪ9999
create sequence test1
start with 1 --���д�1��ʼ
increment by 1 --����ÿ������1
minvalue 1 --������Сֵ1
maxvalue 9999 --�������ֵ9999
--2.�������У���ʼֵΪ50��ÿ������5��
create sequence test2
start with 50
increment by 5
--3.�ڱ�copy_dept�в����¼�����в��ź��������һ���д������������ɣ�
------����copy_dept��--------
create table copy_dept as
select * from dept where 1=0;
------copy_dept�������������dept���Ǹ���dept��������--------
insert into copy_dept
select * from dept
------���в��ź��������һ���д�������������--------
insert into copy_dept
values(test1.nextval,'RESOUCE','BEIJING')

select *from copy_dept
--4.��Ϊ���ʴ����������Ƚ�<10000,>1000,��round��sal��>10000,
�ĸ�������Ч���ĸ�������Ч��
    create index sal_index on emp(sal);
    select * from emp where sal < 10000;--������
    select * from emp where sal > 1000;--������
    select * from emp where round(sal) > 10000;--���������к���
--5.���������á�create table copy_emp_index as select * from emp����
--����500�������ݣ������еġ�Ա���š��ֶ��޸�ΪΨһ��
create table copy_emp_index as select * from emp----����copy_emp_index���ݴ�emp��������

alter table copy_emp_index modify (empno number(10))-----�޸ı���empno���ֶ�alter----modify ��

insert into copy_emp_index select * from copy_emp_index ------����ƣ���������ֶβ��ܺ���Ψһ��Լ�����еĻ��Ͳ��ܸ�����

update copy_emp_index set empno = rownum----------����empnoΪrownumα��

alter table copy_emp_index modify(empno unique)-----------�޸ı���empno���ֶ�ΪΨһ

select * from copy_emp_index
--6.��ѯ��copy_emp_index����Ա����Ϊ200001��Ա�����������ʣ���¼ִ��ʱ�䣻
select ename,sal
from copy_emp_index
where empno=200001;
-----ִ��ʱ����0�룬��Ϊ������Ŀ�Ѿ�empno������uniqueΨһ�ԣ�ϵͳ�Ѿ��Զ��������õ�Ψһ��
--7.��copy_emp_index���empno�ֶ��ϴ����������ٴ�ִ�е�6����䣬��¼ִ��ʱ�䲢���Աȣ�
----------��������:������������ʧ�ܣ���Ϊ�����Ѿ������ˣ���һ���������Ĵ�------
create index index_empno
on copy_emp_index(empno)
-------ִ��������ѯ����֤��Ч��---------
select ename,sal
from copy_emp_index
where empno=200001;

��17��
��ϰ1
--1.�Լ����Դ���һ���û�user1
  --  �����û�ҲҪ��sys ����Ա�û��²���
    create user user1 identified by admin;
--2.ʹ�ù���Ա�˻�Ϊ�û�user1����create session��create table��Ȩ�ޡ�
  --  ��Ϊsys dbaȨ�޵�¼
    grant create session, create table to user1;
    
�κ���ҵ
--1.�������û�neu
create user neu identified by admin;
--2.���û�neu��Ȩ,ʹ���ܹ���¼�����ݿ⣬�ܹ���ѯscott�µ�emp��
--���޸�emp���sal,ename�����ֶ�
grant create session to neu;
grant select on scott.emp to neu;
grant update(sal,ename) on scott.emp to neu;
3.�����û�neu�ĵ�¼Ȩ��
revoke create session from neu;
4.�����û�neu�����ж���Ȩ��
revoke select on scott.emp from neu;
revoke update on scott.emp from neu;
5.������ɫrole_neu
create role role_neu;
6.����ɫrole_neu��Ȩ,ʹ���ܹ���¼�����ݿ�
grant create session to role_neu;
7.����ɫrole_neu���û�neu
grant role_neu to neu;
8.ɾ����ɫrole_neu
drop role role_neu;
9.ɾ���û�neu
drop user neu;
  --  ע�⣺��Ҫ�Ͽ����Ӳ���ɾ��
