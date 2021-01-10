--1.��ѯ��ְ���������Ա����������ְ����
select ename,hiredate
from emp 
where hiredate=(select min(hiredate)from emp )
--2.��ѯ���ʱ�SMITH���ʸ߲��ҹ����ص���CHICAGO��Ա�����������ʣ���������
select e.ename,e.sal,d.dname
from emp e,dept d
where e.deptno=d.deptno
and e.sal>(select sal from emp where ename='SMITH' )
and d.loc='CHICAGO'
--3.��ѯ��ְ���ڱ�20������ְ���������Ա����Ҫ���Ա����������ְ����
select ename,hiredate
from emp
where hiredate<(select min(hiredate) from emp where deptno=20)
--4.��ѯ���������������в���ƽ�������ĵĲ��ű�ţ��������ƣ���������
select d.deptno,d.dname,count(1) ��������
from emp e,dept d
where e.deptno=d.deptno
group by  d.deptno,d.dname
having count(1)>(select avg(count(1)) from emp group by  deptno )
select empno, ename, job, mgr, hiredate, sal, comm, deptno from emp
--1.��ѯ��ְ���ڱ�10��������һ��Ա�����Ա����������ְ���ڣ�������10����Ա��
select ename,hiredate
from emp
where hiredate>any (select hiredate from emp where deptno=10)
and deptno<>10
--2.��ѯ��ְ���ڱ�10��������Ա�����Ա����������ְ���ڣ�������10����Ա��
select ename,hiredate
from emp
where hiredate>all (select hiredate from emp where deptno=10)
and deptno<>10
--3.��ѯְλ��10��������һ��Ա��ְλ��ͬ��Ա��������ְλ��������10����Ա��
select ename , job
from emp
where job = any(select job from emp where deptno = 10)
and deptno <> 10;
--"��ѯְλ��10��������һ��Ա��ְλ��ͬ��....."�ǲ�ѯ��ְλ����ֻ����ְλ�ǡ���10��������һ��Ա��ְλ��ͬ�ġ���
--����where job = any(select job from emp where deptno = 10)
--1.��ѯְλ�������10��������һ��Ա��ְλ��������ͬ��Ա��������ְλ��������10����Ա��
select ename,job
from emp
where (job,mgr) in (select job,mgr from emp where deptno=10)
and deptno<>10
--2.��ѯְλ�������10��������һ��Ա��ְλ������ͬ��Ա��������ְλ��������10����Ա��
select ename,job
from emp
where (
job in(select job from emp where deptno=10)
or
mgr in(select mgr from emp where deptno=10)
)
and deptno<>10


--1.��ѯ���Լ�ְλƽ�����ʸߵ�Ա��������ְλ���������ƣ�ְλƽ������
select e.ename,e.job,d.dname ��������,a.ְλƽ������
from emp e,dept d,(select job ,avg(sal)ְλƽ������ from  emp group by job) a
where e.job=a.job and e.deptno=d.deptno and e.sal>a.ְλƽ������ --�Ѿ���������ְλƽ�����ʡ��ˣ�����a.avg(sal)�ᱨ��
--2.��ѯְλ�;���ͬԱ��SCOTT��BLAKE��ȫ��ͬ��Ա��������ְλ��������SCOTT��BLAKE���ˡ�
select job, ename
      from emp 
     where (job, mgr) in
           (select job, mgr from emp  where ename in ('SCOTT', 'BLAKE'))
       and ename not in ('SCOTT', 'BLAKE');
