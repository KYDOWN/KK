--1.写一个查询,用首字母大写，其它字母小写显示雇员的 ename，显示名字的长度，并给每列一个适当的标签，
--条件是满足所有雇员名字的开始字母是J、A 或 M 的雇员，
--并对查询结果按雇员的ename升序排序。（提示：使用initcap、length、substr）
select initcap(ename) 员工姓名,length(ename) 名字长度
from emp
where substr(ename,1,1) in ('J','A','M')
order by ename asc;
--1.查询员工姓名中中包含大写或小写字母A的员工姓名。
select ename 员工姓名
from emp
where ename like '%a%' or ename like '%A%'
--2.查询部门编号为10或20，入职日期在81年5月1日之后，并且姓名中包含大写字母A的员工姓名，
--员工姓名长度（提示，要求使用INSTR函数，不能使用like进行判断)
select ename 员工姓名,length(ename) 名字的长度,deptno 部门编号,hiredate 入职日期
from emp
where deptno in(10,20) and hiredate>to_date('01-05-1981','dd-mm-yyyy') and instr(ename,'A')>0
--3.查询每个职工的编号,姓名，工资
--要求将查询到的数据按照一定的格式合并成一个字符串.
--前10位：编号,不足部分用*填充,左对齐
--中间10位：姓名，不足部分用*填充,左对齐
--后10位：工资，不足部分用*填充,右对齐
select rpad(empno,10,'*')||rpad(ename,10,'*')||lpad(sal,10,'*') from emp
--
select concat(concat(rpad(empno,10,'*'),rpad(ename,10,'*')),lpad(sal,10,'*')) from emp
--1.写一个查询，分别计算100.456 四舍五入到小数点后第2位，第1位，整数位的值。
select round(100.456,2) , round(100.456,1) ,round(100.456,0) from dual
--2.写一个查询，分别计算100.456 从小数点后第2位，第1位，整数位截断的值。
select trunc(100.456,2) , trunc(100.456,1) ,trunc(100.456,0) from dual
--1.查询每个员工截止到现在一共入职多少天？
select empno 员工编号,ename 员工姓名,round(sysdate-hiredate,0) 入职天数 from emp;
--2.当前日期为2015年，指定日期格式为DD-MON-RR,指定日期为01-1月-01，该日期实际所代表的日期为？
2001-01-01
select to_date('01-1月-01','DD-MON-RR')from dual;
--3.当前日期为2015年，指定日期格式为DD-MON-RR,指定日期为01-1月-95，该日期实际所代表的日期为？
1995-01-01
select to_date('01-1月-95','DD-MON-RR')from dual;
--4.当前日期为1998年，指定日期格式为DD-MON-RR,指定日期为01-1月-01，该日期实际所代表的日期为？
2001-01-01
select to_date('01-1月-01','DD-MON-RR')from dual;
--5.当前日期为1998年，指定日期格式为DD-MON-RR,指定日期为01-1月-95，该日期实际所代表的日期为？
1995-01-01
select to_date('01-1月-95','DD-MON-RR')from dual;
--6.当前日期为2015年，指定日期格式为DD-MON-YY,指定日期为01-1月-01，该日期实际所代表的日期为？
2001-01-01
select to_date('01-1月-01','DD-MON-YY')from dual;
--7.当前日期为1998年，指定日期格式为DD-MON-YY,指定日期为01-1月-95，该日期实际所代表的日期为？
1995-01-01
select to_date('01-1月-95','DD-MON-YY')from dual; --2095/1/1
--1.查询服务器当前时间
SELECT SYSDATE FROM DUAL;
--2.查询部门10,20的员工截止到2000年1月1日，工作了多少个月，入职的月份。
--(提示：使用months_between,extract)
select empno 员工编号, ename 员工姓名,round(months_between(to_date('01-01-2000','dd-mm-yyyy'),
hiredate))工作了多少个月,extract(MONTH from hiredate )入职的月份
from emp;
--3.如果员工试用期6个月，查询职位不是MANAGER的员工姓名，入职日期，转正日期，
--入职日期后的第一个星期一,入职当月的最后一天日期。（提示：使用add_months,next_day,last_day)
select ename,hiredate 入职日期, add_months(hiredate,6)转正日期, next_day(hiredate,'星期一')入职日期后的第一个星期一 ,
last_day(hiredate)入职当月的最后一天日期
from emp
where job not in('MANAGER');
--NEXT_DAY：返回某一日期的下一个指定日期 
--LAST_DAY：返回指定日期当月最后一天的日期
--1.显示服务器系统当前时间，格式为2007-10-12 17:11:11(提示：使用to_char函数)
select  to_char(SYSDATE, 'yyyy-mm-dd hh24:mm:ss')
from dual
--to_char(date,'fmt')
--2.显示ename、hiredate 和 雇员开始工作日是星期几，列标签DAY(提示：使用to_char函数)
select ename 员工姓名,hiredate 入职时间,to_char(hiredate,'day')星期几
from emp;
--3.查询员工姓名，工资，格式化的工资（￥999,999.99） (提示：使用to_char函数)
select ename 员工姓名,to_char(sal,'L999,999.99')工资
from emp;
--to_char(number,'fmt') $:美元符号 ； L：本地货币符号
--4.把字符串2015-3月-18 13:13:13 转换成日期格式，并计算和系统当前时间间隔多少天。 (提示：使用to_date函数)
select round( sysdate - to_date('2015-3月-18 13:13:13','yyyy-mon-dd hh24:mi:ss'))天 from dual;
--1.计算2000年1月1日到现在有多少月，多少周（四舍五入）。
select round(months_between(sysdate,to_date('2000-1-1','yyyy-mm-dd')))多少月,
round((sysdate-to_date('2000-1-1','yyyy-mm-dd'))/7) 多少周 from dual;
--2.查询员工ENAME的第三个字母是A的员工的信息(使用2个函数)。
select ename 员工姓名
from emp
where SUBSTR(ename,3,1)='A';
---SUBSTR:第一个参数是要截取的数据源，第二个参数是从哪里开始截取，第三个参数是截取多少个字符
--instr返回的是某一个字符在字符串中的位置
select ename 员工姓名
from emp
where instr(ename,'A',3)=3;
--3.使用trim函数将字符串‘hello’、‘  Hello ’、‘bllb’、‘ hello    ’
--分别处理得到下列字符串ello、Hello、ll、hello。
SELECT TRIM('h' FROM 'hello'),TRIM(' 'FROM 'Hello'),TRIM('b' FROM 'bllb'),TRIM(' 'FROM 'hello') from dual;
--TRIM---删除,只能删除前面和后面的数据
--4.将员工工资按如下格式显示：123,234.00 RMB 。
select ename 员工姓名,to_char(sal,'999,999.00')||'RMB' 工资
FROM EMP;
--5.查询员工的姓名及其经理编号，要求对于没有经理的显示“No Manager”字符串。
select ename 员工的姓名,nvl(to_char(mgr) , 'No Manager')经理编号 from emp;
--6.将员工的参加工作日期按如下格式显示：月份/年份。 
select hiredate 入职日期 ,to_char(hiredate,'mm/yyyy')||'年' 工作日期
from emp;
select hiredate 入职日期 ,to_char(hiredate,'month/yyyy')||'年' 工作日期
from emp;
--7.在员工表中查询出员工的工资，并计算应交税款：如果工资小于1000,税率为0，
--如果工资大于等于1000并小于2000，税率为10％，如果工资大于等于2000并小于3000，
--税率为15％，如果工资大于等于3000，税率为20％。
SELECT sal,CASE TRUNC(sal/1000,0)
WHEN 0 THEN 0
WHEN 1 THEN sal*0.1
WHEN 2 THEN sal*0.15
ELSE sal*0.2
END 税款
FROM emp;

--8.创建一个查询显示所有雇员的 ename和 sal。格式化sal为 15 个字符长度，用 $ 左填充，列标签 SALARY。
select ename 员工姓名,lpad(sal,15,'$') SALARY
from emp;
