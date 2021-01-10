第12章
练习1
1. 使用NET Configuration Assistant工具配置监听器服务。
练习2
1. 使用NET Configuration Assistant工具配置网络服务名，该网络服务名指向同桌的数据库。
练习3
1. 使用PL/SQL Developer工具连接到练习2所配置的数据库。
2.查询同桌的员工表。


第13章
练习1
1.学校想做一个选课系统，其中涉及到课程表，学生表，请分别创建这两个表，自己思考表中应有的列及数据类型。
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

--  课程表
    create table course(
    cid number(4),    --课程编号
    cname varchar(50),--课程姓名
    ctypeID number(4), --课程类型
    score number(1),   --学分
    chour number(2)   --课时
    );

--学生表
    create table student(
    sid char(10),  --学生编号 2016003004  
    --个人基本信息
    sname varchar2(20),         --学生姓名
    sex char(4) default '不详', --性别
    telephone varchar2(15),     --联系地址  其他个人信息略....  
    --院系信息
    collegeID number(4),--学院
    majorID number(4),  --专业
    classID number(4),  --班级 
    inDate date         --入学日期
    );
练习2

1.通过子查询的方式创建一个表dept10,该表保存10号部门的员工数据。
create table dept10 as select * from emp  --员工数据:select * from emp
where deptno=10   --10号部门

练习3
1.在员工表中添加一个性别列，列名为gender，类型为char(2)，默认值为“男”
alter table emp add gender char(2) default'男'
2.修改员工表中性别列的数据类型为char(4)
alter table emp modify gender char(4);
3.修改员工表中性别列的默认值为“女”
alter table emp modify gender char(4)  default'女'
4.删除员工表中的性别列
alter table emp drop (gender);
课后作业：
1.请分析按照以下要求都需要建立什么类型的字段?
(1)最大2000个字节定长字符串
char(2000)
(2)如果输入‘张三’ 后添空格6个
char(10)
--(3)性别输入'男'或'女’
char(2)
(4)最大4000个字节变长字符串
varchar2(4000)
--(5)如果在数据库中输入'张三'则显示数据'张三’  ----
  nvarchar2(2)
(6)表示数字范围为- 10的125次方到10的126次方, 可以表示小数 也可以表示整数
number
(7)最大表示4位整数  -9999 到 9999
number(4)
(8)表示5位有效数字 2位小数的 一个小数  -999.99 到 999.99
number(5,2)
(9)包含年月日和时分秒  ----
date
(10)包含年月日和时分秒毫秒   ------
  timestamp
(11)二进制大对象图像/声音
    blob

2.创建表date_test,包含列d，类型为date型。试向date_test表中插入两条记录，
一条当前系统日期记录，一条记录为“1998-08-18”。
create table date_test (
d date
);

insert into date_test  values(sysdate);
insert into date_test  values(to_date('1998-08-18','YYYY-MM-DD'));

3.创建与dept表相同表结构的表dtest，将dept表中部门编号在40之前的信息插入该表。
create table dtest as select * from dept where deptno<40
3.创建与emp表结构相同的表empl，并将其部门编号为前30号的员工信息复制到empl表。
create table emp1 as select * from emp where deptno<30
4.试为学生表student增加一列学生性别gender 默认值 “女”。
alter table student add (gender char(2) default '女')
5.试修改学生姓名列数据类型为定长字符型10位。
alter table student modify(xm char(10));

第14章
练习1
1.学校有一个选课系统，其中包括如下关系模式：
系(系编号： 主键，
   系名称:  唯一键，
   系主任： 非空约束，
   系所在校去：取值范围只能在南湖校区和浑南校区)
班级(班级编号： 主键，
     班级名称： 唯一键，
     所属系：  外键)
     --    系(系编号： 主键，
--       系名称:  唯一键，
--       系主任： 非空约束，
--       系所在校去：取值范围只能在南湖校区和浑南校区)

    create table college (
           collegeno number(4)     constraint college_cgno_pk primary key,
           cgname    varchar2(20)  constraint college_cgname_unique unique,
           cgdirector varchar2(20) constraint college_cgdirector_null not null,
           cgcampus   varchar2(40) constraint college_cgcampus_ck 
                                   check(cgcampus in ('南湖校区','浑南校区'))
    );

