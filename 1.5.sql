第15章
练习1
--1.创建一个视图，通过该视图可以查询到工资在2000-5000内并且姓名中包含有A的员工编号，姓名，工资。
create view sal2_5 
as select empno 员工编号,ename 姓名,sal 工资 from emp
where sal between 2000 and 5000
and ename like '%A%';
--2.通过上述创建的视图查询数据
select * from sal2_5;
练习2
--1.创建一个视图，通过该视图可以查询到工作在NEW YORK和CHICAGO的员工编号，姓名，部门编号，入职日期。
create or replace view dept_loc_ve(员工编号,姓名,部门编号,入职日期)
as select e.empno,e.ename,e.deptno,e.hiredate
from emp e,dept d
where e.deptno=d.deptno
and d.loc in('NEW YORK','CHICAGO');

--2.创建一个视图，通过该视图可以查询到每个部门的部门名称及最低工资。
 create or replace view dept_minsal_ve(部门名称， 最低工资)
        as select d.dname, min(nvl(e.sal, 0))
             from emp e, dept d
            where e.deptno(+) = d.deptno
            group by d.dname;
--！！！3.通过如上视图，查询每个部门工资最低的员工姓名及部门名称
select e.ename 姓名, m.部门名称 
      from emp e, dept_minsal_ve m, dept d
     where e.deptno = d.deptno
       and d.dname = m.部门名称
       and m.最低工资 = e.sal;   -----！！！！
       
       
