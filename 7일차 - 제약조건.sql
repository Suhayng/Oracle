-- 7���� - ���� ����

-- ���̺� ���� : ���̺� ��ü�� ������
    -- ���̺��� �����ϸ�, �÷��� ���ڵ常 ���簡 ��
    -- ���̺��� �Ҵ�� ���������� ���� ���� �ʴ´�. ( Alter Table �� ����ؼ� �Ҵ� �ؾ� �Ѵ�. )
    -- ���� ���� : �÷��� �Ҵ�Ǿ� �ִ�. ���Ἲ�� üũ
            -- NOT NULL, Primary Key, Foreing Key, check, default

-- ���̺��� ��ü ���ڵ带 ����    
create table dept_copy
as
select * from department;

select * from dept_copy;

desc department;
desc dept_copy;

select * from dept_copy;

create table emp_copy
as
select * from employee;

select * from employee;

--���̺� ���� : Ư�� �÷��� �����ϱ�
create table emp_second
as
select eno, ename, slary, dno from employee;

select * from emp_seceond;

--���̺� ���� : ������ ����ؼ� ���̺� ����
create table emp_third
as
select eno �����ȣ, ename �����, salary ���� 
from employee
where salary > 2000;

select * from  �����ȣ, �����, ���� from emp_third;    -- ���̺��, �÷��� <== ���� ����� ����

-- ���̺� ���� : ������ �̿��ؼ� ���̺� ���� : �ݵ�� ��Ī �̸��� ����ؾ� �Ѵ�.
create table emp_third
as
select eno, ename, salary * 12 from employee;

select * from emp_fifth

-- ���̺� ���� : ���̺� ������ ����, ���ڵ�� �������� �ʴ´�.

create table emp_sixth
as
select * from employee
where 0 = 1                 -- where ���� : false �� ����

select * from emp_sixth;
desc emp_sixth;

-- ���̺� ���� : Alter Table
create table dept20
as
select * from department;

desc dept20;
select * from dept20;

-- ������ ���̺��� �÷��� �߰� : �ݵ�� �߰��� �÷��� NULL �� ����ؾ� �Ѵ�.
Alter Table dept20;
add (birth date);

alter table dept20
add (email varchar2(100)) 

alter table dept20
add ( address varchar2(200));

-- �÷��� �ڷ����� ���� :
desc dept20

alter table dept20
modify dname varchar2(100)

alter table dept20
modify dno number(4)

alter table dept20
modify address Nvarchar2(200)

-- Ư�� �÷� ���� : �����ð� �ܿ� �۾� ( ���ϰ� ���� �ɸ� �� �ִ�. )

Alter table dept20
drop column birth;

select * from dept20;

alter table dept20
drop column email;

-- �÷��� ������ ���ϰ� ���� �߻���.
    -- SET UNUSED : Ư�� �÷��� ��� ���� (������), �߰��� ����
    
alter talbe dept20      -- �������� �� Ư�� �÷��� �������
set unused (address);

desc dept20

alter table dept20      -- �߰��� ��� ������ �÷��� ���� 
drop unused column;     -- ������� �ʴ� �÷��� ������.
    
/* �÷� �̸� ����*/
alter table dept20
rename column LOC to LOCATIONS

alter table dept20
rename column DNO to D_Number;

/* ���̺� �̸� ����*/
rename dept20 to dept30;

desc dept30;

/* ���̺� ���� */
drop table dept 30;

/*
    DDL : Create (��ü ����), Alter (����), Drop (����)
        << ��ü >>
          ���̺�, ��, �ε���, Ʈ����, ������, �Լ�, �������ν���..
*/
/*
    DML : Insert (���ڵ� �߰�), Update (���ڵ� ����), Delete (���ڵ� ����)
        << ���̺��� �� (���ڵ�, �ο�) >>
*/
/*
    DQL : Select 
*/
/*
    ���̺��� �����̳� ���̺� ������
    1. delete       : ���̺��� ���ڵ带 ����. where�� ������� �ʴ� ��� ���ڵ� ����
    2. truncate     : ���̺��� ���ڵ带 ����. �ӵ��� ������ ������.��
    3. drop         : ���̺� ������ ����
*/

