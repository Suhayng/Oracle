-- 7일차 - 제약 조건

-- 테이블 복사 : 테이블 전체를 복사함
    -- 테이블을 복사하면, 컬럼과 레코드만 복사가 됨
    -- 테이블의 할당된 제약조건은 복사 되지 않는다. ( Alter Table 을 사용해서 할당 해야 한다. )
    -- 제약 조건 : 컬럼에 할당되어 있다. 무결성을 체크
            -- NOT NULL, Primary Key, Foreing Key, check, default

-- 테이블의 전체 레코드를 복사    
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

--테이블 복사 : 특정 컬럼만 복사하기
create table emp_second
as
select eno, ename, slary, dno from employee;

select * from emp_seceond;

--테이블 복사 : 조건을 사용해서 테이블 복사
create table emp_third
as
select eno 사원번호, ename 사원명, salary 월급 
from employee
where salary > 2000;

select * from  사원번호, 사원명, 월급 from emp_third;    -- 테이블명, 컬럼명 <== 영문 사용을 권장

-- 테이블 복서 : 계산식을 이용해서 테이블 복사 : 반드시 별칭 이름을 사용해야 한다.
create table emp_third
as
select eno, ename, salary * 12 from employee;

select * from emp_fifth

-- 테이블 복사 : 테이블 구조만 복사, 레코드는 복사하지 않는다.

create table emp_sixth
as
select * from employee
where 0 = 1                 -- where 조건 : false 를 리턴

select * from emp_sixth;
desc emp_sixth;

-- 테이블 수정 : Alter Table
create table dept20
as
select * from department;

desc dept20;
select * from dept20;

-- 기존의 테이블에서 컬럼을 추가 : 반드시 추가할 컬럼에 NULL 을 허용해야 한다.
Alter Table dept20;
add (birth date);

alter table dept20
add (email varchar2(100)) 

alter table dept20
add ( address varchar2(200));

-- 컬럼의 자료형을 수정 :
desc dept20

alter table dept20
modify dname varchar2(100)

alter table dept20
modify dno number(4)

alter table dept20
modify address Nvarchar2(200)

-- 특정 컬럼 삭제 : 업무시간 외에 작업 ( 부하가 많이 걸릴 수 있다. )

Alter table dept20
drop column birth;

select * from dept20;

alter table dept20
drop column email;

-- 컬럼을 삭제시 부하가 많이 발생됨.
    -- SET UNUSED : 특정 컬럼을 사용 중지 (업무중), 야간에 삭제
    
alter talbe dept20      -- 업무중일 때 특정 컬럼을 사용중지
set unused (address);

desc dept20

alter table dept20      -- 야간에 사용 중지된 컬럼을 삭제 
drop unused column;     -- 사용하지 않는 컬럼을 삭제함.
    
/* 컬럼 이름 변경*/
alter table dept20
rename column LOC to LOCATIONS

alter table dept20
rename column DNO to D_Number;

/* 테이블 이름 변경*/
rename dept20 to dept30;

desc dept30;

/* 테이블 삭제 */
drop table dept 30;

/*
    DDL : Create (객체 생성), Alter (수정), Drop (삭제)
        << 객체 >>
          테이블, 뷰, 인덱스, 트리거, 시퀀스, 함수, 저장프로시져..
*/
/*
    DML : Insert (레코드 추가), Update (레코드 수정), Delete (레코드 삭제)
        << 테이블의 값 (레코드, 로우) >>
*/
/*
    DQL : Select 
*/
/*
    테이블의 내용이나 테이블 삭제시
    1. delete       : 테이블의 레코드를 삭제. where를 사용하지 않는 모든 레코드 삭제
    2. truncate     : 테이블의 레코드를 삭제. 속도가 굉장히 빠르다.ㄴ
    3. drop         : 테이블 자제를 삭제
*/

create table emp20    --10,20,30 만들기
as
select * from employee;

select * from emp10;

-- emp10 : delete 를 사용해서 삭제
    delete emp10
    commit;

    select * from emp10
-- emp20 : truncate 를 사용해서 삭제
    truncate table emp20
    
    select * from emp20

-- emp30 : drop 를 사용해서 삭제
    drop table emp30
    
    select * from emp30
    