--"ְλ�;���"����(job,mgr)������(job,mgr)������(select job,mgr from emp�е� job,mgr��Ӧ
select empno, ename, job, mgr, hiredate, sal, comm, deptno from emp
--3.��ѯ���Ǿ����Ա��������
select ename
from emp
where empno not in(select distinct mgr from emp where mgr is not null)
--ʹ��not in�Ƚ�ʱ������Ӳ�ѯ�Ľ������nullֵ����ô�ȽϵĽ��Ҳ��nullֵ�����Խ����nullȥ���������ѯû�н��
--  distinct �ֶ����ơ�distinct mgr��ȥ���ظ���mgr

--1.��ѯ��ְ���������ǰ5��Ա����������ְ���ڡ�
select rownum,e.ename Ա������, e.hiredate ��ְ����
from (select ename,hiredate from emp order by hiredate asc) e
where rownum <= 5;

--2.��ѯ������CHICAGO������ְ���������ǰ2��Ա����������ְ���ڡ�
   select rownum, e.ename Ա������, e.hiredate ��ְ����, e.loc
      from (select e.*,d.*
              from emp e, dept d
             where e.deptno = d.deptno
               and d.loc = 'CHICAGO'
             order by hiredate asc) e
     where rownum <= 2;
   
1.����ÿҳ��ʾ5����¼���ֱ��ѯ��1ҳ����2ҳ����3ҳ��Ϣ��Ҫ����ʾԱ����������ְ���ڡ��������ơ�
 select e.rn       ��1ҳ,
           e.ename    Ա������,
           e.hiredate ��ְ����,
           e.dname    ��������
      from (select rownum rn, e.*, d.*
              from emp e, dept d
             where e.deptno = d.deptno) e
     where e.rn <= 5;

 --
    select e.rn       ��2ҳ,
           e.ename    Ա������,
           e.hiredate ��ְ����,
           e.dname    ��������
      from (select rownum rn, e.*, d.*
              from emp e, dept d
             where e.deptno = d.deptno) e
     where e.rn > 5
 --
  select e.rn       ��3ҳ,
           e.ename    Ա������,
           e.hiredate ��ְ����,
           e.dname    ��������
      from (select rownum rn, e.*, d.*
              from emp e, dept d
             where e.deptno = d.deptno) e
     where e.rn > 10
       and rn <= 15;

--1.����ÿҳ��ʾ5����¼���ֱ��ѯ������ߵĵ�1ҳ����2ҳ����3ҳ��Ϣ��Ҫ����ʾԱ����������ְ���ڡ��������ơ����ʡ�
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


select e2.*  --�ڶ�ҳ
from    
                   (select rownum rn,e1.*
                    from
                           (select e.ename,e.hiredate,e.sal,d.deptno,d.dname
                           from emp e,dept d
                           where e.deptno=d.deptno
                           order by sal desc) e1
                    where rownum<=10) e2
where e2.rn>5
select e3.*  --����ҳ
from   
             (select rownum rn,e1.*
             from
                       (select e.ename,e.hiredate,e.sal,d.deptno,d.dname
                        from emp e,dept d
                       where e.deptno=d.deptno
                       order by sal desc) e1
                       where rownum<=15) e3
where e3.rn>10

--1.��ѯ���ʸ��ڱ��Ϊ7782��Ա�����ʣ����Һ�7369��Ա��������ͬ������Ա���ı�š����������ʡ�
select empno Ա�����, ename ����, sal ����
      from emp
     where sal > (select sal from emp where empno = 7782)
       and job = (select job from emp where empno = 7369)
       and empno <> 7369;
--2.��ѯ������ߵ�Ա�������͹��ʡ� 
   select ename Ա������, sal ����
      from emp
     where sal = (select max(sal) from emp);
3.��ѯ������͹��ʸ���10�Ų�����͹��ʵĲ��ŵı�š����Ƽ�������͹��ʡ�
  SELECT e.deptno,dname,MIN(sal)
       FROM emp e,dept d
       WHERE e.deptno=d.deptno
      GROUP BY e.deptno,dname
       HAVING MIN(sal)<(SELECT MIN(sal)  FROM emp  WHERE deptno=10);
4.��ѯԱ������Ϊ�䲿����͹��ʵ�Ա���ı�ź����������ʡ�
select empno,ename,sal from emp e,(select deptno,min(sal) minsal from emp 
group by deptno) d
where e.deptno=d.deptno and sal=minsal
--"Ϊ�䲿��"�������ű�ŷ���
5.��ʾ������KING��Ա�����������ʡ�
select ename,sal from emp where mgr=(select empno from emp where ename='KING')
--6.��ʾ��Ա��SMITH�μӹ���ʱ�����Ա�����������ʣ��μӹ���ʱ�䡣
select ename,sal,hiredate from emp where hiredate>(select hiredate from emp
where ename='SMITH')
7.ʹ���Ӳ�ѯ�ķ�ʽ��ѯ��ЩְԱ��NEW YORK������
select * from emp where deptno=(select deptno from dept where loc='NEW YORK')
8.дһ����ѯ��ʾ��Ա��SMITH������ͬһ�����ŵ�Ա���������������ڣ���ѯ������ų�SMITH��
select ename,hiredate from emp
where deptno=(select deptno  from emp where ename='SMITH') --Ա��SMITH������ͬһ������            
and ename<>'SMITH';--��ѯ������ų�SMITH
9.дһ����ѯ��ʾ�乤�ʱ�ȫ��ְԱƽ�����ʸߵ�Ա����š�������
select empno,ename from emp where sal>(select avg(sal) from emp )
10.дһ����ѯ��ʾ���ϼ��쵼��King��Ա�����������ʡ�
select ename,sal from emp where mgr=(select empno from emp where ename='KING')
11.��ʾ���й�����RESEARCH���ŵ�Ա��������ְλ��
select ename,job from emp e,dept d where e.deptno=d.deptno and d.dname='RESEARCH'
--�Ӳ�ѯ��
select ename,job from emp where deptno=(select deptno from dept where dname='RESEARCH')
12.��ѯÿ�����ŵĲ��ű�š�ƽ�����ʣ�Ҫ���ŵ�ƽ�����ʸ��ڲ���20��ƽ�����ʡ�
select deptno,avg(sal) from emp group by deptno 
having avg(sal)>(select avg(sal) from emp where deptno=20) 
--"��ѯÿ�����ŵ�": group by deptno 
13.��ѯ�����Լ�����ƽ�����ʵ�Ա�����������ʣ����ڲ���ƽ�����ʣ����ڲ���ƽ�����ʵĶ�ȡ�
  select e.ename Ա������,
           e.sal ����,
           ed.avgsal ���ڲ���ƽ������,
           (e.sal - ed.avgsal) ����ƽ�����ʶ��
      from emp e,
           (select deptno, avg(sal) avgsal from emp group by deptno) ed
     where e.deptno = ed.deptno  --�������
       and e.sal > ed.avgsal;--�����Լ�����ƽ������
14. �г�������һ����Ա�����в���
select * from dept where deptno in(select deptno from emp group by deptno
having count(*)>0);
15. �г�н���"SMITH"������й�Ա
select * from emp where sal>(select sal from emp where ename='SMITH')
16. �г���ְ����������ֱ���ϼ������й�Ա
select * from emp e where hiredate<(select m.hiredate from emp m where m.empno=e.mgr)
--
 select e.ename      ��Ա����,
           e.mgr        ��Ա����,
           e.hiredate   ��Ա��ְ����,
           mgr.hiredate ������ְ����
      from emp e, emp mgr
     where e.mgr = mgr.empno(+)
       and e.hiredate < mgr.hiredate;
17. ��Ա��������ֱ���ϼ�������
 SELECT e.ename ,m.ename
  FROM emp e,emp m
 WHERE e.mgr=m.empno(+);  --�����������
 --
    select e.ename Ա������, mgr.ename �ϼ�����
      from emp e, emp mgr
     where e.mgr = mgr.empno;  
18. ��ʾ�������ƺ�����
select d.dname,count(empno) from emp e,dept d where e.deptno=d.deptno group by d.dname
19. ��ʾÿ�����ŵ���߹��ʵ�Ա��
 select deptno ����, ename Ա������
      from emp
     where sal in (select max(sal) from emp group by deptno);
--�в��
 SELECT *FROM emp
 WHERE (deptno,sal) IN
                      (SELECT deptno,MAX(sal)
                       FROM emp
                      GROUP BY deptno);

20. ��ʾ����Ա����7369������ͬ��Ա������������
    select ename Ա������, sal ����
      from emp
     where deptno = (select deptno from emp where empno = 7369)
       and empno <> 7369;--���硰��Ա����7369������ͬ��Ա���������е����Ա����A���������Ϊ��֤���Լ�����A
21. ��ʾ���������а���"W"��Ա����ͬ���ŵ�Ա������
    select ename Ա������
      from emp 
     where deptno = (select deptno from emp where ename like '%W%');
22. ��ʾ�����ʴ���ƽ�����ʵ�Ա������������
 select ename Ա������, sal ����
      from emp
     where sal > (select avg(sal) from emp);
23. ��ʾ�����ʴ��ڱ�����ƽ�����ʵ�Ա������������
    select e.ename Ա������, e.sal ����
      from emp e,
           (select deptno,avg(sal) avgsal from emp group by deptno) a
     where e.deptno = a.deptno
       and e.sal > a.avgsal;
24. ��ʾÿλ�������Ա������͹��ʣ�����͹����ߵ�����
    select e.sal ��͹���, e.ename ����,e.mgr
      from emp e
     where (e.mgr,e.sal) in (select e.mgr, min(e.sal)
                               from emp e
                               group by e.mgr);
         
----
select sal,ename from emp where sal in(select min(sal) from emp group by mgr)
25. ��ʾ�ȹ�����ߵ�Ա���μӹ���ʱ�����Ա���������μӹ���ʱ��
    select ename Ա������, hiredate �μӹ���ʱ��
      from emp
     where hiredate >
           (select hiredate
              from emp
             where sal = (select max(sal) from emp));
26. ��ʾ��ƽ��������ߵĵĲ���ƽ�����ʼ���������
SELECT * FROM (SELECT AVG(sal),dname
          FROM emp e,dept d
         WHERE e.deptno=d.deptno
         GROUP BY dname
         ORDER BY AVG(sal) DESC)
  WHERE ROWNUM<=1;
�ڰ���
��ϰ1
1.�ֱ�ʹ���������㼰��ȫ����������ɣ�����ʱ������˳�򣬲�ѯԱ��7839�Ĺ�����λ�б�
 --  union��������
      select job ������λ�б�, hiredate from emp where empno = 7839
      union
      select job, begindate from emp_jobhistory ej where empno = 7839 
      order by hiredate;  --begindate����

     --  union all��ȫ��������  
      select job ������λ�б�, hiredate from emp where empno = 7839
      union all
      select job, begindate from emp_jobhistory ej where empno = 7839 
      order by hiredate;

--2.ʹ�ö�����ӣ���ѯÿ�����ŵĲ��ű�ţ�����������û�������Ĳ�����ʾ0��
 select d.deptno ���ű��, nvl (count(e.ename), 0) ��������  --���⡰���������������emp���enameͳ��
        from emp e, dept d
       where e.deptno(+) = d.deptno
       group by d.deptno;  --�����źŷֺ���󣬾Ϳ�����emp���enameͳ�Ƹ���������
--3.ʹ���������㣬��ѯÿ�����ŵĲ��ű�ţ�����������û�������Ĳ�����ʾ0��
select deptno,count(1) �������� 
from emp 
where deptno is not null
group by deptno
union all
select deptno,nvl(to_number(null),0) ��������----��Ϊcount()�����֣�����Ҫʹ��to_number����
from dept
--Ϊʲô���ֶ�nvl(to_number(null),0)�е�null:
--��Ϊ���⡰û�������Ĳ�����ʾ0����������nvl��֪������һ������Ϊ��ʱ�����ת�ɵڶ���������������null


--4.ʹ���������㣬��ѯ10�Ų��ż�20�Ų��ŵ�Ա�����������ű�š�
select ename Ա������,deptno ���ű�� from emp where deptno=10
union
select ename Ա������,deptno ���ű�� from emp where deptno =20
--5. ʹ�ü������㣬�������Ч����
����              �����ص�      Ա������                       ��ְ���� 

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
select deptno ����,loc �����ص�,to_char(null) ����,to_date(null) ��ְ���� --�������ַ�����������to_char����ְ������������,������to_date
from dept
union   ----��ȥ�أ�������
--select2
select deptno,to_char(null) �����ص�,ename,hiredate
from emp

   
�κ���ҵ
1.�ü������㣬�г�������jobΪSALESMAN �Ĳ��ŵĲ��źš�
select deptno from dept
minus
select deptno from emp where job = 'SALESMAN';--ȫ��-����=������
---������2.дһ�����ϲ�ѯ���г��������Ϣ��
--EMP�������й�Ա�����ֺͲ��ű��,���������Ƿ������κβ��š�
--DEPT���е����в��ű�źͲ������ƣ����������Ƿ���Ա����
select ename ��Ա����,deptno ���ű��,to_char(null) �������� from emp 
union
select to_char(null) ��Ա����,deptno ���ű��,dname �������� from dept
order by ���ű�� desc

--to_char(null) �������ƣ�Ա�����С����������Ƿ������κβ��š���Ա������û�в��������ֶ�
--to_char(null) ��Ա���֣����ű��С����������Ƿ���Ա���������ű�û�й�Ա�����ֶ�
3.�ü��������ѯ��ְλΪSALESMAN�Ͳ��ű��Ϊ10����Ա��š�������ְλ�����ų��ظ������
select empno ��Ա���, ename ����, job ְλ from emp where job = 'SALESMAN'
union all
select empno,ename,job from emp where deptno = 10;
--"���ų��ظ����"���ɰ����ظ����������union all����union�ǲ����ظ����
--4.�ü��ϲ�ѯ������Ϊ10��20��������Ա��š����������ڲ������ơ�
select e.empno ��Ա���, e.ename ����, d.dname ��������
from emp e, dept d
where e.deptno = d.deptno
and e.deptno = 10
union
select e.empno ��Ա���, e.ename ����, d.dname ��������
from emp e, dept d
where e.deptno = d.deptno
and e.deptno = 20; 
--ע�������ӣ�and���ֿ�д10��20
�ھ���
��ϰ1
--1.��ѯ������ְλƽ�����ʸߵ�Ա��������ְλ��

select ename,job
from emp e
where sal>(select avg(sal) from emp where job=e.job)---�Ӳ�ѯ���������Ժ�ѡ�У����Ը���ѯ����
--2.��ѯ����Ϊ�䲿����͹��ʵ�Ա����ţ����������ʡ�
select empno,ename,sal
from emp e
where sal=(select min(sal) from emp where deptno=e.deptno)---����Ӳ�ѯ
��ϰ2
������ϰ��������Ӳ�ѯ���
1.��ѯ���й�Ա��ţ����ֺͲ������֡�
select e.empno Ա����ţ�e.ename ����,
  (select dname from dept where deptno = e.deptno) ��������
from emp e;


2.��ѯ��ЩԱ���Ǿ���
select empno,ename,job,sal,mgr
from emp e
where 0<(select count(1) from emp where mgr=e.empno)
----�����6�����ݣ�ԭ������Ա�����ȥ����û����������������1������
3.��ѯ��ЩԱ�����Ǿ���
select empno,ename,job,sal,mgr
from emp e
where 0=(select count(1) from emp where mgr=e.empno)
4.��ѯÿ�����Ź�����͵�����Ա����ţ����������ʡ�
select empno,ename,sal,deptno
from emp e
where 2>(select count(1) from emp where deptno=e.deptno and sal<e.sal)
��ϰ3
������ϰ����exists��not exists���
1.�г�������һ����Ա�����в������ơ�
   select dname �������� from dept d
      where exists (select 1 from emp where deptno = d.deptno); --��1��ֻ��ռλ�ã���ʵ������
2.�г�һ����Ա��û�е����в������ơ�
select dname �������� from dept d
      where not exists (select 1 from emp where deptno = d.deptno);
�κ���ҵ
������ϰ��ʹ������Ӳ�ѯ��ɡ�
1.��ѯнˮ���������ڲ���ƽ��нˮ�Ĺ�Ա���֣����źš�
select ename ��Ա����, deptno ���ź�,sal
      from emp e
     where sal > (select avg(sal) from emp where deptno = e.deptno);
2.��ѯԱ��������ֱ���ϼ������֡�
 select e.ename Ա������,
           (select ename from emp where empno = e.mgr) �ϼ�����
      from emp e;
3.��ѯÿ�����Ź�����ߵ�Ա�����������ʡ�
 select e.ename Ա������, e.sal ����
      from emp e
     where sal = (select max(sal) from emp where deptno = e.deptno);

--4.��ѯÿ�����Ź���ǰ�����ߵ�Ա�����������ʡ�
 select e.ename Ա������, e.sal ����
      from emp e
     where 1 >= (select count(ename) 
                   from emp 
                  where deptno = e.deptno
                    and sal > e.sal);



select ename,sal,deptno
from emp e
where (select count(*)
 from emp where deptno=e.deptno and sal>e.sal )<2
��ʮ��
1.����һ��������ʾ BLAKE�������¼�������ֱ�Ӻͼ���¼�����Ա�����֡�нˮ�Ͳ��źš�
select ename ��Ա����,sal нˮ,deptno ���ź� from emp
start with ename = 'BLAKE'
connect by prior empno = mgr; 
2.����һ��������ʾ���ڹ�Ա SMITH ����Ĳ�Σ����������������������ʾ����ֱ�Ӿ���
   select level ����, ename ����
      from emp
     where ename <> 'SMITH'  --��where�Ӿ�ȥ��һ���ڵ�
     start with ename = 'SMITH'
   connect by prior mgr = empno;
3.����һ������������ʾ�����Σ�������Ϊ KING�Ĺ�Ա��ʼ����ʾ��Ա�����֡�����ID�Ͳ���ID��
 SELECT LPAD(ename, LENGTH(ename)+LEVEL*2,'*') ename,mgr,deptno
   FROM emp
  START WITH ename='KING'
CONNECT BY PRIOR empno=mgr;  --����ʾ�����Σ�������Ϊ KING�Ĺ�Ա��ʼ���е�KING�Ǿ���
--4.����һ����˾��֯ͼ����ʾ�����Ρ���������˿�ʼ���ų�����jobΪCLERK���ˣ�
��Ҫ�ų�FORD����Щ��FORD����Ĺ�Ա��
  SELECT LPAD(ename, LENGTH(ename)+LEVEL*2,'*') ename,mgr,deptno
   FROM emp
  WHERE job<>'CLERK'  --�ų�����jobΪCLERK����
  START WITH ename='KING'
CONNECT BY PRIOR empno=mgr
    AND ename<>'FORD';    --��Ҫ�ų�FORD����Щ��FORD����Ĺ�Ա
��ʮһ��
��ϰ1
1.���ű�����һ�����ţ����ű��Ϊ50����������ΪHR�������ص�ΪSY��
insert into dept(deptno,dname,loc) values (50,'HR','SY');
select * from dept;
2.���ű�����һ�����ţ����ű��Ϊ60����������ΪMARKET��
insert into dept(deptno,dname) values (60,'MARKET')
��ϰ2
1.��Ա����������һ��Ա����Ա�����Ϊ8888������ΪBOB����λΪCLERK������Ϊ��7788��
��ְ����Ϊ1985-03-03��н��3000������Ͳ���Ϊ�ա�
insert into emp (empno,ename,job,mgr,hiredate,sal,comm,deptno)
values(8888,'BOB','CLERK',7788,to_date('1985-03-03','yyyy-mm-dd'),3000,null,null)

��ϰ3
1.ʹ��CREATE TABLE emp_back as 
        SELECT * FROM EMP WHERE 1=0������emp_back��,�����������ɡ�
CREATE TABLE emp_back as 
SELECT * FROM EMP WHERE 1=0

2.��emp������ְ���ڴ���1982��1��1��֮ǰ��Ա����Ϣ���Ƶ�emp_back���С�
 INSERT INTO emp_back
 SELECT *
  FROM emp
 WHERE hiredate>=to_date('1982-01-01','yyyy-mm-dd');

��ϰ4
1.�޸Ĳ���20��Ա����Ϣ����82��֮����ְ��Ա����ְ����������10��
update  emp set hiredate=hiredate+10 
where deptno=20 and hiredate>to_date('1982-12-31','yyyy-mm-dd')
--82��֮��:��'1982-12-31'��������1��1��
--update ����
2.�޸Ľ���Ϊnull��Ա������������Ϊ0
update emp set comm=0 where comm is null
--comm is null ,������ ����null
3.�޸Ĺ����ص���NEW YORK��CHICAGO��Ա�����ʣ���������500
update emp set sal=sal+500 
where deptno in(select deptno from dept where loc in('NEW YORK','CHICAGO')) 
��ϰ5
1.�ظ���һ�¸ղŵİ�����
��1.��emp��������һ����dname, ���洢��������.
alter table emp_back add(dname varchar2(14));
��2.ʹ������Ӳ�ѯ����dname��Ϊ��ȷ�Ĳ������ơ�
update emp_back e set dname=(select dname from dept d where deptno=e.deptno)
--�������

��ϰ6
1.ɾ��������Ϊ7566��Ա����¼
delete from emp where mgr=7566
2.ɾ��������NEW YORK��Ա����¼
deletedelete from emp where deptno in (select deptno from dept where loc='NEW YORK')
--in :��Ӧ������   ��������NEW YORK"�������ж��
-- =����Ӧһ�����
3.ɾ�����ʴ������ڲ���ƽ�����ʵ�Ա����¼
delete from emp e where sal>(select avg(sal) from emp where deptno=e.deptno)
��ϰ7
��������������У���Щ�����������
INSERT��
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

--ִ��һ��DCL(GRANT��REVOKE)���;ִ��һ��DDL(CREATE��ALTER��DROP��TRUNCATE��RENAME����䣻
--�ύ(COMMIT);�ع�(ROLLBACK)
��ϰ8
1.test��Ϊ�ձ��������������������test���״̬��
INSERT INTO test(id,name) values(1, 'a')��
INSERT INTO test(id,name) values(2, 'b')��
SAVEPOINT s1;
INSERT INTO test(id,name) values(3, 'c')��
INSERT INTO test(id,name) values(4, 'd')��
DELETE FROM test WHERE id in (1,3);
ROLLBACK TO s1;--�ع��������s1����3��������Ч
DELETE FROM test WHERE id in (2,4);
COMMIT; --�������޸�д�����ݿ�
ROLLBACK;--���в����Ѿ��ύ�����ܻع�
--ɾ��(2,4)������ʣ��INSERT INTO test(id,name) values(1, 'a')����������
��ϰ9
�������������Ự��ִ����ÿһ��ʱ�����ݿ�״̬��
�ỰA:
1.UPDATE EMP SET sal = sal+500 WHERE deptno= 10;
3.SELECT sal FROM EMP WHERE deptno = 10;
6.COMMIT:
8.SELECT sal FROM EMP WHERE deptno = 10;
�ỰB��
2.SELECT sal FROM EMP WHERE deptno = 10;
4.UPDATE EMP SET sal = sal+500 WHERE deptno = 20;
5. UPDATE EMP SET sal = sal+1000 WHERE deptno = 10;
7.COMMIT;

�κ���ҵ
1.ʹ��������䣬����ѧ����student�Ͱ༶��class
create table student (        --ѧ����
      xh char(4),--ѧ��
      xm varchar2(10),--����
      sex char(2),--�Ա�
      birthday date,--��������
      sal number(7,2), --��ѧ��
      studentcid number(2) --ѧ���༶��
)
Create table class (   --�༶��
      classid number(2), --�༶���
      cname varchar2(20),--�༶����
        ccount  number(3) --�༶����
)
 --ѧ����
create table student(
       xh  char(4),xm varchar2(10),sex char(2),birthday date,sal number(7,2),
       studentcid number(2)  
)
--�༶��
create table class(
      classid number(2),cname varchar2(20),ccount number(3)
)

2.��������ѧ����Ͱ༶�������������
��1����������༶��ϢΪ��1��JAVA1�࣬null
                         2��JAVA2�࣬null
                         3��JAVA3�࣬null
 --
 insert into class(classid,cname,ccount) values(1,'java1��',null);  
 insert into class(classid,cname,ccount) values(2,'Java2��',null);
 insert into class(classid,cname,ccount) values(3,'Java3��',null);
��2�����ѧ����Ϣ���£���A001��,��������,���С�,��01-5��-05��,100,1
INSERT INTO student
VALUES('A001','����','��','01-5��-05',100,1);
��3�����ѧ����Ϣ���£�'A002','MIKE','��','1905-05-06',10
INSERT INTO student
VALUES('A002','MIKE','��',TO_DATE('1905-05-06','YYYY-MM-DD'),10,NULL);
--��4�����벿��ѧ����Ϣ�� 'A003','JOHN','Ů��
insert into student(xh,xm,sex)  values('A003','JOHN','Ů')
--��5����A001ѧ���Ա��޸�Ϊ'Ů��
update student set sex='Ů' where xh='A001'
--��6����A001ѧ����Ϣ�޸����£��Ա�Ϊ�У���������Ϊ1980-04-01
update student set sex='��' , birthday=to_date('1980-04-01','YYYY-MM-DD') 
where xh='A001'
��7��������Ϊ�յ�ѧ���༶�޸�ΪJava3��
update student set studentcid=(select classid from class where cname='Java3��')
where birthday is null
��8����ʹ��һ��SQL��䣬ʹ���Ӳ�ѯ�����°༶����ÿ���༶�������ֶ�
update class c set ccount=(select count(*) from student s 
where c.classid=s.studentcid);
3.ʹ��������䣬�������±�
CREATE TABLE copy_emp   (
  empno number(4),
  ename varchar2(20),
  hiredate date default sysdate ,
  deptno number(2),
  sal number(8,2))
  
4.�ڵ������Ļ����ϣ������������
(1)�ڱ�copy_emp�в������ݣ�Ҫ��sal�ֶβ����ֵ�����ź�50��
�μӹ���ʱ��Ϊ2000��1��1�գ������ֶ�����
insert into copy_emp values(1,'����','01-1��-2000',50,null);
(2)�ڱ�copy_emp�в������ݣ�Ҫ���emp���в��ź�Ϊ10�Ų��ŵ�Ա����Ϣ����
insert into copy_emp select empno,ename,hiredate,deptno,sal from emp 
where deptno=10
(3)�޸�copy_emp�������ݣ�Ҫ��10�Ų�������Ա����20%�Ĺ���
update copy_emp set sal=sal*1.2 where deptno=10
(4)�޸�copy_emp����salΪ�յļ�¼�������޸�Ϊƽ������
UPDATE copy_emp
    SET sal=
           (SELECT AVG(sal)
              FROM copy_emp)
 WHERE sal IS NULL;
(5)�ѹ���Ϊƽ�����ʵ�Ա���������޸�Ϊ��
update copy_emp set sal=null where sal=
(select avg(sal) from copy_emp);
(6)����򿪴���2�鿴�����޸�
�޸���Ч
(7)ִ��commit������2���ٴβ鿴������Ϣ
COMMIT;
�޸���Ч
(8)ɾ������Ϊ�յ�Ա����Ϣ
DELETE FROM copy_emp
WHERE sal IS NULL;
(9)ִ��rollback
ROLLBACK;