create table emp20    --10,20,30 �����
as
select * from employee;

select * from emp10;

-- emp10 : delete �� ����ؼ� ����
    delete emp10
    commit;

    select * from emp10
-- emp20 : truncate �� ����ؼ� ����
    truncate table emp20
    
    select * from emp20

-- emp30 : drop �� ����ؼ� ����
    drop table emp30
    
    select * from emp30
    

drop table EMP
drop table emp_copy


/*
    ������ ���� : �ý����� ���� ������ ����� �ִ� ���̺�
        user_  : �ڽ��� ������ ���� ��ü ������ ���
        all_   : �ڽ��� ������ ������ ��ü�� ������ �ο� ���� ��ü ������ ���
        dba_   : ������ ���̽� �����ڸ� ���� ������ ��ü ������ ���
        
*/

show user;

select * from user_tables;              -- ����ڰ� ������ ���̺� ���� ���
select table_name from user_tables;
select * from user_views;               -- ����ڰ� ������ �信 ���� ���� ���
select * from user_indexes;             -- ����ڰ� ������ �ε��� ����
select * from user_constraints          -- ���� ���� Ȯ��
where table_name = 'EMPLOYEE';
select * from user_sequences;

select * from all_tables;               -- ��� ���̺��� ���, ������ �ο� ���� ���̺� ���
select * from all_views;

select * from dba_tables;               -- ������ ���������� ���� ����

/*
    ���� ���� : ���̺��� ���Ἲ�� Ȯ���ϱ� ���ؼ� �÷��� �ο��Ǵ�  ��Ģ
        1. Primary Key
        2. Unique
        3. Not NULL
        4. CHECK
        5. FOREIGN KEY
        6. DEFAULT
*/

-- 1. Primary Key : �ߺ��� ���� ���� �� ����.

    -- a. ���̺� ������ �÷��� ���� ���� �ο�
        -- ���� ���� �̸� : �������� ���� ��� : Oracle ���� ������ �̸����� ����
            -- ���� ������ ������ �� ���� ���� �̸��� ����ؼ� ����
            -- PK_customer01_id : Primary Key, customer01, id
            -- NU_customer01_pwd : Not Null, coustomer01(���̺��), id (�÷���)
   
    create table customer01 (
        id varchar2(20) not null constraint PK_customer01_id Primary Key ,
        pwd varchar2(20) constraint  NN_customer01_pwd not null, 
        name varchar2(20) constraint NN_customer01_name not null,
        phone varchar2(30) null,
        address varchar(100) null
    )
    
    select * from user_constraints
    where table_name = 'CUSTOMER01'

   create table customer02 (
        id varchar2(20) not null constraint PK_customer01_id Primary Key ,
        pwd varchar2(20) constraint  NN_customer01_pwd not null, 
        name varchar2(20) constraint NN_customer01_name not null,
        phone varchar2(30) null,
        address varchar(100) null
    )
    select * from user_constraints
    where table_name = 'CUSTOMER02'

-- ���̺��� �÷� ���� �� ���� ���� �Ҵ�    
    create table customer01 (
        id varchar2(20) not null constraint PK_customer01_id Primary Key ,
        pwd varchar2(20) constraint  NN_customer01_pwd not null, 
        name varchar2(20) constraint NN_customer01_name not null,
        phone varchar2(30) null,
        address varchar(100) null,
        constraint PK_custumer01_id Primary Key (id)
    )
    
/*
    Foreign Key (����Ű) : �ٸ� ���̺�(�θ�)�� Primary Key, Unique �÷��� �����ؼ� ���� �Ҵ�
    check : �÷��� ���� �Ҵ��� �� check �� �´� ���� �Ҵ�.
*/

