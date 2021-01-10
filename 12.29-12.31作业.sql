--1.查询入职日期最早的员工姓名，入职日期
select ename,hiredate
from emp 
where hiredate=(select min(hiredate)from emp )
--2.查询工资比SMITH工资高并且工作地点在CHICAGO的员工姓名，工资，部门名称
select e.ename,e.sal,d.dname
from emp e,dept d
where e.deptno=d.deptno
and e.sal>(select sal from emp where ename='SMITH' )
and d.loc='CHICAGO'
--3.查询入职日期比20部门入职日期最早的员工还要早的员工姓名，入职日期
select ename,hiredate
from emp
where hiredate<(select min(hiredate) from emp where deptno=20)
--4.查询部门人数大于所有部门平均人数的的部门编号，部门名称，部门人数
select d.deptno,d.dname,count(1) 部门人数
from emp e,dept d
where e.deptno=d.deptno
group by  d.deptno,d.dname
having count(1)>(select avg(count(1)) from emp group by  deptno )
select empno, ename, job, mgr, hiredate, sal, comm, deptno from emp
--1.查询入职日期比10部门任意一个员工晚的员工姓名、入职日期，不包括10部门员工
select ename,hiredate
from emp
where hiredate>any (select hiredate from emp where deptno=10)
and deptno<>10
--2.查询入职日期比10部门所有员工晚的员工姓名、入职日期，不包括10部门员工
select ename,hiredate
from emp
where hiredate>all (select hiredate from emp where deptno=10)
and deptno<>10
--3.查询职位和10部门任意一个员工职位相同的员工姓名，职位，不包括10部门员工
select ename , job
from emp
where job = any(select job from emp where deptno = 10)
and deptno <> 10;
--"查询职位和10部门任意一个员工职位相同的....."是查询“职位”，只不过职位是“和10部门任意一个员工职位相同的”，
--所以where job = any(select job from emp where deptno = 10)
--1.查询职位及经理和10部门任意一个员工职位及经理相同的员工姓名，职位，不包括10部门员工
select ename,job
from emp
where (job,mgr) in (select job,mgr from emp where deptno=10)
and deptno<>10
--2.查询职位及经理和10部门任意一个员工职位或经理相同的员工姓名，职位，不包括10部门员工
select ename,job
from emp
where (
job in(select job from emp where deptno=10)
or
mgr in(select mgr from emp where deptno=10)
)
and deptno<>10


--1.查询比自己职位平均工资高的员工姓名、职位，部门名称，职位平均工资
select e.ename,e.job,d.dname 部门名称,a.职位平均工资
from emp e,dept d,(select job ,avg(sal)职位平均工资 from  emp group by job) a
where e.job=a.job and e.deptno=d.deptno and e.sal>a.职位平均工资 --已经给别名“职位平均工资”了，则用a.avg(sal)会报错
--2.查询职位和经理同员工SCOTT或BLAKE完全相同的员工姓名、职位，不包括SCOTT和BLAKE本人。
select job, ename
      from emp 
     where (job, mgr) in
           (select job, mgr from emp  where ename in ('SCOTT', 'BLAKE'))
       and ename not in ('SCOTT', 'BLAKE');
