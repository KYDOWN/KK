--˼���������⣻дһ����ѯ��䣬��ѯԱ���������������ơ������ص㣿
select e.ename,d.dname,d.loc
from emp e,dept d
where e.deptno=d.deptno
--1.дһ����ѯ����ʾ����Ա�����������ű�ţ��������ơ�
select e.ename,d.deptno,d.dname
from emp e join dept d
on e.deptno=d.deptno  
--2.дһ����ѯ����ʾ���й�����CHICAGO���ҽ���Ϊ�յ�Ա�������������ص㣬����
select e.ename,d.loc,e.comm
from emp e,dept d
where e.deptno=d.deptno and loc='CHICAGO' and comm is not null--������Ϊ0���ǿգ�����ʲôҲû�У�0��0������ֵ�ģ�

select e.ename,d.loc,e.comm
from emp e join dept d on e.deptno=d.deptno
where  e.comm > 0;
--3.дһ����ѯ����ʾ���������к���A�ַ���Ա�������������ص㡣
select e.ename,d.loc
from emp e join dept d on e.deptno=d.deptno
where e.ename like '%A%'
--1.��ѯÿ��Ա���ı�ţ����������ʣ����ʵȼ������ڹ������У�
--���չ��ʵȼ�������������
select e.empno,e.ename,e.sal,s.grade,d.loc
from emp e join dept d on d.deptno=e.deptno,salgrade s --���������������ű����ʱ�
order by s.grade asc;
--˼������ѯÿ��Ա����������ֱ���ϼ�����
select worker.ename,boss.ename
from emp worker left join emp boss
on worker.mgr=boss.empno

--1.��ѯ���й�����NEW YORK��CHICAGO��Ա��������Ա����ţ��Լ����ǵľ��������������š�
select worker.empno Ա�����,worker.ename Ա������,boss.empno ������,boss.ename ��������,d.loc
from emp worker,emp boss,dept d
where worker.mgr=boss.empno and worker.deptno=d.deptno and d.loc in ('NEW YORK','CHICAGO');
--2.����һ��Ļ����ϣ����û�о����Ա��King��������Ա���������
select worker.empno Ա�����,worker.ename Ա������,boss.empno ������,boss.ename ��������,d.loc
from emp worker,emp boss,dept d
where worker.mgr=boss.empno(+) and worker.deptno=d.deptno and d.loc in ('NEW YORK','CHICAGO');
--3.��ѯ����Ա����ţ��������������ƣ�����û�в��ŵ�Ա��ҲҪ��ʾ������
select e.empno,e.ename,d.dname
from emp e full outer join dept d on e.deptno=d.deptno--"����Ա����ţ���������������"��������ʾԱ���������е�Ա����ź�������
--ҲҪ��ʾ���ű������еĲ������ƣ�����Ҫ��ȫ����

--1.����һ��Ա����Ͳ��ű�Ľ������ӡ�
select e.empno,e.ename,d.dname
from emp e cross join dept d
--2.ʹ����Ȼ���ӣ���ʾ��ְ������80��5��1��֮���Ա���������������ƣ���ְ����
select ename,dname,hiredate
from emp
natural join dept
where hiredate>to_date('1980-05-01','YYYY-MM-DD')--û��yy-mm-dd��ʽ�����Ҫдȫ��������������

SELECT empno,ename,sal,deptno,loc
FROM emp
NATURAL JOIN  dept
where hiredate > '1-5��-80';
--3.ʹ��USING�Ӿ䣬��ʾ������CHICAGO��Ա���������������ƣ������ص�
select  e.ename,d.dname,d.loc
FROM emp e
JOIN dept d USING (deptno)
where d.loc='CHICAGO';
--4.ʹ��ON�Ӿ䣬��ʾ������CHICAGO��Ա���������������ƣ������ص㣬н�ʵȼ�
select e.ename Ա������,d.dname ��������,d.loc �����ص�,s.grade н�ʵȼ�
from emp e
     join dept d on (e.deptno=d.deptno)
     join salgrade s on (e.sal between s.losal and s.hisal)
where d.loc in ('CHICAGO');

--5.ʹ�������ӣ���ѯÿ��Ա��������������������û�о����KingҲҪ��ʾ������
select worker.ename,boss.ename
from emp worker
     left join emp boss on (worker.mgr=boss.empno)  
    
--6.ʹ�������ӣ���ѯÿ��Ա��������������������û�о����KingҲҪ��ʾ������
select worker.ename,boss.ename
from emp boss
     right join emp worker on (worker.mgr=boss.empno)  
--1.��ʾԱ��SMITH���������������ƣ�ֱ���ϼ�����
SELECT worker.ename,d.dname,boss.ename
FROM emp worker
join  dept d  on worker.deptno=d.deptno
join emp boss on  worker.mgr=boss.empno
where worker.ename='SMITH'

--2.��ʾԱ���������������ƣ����ʣ����ʼ���Ҫ���ʼ������4����
SELECT  e.ename "Ա������",dname "��������",e.sal "����",s.grade "���ʼ���"
FROM emp e, dept d,salgrade s  --���ű�����
WHERE e.deptno=d.deptno
AND e.sal BETWEEN s.losal AND s.hisal
AND s.grade>4
--3.��ʾԱ��KING��FORD����� Ա������ �� �侭��������
select worker.ename Ա������,boss.ename ��������
from emp worker,emp boss
where worker.mgr=boss.empno
      and boss.ename in ('KING','FORD');