-- �θ� ���̺�
    create table ParentTbl (
        name varchar2(20),
        age number(3) constraint CK_ParentTbl_age check (AGE > 0 and AGE < 200),
        gender varchar(3) constraint CK_ParentTbl_gender check (gender IN ('M', 'W')),
        infono number constraint PK_ParentTBL_infono Primary Key
    )
    
    desc parentTbl
    select * from user_constraints
    where table_name = 'PARENTTBL'
    
    select * from ParentTbl;
    insert into ParentTbl 
    values ('ȫ�浿', 30, 'M', 1)
    
     insert into ParentTbl 
    values ('ȫ�浿', 300, 'K', 1)     -- ���� �߻� : 300 (check ����), K (check ����), 1 (Primary Key ����)
    
-- �ڽ� ���̺�     
Create Table ChildTbl(
    id varchar2(40) constraint PK_childTbl_id Primary Key
    pw varchar2(40),
    infono number,
    constraint FK_ChildTbl_infoni foreign key (infono) reference ParentTbl(infono)
);

insert into ChildTbl
values ('aaa', '1234', 1)

insert into ChildTbl
values ('bbb', '1234', 2)

commit;

-- �θ� ���̺�
create table ParentTbl2 (
    dno number(2) not null Primary Key,
    dname varchar2(50),
    loc varchar2(50)
);

    insert into ParentTbl2 
    values (10, 'SALES', 'SEOUL')
    

-- �ڽ� ���̺�
create table ChildTbl2 (
    no number not null,
    ename varchar(50),
    dno number(2) not null, 
    foreign key(dno) reference ParentTbl2(dno)
)
    select * from ChildTbl2

    insert into ChildThl2
    value (1, 'Park', 10)

    select * from ChildTbl2
    
-- default ���� ���� : ���� �Ҵ� ���� ������ default ���� �Ҵ�

Create Table emp_sample01 (
    eno number(4) not null primary key,
    ename varchar(50),
    salary number(7, 2) default 1000
)

select * from emp_sample01;

-- default �÷��� ���� �Ҵ��� ���
insert into emp_sample01
values (1111, 'ȫ�浿', 1500);

-- defaulr �÷��� ���� �Ҵ����� �ʴ� ���. default �� �Ҵ�� ���� ����
insert into emp_sample01 (eno, ename)
values (2222, 'ȫ���');

insert into emp_sample01
values (3333, '������', default)


Create Table emp_sample02 (
    eno number(4) not null primary key,
    ename varchar(50) default 'ȫȫȫ',
    salary number(7, 2) default 1000
)

insert into emp_sample02 (eno)
values(10)

select * from emp_sample02

insert into emp_sample02
values (20, default, default);

/*
    Priamry Key, Foreign Key, Unique, Check, Default, not null
*/

create table member10 (
    no number not null constraint PK_member10_no Primary Key,
    name varchar(50) constraint NN_member10_name Not null,
    birthday date default sysdate ,
    age number(3) check(age > 0 and age < 150),
    gender char(1) check (gender in ('M', 'W')),
    dno number(2) Unique 
);

insert into member10
values(1, 'ȫ�浿', default, 30, 'M', 10)

insert into member10
values(2, '������', default, 30, 'M', 20)

select * from member10

create table orders10 (
    no number not null Primary Key,
    p_no varchar(100) not null,
    p_name varchar(100) not null,
    price number check (price > 10),
    phone varchar(100) default '010-0000-0000',
    dno number(2) not null, 
    foreign key (dno) references member10(dno)
 )
 
 insert into orders10
 values(1, '11111', '������', 5000, default, 10)
 
select * from orders10

drop table member
drop table orders;