--"职位和经理"则用(job,mgr)，并且(job,mgr)和这里(select job,mgr from emp中的 job,mgr对应
select empno, ename, job, mgr, hiredate, sal, comm, deptno from emp
--3.查询不是经理的员工姓名。
select ename
from emp
where empno not in(select distinct mgr from emp where mgr is not null)
--使用not in比较时，如果子查询的结果中有null值，那么比较的结果也是null值，所以建议把null去掉，否则查询没有结果
--  distinct 字段名称。distinct mgr：去掉重复的mgr

--1.查询入职日期最早的前5名员工姓名，入职日期。
select rownum,e.ename 员工姓名, e.hiredate 入职日期
from (select ename,hiredate from emp order by hiredate asc) e
where rownum <= 5;

--2.查询工作在CHICAGO并且入职日期最早的前2名员工姓名，入职日期。
   select rownum, e.ename 员工姓名, e.hiredate 入职日期, e.loc
      from (select e.*,d.*
              from emp e, dept d
             where e.deptno = d.deptno
               and d.loc = 'CHICAGO'
             order by hiredate asc) e
     where rownum <= 2;
   
1.按照每页显示5条记录，分别查询第1页，第2页，第3页信息，要求显示员工姓名、入职日期、部门名称。
 select e.rn       第1页,
           e.ename    员工姓名,
           e.hiredate 入职日期,
           e.dname    部门名称
      from (select rownum rn, e.*, d.*
              from emp e, dept d
             where e.deptno = d.deptno) e
     where e.rn <= 5;

 --
    select e.rn       第2页,
           e.ename    员工姓名,
           e.hiredate 入职日期,
           e.dname    部门名称
      from (select rownum rn, e.*, d.*
              from emp e, dept d
             where e.deptno = d.deptno) e
     where e.rn > 5
 --
  select e.rn       第3页,
           e.ename    员工姓名,
           e.hiredate 入职日期,
           e.dname    部门名称
      from (select rownum rn, e.*, d.*
              from emp e, dept d
             where e.deptno = d.deptno) e
     where e.rn > 10
       and rn <= 15;

--1.按照每页显示5条记录，分别查询工资最高的第1页，第2页，第3页信息，要求显示员工姓名、入职日期、部门名称、工资。
select e1.*
from
          (select rownum rn,e.*
                    from
                           (select e.ename,e.hiredate,e.sal,d.deptno,d.dname
                           from emp e,dept d
                           where e.deptno=d.deptno
                           order by sal desc) e
                    where rownum<=5 )e1
where e1.rn>0


select e2.*  --第二页
from    
                   (select rownum rn,e1.*
                    from
                           (select e.ename,e.hiredate,e.sal,d.deptno,d.dname
                           from emp e,dept d
                           where e.deptno=d.deptno
                           order by sal desc) e1
                    where rownum<=10) e2
where e2.rn>5
select e3.*  --第三页
from   
             (select rownum rn,e1.*
             from
                       (select e.ename,e.hiredate,e.sal,d.deptno,d.dname
                        from emp e,dept d
                       where e.deptno=d.deptno
                       order by sal desc) e1
                       where rownum<=15) e3
where e3.rn>10

--1.查询工资高于编号为7782的员工工资，并且和7369号员工从事相同工作的员工的编号、姓名及工资。
select empno 员工编号, ename 姓名, sal 工资
      from emp
     where sal > (select sal from emp where empno = 7782)
       and job = (select job from emp where empno = 7369)
       and empno <> 7369;
--2.查询工资最高的员工姓名和工资。 
   select ename 员工姓名, sal 工资
      from emp
     where sal = (select max(sal) from emp);
3.查询部门最低工资高于10号部门最低工资的部门的编号、名称及部门最低工资。
  SELECT e.deptno,dname,MIN(sal)
       FROM emp e,dept d
       WHERE e.deptno=d.deptno
      GROUP BY e.deptno,dname
       HAVING MIN(sal)<(SELECT MIN(sal)  FROM emp  WHERE deptno=10);
4.查询员工工资为其部门最低工资的员工的编号和姓名及工资。
select empno,ename,sal from emp e,(select deptno,min(sal) minsal from emp 
group by deptno) d
where e.deptno=d.deptno and sal=minsal
--"为其部门"：按部门编号分组
5.显示经理是KING的员工姓名，工资。
select ename,sal from emp where mgr=(select empno from emp where ename='KING')
--6.显示比员工SMITH参加工作时间晚的员工姓名，工资，参加工作时间。
select ename,sal,hiredate from emp where hiredate>(select hiredate from emp
where ename='SMITH')
7.使用子查询的方式查询哪些职员在NEW YORK工作。
select * from emp where deptno=(select deptno from dept where loc='NEW YORK')
8.写一个查询显示和员工SMITH工作在同一个部门的员工姓名，雇用日期，查询结果中排除SMITH。
select ename,hiredate from emp
where deptno=(select deptno  from emp where ename='SMITH') --员工SMITH工作在同一个部门            
and ename<>'SMITH';--查询结果中排除SMITH
9.写一个查询显示其工资比全体职员平均工资高的员工编号、姓名。
select empno,ename from emp where sal>(select avg(sal) from emp )
10.写一个查询显示其上级领导是King的员工姓名、工资。
select ename,sal from emp where mgr=(select empno from emp where ename='KING')
11.显示所有工作在RESEARCH部门的员工姓名，职位。
select ename,job from emp e,dept d where e.deptno=d.deptno and d.dname='RESEARCH'
--子查询：
select ename,job from emp where deptno=(select deptno from dept where dname='RESEARCH')
12.查询每个部门的部门编号、平均工资，要求部门的平均工资高于部门20的平均工资。
select deptno,avg(sal) from emp group by deptno 
having avg(sal)>(select avg(sal) from emp where deptno=20) 
--"查询每个部门的": group by deptno 
13.查询大于自己部门平均工资的员工姓名，工资，所在部门平均工资，高于部门平均工资的额度。
  select e.ename 员工姓名,
           e.sal 工资,
           ed.avgsal 所在部门平均工资,
           (e.sal - ed.avgsal) 高与平均工资额度
      from emp e,
           (select deptno, avg(sal) avgsal from emp group by deptno) ed
     where e.deptno = ed.deptno  --多表连接
       and e.sal > ed.avgsal;--大于自己部门平均工资
14. 列出至少有一个雇员的所有部门
select * from dept where deptno in(select deptno from emp group by deptno
having count(*)>0);
15. 列出薪金比"SMITH"多的所有雇员
select * from emp where sal>(select sal from emp where ename='SMITH')
16. 列出入职日期早于其直接上级的所有雇员
select * from emp e where hiredate<(select m.hiredate from emp m where m.empno=e.mgr)
--
 select e.ename      雇员姓名,
           e.mgr        雇员经理,
           e.hiredate   雇员入职日期,
           mgr.hiredate 经理入职日期
      from emp e, emp mgr
     where e.mgr = mgr.empno(+)
       and e.hiredate < mgr.hiredate;
17. 找员工姓名和直接上级的名字
 SELECT e.ename ,m.ename
  FROM emp e,emp m
 WHERE e.mgr=m.empno(+);  --与下面结果差别
 --
    select e.ename 员工姓名, mgr.ename 上级名字
      from emp e, emp mgr
     where e.mgr = mgr.empno;  
18. 显示部门名称和人数
select d.dname,count(empno) from emp e,dept d where e.deptno=d.deptno group by d.dname
19. 显示每个部门的最高工资的员工
 select deptno 部门, ename 员工姓名
      from emp
     where sal in (select max(sal) from emp group by deptno);
--有差别
 SELECT *FROM emp
 WHERE (deptno,sal) IN
                      (SELECT deptno,MAX(sal)
                       FROM emp
                      GROUP BY deptno);

20. 显示出和员工号7369部门相同的员工姓名，工资
    select ename 员工姓名, sal 工资
      from emp
     where deptno = (select deptno from emp where empno = 7369)
       and empno <> 7369;--比如“和员工号7369部门相同的员工姓名”中的这个员工叫A，则这句是为了证明自己不是A
21. 显示出和姓名中包含"W"的员工相同部门的员工姓名
    select ename 员工姓名
      from emp 
     where deptno = (select deptno from emp where ename like '%W%');
22. 显示出工资大于平均工资的员工姓名，工资
 select ename 员工姓名, sal 工资
      from emp
     where sal > (select avg(sal) from emp);
23. 显示出工资大于本部门平均工资的员工姓名，工资
    select e.ename 员工姓名, e.sal 工资
      from emp e,
           (select deptno,avg(sal) avgsal from emp group by deptno) a
     where e.deptno = a.deptno
       and e.sal > a.avgsal;
24. 显示每位经理管理员工的最低工资，及最低工资者的姓名
    select e.sal 最低工资, e.ename 姓名,e.mgr
      from emp e
     where (e.mgr,e.sal) in (select e.mgr, min(e.sal)
                               from emp e
                               group by e.mgr);
         
----
select sal,ename from emp where sal in(select min(sal) from emp group by mgr)
25. 显示比工资最高的员工参加工作时间晚的员工姓名，参加工作时间
    select ename 员工姓名, hiredate 参加工作时间
      from emp
     where hiredate >
           (select hiredate
              from emp
             where sal = (select max(sal) from emp));
26. 显示出平均工资最高的的部门平均工资及部门名称
SELECT * FROM (SELECT AVG(sal),dname
          FROM emp e,dept d
         WHERE e.deptno=d.deptno
         GROUP BY dname
         ORDER BY AVG(sal) DESC)
  WHERE ROWNUM<=1;
第八章
练习1
1.分别使用联合运算及完全联合运算完成，按照时间升序顺序，查询员工7839的工作岗位列表。
 --  union联合运算
      select job 工作岗位列表, hiredate from emp where empno = 7839
      union
      select job, begindate from emp_jobhistory ej where empno = 7839 
      order by hiredate;  --begindate不行

     --  union all完全联合运算  
      select job 工作岗位列表, hiredate from emp where empno = 7839
      union all
      select job, begindate from emp_jobhistory ej where empno = 7839 
      order by hiredate;

--2.使用多表连接，查询每个部门的部门编号，部门人数，没有人数的部门显示0。
 select d.deptno 部门编号, nvl (count(e.ename), 0) 部门人数  --题意“多表”，部门人数用emp表的ename统计
        from emp e, dept d
       where e.deptno(+) = d.deptno
       group by d.deptno;  --按部门号分好组后，就可以用emp表的ename统计各部门人数
--3.使用联合运算，查询每个部门的部门编号，部门人数，没有人数的部门显示0。
select deptno,count(1) 部门人数 
from emp 
where deptno is not null
group by deptno
union all
select deptno,nvl(to_number(null),0) 部门人数----因为count()是数字，所以要使用to_number函数
from dept
--为什么用字段nvl(to_number(null),0)中的null:
--因为题意“没有人数的部门显示0”，则又由nvl可知，当第一个参数为空时，结果转成第二个参数，所以用null


--4.使用联合运算，查询10号部门及20号部门的员工姓名，部门编号。
select ename 员工姓名,deptno 部门编号 from emp where deptno=10
union
select ename 员工姓名,deptno 部门编号 from emp where deptno =20
--5. 使用集合运算，输出如下效果？
部门              工作地点      员工姓名                       入职日期 

   10               NEW YORK 
   10                             CLARK                        1981/6/9 
   10                             KING                         1981/11/17 
   10                             MILLER                       1982/1/23 
   20               DALLAS 
   20                             ADAMS                        1987/5/23 
   20                             FORD                         1981/12/3 
   20                             JONES                        1981/4/2 
   20                             SCOTT                        1987/4/19 
   20                             SMITH                        1980/12/17 
   30               CHICAGO 
   30                             ALLEN                        1981/2/20 
   30                             BLAKE                        1981/5/1 
   30                             JAMES                        1981/12/3 
   30                             MARTIN                       1981/9/28 
   30                             TURNER                       1981/9/8 
   30                             WARD                         1981/2/22 
   40               BOSTON 
  
--select1
select deptno 部门,loc 工作地点,to_char(null) 姓名,to_date(null) 入职日期 --姓名是字符串，所以用to_char，入职日期是日期型,所以用to_date
from dept
union   ----会去重，会排序
--select2
select deptno,to_char(null) 工作地点,ename,hiredate
from emp

   
课后作业
1.用集合运算，列出不包含job为SALESMAN 的部门的部门号。
select deptno from dept
minus
select deptno from emp where job = 'SALESMAN';--全部-包含=不包含
---！！！2.写一个联合查询，列出下面的信息：
--EMP表中所有雇员的名字和部门编号,不管他们是否属于任何部门。
--DEPT表中的所有部门编号和部门名称，不管他们是否有员工。
select ename 雇员名字,deptno 部门编号,to_char(null) 部门名称 from emp 
union
select to_char(null) 雇员名字,deptno 部门编号,dname 部门名称 from dept
order by 部门编号 desc

--to_char(null) 部门名称：员工表中“不管他们是否属于任何部门”。员工表中没有部门名称字段
--to_char(null) 雇员名字：部门表中“不管他们是否有员工”。部门表没有雇员名字字段
3.用集合运算查询出职位为SALESMAN和部门编号为10的人员编号、姓名、职位，不排除重复结果。
select empno 人员编号, ename 姓名, job 职位 from emp where job = 'SALESMAN'
union all
select empno,ename,job from emp where deptno = 10;
--"不排除重复结果"即可包含重复结果，则用union all，而union是不含重复结果
--4.用集合查询出部门为10和20的所有人员编号、姓名、所在部门名称。
select e.empno 人员编号, e.ename 姓名, d.dname 部门名称
from emp e, dept d
where e.deptno = d.deptno
and e.deptno = 10
union
select e.empno 人员编号, e.ename 姓名, d.dname 部门名称
from emp e, dept d
where e.deptno = d.deptno
and e.deptno = 20; 
--注意多表连接，and：分开写10和20
第九章
练习1
--1.查询比所在职位平均工资高的员工姓名，职位。

select ename,job
from emp e
where sal>(select avg(sal) from emp where job=e.job)---子查询的条件来自候选行，来自父查询的列
--2.查询工资为其部门最低工资的员工编号，姓名，工资。
select empno,ename,sal
from emp e
where sal=(select min(sal) from emp where deptno=e.deptno)---相关子查询
练习2
如下练习，用相关子查询完成
1.查询所有雇员编号，名字和部门名字。
select e.empno 员工编号，e.ename 名字,
  (select dname from dept where deptno = e.deptno) 部门名字
from emp e;


2.查询哪些员工是经理？
select empno,ename,job,sal,mgr
from emp e
where 0<(select count(1) from emp where mgr=e.empno)
----结果有6条数据，原理：拿着员工编号去查有没有下属，数量大于1，则有
3.查询哪些员工不是经理？
select empno,ename,job,sal,mgr
from emp e
where 0=(select count(1) from emp where mgr=e.empno)
4.查询每个部门工资最低的两个员工编号，姓名，工资。
select empno,ename,sal,deptno
from emp e
where 2>(select count(1) from emp where deptno=e.deptno and sal<e.sal)
练习3
如下练习，用exists或not exists完成
1.列出至少有一个雇员的所有部门名称。
   select dname 部门名称 from dept d
      where exists (select 1 from emp where deptno = d.deptno); --’1’只是占位用，无实际意义
2.列出一个雇员都没有的所有部门名称。
select dname 部门名称 from dept d
      where not exists (select 1 from emp where deptno = d.deptno);
课后作业
如下练习，使用相关子查询完成。
1.查询薪水多于他所在部门平均薪水的雇员名字，部门号。
select ename 雇员姓名, deptno 部门号,sal
      from emp e
     where sal > (select avg(sal) from emp where deptno = e.deptno);
2.查询员工姓名和直接上级的名字。
 select e.ename 员工姓名,
           (select ename from emp where empno = e.mgr) 上级姓名
      from emp e;
3.查询每个部门工资最高的员工姓名，工资。
 select e.ename 员工姓名, e.sal 工资
      from emp e
     where sal = (select max(sal) from emp where deptno = e.deptno);

--4.查询每个部门工资前两名高的员工姓名，工资。
 select e.ename 员工姓名, e.sal 工资
      from emp e
     where 1 >= (select count(ename) 
                   from emp 
                  where deptno = e.deptno
                    and sal > e.sal);



select ename,sal,deptno
from emp e
where (select count(*)
 from emp where deptno=e.deptno and sal>e.sal )<2
第十章
1.产生一个报告显示 BLAKE的所有下级（包括直接和间接下级）雇员的名字、薪水和部门号。
select ename 雇员名字,sal 薪水,deptno 部门号 from emp
start with ename = 'BLAKE'
connect by prior empno = mgr; 
2.创建一个报告显示对于雇员 SMITH 经理的层次，包括级别和姓名，首先显示他的直接经理。
   select level 级别, ename 姓名
      from emp
     where ename <> 'SMITH'  --用where子句去除一个节点
     start with ename = 'SMITH'
   connect by prior mgr = empno;
3.创建一个缩进报告显示经理层次，从名字为 KING的雇员开始，显示雇员的名字、经理ID和部门ID。
 SELECT LPAD(ename, LENGTH(ename)+LEVEL*2,'*') ename,mgr,deptno
   FROM emp
  START WITH ename='KING'
CONNECT BY PRIOR empno=mgr;  --“显示经理层次，从名字为 KING的雇员开始”中的KING是经理
--4.产生一个公司组织图表显示经理层次。从最顶级的人开始，排除所有job为CLERK的人，
还要排除FORD和那些对FORD报告的雇员。
  SELECT LPAD(ename, LENGTH(ename)+LEVEL*2,'*') ename,mgr,deptno
   FROM emp
  WHERE job<>'CLERK'  --排除所有job为CLERK的人
  START WITH ename='KING'
CONNECT BY PRIOR empno=mgr
    AND ename<>'FORD';    --还要排除FORD和那些对FORD报告的雇员
第十一章
练习1
1.向部门表新增一个部门，部门编号为50，部门名称为HR，工作地点为SY。
insert into dept(deptno,dname,loc) values (50,'HR','SY');
select * from dept;
2.向部门表新增一个部门，部门编号为60，部门名称为MARKET。
insert into dept(deptno,dname) values (60,'MARKET')
练习2
1.向员工表中新增一个员工，员工编号为8888，姓名为BOB，岗位为CLERK，经理为号7788，
入职日期为1985-03-03，薪资3000，奖金和部门为空。
insert into emp (empno,ename,job,mgr,hiredate,sal,comm,deptno)
values(8888,'BOB','CLERK',7788,to_date('1985-03-03','yyyy-mm-dd'),3000,null,null)

练习3
1.使用CREATE TABLE emp_back as 
        SELECT * FROM EMP WHERE 1=0，创建emp_back表,拷贝下来即可。
CREATE TABLE emp_back as 
SELECT * FROM EMP WHERE 1=0

2.把emp表中入职日期大于1982年1月1日之前的员工信息复制到emp_back表中。
 INSERT INTO emp_back
 SELECT *
  FROM emp
 WHERE hiredate>=to_date('1982-01-01','yyyy-mm-dd');

练习4
1.修改部门20的员工信息，把82年之后入职的员工入职日期向后调整10天
update  emp set hiredate=hiredate+10 
where deptno=20 and hiredate>to_date('1982-12-31','yyyy-mm-dd')
--82年之后:是'1982-12-31'，而不是1月1日
--update 表名
2.修改奖金为null的员工，奖金设置为0
update emp set comm=0 where comm is null
--comm is null ,而不是 等于null
3.修改工作地点在NEW YORK或CHICAGO的员工工资，工资增加500
update emp set sal=sal+500 
where deptno in(select deptno from dept where loc in('NEW YORK','CHICAGO')) 
练习5
1.重复做一下刚才的案例。
例1.在emp表中增加一个列dname, 来存储部门名称.
alter table emp_back add(dname varchar2(14));
例2.使用相关子查询更新dname列为正确的部门名称。
update emp_back e set dname=(select dname from dept d where deptno=e.deptno)
--多表连接

练习6
1.删除经理编号为7566的员工记录
delete from emp where mgr=7566
2.删除工作在NEW YORK的员工记录
deletedelete from emp where deptno in (select deptno from dept where loc='NEW YORK')
--in :对应多个结果   ”工作在NEW YORK"：可能有多个
-- =：对应一个结果
3.删除工资大于所在部门平均工资的员工记录
delete from emp e where sal>(select avg(sal) from emp where deptno=e.deptno)
练习7
分析如下语句序列，哪些语句会结束事务？
INSERT…
UPDATE..
INSERT
ROLLBACK;--
DELETE..
DELETE..
SELECT..
COMMIT..--
INSERT..
INSERT..
DELETE..
GRANT..--
INSERT..
SELECT;

--执行一个DCL(GRANT、REVOKE)语句;执行一个DDL(CREATE、ALTER、DROP、TRUNCATE、RENAME）语句；
--提交(COMMIT);回滚(ROLLBACK)
练习8
1.test表为空表，分析如下语句操作后，最后test表的状态。
INSERT INTO test(id,name) values(1, 'a')；
INSERT INTO test(id,name) values(2, 'b')；
SAVEPOINT s1;
INSERT INTO test(id,name) values(3, 'c')；
INSERT INTO test(id,name) values(4, 'd')；
DELETE FROM test WHERE id in (1,3);
ROLLBACK TO s1;--回滚到保存点s1，后3条数据无效
DELETE FROM test WHERE id in (2,4);
COMMIT; --将所有修改写入数据库
ROLLBACK;--所有操作已经提交，不能回滚
--删除(2,4)后，最终剩下INSERT INTO test(id,name) values(1, 'a')；这条数据
练习9
分析如下两个会话，执行完每一步时的数据库状态。
会话A:
1.UPDATE EMP SET sal = sal+500 WHERE deptno= 10;
3.SELECT sal FROM EMP WHERE deptno = 10;
6.COMMIT:
8.SELECT sal FROM EMP WHERE deptno = 10;
会话B：
2.SELECT sal FROM EMP WHERE deptno = 10;
4.UPDATE EMP SET sal = sal+500 WHERE deptno = 20;
5. UPDATE EMP SET sal = sal+1000 WHERE deptno = 10;
7.COMMIT;

课后作业
1.使用如下语句，创建学生表student和班级表class
create table student (        --学生表
      xh char(4),--学号
      xm varchar2(10),--姓名
      sex char(2),--性别
      birthday date,--出生日期
      sal number(7,2), --奖学金
      studentcid number(2) --学生班级号
)
Create table class (   --班级表
      classid number(2), --班级编号
      cname varchar2(20),--班级名称
        ccount  number(3) --班级人数
)
 --学生表
create table student(
       xh  char(4),xm varchar2(10),sex char(2),birthday date,sal number(7,2),
       studentcid number(2)  
)
--班级表
create table class(
      classid number(2),cname varchar2(20),ccount number(3)
)

2.基于上述学生表和班级表，完成如下问题
（1）添加三个班级信息为：1，JAVA1班，null
                         2，JAVA2班，null
                         3，JAVA3班，null
 --
 insert into class(classid,cname,ccount) values(1,'java1班',null);  
 insert into class(classid,cname,ccount) values(2,'Java2班',null);
 insert into class(classid,cname,ccount) values(3,'Java3班',null);
（2）添加学生信息如下：‘A001’,‘张三’,‘男’,‘01-5月-05’,100,1
INSERT INTO student
VALUES('A001','张三','男','01-5月-05',100,1);
（3）添加学生信息如下：'A002','MIKE','男','1905-05-06',10
INSERT INTO student
VALUES('A002','MIKE','男',TO_DATE('1905-05-06','YYYY-MM-DD'),10,NULL);
--（4）插入部分学生信息： 'A003','JOHN','女’
insert into student(xh,xm,sex)  values('A003','JOHN','女')
--（5）将A001学生性别修改为'女‘
update student set sex='女' where xh='A001'
--（6）将A001学生信息修改如下：性别为男，生日设置为1980-04-01
update student set sex='男' , birthday=to_date('1980-04-01','YYYY-MM-DD') 
where xh='A001'
（7）将生日为空的学生班级修改为Java3班
update student set studentcid=(select classid from class where cname='Java3班')
where birthday is null
（8）请使用一条SQL语句，使用子查询，更新班级表中每个班级的人数字段
update class c set ccount=(select count(*) from student s 
where c.classid=s.studentcid);
3.使用如下语句，建立以下表
CREATE TABLE copy_emp   (
  empno number(4),
  ename varchar2(20),
  hiredate date default sysdate ,
  deptno number(2),
  sal number(8,2))
  
4.在第三题表的基础上，完成下列问题
(1)在表copy_emp中插入数据，要求sal字段插入空值，部门号50，
参加工作时间为2000年1月1日，其他字段随意
insert into copy_emp values(1,'张三','01-1月-2000',50,null);
(2)在表copy_emp中插入数据，要求把emp表中部门号为10号部门的员工信息插入
insert into copy_emp select empno,ename,hiredate,deptno,sal from emp 
where deptno=10
(3)修改copy_emp表中数据，要求10号部门所有员工涨20%的工资
update copy_emp set sal=sal*1.2 where deptno=10
(4)修改copy_emp表中sal为空的记录，工资修改为平均工资
UPDATE copy_emp
    SET sal=
           (SELECT AVG(sal)
              FROM copy_emp)
 WHERE sal IS NULL;
(5)把工资为平均工资的员工，工资修改为空
update copy_emp set sal=null where sal=
(select avg(sal) from copy_emp);
(6)另外打开窗口2查看以上修改
修改无效
(7)执行commit，窗口2中再次查看以上信息
COMMIT;
修改有效
(8)删除工资为空的员工信息
DELETE FROM copy_emp
WHERE sal IS NULL;
(9)执行rollback
ROLLBACK;
