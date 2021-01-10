--思考如下问题；写一条查询语句，查询员工姓名、部门名称、工作地点？
select e.ename,d.dname,d.loc
from emp e,dept d
where e.deptno=d.deptno
--1.写一个查询，显示所有员工姓名，部门编号，部门名称。
select e.ename,d.deptno,d.dname
from emp e join dept d
on e.deptno=d.deptno  
--2.写一个查询，显示所有工作在CHICAGO并且奖金不为空的员工姓名，工作地点，奖金
select e.ename,d.loc,e.comm
from emp e,dept d
where e.deptno=d.deptno and loc='CHICAGO' and comm is not null--错误，因为0不是空，空是什么也没有，0是0，是有值的；

select e.ename,d.loc,e.comm
from emp e join dept d on e.deptno=d.deptno
where  e.comm > 0;
--3.写一个查询，显示所有姓名中含有A字符的员工姓名，工作地点。
select e.ename,d.loc
from emp e join dept d on e.deptno=d.deptno
where e.ename like '%A%'
--1.查询每个员工的编号，姓名，工资，工资等级，所在工作城市，
--按照工资等级进行升序排序。
select e.empno,e.ename,e.sal,s.grade,d.loc
from emp e join dept d on d.deptno=e.deptno,salgrade s --可以这样连第三张表：工资表
order by s.grade asc;
--思考：查询每个员工的姓名和直接上级姓名
select worker.ename,boss.ename
from emp worker left join emp boss
on worker.mgr=boss.empno

--1.查询所有工作在NEW YORK和CHICAGO的员工姓名，员工编号，以及他们的经理姓名，经理编号。
select worker.empno 员工编号,worker.ename 员工姓名,boss.empno 经理编号,boss.ename 经理姓名,d.loc
from emp worker,emp boss,dept d
where worker.mgr=boss.empno and worker.deptno=d.deptno and d.loc in ('NEW YORK','CHICAGO');
--2.第上一题的基础上，添加没有经理的员工King，并按照员工编号排序。
select worker.empno 员工编号,worker.ename 员工姓名,boss.empno 经理编号,boss.ename 经理姓名,d.loc
from emp worker,emp boss,dept d
where worker.mgr=boss.empno(+) and worker.deptno=d.deptno and d.loc in ('NEW YORK','CHICAGO');
--3.查询所有员工编号，姓名，部门名称，包括没有部门的员工也要显示出来。
select e.empno,e.ename,d.dname
from emp e full outer join dept d on e.deptno=d.deptno--"所有员工编号，姓名，部门名称"不仅是显示员工表里所有的员工编号和姓名，
--也要显示部门表里所有的部门名称，所以要用全连接

--1.创建一个员工表和部门表的交叉连接。
select e.empno,e.ename,d.dname
from emp e cross join dept d
--2.使用自然连接，显示入职日期在80年5月1日之后的员工姓名，部门名称，入职日期
select ename,dname,hiredate
from emp
natural join dept
where hiredate>to_date('1980-05-01','YYYY-MM-DD')--没有yy-mm-dd格式，年份要写全，否则结果不出来

SELECT empno,ename,sal,deptno,loc
FROM emp
NATURAL JOIN  dept
where hiredate > '1-5月-80';
--3.使用USING子句，显示工作在CHICAGO的员工姓名，部门名称，工作地点
select  e.ename,d.dname,d.loc
FROM emp e
JOIN dept d USING (deptno)
where d.loc='CHICAGO';
--4.使用ON子句，显示工作在CHICAGO的员工姓名，部门名称，工作地点，薪资等级
select e.ename 员工姓名,d.dname 部门名称,d.loc 工作地点,s.grade 薪资等级
from emp e
     join dept d on (e.deptno=d.deptno)
     join salgrade s on (e.sal between s.losal and s.hisal)
where d.loc in ('CHICAGO');

--5.使用左连接，查询每个员工的姓名，经理姓名，没有经理的King也要显示出来。
select worker.ename,boss.ename
from emp worker
     left join emp boss on (worker.mgr=boss.empno)  
    
--6.使用右连接，查询每个员工的姓名，经理姓名，没有经理的King也要显示出来。
select worker.ename,boss.ename
from emp boss
     right join emp worker on (worker.mgr=boss.empno)  
--1.显示员工SMITH的姓名，部门名称，直接上级名称
SELECT worker.ename,d.dname,boss.ename
FROM emp worker
join  dept d  on worker.deptno=d.deptno
join emp boss on  worker.mgr=boss.empno
where worker.ename='SMITH'

--2.显示员工姓名，部门名称，工资，工资级别，要求工资级别大于4级。
SELECT  e.ename "员工姓名",dname "部门名称",e.sal "工资",s.grade "工资级别"
FROM emp e, dept d,salgrade s  --三张表连接
WHERE e.deptno=d.deptno
AND e.sal BETWEEN s.losal AND s.hisal
AND s.grade>4
--3.显示员工KING和FORD管理的 员工姓名 及 其经理姓名。
select worker.ename 员工姓名,boss.ename 经理姓名
from emp worker,emp boss
where worker.mgr=boss.empno
      and boss.ename in ('KING','FORD');