/*
    Foreign KEY �� ���� �Ǵ� ���̺� �����ϴ� ���
        1. �ڽ� ���̺��� ���� ���� �� �θ� ���̺� ����
        2. Foreign KEY ���� ������ ��� ���� �� ���̺� ����
        3.  cascade constraints �ɼ����� ���̺��� ���� ����
*/



-- ���̺� ������ ���� ���� : �ٸ� ���̺��� Foreign Key �� �ڽ��� ���̺��� ���� �ϰ� ������ ������ �ȵ�.
    -- �ٸ� ���̺��� �����ϰ� �ִ��� ������ �����ϴ� �ɼ� : cascade constraints �ɼ����� ���� ����
drop table orders;
drop table member;          -- ���� �߻� : Orders ���̺��� id �÷��� member ���̺��� id �÷��� ���� �ϰ� �ִ�.
drop table tb_zipcode;      -- ���� �߻� : member ���̺��� zipcode �÷��� tb_zipcode ���̺��� zipcode �÷��� �����ϰ� �ִ�.
drop table products;

-- ���� ���� ���� �Ŀ� ����
alter table tb_zipcode
drop constraint;

alter table member 
drop constraint FK_MEMBER_ZIPCODE_TB_ZIPCODE

alter table orders
drop constraint FK_ORDERS_ID_MEMBER

alter table orders
drop constraint FK_ORDERS_ID_PRODUCT

-- ���� ���� Ȯ��
select * from user_constraints
table_name = 'MEMBER'

drop table member;

-- cascade constraints �ɼ��� ����ؼ� ����. <== Foreign KEY ���� ������ ���� ���� �� ����

drop table member cascade constraints;
drop table tb_zipcode cascade constraints;
drop table products;



-- ���̺� ������(Foreign Key ����) : �θ� ���̺� (FK ���� ���̺�) �� ���� �����ؾ� �Ѵ�. �ڽ����̺� ����
    -- �ڽ� ���̺��� ������ �� FK �� ���� �ʰ� ���� �� , �θ� ���̺� ���� ��, Alter Table �� ����ؼ� ���߿� FK �� �־��ش�.

-- *************** �ٽ� �ۼ� 
------------ ���̺� ���� --------------

create table tb_zipcode (
    zipcode varchar2(7), not null constraint PK_tb_zipcode_zipcode primary KEY,
    sido varcahr2(30),
    gugum varchar2(30),
    dong varchar2(30),
    bungi varchar2(30)
);

create table member (
    id varchar2(20) not null constraint PK_member_id primary KEY,
    pwd varchar2(20),
    name varchar2(50),
    zipcode varchar2(7),
    constraint FK_member_zipcod_tb_zipcode foreign KEY reference FK_member_id_tb_zipcode(zipcode)
);

-- 1.

-- 2.

-- 3. ������ �ڸ��� �÷��ֱ�
Alter Table tb_zipcode
modify ZIPCODE varchar2 (100);

Alter Table 


-- ���� ���� ��� ��Ȱ��ȭ �ϱ�, (��� ��Ȱ��ȭ �ϱ�)  
    --<= Bulk Insert (�뷮���� Insert) : ���� �������� ���ؼ� Insert �Ǵ� �ӵ��� ������ ������.
alter table tb_zipcode
disable constraint PK_tb_zipcode_zipcode    -- ���� �߻� : member ���̺��� zipcode �÷��� �����ϰ� �ִ�.

alter talbe tb_zipcode
disable constraint PK_tb_zipcode_zipcode cascade    -- Memeber ���̺��� FK�� ����� ���� ���ǵ� �Բ� disable

select * from user_constraints
where table_name IN ('MEMBER', 'TB_ZIPCODE')

select * from tb_zipcode

truncate table tb_zipcode  -- ������ ���ڵ常 ��� ���� ( ������ ��� ���ڵ� ����)

delete tb_zipcode;         -- ������ ���ڵ常 

------- ���� �ٽ� �Է�

/*
    ���� ���� ����(Alter Table) : ������ ���̺� ���� ������ ����
*/

create table emp_copy50
as
select * from employee;

create table dept_copy50
as 
selet * from department;

select * from emp_copy50;
select * from dept_copy50;

select * from user_constrains
where table_name in ('EMPLOYEE', 'DEPARTMENT')

select * from user_constrains
where table_name in ('EMP_COPY50', 'DEPT_COPY50')

-- ���̺��� �����ϸ� ���ڵ常 ���簡 �ȴ�. ���̺��� ���� ������ ����Ǿ� ���� �ʴ´�. 
    --Alter Table �� ����ؼ� ���� ������ ����

select * from emp_copy50

-- Priamry KEY
alter table emp_copy50
add constraint PK_emp_copy50_eno Primary KEY (eno);

alter table deprt_copy50
add constraint PK_dept_copy50 Primary KEY (dno);

--Foreign KEY
alter table emp_copy50
add constraint FK_emp_copy50_dno_depy_copy50 foreign key (dno) reference dept_copy50 (dno);

-- NOT NULL ���� ���� �߰� (������ �ٸ���. add ��ſ� modify �� ���)
desc employee;
desc emp_copy50;    -- Not NULL �� ���� �ʾ�����, Primary Key ���� ������ �Ҵ�
desc department;
desc dept_copy50;   -- Primary Key �������� �ڵ����� Not NULL

    -- ������ null �� �� �ִ� �������� not null �÷����� ������ �� ����.
select ename from emp_copy50
where ename is null 

alter table emp_copy50
modify ename constraint NN_emp_copy50_ename not null;

    -- commission �÷��� not null �Ҵ� �ϱ� : null �� �� �ִ� ��� null �� ó��
select * from emp_copy50;

alter table emp_copy50
modify commission constraint NN_emp_copy50_commission not null;

update emp_copy50
set commission = 0
where commission is null

-- Unique ���� ���� �߰� : �÷��� �ߺ��� ���� ������ �Ҵ� ���� ���Ѵ�.

select ename, count(*)
from emp_copy50
group ename
having count(*) > 2

alter table emp_copy50
add constraint UK_emp


-- check ���� ���� �߰�

select * from emp_copy50;

alter table emp_copy50

alter talbe emp_copy50
add constraint CK_emp_salary check (salary > 0 and salary < 10000)

-- default ���� ���� �߰� <���������� �ƴ� : ���� ���� �̸��� �Ҵ��� �� ����
    -- ���� ���� ���� ��� default �� ������ ���� ����.

alter table emp_copy50
modify salary default 1000;

alter table emp_copy50
modify hiredqte default sysdate;

desc emp_copy50;

insert into emp_copy50 (eno, ename, commission)
values (9999, 'JULI', 100)

default table emp_copy50
values ( 8888, 'JULIA', null, null, default, default, 1500, null);    

/*  ���� ���� ���� : Alter Table ���̺�� drop */

-- Primary KEY ���� : ���̺� �ϳ��� ������

alter table emp_copy50  -- ���� ���� ���ŵ�
drop primary key;

alter table dept_copy50 -- ���� �߻� : foreign key �� �����ϱ� ������ ���� �ȵ�
drop primary key;

select * from dept_copy50 -- foreign key �� ���� �����ϰ� primary key ����
drop primary key cascade;

select * from user_constraints
where table_name in ('ENP_COPY50', 'DEPT_COPY50');

--NOT NULL �÷� ���� �ϱ� : <<���� ���� �̸����� ����>>
alter table emp_copy50
drop constraint NN_EMP_COPY50_ENAME;

--Unique, check ���� ���� ���� << ���� ���� �̸����� ����>>
alter table emp_copy50
drop constraint UK_EMP_COPY50_ENAME;

alter table emp_copy50
drop constraint UK_EMP_COPY50_salary;

alter table emp_copy50
drop constraint NN_EMP_COPY50_COMMISSION;

