-- 다시 작성하기



--  기존의 시퀀스 수정

select * from user_sequences;

alter sequence emp_seq_no
	maxvalues 1000;     -- 최대값 : 1000

alter sequence emp_seq_no
	cycle;		-- 최대값이 적용되고 다시 처음부터 순환

alter sequence emp_seq_no
	nocycle;		

drop sequence sampt_seq;

/*
    INDEX : 테이블의 컬럼에 생성, 특정 컬럼의 검색을 빠르게 사용할 수 있도록 한다.
	- INDEX page : 컬럼의 중요 키워드를 걸러서 위치 정보를 담아 놓은 페이지를 INDEX page 라 한다. 
		- DB 공간의 10% 
	- 색인(index) : 책의 색인, 책의 내용의 중요 키워드를 수집해서 위치를 알려줌.
	- 테이블 스캔 : 레코드의 처음 ~ 마지막까지 검색 (검색 속도가 느리다. ), 인덱스를 사용하지 않고 검색.
		- Index 가 생성되어 있지 않는 컬럼은 테이블 스캔을 한다.
	- Primary key, Unique 키가 적용된 컬럼은 Index Page 가 생성되어 검색을 빠르게 한다.
	- Where 절에서 자주 검색으 하는 컬럼에 Index 를 생성
	- 테이블의 검색을 자주하는 컬럼에 Index 생성.
		- 테이블 스캔을 하지 않고 Index Page 를 검색해서 위치를 빠르게 찾는다.
	- Index 를 생성할 때 부하가 많이 걸린다. 주로 업무 시간을 피해서 야간에 생성함.	
	- Index 는 잘 생성해야 한다. 
*/

-- Index 정보가 저장되어 있는 데이터 사전 .
	-- user_columns, user_ind_columnss

select * from user_tab_columns;
select * from user_ind_columns;

select * from user_tab_columns
where table_name in ('EMPLOYEE', 'DEPARTMENT')

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMPLOYEE', 'DEPARTMENT');

select * from employee;	-- ENO 컬럼에 Primary Key <== 자동으로 Index 가 생성됨.

/*
    Index 자동 생성, (Primary Key, Unique) 컬럼에는 Index Page 가 자동으로 생성된다.
*/ 

create table tbl1 (
	a number(4) constraint PK_tbl1_a Primary Key,
	b number(4),
	c number(4)
	)

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('TBL1', 'TBL2', 'EMPLOYEE', 'DEPARTMENT');

select * from tbl1;

create table tbl2 (
	a number(4) constraint PK_tbl2_a Primary Key,
	b number(4) constraint UK_tbl2_b Unique,
	c number(4) constraint UK_tbl2_c Unique,
	d number(4),
	e number(4)
	);

create table emp_copy90
as
select * from employee;

select * from emp_copy90

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMP_copy90');

select * from emp_copy90
where ename = 'KING' ;	-- ename 컬럼에 index 가 없으므로 KING 을 검색하기 위해서 테이블 스캔 한다.

select * from emp_copy90
where job = 'SALESMAN'  	-- 


-- ename 컬럼에 index 생성하기 (야간에 작업해야 한다. 부하가 많이 걸린다.)

-- 컬럼에 index가 생성되어 있지 않으면 테이블 스캔을 한다. 처음부터 하나하나 검색한다.
-- 컬럼에 index가 생성되어 있으면 Index Page (책의 목차) 를 검색한다. 빠르게 검색한다.

create index id_emp_ename
on emp_copy90(ename)

drop index id_emp_ename;

/*
     Index 는 주기적으로 REBUILD 해 줘야 한다. ( 1주일, 1달 )
	- Index 는 조각난다 (Insert, update, delete) 빈번하게 일어나면
	
*/

-- Index REBUIOLD 를 해야 하는 정보 얻기 : 
	--Index 의 Tree 깊이가 4 이상인 경우가 조회가 되면 Rebulid 할 필요가 있다.

SELECT I.TABLESPACE_NAME,I.TABLE_NAME,I.INDEX_NAME, I.BLEVEL,
       DECODE(SIGN(NVL(I.BLEVEL,99)-3),1,DECODE(NVL(I.BLEVEL,99),99,'?','Rebuild'),'Check') CNF
FROM   USER_INDEXES I
WHERE   I.BLEVEL > 4
ORDER BY I.BLEVEL DESC

-- Index rebuild : 

alter index id_emp_ename rebuild; 	-- index를 새롭게 생성

select * from emp_copy90;

/*
     Index 를 사용해야 하는 경우 
	1. 테이블의 행(로우, 레코드)의 개수가 많은 경우 
	2. where 절에서 자주 사용되는 컬럼.   
	3. Join 시 사용되는 키 컬럼. 
	4. 검색 결과가 원본 테이블 데이터의 2~4% 되는 경우
	5. 해당 컬럼이 null 이 포함하는 경우 ( 색인은 null 은 제외 )

     Index 를 사용하면 안좋은 경우
	1. 테이블의 행의 개수가 작은 경우
	2. 검색 결과가 원본 테이블의 많은 비중을 차지하는 경우
	3. insert, update, delete가 빈번하게 일어나는 컬럼. 
*/

/*
     Index 종류
	1. 고유 인덱스 (Unique Index) : 컬럼의 중복되지 않는 고유한 값을 갖는 Index (Primary Key, Unique)
	2. 단일 인덱스 (Single Index) : 한 컬럼에 부여 되는 Index
	3. 결합 인덱스 (Composit Index) : 여러 컬럼을 묶어서 생성한 Index
	4. 함수 인덱스 (Function Base Index) : 함수를 적용한 컬럼에 생성한 Index	
*/

select * from emp_copy90;

-- 단일 인덱스 생성
create index inx_emp_copy90_salary
on emp_copy90 (salary) 

-- 결합 인덱스 생성 : 두 컬럼 이상을 결합해서 인덱스 생성
create table dept_copy91
as 
select * from department;

create index idx_dept_copy90_dname_loc
on dept_copy91 (dname, loc)

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('dept_copy91');

-- 함수 기반 인덱스 : 함수를 적용한 컬럼에 부여되는 index

create table emp_copy91
as
select * from employee;

create index idx_empcopy91_allsal
on emp_copy91 (salary * 12) 		-- 컬럼에 함수, 계산식을 적용한 인덱스

/* 인덱스 삭제 */

drop indexs idx_empcopy91_allsal

/* 권한 관리    
    - 사용권한 : DBMS 는 여러명이 사용 		
    	- 각 사용자별로 계정을 생성 : DBMS 에 접속할 수 있는 사용자를 생성. 		
	   (인증 (Authentication : Credential ( Identity + Password) 확인
	   (허가 (Authorization : 인증된 사용자에게 Oracle 의 시스템 권한, 객체 ( 테이블, 뷰, 트리거, 함수 ) 권한
		- System Privileges : Oracle 의 전반적인 권한 할당
		- Object Privilleges : 테이블, 뷰, 트리거, 함수, 저장 프로시저, 시퀀스, 인덱스 ) 접근 권한.
*/