--4.��ʾԱ���������μӹ���ʱ�䣬���������μӹ���ʱ�䣬Ҫ��μ�ʱ��Ⱦ����硣
select worker.ename,worker.hiredate,boss.ename,boss.hiredate
from emp worker,emp boss
where worker.mgr=boss.empno
      and worker.hiredate<boss.hiredate
--    
��˼���������⣿
��ѯ����Ա����ÿ���¹����ܺͣ�ƽ�����ʣ�
��ѯ������ߺ���͵Ĺ����Ƕ��٣�
��ѯ��˾����������
��ѯ�н������������
������..
--
--1.��ѯ����20��Ա����ÿ���µĹ����ܺͼ�ƽ�����ʡ�
select sum(sal) "�����ܺ�",avg(sal) "ƽ������"
from emp 
where deptno=20;
--2.��ѯ������CHICAGO��Ա����������߹��ʼ���͹��ʡ�
select max(sal) "��߹���",min(sal) "��͹���"
from emp e join dept d on e.DEPTNO=d.DEPTNO
where d.loc = 'CHICAGO'
--3.��ѯԱ������һ���м��ָ�λ���͡�
select distinct(job) from emp;
--
˼������ѯÿ�����ŵ�ƽ�����ʣ�
--


1.��ѯÿ�����ŵĲ��ű�ţ��������ƣ�������������߹��ʣ���͹��ʣ������ܺͣ�ƽ�����ʡ�
select d.deptno,d.dname,count(*),
max(sal),min(sal),sum(sal),avg(nvl(sal,0))
from emp e left outer join dept d on e.deptno=d.deptno
group by d.deptno, d.dname;
2.��ѯÿ�����ţ�ÿ����λ�Ĳ��ű�ţ��������ƣ���λ���ƣ�������������߹��ʣ���͹��ʣ������ܺͣ�ƽ�����ʡ�
select distinct e.job ��λ����,d.deptno ���ű��,d.dname ��������,count(e.empno) ��������,max(sal) ��߹���,min(sal) ��͹���,sum(sal) �����ܺ�,round(avg(sal)) ƽ������
from emp e left join dept d on(e.deptno=d.deptno)
group by e.job,d.deptno,d.dname
3.��ѯÿ������������������������ţ�����������Ҫ�����û�о������Ա��Ϣ��
SELECT COUNT(a.empno),b.empno,b.ename
from emp a left JOIN emp b on a.mgr=b.empno
GROUP BY b.empno,b.ename
1.��ѯ������������2�Ĳ��ű�ţ��������ƣ�����������
select d.deptno,d.dname,count(e.empno)
from emp e right outer join dept d on e.deptno=d.deptno
group by d.deptno, d.dname
having count(e.empno)>2
order by d.deptno;

--2.��ѯ����ƽ�����ʴ���2000������������2�Ĳ��ű�ţ��������ƣ���������������ƽ�����ʣ�
--�����ղ���������������
select d.deptno,d.dname,count(e.empno),avg(nvl(sal,0))
from emp e right outer join dept d on e.deptno=d.deptno
group by d.deptno, d.dname
having avg(nvl(sal,0))>2000
order by count(e.empno);
1.��ѯ����ƽ��������2500Ԫ���ϵĲ������Ƽ�ƽ�����ʡ�
select d.dname ��������,round(avg(sal)) ƽ������
from emp e left join dept d on(e.deptno=d.deptno)
group by d.dname having avg(sal)>2500
2.��ѯԱ����λ�в����ԡ�SA����ͷ����ƽ��������2500Ԫ���ϵĸ�λ��ƽ�����ʣ�����ƽ�����ʽ�������
SELECT e.job,avg(e.sal)
from emp e
where e.job not like 'SA%'
GROUP BY e.job
HAVING avg(e.sal)>2500
ORDER BY avg(e.sal) desc;
3.��ѯ����������2�����ϵĲ������ơ���͹��ʡ���߹���,������õĹ��ʽ����������뵽����λ��
SELECT d.dname,ROUND(MIN(e.sal),0),ROUND(MAX(e.sal),0)
from emp e,dept d
where e.deptno=d.deptno
GROUP BY d.dname
HAVING COUNT(e.empno)>2
--����������4.��ѯ��λ��ΪSALESMAN�����ʺʹ��ڵ���2500�ĸ�λ��ÿ�ָ�λ�Ĺ��ʺ͡�
select job,sum(sal)
from emp
group by job
having job not like 'SALESMAN' and sum(sal)>=2500;  --��ȷ

SELECT job,SUM(sal)
from emp
where job not like 'salesman'
GROUP BY job
HAVING SUM(sal)>=2500;   --���󣬲�ѯ�ĸ�λ��SALESMAN

5.��ʾ�������;����������������������Ա������͹��ʣ�û�о����KINGҲҪ��ʾ��
��������͹���С��3000�ģ�����͹����ɸߵ�������
select boss.empno �������,
boss.ename ��������,
min(worker.sal) ����Ա����͹���
from emp worker, emp boss
where worker.mgr = boss.empno(+)  --"û�о����KINGҲҪ��ʾ"����KING����������˵����Ա����Ϊ����
group by boss.empno, boss.ename
having min(worker.sal) >= 3000
order by min(worker.sal) desc;
--����6.дһ����ѯ����ʾÿ��������߹��ʺ���͹��ʵĲ��
select max(e.sal) ������߹���,
min(e.sal) ������͹���,
(nvl(max(e.sal) - min(e.sal), 0)) �������͹��ʵĲ��
from emp e, dept d
where e.deptno(+) = d.deptno  --"��ʾÿ������"��˵�����ű�������
group by d.deptno   --��Ϊʲô�����ű��
order by d.deptno;
