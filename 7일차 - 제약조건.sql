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
drop table orders

------------ ���� --------------


create table member (
    no number not null constraint PK_member_id Primary Key,
    id varchar2(20) not null,
    pwd varchar2(20) not null,
    name varchar2(50) not null,
    zipcode varchar2(7) not null,
    address varchar2(30) not null,
    tel varchar2(13) not null,
    indate date default sysdate
    foreign Key (zipcode) reference FK_member_id_tb_zipcode(zipcode)
);

create table Shopping_DB (
    no number not null constraint PK_tb_zipcode_zipcode Primary Key,
    zipcode varchar2(7) �����ȣ not null,
    sido varchar2(30) not null,
    gugum varchar2(30) not null,
    dong varchar2(30) not null,
    bungi varcahr(30)
)