-- default �� null ��� �÷��� default null �� ���� : default ���� ������ ���� �ϴ� ��
alter table emp_copy50
modify hiredate default null;

select * from emp_copy50

/*
    ���� ���� disable / enable
        - ���� ������ ��� ���� ��Ŵ.
        - �뷮(Bulk Insert) ���� ���� ���̺� �߰��� �� ���ϰ� ���� �ɸ���. disable ==> enable
        - Index�� ������ ���ϰ� ���� �ɸ���. disable ==> enable
*/

alter table dept_copy50
add constraint PK_dept_copy50_dno Primary Key (dno);

alter table emp_copy50
add constraint PK_emp_copy50_eno Primary Key (eno);

alter table emp_copy50
add consraint FK_emp_copy50_dno Foreign Key (dno) references dept_copy50(dno);

select * from user_constraints
where table_name in ('EMP_COPY50', 'DEPT_COPY50')

select * from emp_copy50;
select * from dept_copy50;

alter table emp_copy50
disable constraint FK_emp_copy50_dno;

insert into emp_copy50 (eno, ename, dno)
values (8989, 'aaaa', 50)

insert into dept_copy50
values (50, 'HR', 'SEOUL')

alter table emp_copy50
enable constraint FK_emp_copy50_dno;
=============================================================================
-- ���̺� ���� ���� ���� 
���̺� ���� ���� ����

1. ���� ǥ�� ��õ� ��� DEPT ���̺��� ���� �Ͻÿ�. 

�÷���	������Ÿ��	ũ��	NULL
---------------------------------------------------------------
DNO	number		2	NOT NULL
DNAME	varchar2		14	NULL
LOC	varchar2		13	NULL

select * from user_tables   -- ���� ����ڰ� ����� ���� ��� ���̺� ���(������ ����) : 
where table_name = 'DEPT';

drop table dept;            -- ���� ���̺� ����

create table dept (
    dno number(2) not null,
    dname varchar2(14) null,
    loc varchar2(13) null
)


2. ���� ǥ�� ��õ� ��� EMP ���̺��� ���� �Ͻÿ�. 

�÷���	������Ÿ��	ũ��	NULL
---------------------------------------------------------------
ENO	number		4	NOT NULL
ENAME	varchar2		10	NULL
DNO	number		2	NULL

drop table emp;

create table emp (
    eno number(4) not null,
    dname varchar2(10) null,
    dno number(2) null
)
-- DB ������ ����, NULL ��� ���ΰ� �ٸ��� ���õǾ� ���� �� �ִ�.

3. ���̸��� ���� �� �ֵ��� EMP ���̺��� ENAME �÷��� ũ�⸦ �ø��ÿ�. 

�÷���	������Ÿ��	ũ��	NULL
---------------------------------------------------------------
ENO	number		4	NOT NULL
ENAME	varchar2		25	NULL		<<==���� �÷�  : 10 => 25  �� �ø�
DNO	number		2	NULL

select length (ename) from employee;
where length (ename) > 5


4. EMPLOYEE ���̺��� �����ؼ� EMPLOYEE2 �� �̸��� ���̺��� �����ϵ� �����ȣ, �̸�, �޿�, �μ���ȣ �÷��� �����ϰ� ���� ������ ���̺��� �÷����� ���� EMP_ID, NAME, SAL, DEPT_ID �� ���� �Ͻÿ�. 

create table employee2 
as
select eno, ename, salary, dno from employee;

select from employee2

-- ���̺� ������ �� ���������� ���� ���� �ʴ´�.
    -- Primary Key, Unique, not null, check, Foreign Key, default

5. EMP ���̺��� ���� �Ͻÿ�. 

drop table emlp;

6. EMPLOYEE2 �� ���̺� �̸��� EMP�� ���� �Ͻÿ�. 

rename employee2 to emp;

desc employee2;