--    班级(班级编号： 主键，
--         班级名称： 唯一键，
--         所属系：  外键)
    create table class (
           classno varchar2(10) constraint class_classno_pk primary key,
           clname  varchar2(40) constraint class_clname_unique unique,
           cgname  varchar2(40) constraint class_cgname_fk 
                                references college(cgname)
    );

    --  系测试用例
    select * from college;
    insert into college (collegeno,cgname,cgdirector,cgcampus) 
           values (0001,'中文系','张三','南湖校区');--ok

    insert into college (collegeno,cgname,cgdirector,cgcampus) 
           values (0001,'英文系','张三','南湖校区');
           --违反主键约束（primary key）college_cgno_pk

    insert into college (collegeno,cgname,cgdirector,cgcampus) 
           values (0002,'中文系','张三','南湖校区');
           --违反唯一约束college_cgname_unique

    insert into college (collegeno,cgname,cgdirector,cgcampus) 
           values (0003,'数学系',null,'南湖校区');
           --违反非空约束college_cgdirector_null

    insert into college (collegeno,cgname,cgdirector,cgcampus) 
           values (0004,'法文系','张三','北京校区');
           --违反检查约束college_cgcampus_ck

    --  班级测试用例
    select * from class;
    insert into class (classno,clname,cgname) 
           values (1001,'一班','中文系');--ok
    insert into class (classno,clname,cgname) 
           values (1002,'二班','中文系');--ok

    insert into class (classno,clname,cgname) 
           values (1001,'一班','中文系');--违反主键约束class_classno_pk
    insert into class (classno,clname,cgname) 
           values (1002,'一班','数学系');--违反唯一约束class_clname_unique
    insert into class (classno,clname,cgname) 
           values (1003,'三班','数学系');
           --违法外键约束条件class_cgname_fk，未找到父项关键字


2.创建学生表，包含如下属性:
学号 定长字符型 10位 主键
姓名 变长字符型 20位 非空
性别 定长字符型 2位 取值范围只能为男或女
出生日期 日期型 
所在班级 
 create table student (
         studentno char(10)     constraint student_stuno_pk primary key,
         stuname   varchar2(10) constraint student_stuname_null not null,
         sex       char(2)      constraint student_sex_ck check(sex in('男','女')),
         birthdate date,
         classno   varchar2(10) constraint student_classno_fk 
                                 references class(classno)      
  );

  --  学生测试用例
  select * from student;
  insert into student (studentno,stuname,sex,birthdate,classno) 
         values ('201800001','王三','男','1-1月-1997',1001);--ok    

  insert into student (studentno,stuname,sex,birthdate,classno) 
         values ('201800001','王四','男','1-2月-1997',1001);
         --违反主键约束student_stuno_pk                 

  insert into student (studentno,stuname,sex,birthdate,classno) 
         values ('201800002',null,'男','1-2月-1997',1001);
         --违反非空约束student_stuname_null                

  insert into student (studentno,stuname,sex,birthdate,classno) 
         values ('201800002','王四','妖','1-2月-1997',1001);
         --违反检查约束student_sex_ck          

  insert into student (studentno,stuname,sex,birthdate,classno) 
         values ('201800002','王四','男','1-2月-1997',1002);
         --违法外键约束条件student_clname_fk，未找到父项关键字

课后作业
--1.简述5种约束的含义。
    1、not null 非空约束：主要作用为约束列值不能为空
    2、primary key 主键约束：约束列值唯一且不能为空
    3、foreign key 外键约束：约束列值与父项相关
    4、unique 唯一约束：约束列值必须唯一
    5、check 检查约束：约束列值在某一范围
    
    
2.创建学生关系sc，包括属性名：
选课流水号 数值型 主键；
学生编号 非空 外键
课程编号 非空 外键；
成绩     0-100之间；


  --  为题2创建的课程表，用以设置外键foreign key
    create table course(
    cid number(4) constraint course_cis_pk primary key,    --课程编号
    cname varchar(50) constraint course_cname_unique unique--课程姓名
    --ctypeID number(4), --课程类型
    --score number(1),   --学分
    --chour number(2)   --课时
    );
    select * from course;
    insert into course (cid,cname) values (0001,'数学');--ok
--2.创建学生关系sc，包括属性名：
--选课流水号 数值型 主键；
--学生编号 非空 外键
--课程编号 非空 外键；
--成绩     0-100之间；   
  create table sc (
           scid number(10) constraint sc_scid_pk primary key,--选课流水号
           studentno char(10) constraint sc_scstuno_fk 
                              references student(studentno),--学生编号
           cid number(4) constraint sc_sccid_fk 
                         references course(cid),--课程编号
           grade number(5,2) constraint sc_grade_ck 
                             check(grade between 0 and 100)--成绩
    );

    --  学生关系表测试用例
    select * from sc;
    insert into sc (scid,studentno,cid,grade) values (1,'201800001',0001,88);--ok
    insert into sc (scid,studentno,cid,grade) values (1,'201800001',0001,110);--notok
    insert into sc (scid,studentno,cid,grade) values (1,'201800001',0001,10);--not ok
    insert into sc (scid,studentno,cid,grade) values (2,'201800001',0003,11);--not ok
3.创建copy_emp，要求格式同emp表完全一样，不包含数据。
create table copy_emp as select * from emp where 1=0;
    
4.创建copy_dept，要求格式同dept表完全一样，不包含数据。
 create table copy_dept as select * from dept where 1=0;
    

5.设置copy_emp 表中外键deptno，参照copy_dept中deptno,语句能否成功,为什么？
 alter table copy_emp add constraint copy_emp_deptno_fk 
                             foreign key(deptno) references copy_dept(deptno);    
    --  不能，因为copy_dept表中的deptno不是主键或唯一值
6.追加copy_dept表中主键deptno
alter table copy_dept add constraint copy_dept_deptno_pk primary key(deptno);

