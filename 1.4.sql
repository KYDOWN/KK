��12��
��ϰ1
1. ʹ��NET Configuration Assistant�������ü���������
��ϰ2
1. ʹ��NET Configuration Assistant������������������������������ָ��ͬ�������ݿ⡣
��ϰ3
1. ʹ��PL/SQL Developer�������ӵ���ϰ2�����õ����ݿ⡣
2.��ѯͬ����Ա����


��13��
��ϰ1
1.ѧУ����һ��ѡ��ϵͳ�������漰���γ̱�ѧ������ֱ𴴽����������Լ�˼������Ӧ�е��м��������͡�
create table student(
xh char(4),
xm varchar(10),
sex char(2),
birth date,
classid number(2));

create table course(
courseno number(4),
coursename char(30),
teacher char(10));

----

--  �γ̱�
    create table course(
    cid number(4),    --�γ̱��
    cname varchar(50),--�γ�����
    ctypeID number(4), --�γ�����
    score number(1),   --ѧ��
    chour number(2)   --��ʱ
    );

--ѧ����
    create table student(
    sid char(10),  --ѧ����� 2016003004  
    --���˻�����Ϣ
    sname varchar2(20),         --ѧ������
    sex char(4) default '����', --�Ա�
    telephone varchar2(15),     --��ϵ��ַ  ����������Ϣ��....  
    --Ժϵ��Ϣ
    collegeID number(4),--ѧԺ
    majorID number(4),  --רҵ
    classID number(4),  --�༶ 
    inDate date         --��ѧ����
    );
��ϰ2

1.ͨ���Ӳ�ѯ�ķ�ʽ����һ����dept10,�ñ���10�Ų��ŵ�Ա�����ݡ�
create table dept10 as select * from emp  --Ա������:select * from emp
where deptno=10   --10�Ų���

��ϰ3
1.��Ա���������һ���Ա��У�����Ϊgender������Ϊchar(2)��Ĭ��ֵΪ���С�
alter table emp add gender char(2) default'��'
2.�޸�Ա�������Ա��е���������Ϊchar(4)
alter table emp modify gender char(4);
3.�޸�Ա�������Ա��е�Ĭ��ֵΪ��Ů��
alter table emp modify gender char(4)  default'Ů'
4.ɾ��Ա�����е��Ա���
alter table emp drop (gender);
�κ���ҵ��
1.�������������Ҫ����Ҫ����ʲô���͵��ֶ�?
(1)���2000���ֽڶ����ַ���
char(2000)
(2)������롮������ ����ո�6��
char(10)
--(3)�Ա�����'��'��'Ů��
char(2)
(4)���4000���ֽڱ䳤�ַ���
varchar2(4000)
--(5)��������ݿ�������'����'����ʾ����'������  ----
  nvarchar2(2)
(6)��ʾ���ַ�ΧΪ- 10��125�η���10��126�η�, ���Ա�ʾС�� Ҳ���Ա�ʾ����
number
(7)����ʾ4λ����  -9999 �� 9999
number(4)
(8)��ʾ5λ��Ч���� 2λС���� һ��С��  -999.99 �� 999.99
number(5,2)
(9)���������պ�ʱ����  ----
date
(10)���������պ�ʱ�������   ------
  timestamp
(11)�����ƴ����ͼ��/����
    blob

2.������date_test,������d������Ϊdate�͡�����date_test���в���������¼��
һ����ǰϵͳ���ڼ�¼��һ����¼Ϊ��1998-08-18����
create table date_test (
d date
);

insert into date_test  values(sysdate);
insert into date_test  values(to_date('1998-08-18','YYYY-MM-DD'));

3.������dept����ͬ��ṹ�ı�dtest����dept���в��ű����40֮ǰ����Ϣ����ñ�
create table dtest as select * from dept where deptno<40
3.������emp��ṹ��ͬ�ı�empl�������䲿�ű��Ϊǰ30�ŵ�Ա����Ϣ���Ƶ�empl��
create table emp1 as select * from emp where deptno<30
4.��Ϊѧ����student����һ��ѧ���Ա�gender Ĭ��ֵ ��Ů����
alter table student add (gender char(2) default 'Ů')
5.���޸�ѧ����������������Ϊ�����ַ���10λ��
alter table student modify(xm char(10));