课后作业
---1.创建视图v_emp_20，包含20号部门的员工编号，姓名，年薪列(年薪=12*(工资+奖金）；
create or replace view v_emp_20
as select empno,ename,12*(nvl(sal,0)+nvl(comm,0)) 年薪
from emp;
select * from v_emp_20;
--2.从视图v_emp_20中查询年薪大于1万元员工的信息；
 select * from v_emp_20 where 年薪 > 10000;
--3.请为工资大于2000的员工创建视图，要求显示员工的部门信息，职位信息，工作地点；
create view sal2_ve as
select e.deptno,e.job ,d.dname,d.loc from emp e ,dept d
where e.deptno=d.deptno and sal>2000;

--4.针对以上视图执行insert,update,delete,语句能否成功，为什么？
insert into v_emp_20 values(1214,'呵呵',2000);--no 不允许虚拟列
update v_emp_20 set empno = 1214 where empno = 1234; --ok
    delete v_emp_20;--ok

    --  向sal2_ve 视图执行操作
    insert into sal2_ve values (12,'老板','北京');--no ok
    --  1、当职位用相关子查询时，为不允许虚拟列
    --  2、当使用多表连接时，为无法通过连接视图修改多个基表

    update sal2_ve set deptno = 20 where deptno = 10; --ok
    delete sal2_ve;--ok
    select * from emp;
    select * from dept;
    select * from sal2_ve;
第16章
练习1
--1.创建一个序列，该序列起始值从1开始，无最大值，增量是1，不循环。
create sequence test3
start with 1
nomaxvalue
increment by 1
nocycle;
--2.查询序列的当前值及下一个值
select test3.currval from dual;-------查询序列的当前值:currval
select test3.nextval from dual;-------查询序列的下一个值:nextval
--3.使用第1题所建的序列，向部门表中插入两条记录，部门编号使用序列值，
--部门名称分别为：Education、Market，城市分别为：DALLAS、WASHTON

insert into dept (deptno,dname,loc) values (test3.nextval,'Education','DALLAS');
insert into dept (deptno,dname,loc) values (test3.nextval,'Market','WASHTON');
练习2
--1.使用子查询的方式，创建test表。
 create table test as select * from emp;
--2.快速复制test表中的数据，复制到100w条左右
insert into test select * from test;            ----一直加
--3.更新test表中的empno字段为rownum
update test set empno=rownum;
--4.查询test中empno为800000的记录值，记录查询执行时间。
select * from test
where empno=800000
执行时间：0.031
--5.在test表的empno字段上创建索引
create index index_empno
on test(empno);
--6.重新执行第4题，对比查询时间
select * from test
where empno=800000
执行时间：0.016

练习3
--1.有如下关系模式，
student(sno,sname,gender,birthday,email);--学生
course(cno,cname,type,credit);--课程
sc（sno,cno,grade);--选课
试分析哪些列上适合创建索引？
 --  语法：create index 索引名 on 表名 (列名);
    son , cno
    
课后作业
--1.创建序列，起始位1，自增为1，最小值为1，最大值为9999
create sequence test1
start with 1 --序列从1开始
increment by 1 --序列每次增加1
minvalue 1 --序列最小值1
maxvalue 9999 --序列最大值9999
--2.创建序列，起始值为50，每次增加5；
create sequence test2
start with 50
increment by 5
--3.在表copy_dept中插入记录，其中部门号码采用上一步中创建的序列生成；
------创建copy_dept表--------
create table copy_dept as
select * from dept where 1=0;
------copy_dept表插入数据来自dept即是复制dept表中数据--------
insert into copy_dept
select * from dept
------其中部门号码采用上一步中创建的序列生成--------
insert into copy_dept
values(test1.nextval,'RESOUCE','BEIJING')

select *from copy_dept
--4.请为工资创建索引，比较<10000,>1000,与round（sal）>10000,
哪个索引有效，哪个索引无效；
    create index sal_index on emp(sal);
    select * from emp where sal < 10000;--有索引
    select * from emp where sal > 1000;--有索引
    select * from emp where round(sal) > 10000;--无索引，有函数
--5.创建表，采用“create table copy_emp_index as select * from emp”，
--生成500万条数据，把其中的“员工号”字段修改为唯一；
create table copy_emp_index as select * from emp----创建copy_emp_index数据从emp表中引用

alter table copy_emp_index modify (empno number(10))-----修改表中empno列字段alter----modify —

insert into copy_emp_index select * from copy_emp_index ------疯狂复制，表里面的字段不能含有唯一性约束，有的话就不能复制了

update copy_emp_index set empno = rownum----------设置empno为rownum伪列

alter table copy_emp_index modify(empno unique)-----------修改表中empno列字段为唯一

select * from copy_emp_index
--6.查询表copy_emp_index表中员工号为200001的员工姓名，工资，记录执行时间；
select ename,sal
from copy_emp_index
where empno=200001;
-----执行时间是0秒，因为上面题目已经empno设置了unique唯一性，系统已经自动帮你设置的唯一性
--7.在copy_emp_index表的empno字段上创建索引，再次执行第6题语句，记录执行时间并做对比；
----------创建索引:此题索引创建失败，因为上面已经创建了，上一题就是这题的答案------
create index index_empno
on copy_emp_index(empno)
-------执行索引查询，验证其效率---------
select ename,sal
from copy_emp_index
where empno=200001;

第17章
练习1
--1.自己尝试创建一个用户user1
  --  创建用户也要在sys 管理员用户下操作
    create user user1 identified by admin;
--2.使用管理员账户为用户user1分配create session和create table的权限。
  --  换为sys dba权限登录
    grant create session, create table to user1;
    
课后作业
--1.建立新用户neu
create user neu identified by admin;
--2.给用户neu授权,使其能够登录到数据库，能够查询scott下的emp表，
--能修改emp表的sal,ename两个字段
grant create session to neu;
grant select on scott.emp to neu;
grant update(sal,ename) on scott.emp to neu;
3.回收用户neu的登录权限
revoke create session from neu;
4.回收用户neu的所有对象权限
revoke select on scott.emp from neu;
revoke update on scott.emp from neu;
5.建立角色role_neu
create role role_neu;
6.给角色role_neu授权,使其能够登录到数据库
grant create session to role_neu;
7.赋角色role_neu给用户neu
grant role_neu to neu;
8.删除角色role_neu
drop role role_neu;
9.删除用户neu
drop user neu;
  --  注意：需要断开连接才能删除