--4.显示员工姓名，参加工作时间，经理名，参加工作时间，要求参加时间比经理早。
select worker.ename,worker.hiredate,boss.ename,boss.hiredate
from emp worker,emp boss
where worker.mgr=boss.empno
      and worker.hiredate<boss.hiredate
--    
请思考如下问题？
查询所有员工的每个月工资总和，平均工资？
查询工资最高和最低的工资是多少？
查询公司的总人数？
查询有奖金的总人数？
………..
--
--1.查询部门20的员工，每个月的工资总和及平均工资。
select sum(sal) "工资总和",avg(sal) "平均工资"
from emp 
where deptno=20;
--2.查询工作在CHICAGO的员工人数，最高工资及最低工资。
select max(sal) "最高工资",min(sal) "最低工资"
from emp e join dept d on e.DEPTNO=d.DEPTNO
where d.loc = 'CHICAGO'
--3.查询员工表中一共有几种岗位类型。
select distinct(job) from emp;
--
思考：查询每个部门的平均工资？
--


1.查询每个部门的部门编号，部门名称，部门人数，最高工资，最低工资，工资总和，平均工资。
select d.deptno,d.dname,count(*),
max(sal),min(sal),sum(sal),avg(nvl(sal,0))
from emp e left outer join dept d on e.deptno=d.deptno
group by d.deptno, d.dname;
2.查询每个部门，每个岗位的部门编号，部门名称，岗位名称，部门人数，最高工资，最低工资，工资总和，平均工资。
select distinct e.job 岗位名称,d.deptno 部门编号,d.dname 部门名称,count(e.empno) 部门人数,max(sal) 最高工资,min(sal) 最低工资,sum(sal) 工资总和,round(avg(sal)) 平均工资
from emp e left join dept d on(e.deptno=d.deptno)
group by e.job,d.deptno,d.dname
3.查询每个经理所管理的人数，经理编号，经理姓名，要求包括没有经理的人员信息。
SELECT COUNT(a.empno),b.empno,b.ename
from emp a left JOIN emp b on a.mgr=b.empno
GROUP BY b.empno,b.ename
1.查询部门人数大于2的部门编号，部门名称，部门人数。
select d.deptno,d.dname,count(e.empno)
from emp e right outer join dept d on e.deptno=d.deptno
group by d.deptno, d.dname
having count(e.empno)>2
order by d.deptno;

--2.查询部门平均工资大于2000，且人数大于2的部门编号，部门名称，部门人数，部门平均工资，
--并按照部门人数升序排序。
select d.deptno,d.dname,count(e.empno),avg(nvl(sal,0))
from emp e right outer join dept d on e.deptno=d.deptno
group by d.deptno, d.dname
having avg(nvl(sal,0))>2000
order by count(e.empno);
1.查询部门平均工资在2500元以上的部门名称及平均工资。
select d.dname 部门名称,round(avg(sal)) 平均工资
from emp e left join dept d on(e.deptno=d.deptno)
group by d.dname having avg(sal)>2500
2.查询员工岗位中不是以“SA”开头并且平均工资在2500元以上的岗位及平均工资，并按平均工资降序排序。
SELECT e.job,avg(e.sal)
from emp e
where e.job not like 'SA%'
GROUP BY e.job
HAVING avg(e.sal)>2500
ORDER BY avg(e.sal) desc;
3.查询部门人数在2人以上的部门名称、最低工资、最高工资,并对求得的工资进行四舍五入到整数位。
SELECT d.dname,ROUND(MIN(e.sal),0),ROUND(MAX(e.sal),0)
from emp e,dept d
where e.deptno=d.deptno
GROUP BY d.dname
HAVING COUNT(e.empno)>2
--？？？区别4.查询岗位不为SALESMAN，工资和大于等于2500的岗位及每种岗位的工资和。
select job,sum(sal)
from emp
group by job
having job not like 'SALESMAN' and sum(sal)>=2500;  --正确

SELECT job,SUM(sal)
from emp
where job not like 'salesman'
GROUP BY job
HAVING SUM(sal)>=2500;   --错误，查询的岗位有SALESMAN

5.显示经理号码和经理姓名，这个经理所管理员工的最低工资，没有经理的KING也要显示，
不包括最低工资小于3000的，按最低工资由高到低排序。
select boss.empno 经理号码,
boss.ename 经理姓名,
min(worker.sal) 下属员工最低工资
from emp worker, emp boss
where worker.mgr = boss.empno(+)  --"没有经理的KING也要显示"，（KING是下属），说明以员工表为主表
group by boss.empno, boss.ename
having min(worker.sal) >= 3000
order by min(worker.sal) desc;
--？？6.写一个查询，显示每个部门最高工资和最低工资的差额
select max(e.sal) 部门最高工资,
min(e.sal) 部门最低工资,
(nvl(max(e.sal) - min(e.sal), 0)) 最高与最低工资的差额
from emp e, dept d
where e.deptno(+) = d.deptno  --"显示每个部门"，说明部门表是主表
group by d.deptno   --？为什么按部门编号
order by d.deptno;