��14��
��ϰ1
1.ѧУ��һ��ѡ��ϵͳ�����а������¹�ϵģʽ��
ϵ(ϵ��ţ� ������
   ϵ����:  Ψһ����
   ϵ���Σ� �ǿ�Լ����
   ϵ����Уȥ��ȡֵ��Χֻ�����Ϻ�У���ͻ���У��)
�༶(�༶��ţ� ������
     �༶���ƣ� Ψһ����
     ����ϵ��  ���)
     --    ϵ(ϵ��ţ� ������
--       ϵ����:  Ψһ����
--       ϵ���Σ� �ǿ�Լ����
--       ϵ����Уȥ��ȡֵ��Χֻ�����Ϻ�У���ͻ���У��)

    create table college (
           collegeno number(4)     constraint college_cgno_pk primary key,
           cgname    varchar2(20)  constraint college_cgname_unique unique,
           cgdirector varchar2(20) constraint college_cgdirector_null not null,
           cgcampus   varchar2(40) constraint college_cgcampus_ck 
                                   check(cgcampus in ('�Ϻ�У��','����У��'))
    );

--    �༶(�༶��ţ� ������
--         �༶���ƣ� Ψһ����
--         ����ϵ��  ���)
    create table class (
           classno varchar2(10) constraint class_classno_pk primary key,
           clname  varchar2(40) constraint class_clname_unique unique,
           cgname  varchar2(40) constraint class_cgname_fk 
                                references college(cgname)
    );

    --  ϵ��������
    select * from college;
    insert into college (collegeno,cgname,cgdirector,cgcampus) 
           values (0001,'����ϵ','����','�Ϻ�У��');--ok

    insert into college (collegeno,cgname,cgdirector,cgcampus) 
           values (0001,'Ӣ��ϵ','����','�Ϻ�У��');
           --Υ������Լ����primary key��college_cgno_pk

    insert into college (collegeno,cgname,cgdirector,cgcampus) 
           values (0002,'����ϵ','����','�Ϻ�У��');
           --Υ��ΨһԼ��college_cgname_unique

    insert into college (collegeno,cgname,cgdirector,cgcampus) 
           values (0003,'��ѧϵ',null,'�Ϻ�У��');
           --Υ���ǿ�Լ��college_cgdirector_null

    insert into college (collegeno,cgname,cgdirector,cgcampus) 
           values (0004,'����ϵ','����','����У��');
           --Υ�����Լ��college_cgcampus_ck

    --  �༶��������
    select * from class;
    insert into class (classno,clname,cgname) 
           values (1001,'һ��','����ϵ');--ok
    insert into class (classno,clname,cgname) 
           values (1002,'����','����ϵ');--ok

    insert into class (classno,clname,cgname) 
           values (1001,'һ��','����ϵ');--Υ������Լ��class_classno_pk
    insert into class (classno,clname,cgname) 
           values (1002,'һ��','��ѧϵ');--Υ��ΨһԼ��class_clname_unique
    insert into class (classno,clname,cgname) 
           values (1003,'����','��ѧϵ');
           --Υ�����Լ������class_cgname_fk��δ�ҵ�����ؼ���


2.����ѧ����������������:
ѧ�� �����ַ��� 10λ ����
���� �䳤�ַ��� 20λ �ǿ�
�Ա� �����ַ��� 2λ ȡֵ��Χֻ��Ϊ�л�Ů
�������� ������ 
���ڰ༶ 
 create table student (
         studentno char(10)     constraint student_stuno_pk primary key,
         stuname   varchar2(10) constraint student_stuname_null not null,
         sex       char(2)      constraint student_sex_ck check(sex in('��','Ů')),
         birthdate date,
         classno   varchar2(10) constraint student_classno_fk 
                                 references class(classno)      
  );

  --  ѧ����������
  select * from student;
  insert into student (studentno,stuname,sex,birthdate,classno) 
         values ('201800001','����','��','1-1��-1997',1001);--ok    

  insert into student (studentno,stuname,sex,birthdate,classno) 
         values ('201800001','����','��','1-2��-1997',1001);
         --Υ������Լ��student_stuno_pk                 

  insert into student (studentno,stuname,sex,birthdate,classno) 
         values ('201800002',null,'��','1-2��-1997',1001);
         --Υ���ǿ�Լ��student_stuname_null                

  insert into student (studentno,stuname,sex,birthdate,classno) 
         values ('201800002','����','��','1-2��-1997',1001);
         --Υ�����Լ��student_sex_ck          

  insert into student (studentno,stuname,sex,birthdate,classno) 
         values ('201800002','����','��','1-2��-1997',1002);
         --Υ�����Լ������student_clname_fk��δ�ҵ�����ؼ���

�κ���ҵ
--1.����5��Լ���ĺ��塣
    1��not null �ǿ�Լ������Ҫ����ΪԼ����ֵ����Ϊ��
    2��primary key ����Լ����Լ����ֵΨһ�Ҳ���Ϊ��
    3��foreign key ���Լ����Լ����ֵ�븸�����
    4��unique ΨһԼ����Լ����ֵ����Ψһ
    5��check ���Լ����Լ����ֵ��ĳһ��Χ
    
    
2.����ѧ����ϵsc��������������
ѡ����ˮ�� ��ֵ�� ������
ѧ����� �ǿ� ���
�γ̱�� �ǿ� �����
�ɼ�     0-100֮�䣻


  --  Ϊ��2�����Ŀγ̱������������foreign key
    create table course(
    cid number(4) constraint course_cis_pk primary key,    --�γ̱��
    cname varchar(50) constraint course_cname_unique unique--�γ�����
    --ctypeID number(4), --�γ�����
    --score number(1),   --ѧ��
    --chour number(2)   --��ʱ
    );
    select * from course;
    insert into course (cid,cname) values (0001,'��ѧ');--ok
--2.����ѧ����ϵsc��������������
--ѡ����ˮ�� ��ֵ�� ������
--ѧ����� �ǿ� ���
--�γ̱�� �ǿ� �����
--�ɼ�     0-100֮�䣻   
  create table sc (
           scid number(10) constraint sc_scid_pk primary key,--ѡ����ˮ��
           studentno char(10) constraint sc_scstuno_fk 
                              references student(studentno),--ѧ�����
           cid number(4) constraint sc_sccid_fk 
                         references course(cid),--�γ̱��
           grade number(5,2) constraint sc_grade_ck 
                             check(grade between 0 and 100)--�ɼ�
    );

    --  ѧ����ϵ���������
    select * from sc;
    insert into sc (scid,studentno,cid,grade) values (1,'201800001',0001,88);--ok
    insert into sc (scid,studentno,cid,grade) values (1,'201800001',0001,110);--notok
    insert into sc (scid,studentno,cid,grade) values (1,'201800001',0001,10);--not ok
    insert into sc (scid,studentno,cid,grade) values (2,'201800001',0003,11);--not ok
3.����copy_emp��Ҫ���ʽͬemp����ȫһ�������������ݡ�
create table copy_emp as select * from emp where 1=0;
    
4.����copy_dept��Ҫ���ʽͬdept����ȫһ�������������ݡ�
 create table copy_dept as select * from dept where 1=0;
    

5.����copy_emp �������deptno������copy_dept��deptno,����ܷ�ɹ�,Ϊʲô��
 alter table copy_emp add constraint copy_emp_deptno_fk 
                             foreign key(deptno) references copy_dept(deptno);    
    --  ���ܣ���Ϊcopy_dept���е�deptno����������Ψһֵ
6.׷��copy_dept��������deptno
alter table copy_dept add constraint copy_dept_deptno_pk primary key(deptno);