7. DEPT ���̺��� DNAME �÷��� ���� �Ͻÿ�

select * from dept;

-- ���� ��ϴ� �ý��ۿ����� ���ڵ尡 ���� ����ִ�. �÷� ���Ž� ���ϰ� ���� �߻�, (�߰�)

alter table dept
drop column dname

8. DEPT ���̺��� LOC �÷��� UNUSED�� ǥ�� �Ͻÿ�. 
    -- ������ �÷��� ��Ȱ��ȭ (�����ð�)
    
alter talbe dept
set unused ( loc ) ;

9. UNUSED Ŀ���� ��� ���� �Ͻÿ�. 
    -- �߰��� �۾�
    
alter table dept
drop unused columns;


09 - ������ ���۰� Ʈ����� ����. 
================================================================================

1. EMP ���̺��� ������ �����Ͽ� EMP_INSERT �� �̸��� �� ���̺��� ����ÿ�. 

create table emp_insert 
as
select * from emp
where 0=1               -- ������ false �� �����ϸ�

2. ������ EMP_INSERT ���̺� �߰��ϵ� SYSDATE�� �̿��ؼ� �Ի����� ���÷� �Է��Ͻÿ�. 

select * from emp_insert

-- ���̺� �÷��� �߰��� ���� NULL ����ϸ鼭 �߰��ؾ���.

alter table emp_insert
add hiredate date;

desc emp_insert;

insert into emp_insert (eno, ename, salary, dno, hiredate)
values ( 1000, 'ȫ�浿', 3000.35, 10, sysdate)
commit;

3. EMP_INSERT ���̺� �� ����� �߰��ϵ� TO_DATE �Լ��� �̿��ؼ� �Ի����� ������ �Է��Ͻÿ�. 

insert into emp_insert (eno, ename, salary, dno, hiredate)
values ( 1001, '�����', 3000.35, 10, to_date(sysdate-1, 'YY/MM/DD'))
commit;

4. employee���̺��� ������ ������ �����Ͽ� EMP_COPY�� �̸��� ���̺��� ����ÿ�. 

create table emp_copy
as
select * from employee

5. �����ȣ�� 7788�� ����� �μ���ȣ�� 10������ �����Ͻÿ�. [ EMP_COPY ���̺� ���] 

select * from emp_copy

update emp_copy
set dno = 10
where eno = 7788        -- ���� : UPDATE, DELETE �� �ݵ�� ������ ���

rollback;

6. �����ȣ�� 7788 �� ��� ���� �� �޿��� �����ȣ 7499�� ������ �� �޿��� ��ġ �ϵ��� �����Ͻÿ�. [ EMP_COPY ���̺� ���] 

select * from emp_copy where eno = 7788
select * from emp_copy where eno = 7499

update emp_copy
set job = (select job from emp_copy where eno = 7788), 
    salary = (select salary from emp_copy where eno = 7788)
where eno = 7499
commit;

7. �����ȣ 7369�� ������ ������ ����� �μ���ȣ�� ��� 7369�� ���� �μ���ȣ�� ���� �Ͻÿ�. [ EMP_COPY ���̺� ���] 

select * form emp_copy where eno = 7369
select * from emp_copy where job = 'CLERK'

update emp_copy
set dno = (select dno from emp_copy where eno = 7369)
where job = (select job from emp_copy where eno = 7369)

8. department ���̺��� ������ ������ �����Ͽ� DEPT_COPY �� �̸��� ���̺��� ����ÿ�. 

create talbe dept_copy
as
select * from department;

9. DEPT_COPY�� ���̺��� �μ����� RESEARCH�� �μ��� ���� �Ͻÿ�. 

delete dept_copy 
where dname = 'RESEARCH'
commit;

10. DEPT_COPY ���̺��� �μ���ȣ�� 10 �̰ų� 40�� �μ��� ���� �Ͻÿ�. 

delete dept_copy
where dno in (10,40)






