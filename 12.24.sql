----1.ʹ�����ַ�ʽ��ѯ����Ա��(EMP)��Ϣ
select * from emp
select empno, ename, job, mgr, hiredate, sal, comm, deptno from emp
--2.��ѯ(EMP)Ա����š�Ա��������Ա��ְλ��Ա����н���������ű�š�
select empno, ename, job, sal,  deptno from emp

--1.Ա��ת������н�ϵ�20%�����ѯ������Ա��ת�������н��
select sal*1.2 from emp
--2.Ա��������6���£�ת������н�ϵ�20%�����ѯ������Ա��������һ�����н���ã������ǽ��𲿷�,��н��������6���µ���н+ת����6���µ���н)
select sal*6+sal*1.2*6 from emp
---!!!1.Ա��������6���£�ת������н�ϵ�20%�����ѯ������Ա��������һ����������루�迼�ǽ��𲿷�)��Ҫ����ʾ�б���ΪԱ���������������룬�������룬�����롣
--Ϊ0ʱ��ȫ��Ϊ0������Ҫ��nvl
select ename Ա������ ,(sal*6+sal*1.2*6) ��������, nvl((comm*6+comm*6*1.2),0) ��������,(sal*6+sal*1.2*6)+nvl((comm*6+comm*6*1.2),0) ������ from emp
--����1.Ա��������6���£�ת������н�ϵ�20%�����ѯ������Ա��������һ����������루�迼�ǽ��𲿷�)��Ҫ����ʾ��ʽΪ:XXX�ĵ�һ��������ΪXXX��
select ename||'�ĵ�һ��������Ϊ'||((sal*6)+(sal*1.2*6)+nvl(comm,0)) Ա���ĵ�һ������
from emp;
--2.��ѯԱ������һ�����ļ��ָ�λ���͡�
select distinct job from emp
--1.�ֱ�ѡ��Ա�������ű�н�ʵȼ����е��������ݡ�
select * from emp,dept,salgrade
--2.�ֱ�鿴Ա�������ű�н�ʵȼ���ı�ṹ��

--1.��ѯְλΪSALESMAN��Ա����š�ְλ����ְ���ڡ�
select empno,job,hiredate from emp where job='SALESMAN' --���˵����ţ�ԭ����д�ʹ�д��Сд��Ч
--!!!2.��ѯ1985��12��31��֮ǰ��ְ��Ա����������ְ���ڡ�
--Ҫ��to-date�����ţ�����
select ename,hiredate from emp where hiredate<to_date('31-12-1985','dd-mm-yyyy')
---2.��ѯ1985��12��31��֮ǰ��ְ��Ա����������ְ���ڡ�
select ename Ա������,hiredate ��ְ����
from emp
where hiredate < to_date('31-12-1985','DD-MM-YYYY');--------to_date('31-12-1985','DD-MM-YYYY')

select ename,hiredate
from emp
where hiredate <'31-12��-85';----'DD-MM��-YY'
--3.��ѯ���ű�Ų���10���ŵ�Ա�����������ű�š�
select ename,empno from emp where deptno not in( 10 )
--1.��ѯ��ְ������82����85���Ա����������ְ���ڡ�
select ename,hiredate from emp where hiredate between to_date('01-01-1982','dd-mm-yyyy') and to_date('31-12-1985','dd-mm-yyyy')
--2.��ѯ��н��3000��5000��Ա����������н��
select ename,sal from emp where sal between 3000 and 5000
--3.��ѯ���ű��Ϊ10����20��Ա�����������ű�š�
select ename,deptno from emp where deptno=10 or deptno=20
--4.��ѯ������Ϊ7902, 7566, 7788��Ա�������������š�
select ename,mgr from emp where mgr in (7902,7566,7786)
--1.��ѯԱ��������W��ͷ��Ա��������
select ename from emp where ename like 'W%'  --WҪ��д��Сд���У���Ϊ�������ţ�����Ҫ��Ӧ�����������
--2.��ѯԱ������������2���ַ�ΪT��Ա��������
select ename from emp where ename like '%T_'
--3.��ѯ����Ϊ�յ�Ա������������
select ename,comm from emp where comm is null
--???1.��ѯ���ʳ���2000����ְλ��MANAGER,����ְλ��SALESMAN��Ա��������ְλ������
select ename,job,sal from emp where sal > 2000 and job='MANAGER'  or job='SALESMAN'
--???2.��ѯ���ʳ���2000����ְλ�� MANAGER��SALESMAN��Ա��������ְλ�����ʡ�
select ename,job,sal from emp where sal > 2000 and (job='MANAGER' or job='SALESMAN')
--3.��ѯ������10����20�����ҹ�����3000��5000֮���Ա�����������š����ʡ�
select ename,deptno,sal from emp where deptno in('10','20') and (sal between 3000 and 5000)
--4.��ѯ��ְ������81�꣬����ְλ����SALES��ͷ��Ա����������ְ���ڡ�ְλ��
select ename,hiredate,job from emp where hiredate between to_date('01-01-1981','dd-mm-yyyy') and to_date('31-12-1981','dd-mm-yyyy') and job  not like  'SALES%'
--��ʽֻ����01-01-1981��û��1-1-1981
--5.��ѯְλΪSALESMAN��MANAGER�����ű��Ϊ10����20����������A��Ա��������ְλ�����ű�š�
select ename,job,deptno from emp where job in('SALESMAN','MANAGER') and deptno in(10,20) and ename like '%A%'
--1.��ѯ������20��30��Ա�����������ű�ţ������չ�����������
select ename,deptno from emp where deptno in(20,30) order by sal asc
--2.��ѯ������2000-3000֮�䣬���Ų���10�ŵ�Ա�����������ű�ţ����ʣ������ղ������򣬹��ʽ�������
select ename,deptno,sal from emp where( sal between 2000 and 3000 ) and deptno not in(10) order by sal desc
--3.��ѯ��ְ������82����83��֮�䣬ְλ��SALES����MAN��ͷ��Ա����������ְ���ڣ�ְλ����������ְ���ڽ�������
select ename,hiredate,job from emp where( hiredate between to_date('01-01-1982','dd-mm-yyyy') and to_date('31-12-1983','dd-mm-yyyy')) 
and (job  like  'SALES%' or job  like 'MAN%') order by hiredate desc
--1.��ѯ��ְʱ����1982-7-9֮�󣬲��Ҳ�����SALESMAN������Ա����������ְʱ�䡢ְλ��
select ename,hiredate,job from emp where hiredate >to_date('09-07-1982','dd-mm-yyyy') and job not in('SALESMAN')
--2.��ѯԱ�������ĵ�������ĸ��a��Ա��������
select ename from emp where ename like '__A%'
--3.��ѯ����10��20�Ų��������Ա�����������ű�š�
select ename,deptno from emp where deptno not in(10,20)
--???4.��ѯ���ź�Ϊ30��Ա������Ϣ���Ȱ����ʽ��������ٰ�������������
select * from emp where deptno='30' order by sal desc , ename asc
--5.��ѯû���ϼ���Ա��(�����Ϊ��)��Ա��������
select ename from emp where mgr is null
--6.��ѯ���ʴ��ڵ���4500���Ҳ���Ϊ10����20��Ա��������\���ʡ����ű�š�
select ename,sal,deptno from emp where sal>=4500 and deptno in(10,20)
