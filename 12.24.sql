----1.使用两种方式查询所有员工(EMP)信息
select * from emp
select empno, ename, job, mgr, hiredate, sal, comm, deptno from emp
--2.查询(EMP)员工编号、员工姓名、员工职位、员工月薪、工作部门编号。
select empno, ename, job, sal,  deptno from emp

--1.员工转正后，月薪上调20%，请查询出所有员工转正后的月薪。
select sal*1.2 from emp
--2.员工试用期6个月，转正后月薪上调20%，请查询出所有员工工作第一年的年薪所得（不考虑奖金部分,年薪的试用期6个月的月薪+转正后6个月的月薪)
select sal*6+sal*1.2*6 from emp
---!!!1.员工试用期6个月，转正后月薪上调20%，请查询出所有员工工作第一年的所有收入（需考虑奖金部分)，要求显示列标题为员工姓名，工资收入，奖金收入，总收入。
--为0时，全部为0，所以要用nvl
select ename 员工姓名 ,(sal*6+sal*1.2*6) 工资收入, nvl((comm*6+comm*6*1.2),0) 奖金收入,(sal*6+sal*1.2*6)+nvl((comm*6+comm*6*1.2),0) 总收入 from emp
--？？1.员工试用期6个月，转正后月薪上调20%，请查询出所有员工工作第一年的所有收入（需考虑奖金部分)，要求显示格式为:XXX的第一年总收入为XXX。
select ename||'的第一年总收入为'||((sal*6)+(sal*1.2*6)+nvl(comm,0)) 员工的第一年收入
from emp;
--2.查询员工表中一共有哪几种岗位类型。
select distinct job from emp
--1.分别选择员工表、部门表、薪资等级表中的所有数据。
select * from emp,dept,salgrade
--2.分别查看员工表、部门表、薪资等级表的表结构。

--1.查询职位为SALESMAN的员工编号、职位、入职日期。
select empno,job,hiredate from emp where job='SALESMAN' --用了单引号，原本大写就大写，小写无效
--!!!2.查询1985年12月31日之前入职的员工姓名及入职日期。
--要有to-date，括号，逗号
select ename,hiredate from emp where hiredate<to_date('31-12-1985','dd-mm-yyyy')
---2.查询1985年12月31日之前入职的员工姓名及入职日期。
select ename 员工姓名,hiredate 入职日期
from emp
where hiredate < to_date('31-12-1985','DD-MM-YYYY');--------to_date('31-12-1985','DD-MM-YYYY')

select ename,hiredate
from emp
where hiredate <'31-12月-85';----'DD-MM月-YY'
--3.查询部门编号不在10部门的员工姓名、部门编号。
select ename,empno from emp where deptno not in( 10 )
--1.查询入职日期在82年至85年的员工姓名，入职日期。
select ename,hiredate from emp where hiredate between to_date('01-01-1982','dd-mm-yyyy') and to_date('31-12-1985','dd-mm-yyyy')
--2.查询月薪在3000到5000的员工姓名，月薪。
select ename,sal from emp where sal between 3000 and 5000
--3.查询部门编号为10或者20的员工姓名，部门编号。
select ename,deptno from emp where deptno=10 or deptno=20
--4.查询经理编号为7902, 7566, 7788的员工姓名，经理编号。
select ename,mgr from emp where mgr in (7902,7566,7786)
--1.查询员工姓名以W开头的员工姓名。
select ename from emp where ename like 'W%'  --W要大写，小写不行，因为用了引号，所以要对应表里面的数据
--2.查询员工姓名倒数第2个字符为T的员工姓名。
select ename from emp where ename like '%T_'
--3.查询奖金为空的员工姓名，奖金。
select ename,comm from emp where comm is null
--???1.查询工资超过2000并且职位是MANAGER,或者职位是SALESMAN的员工姓名、职位、工资
select ename,job,sal from emp where sal > 2000 and job='MANAGER'  or job='SALESMAN'
--???2.查询工资超过2000并且职位是 MANAGER或SALESMAN的员工姓名、职位、工资。
select ename,job,sal from emp where sal > 2000 and (job='MANAGER' or job='SALESMAN')
--3.查询部门在10或者20，并且工资在3000到5000之间的员工姓名、部门、工资。
select ename,deptno,sal from emp where deptno in('10','20') and (sal between 3000 and 5000)
--4.查询入职日期在81年，并且职位不是SALES开头的员工姓名、入职日期、职位。
select ename,hiredate,job from emp where hiredate between to_date('01-01-1981','dd-mm-yyyy') and to_date('31-12-1981','dd-mm-yyyy') and job  not like  'SALES%'
--格式只能是01-01-1981，没有1-1-1981
--5.查询职位为SALESMAN或MANAGER，部门编号为10或者20，姓名包含A的员工姓名、职位、部门编号。
select ename,job,deptno from emp where job in('SALESMAN','MANAGER') and deptno in(10,20) and ename like '%A%'
--1.查询部门在20或30的员工姓名，部门编号，并按照工资升序排序。
select ename,deptno from emp where deptno in(20,30) order by sal asc
--2.查询工资在2000-3000之间，部门不在10号的员工姓名，部门编号，工资，并按照部门升序，工资降序排序。
select ename,deptno,sal from emp where( sal between 2000 and 3000 ) and deptno not in(10) order by sal desc
--3.查询入职日期在82年至83年之间，职位以SALES或者MAN开头的员工姓名，入职日期，职位，并按照入职日期降序排序。
select ename,hiredate,job from emp where( hiredate between to_date('01-01-1982','dd-mm-yyyy') and to_date('31-12-1983','dd-mm-yyyy')) 
and (job  like  'SALES%' or job  like 'MAN%') order by hiredate desc
--1.查询入职时间在1982-7-9之后，并且不从事SALESMAN工作的员工姓名、入职时间、职位。
select ename,hiredate,job from emp where hiredate >to_date('09-07-1982','dd-mm-yyyy') and job not in('SALESMAN')
--2.查询员工姓名的第三个字母是a的员工姓名。
select ename from emp where ename like '__A%'
--3.查询除了10、20号部门以外的员工姓名、部门编号。
select ename,deptno from emp where deptno not in(10,20)
--???4.查询部门号为30号员工的信息，先按工资降序排序，再按姓名升序排序。
select * from emp where deptno='30' order by sal desc , ename asc
--5.查询没有上级的员工(经理号为空)的员工姓名。
select ename from emp where mgr is null
--6.查询工资大于等于4500并且部门为10或者20的员工的姓名\工资、部门编号。
select ename,sal,deptno from emp where sal>=4500 and deptno in(10,20)