drop table EMP
drop table emp_copy


/*
    데이터 사전 : 시스템의 각종 정보를 출력해 주는 테이블
        user_  : 자신의 계정에 속한 객체 정보를 출력
        all_   : 자신의 계정이 소유한 객체나 권한을 부여 받은 객체 정보를 출력
        dba_   : 데이터 베이스 관리자만 접근 가능한 객체 정보를 출력
        
*/

show user;

select * from user_tables;              -- 사용자가 생성한 테이블 정보 출력
select table_name from user_tables;
select * from user_views;               -- 사용자가 생성한 뷰에 대한 정보 출력
select * from user_indexes;             -- 사용자가 생성한 인덱스 정보
select * from user_constraints          -- 제약 조건 확인
where table_name = 'EMPLOYEE';
select * from user_sequences;

select * from all_tables;               -- 모든 테이블을 출력, 권한을 부여 받은 테이블만 출력
select * from all_views;

select * from dba_tables;               -- 관리자 계정에서만 실행 가능

/*
    제약 조건 : 테이블의 무결성을 확보하기 위해서 컬럼에 부여되는  규칙
        1. Primary Key
        2. Unique
        3. Not NULL
        4. CHECK
        5. FOREIGN KEY
        6. DEFAULT
*/

-- 1. Primary Key : 중복된 값을 넣을 수 없다.

    -- a. 테이블 생성시 컬럼에 제약 조건 부여
        -- 제약 조건 이름 : 지정하지 않을 경우 : Oracle 에서 랜덤한 이름으로 생성
            -- 제약 조건을 수정할 때 제약 조건 이름을 사용해서 수정
            -- PK_customer01_id : Primary Key, customer01, id
            -- NU_customer01_pwd : Not Null, coustomer01(테이블명), id (컬럼명)
   
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

-- 테이블의 컬럼 생성 후 제약 조건 할당    
    create table customer01 (
        id varchar2(20) not null constraint PK_customer01_id Primary Key ,
        pwd varchar2(20) constraint  NN_customer01_pwd not null, 
        name varchar2(20) constraint NN_customer01_name not null,
        phone varchar2(30) null,
        address varchar(100) null,
        constraint PK_custumer01_id Primary Key (id)
    )
    
/*
    Foreign Key (참조키) : 다른 테이블(부모)의 Primary Key, Unique 컬럼을 참조해서 값을 할당
    check : 컬럼에 값을 할당할 때 check 에 맞는 값을 할당.
*/

-- 부모 테이블
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
    values ('홍길동', 30, 'M', 1)
    
     insert into ParentTbl 
    values ('홍길동', 300, 'K', 1)     -- 오류 발생 : 300 (check 위배), K (check 위배), 1 (Primary Key 위배)
    
-- 자식 테이블     
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

-- 부모 테이블
create table ParentTbl2 (
    dno number(2) not null Primary Key,
    dname varchar2(50),
    loc varchar2(50)
);

    insert into ParentTbl2 
    values (10, 'SALES', 'SEOUL')
    

-- 자식 테이블
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
    
-- default 제약 조건 : 값을 할당 하지 않으면 default 값이 할당

Create Table emp_sample01 (
    eno number(4) not null primary key,
    ename varchar(50),
    salary number(7, 2) default 1000
)

select * from emp_sample01;

-- default 컬럼에 값을 할당한 경우
insert into emp_sample01
values (1111, '홍길동', 1500);

-- defaulr 컬럼에 값을 할당하지 않는 경우. default 에 할당된 값이 적용
insert into emp_sample01 (eno, ename)
values (2222, '홍길순');

insert into emp_sample01
values (3333, '김유신', default)


Create Table emp_sample02 (
    eno number(4) not null primary key,
    ename varchar(50) default '홍홍홍',
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
values(1, '홍길동', default, 30, 'M', 10)

insert into member10
values(2, '김유신', default, 30, 'M', 20)

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
 values(1, '11111', '유관순', 5000, default, 10)
 
select * from orders10

drop table member
drop table orders;

/*
    Foreign KEY 로 참조 되는 테이블 삭제하는 방법
        1. 자식 테이블을 먼저 삭제 후 부모 테이블 삭제
        2. Foreign KEY 제약 조건을 모두 제거 후 테이블 삭제
        3.  cascade constraints 옵션으로 테이블을 강제 삭제
*/



-- 테이블 삭제시 주의 사항 : 다른 테이블에서 Foreign Key 로 자신의 테이블을 참조 하고 있으면 삭제가 안됨.
    -- 다른 테이블이 참조하고 있더라도 강제로 삭제하는 옵션 : cascade constraints 옵션으로 강제 삭제
drop table orders;
drop table member;          -- 오류 발생 : Orders 테이블의 id 컬럼이 member 테이블의 id 컬럼을 참조 하고 있다.
drop table tb_zipcode;      -- 오류 발생 : member 테이블의 zipcode 컬럼이 tb_zipcode 테이블의 zipcode 컬럼을 참조하고 있다.
drop table products;

-- 제약 조건 제거 후에 삭제
alter table tb_zipcode
drop constraint;

alter table member 
drop constraint FK_MEMBER_ZIPCODE_TB_ZIPCODE

alter table orders
drop constraint FK_ORDERS_ID_MEMBER

alter table orders
drop constraint FK_ORDERS_ID_PRODUCT

-- 제약 조건 확인
select * from user_constraints
table_name = 'MEMBER'

drop table member;

-- cascade constraints 옵션을 사용해서 삭제. <== Foreign KEY 제약 조건을 먼저 제거 후 삭제

drop table member cascade constraints;
drop table tb_zipcode cascade constraints;
drop table products;



-- 테이블 생성시(Foreign Key 존재) : 부모 테이블 (FK 참조 테이블) 을 먼저 생성해야 한다. 자식테이블 생성
    -- 자식 테이블을 생성할 때 FK 를 넣지 않고 생성 후 , 부모 테이블 생성 후, Alter Table 를 사용해서 나중에 FK 를 넣어준다.

-- *************** 다시 작성 
------------ 테이블 설계 --------------

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

-- 3. 부족한 자리수 늘려주기
Alter Table tb_zipcode
modify ZIPCODE varchar2 (100);

Alter Table 


-- 제약 조건 잠시 비활성화 하기, (잠시 비활성화 하기)  
    --<= Bulk Insert (대량으로 Insert) : 제약 조건으로 인해서 Insert 되는 속도가 굉장히 느리다.
alter table tb_zipcode
disable constraint PK_tb_zipcode_zipcode    -- 오류 발생 : member 테이블의 zipcode 컬럼이 참조하고 있다.

alter talbe tb_zipcode
disable constraint PK_tb_zipcode_zipcode cascade    -- Memeber 테이블의 FK가 적용된 제약 조건도 함께 disable

select * from user_constraints
where table_name IN ('MEMBER', 'TB_ZIPCODE')

select * from tb_zipcode

truncate table tb_zipcode  -- 기존의 레코드만 모두 제거 ( 빠르게 모든 레코드 삭제)

delete tb_zipcode;         -- 기존의 레코드만 

------- 위에 다시 입력

/*
    제약 조건 수정(Alter Table) : 기존의 테이블에 제약 조건을 수정
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

-- 테이블을 복사하면 레코드만 복사가 된다. 테이블의 제약 조건은 복사되어 오지 않는다. 
    --Alter Table 를 사용해서 제약 조건을 적용

select * from emp_copy50

-- Priamry KEY
alter table emp_copy50
add constraint PK_emp_copy50_eno Primary KEY (eno);

alter table deprt_copy50
add constraint PK_dept_copy50 Primary KEY (dno);

--Foreign KEY
alter table emp_copy50
add constraint FK_emp_copy50_dno_depy_copy50 foreign key (dno) reference dept_copy50 (dno);

-- NOT NULL 제약 조건 추가 (구문이 다르다. add 대신에 modify 를 사용)
desc employee;
desc emp_copy50;    -- Not NULL 을 넣지 않았지만, Primary Key 제약 조건을 할당
desc department;
desc dept_copy50;   -- Primary Key 적용으로 자동으로 Not NULL

    -- 기존의 null 이 들어가 있는 곳에서는 not null 컬럼으로 지정할 수 없다.
select ename from emp_copy50
where ename is null 

alter table emp_copy50
modify ename constraint NN_emp_copy50_ename not null;

    -- commission 컬럼에 not null 할당 하기 : null 이 들어가 있는 경우 null 을 처리
select * from emp_copy50;

alter table emp_copy50
modify commission constraint NN_emp_copy50_commission not null;

update emp_copy50
set commission = 0
where commission is null

-- Unique 제약 조건 추가 : 컬럼에 중복된 값이 있으면 할당 하지 못한다.

select ename, count(*)
from emp_copy50
group ename
having count(*) > 2

alter table emp_copy50
add constraint UK_emp


-- check 제약 조건 추가

select * from emp_copy50;

alter table emp_copy50

alter talbe emp_copy50
add constraint CK_emp_salary check (salary > 0 and salary < 10000)

-- default 제약 조건 추가 <제약조건이 아님 : 제약 조건 이름을 할당할 수 없다
    -- 값을 넣지 않을 경우 default 로 설정된 값이 들어간다.

alter table emp_copy50
modify salary default 1000;

alter table emp_copy50
modify hiredqte default sysdate;

desc emp_copy50;

insert into emp_copy50 (eno, ename, commission)
values (9999, 'JULI', 100)

default table emp_copy50
values ( 8888, 'JULIA', null, null, default, default, 1500, null);    

/*  제약 조건 제거 : Alter Table 테이블명 drop */

-- Primary KEY 제거 : 테이블에 하나만 존재함

alter table emp_copy50  -- 오류 없이 제거됨
drop primary key;

alter table dept_copy50 -- 오류 발생 : foreign key 가 참조하기 때문에 삭제 안됨
drop primary key;

select * from dept_copy50 -- foreign key 를 먼저 제거하고 primary key 제거
drop primary key cascade;

select * from user_constraints
where table_name in ('ENP_COPY50', 'DEPT_COPY50');

--NOT NULL 컬럼 제거 하기 : <<제약 조건 이름으로 삭제>>
alter table emp_copy50
drop constraint NN_EMP_COPY50_ENAME;

--Unique, check 제약 조건 제거 << 제약 조건 이름으로 제거>>
alter table emp_copy50
drop constraint UK_EMP_COPY50_ENAME;

alter table emp_copy50
drop constraint UK_EMP_COPY50_salary;

alter table emp_copy50
drop constraint NN_EMP_COPY50_COMMISSION;

-- default 는 null 허용 컬럼은 default null 로 셋팅 : default 제약 조건을 제거 하는 것
alter table emp_copy50
modify hiredate default null;

select * from emp_copy50

/*
    제약 조건 disable / enable
        - 제약 조건을 잠시 중지 시킴.
        - 대량(Bulk Insert) 으로 값을 테이블에 추가할 때 부하가 많이 걸린다. disable ==> enable
        - Index를 생성시 부하가 많이 걸린다. disable ==> enable
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
-- 테이블 생성 수정 제거 
테이블 생성 수정 제거

1. 다음 표에 명시된 대로 DEPT 테이블을 생성 하시오. 

컬럼명	데이터타입	크기	NULL
---------------------------------------------------------------
DNO	number		2	NOT NULL
DNAME	varchar2		14	NULL
LOC	varchar2		13	NULL

select * from user_tables   -- 현재 사용자가 만들어 놓은 모든 테이블 출력(데이터 사전) : 
where table_name = 'DEPT';

drop table dept;            -- 기존 테이블 제거

create table dept (
    dno number(2) not null,
    dname varchar2(14) null,
    loc varchar2(13) null
)


2. 다음 표에 명시된 대로 EMP 테이블을 생성 하시오. 

컬럼명	데이터타입	크기	NULL
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
-- DB 설정에 따라서, NULL 허용 여부가 다르게 셋팅되어 있을 수 있다.

3. 긴이름을 넣을 수 있도록 EMP 테이블의 ENAME 컬럼의 크기를 늘리시오. 

컬럼명	데이터타입	크기	NULL
---------------------------------------------------------------
ENO	number		4	NOT NULL
ENAME	varchar2		25	NULL		<<==수정 컬럼  : 10 => 25  로 늘림
DNO	number		2	NULL

select length (ename) from employee;
where length (ename) > 5


4. EMPLOYEE 테이블을 복사해서 EMPLOYEE2 란 이름의 테이블을 생성하되 사원번호, 이름, 급여, 부서번호 컬럼만 복사하고 새로 생성된 테이블의 컬럼명은 각각 EMP_ID, NAME, SAL, DEPT_ID 로 지정 하시오. 

create table employee2 
as
select eno, ename, salary, dno from employee;

select from employee2

-- 테이블 복사할 때 제약조건은 복사 되지 않는다.
    -- Primary Key, Unique, not null, check, Foreign Key, default

5. EMP 테이블을 삭제 하시오. 

drop table emlp;

6. EMPLOYEE2 란 테이블 이름을 EMP로 변경 하시오. 

rename employee2 to emp;

desc employee2;


7. DEPT 테이블에서 DNAME 컬럼을 제거 하시오

select * from dept;

-- 실제 운영하는 시스템에서는 레코드가 많이 들어있다. 컬럼 제거시 부하가 많이 발생, (야간)

alter table dept
drop column dname

8. DEPT 테이블에서 LOC 컬럼을 UNUSED로 표시 하시오. 
    -- 제거할 컬럼을 비활성화 (업무시간)
    
alter talbe dept
set unused ( loc ) ;

9. UNUSED 커럼을 모두 제거 하시오. 
    -- 야간에 작업
    
alter table dept
drop unused columns;


09 - 데이터 조작과 트랜잭션 문제. 
================================================================================

1. EMP 테이블의 구조만 복사하여 EMP_INSERT 란 이름의 빈 테이블을 만드시오. 

create table emp_insert 
as
select * from emp
where 0=1               -- 조건을 false 로 설정하면

2. 본인을 EMP_INSERT 테이블에 추가하되 SYSDATE를 이용해서 입사일을 오늘로 입력하시오. 

select * from emp_insert

-- 테이블에 컬럼을 추가할 때는 NULL 허용하면서 추가해야함.

alter table emp_insert
add hiredate date;

desc emp_insert;

insert into emp_insert (eno, ename, salary, dno, hiredate)
values ( 1000, '홍길동', 3000.35, 10, sysdate)
commit;

3. EMP_INSERT 테이블에 옆 사람을 추가하되 TO_DATE 함수를 이용해서 입사일을 어제로 입력하시오. 

insert into emp_insert (eno, ename, salary, dno, hiredate)
values ( 1001, '옆사람', 3000.35, 10, to_date(sysdate-1, 'YY/MM/DD'))
commit;

4. employee테이블의 구조와 내용을 복사하여 EMP_COPY란 이름의 테이블을 만드시오. 

create table emp_copy
as
select * from employee

5. 사원번호가 7788인 사원의 부서번호를 10번으로 수정하시오. [ EMP_COPY 테이블 사용] 

select * from emp_copy

update emp_copy
set dno = 10
where eno = 7788        -- 주의 : UPDATE, DELETE 시 반드시 조건을 사용

rollback;

6. 사원번호가 7788 의 담당 업무 및 급여를 사원번호 7499의 담당업무 및 급여와 일치 하도록 갱신하시오. [ EMP_COPY 테이블 사용] 

select * from emp_copy where eno = 7788
select * from emp_copy where eno = 7499

update emp_copy
set job = (select job from emp_copy where eno = 7788), 
    salary = (select salary from emp_copy where eno = 7788)
where eno = 7499
commit;

7. 사원번호 7369와 업무가 동일한 사원의 부서번호를 사원 7369의 현재 부서번호로 갱신 하시오. [ EMP_COPY 테이블 사용] 

select * form emp_copy where eno = 7369
select * from emp_copy where job = 'CLERK'

update emp_copy
set dno = (select dno from emp_copy where eno = 7369)
where job = (select job from emp_copy where eno = 7369)

8. department 테이블의 구조와 내용을 복사하여 DEPT_COPY 란 이름의 테이블을 만드시오. 

create talbe dept_copy
as
select * from department;

9. DEPT_COPY란 테이블에서 부서명이 RESEARCH인 부서를 제거 하시오. 

delete dept_copy 
where dname = 'RESEARCH'
commit;

10. DEPT_COPY 테이블에서 부서번호가 10 이거나 40인 부서를 제거 하시오. 

delete dept_copy
where dno in (10,40)






