/*
    뷰(view) : 가상의 테이블을 뷰(view)라 한다.
        --테이블은 데이타 값을 가지고 있다.
        --뷰는 데이터 값을 가지지 않는다. 실행 코드만 들어가 있다.
        --뷰를 사용하는 목적:
            1. 보안을 위해서 : 실제 테이블의 특정 컬럼만 가지고와 실제 테이블의중요 컬럼을 숨길수 있다.
            2. 복잡한 쿼리를 뷰를 생성해서 편리하게 사용할 수 있다. (복잡한 JOIN 쿼리)
        - 뷰는 일반적으로 select 구문이 온다.
        - 뷰는 insert,update,delete 구문이 올수 없다
        - 뷰에 값을 INSERT하면 실제 테이블에 저장된디. 실제 테이블의 제약조건을 만족해야 한다.
        - 뷰에 값을 insert 할경우 실제 테이블의 제약조건에 따라서 insert 될 수도 있고 그렇지 않을 수도 있다.
        - 그룹함수를 적용한 view에는 insert 할 수 없다.
    
*/

CREATE TABLE dept_copy60
AS 
SELECT * FROM department;

CREATE TABLE emp_copy60
AS 
SELECT * FROM employee;

--뷰 생성
CREATE VIEW v_emp_job
AS 
SELECT eno,ename,dno,job
FROM emp_copy60
WHERE job like 'SALESMAN';

--뷰 생성 확인
SELECT * FROM user_views;

--뷰의 실행 (select * from 뷰이름)
SELECT * FROM v_emp_job;

--복잡한 조인 쿼리를 뷰에 만들어 두기
CREATE VIEW v_join
as
SELECT e.dno,ename,job, dname, loc
FROM employee e , department d
WHERE e.dno=d.dno
and job = 'SALESMAN';

SELECT * FROM v_join;

-- 뷰를 사용해서 실제 테이블의 중요한 정보 숨기기. (보안)

SELECT * FROM emp_copy60;

CREATE VIEW simple_emp
as
SELECT ename,job,dno
FROM emp_copy50;

SELECT * FROM simple_emp; --view를 사용해서 실제 테이블의 중요 컬럼을 숨긴다.

SELECT * FROM user_views;

-- 뷰를 생성할때 반드시 별칭 이름을 사용해야 하는 경우, group by 할때

CREATE VIEW v_groupping
as
SELECT dno,count(*) groupCount, avg(salary) AVG, SUM(salary) SUM --<함수를 적용할때 별칭만들어 줘야함
FROM emp_copy60
GROUP BY dno;


SELECT * FROM v_groupping;

--뷰를 생성할때 as 하위에 select 문이 와야한다. insert, update, delete 문은 올 수 없다.
--CREATE VIEW v_error
--as
--INSERT INTO dno
--VALUES (60,'HR','BUSAN');

--view에 값을 insert 할 수 있을까? 컬럼의 제약 조건을 만족하면 view에도 값을 넣을 수 있다.
    --실제 테이블에 값이 insert 된다.

CREATE VIEW v_dept
as
SELECT dno,dname
FROM dept_copy60;

INSERT INTO v_dept  --view에 값을 INSERT, 제약조건이 일치할때 insert 가능.
VALUES (70, 'HR');

SELECT * FROM dept_copy60;

CREATE or REPLACE VIEW v_dept  --v_dept가 존재하지 않을 경우 : create 하고 존재할 경우 : replace 
as
SELECT dname,loc
FROM dept_copy60;

SELECT * FROM v_dept;

INSERT INTO v_dept
VALUES ('HR2', 'BUSAN');

UPDATE dept_copy60
SET dno = 80
WHERE dno is NULL;
commit;

ALTER TABLE dept_copy60
ADD CONSTRAINT PK_dept_copy60 PRIMARY KEY(dno);

SELECT * FROM user_constraints
WHERE table_name = 'DEPT_COPY60';

SELECT * FROM v_dept;

INSERT INTO v_dept
VALUES ('HR3','PUSAN2'); --<-- PRIMARY KEY 세팅 되어있어서 안됨

SELECT * FROM user_views;

SELECT * FROM v_groupping; --그룹핑된 view에는 insert 할 수 없다.

CREATE OR REPLACE VIEW v_groupping
as
SELECT dno,count(*) groupCount, round(AVG(salary),2) AVG, SUM(salary) SUM  
FROM emp_copy60
GROUP BY dno;

SELECT * FROM v_groupping;

DROP VIEW v_groupping;


--INSERT, UPDATE, DELETE가 가능한 뷰
CREATE VIEW v_dept10
as
SELECT dno, dname, loc
FROM dept_copy60;

INSERT INTO v_dept10
VALUES (90,'HR4','BUSAN4');

UPDATE v_dept10
SET dname = 'HR5', loc = 'BUSAN5'
WHERE dno =90;

DELETE v_dept10
WHERE dno=90;

commit;


--읽기만 가능한 뷰 생성 : (insert, update, delete 못하도록 설정)

CREATE VIEW v_dept10_read_only
as
SELECT dno, dname, loc              
FROM dept_copy60 WITH READ ONLY;    

INSERT INTO v_dept10_read_only      -->read-only라 안됨
VALUES (88,'HR7','BUSAN7');

UPDATE v_dept10_read_only           -->read-only라 안됨
SET dname = 'HR77', loc = 'BUSAN77'
WHERE dno =90;

DELETE v_dept10_read_only           -->read-only라 안됨
WHERE dno=90;









-- 10 : 테이터 무결성과 제약 조건, 11 뷰

1. employee 테이블의 구조를 복사하여 emp_sample 란 이름의 테이블을 만드시오. 사원 테이블의 사원번호 컬럼에 테이블 레벨로 primary key 제약조건을 지정하되 제약조건 이름은 my_emp_pk로 지정하시오. 

-- 테이블 복사할 때 제약 조건은 복사되지 않는다. alter table 을 사용해서 넣어줘야 한다.
create table emp_sample
as
select * from employee
where 0 = 1;

select * from emp_sample;

alter table emp_sample
add comstraint PK_emp_sample_eno Primary Key(eno);

select * from user_constraints
where table_name = 'EMP_SAMPLE'

2. department 테이블의 구조를 복사하여 dept_sample 란 이름의 테이블을 만드시오. 부서 테이블의 부서번호 컬럼에 레벨로 primary key 제약 조건을 지정하되 제약 조건이름은 my_dept_pk로 지정하시오. 

create table dept_sample
as
select * from department
where 0 =1

alter table dept_sample
add constraint PK_ dept_sample_dno Primary Key (dno);

select * from user_constraints
where table_name = 'DEP_SAMPLE'

3. 사원 테이블의 부서번호 컬럼에 존재하지 않는 부서의 사원이 배정되지 않도록 외래키 제약조건을 지정하되 제약 조건이름은 my_emp_dept_fk 로 지정하시오. [주의 : 위 복사한 테이블을 사용하시오]

select * from emp_sample;
select * from dept_sample;

alter table emp_sample
add constraint FK_emp_sample_dno_dept_sample Foreign Key (dno) reference dept_sample(dno);

select * from user_constraints
where table_name in ('EMP_SAMPLE', 'DEPT_SAMPLE');

4. 사원테이블의 커밋션 컬럼에 0보다 큰 값만을 입력할 수 있도록 제약 조건을 지정하시오. [주의 : 위 복사한 테이블을 사용하시오]

select * from emp_sample

alter table emp_sample
add constraint CK_emp_sample_commission check (commission >= 0)

--------------------------------------------------------------------------------------
5. 사원테이블의 웝급 컬럼에 기본 값으로 1000 을 입력할 수 있도록 제약 조건을 지정하시오. [주의 : 위 복사한 테이블을 사용하시오]

alter emp

6. 사원테이블의 이름 컬럼에 중복되지 않도록  제약 조건을 지정하시오. [주의 : 위 복사한 테이블을 사용하시오]

7. 사원테이블의 커밋션 컬럼에 null 을 입력할 수 없도록 제약 조건을 지정하시오. [주의 : 위 복사한 테이블을 사용하시오]

8. 위의 생성된 모든 제약 조건을 제거 하시오. 

-- 제약 조건 제거시 : Foreign Key 참조하면 제거가 안된다.
    -- 1. Foreign Key 를 먼저 제거 후 Primary Key 제거
    -- 2. Primary Key 를 제거할 때 cascade 옵션을 사용 : Foreign Key 먼저 제거 되고 Primary Key 가 제거됨.
    
altder table dept_sample
drop Priamry Key cascade;

alter table emp_sample
drop comstraint PK_EMP_SAMPLE_ENO;

alter table emp_sample
drop comstraint CK_EMP_SAMPLE_COMMISSION;

뷰 문제 

1. 20번 부서에 소속된 사원의 사원번호과 이름과 부서번호를 출력하는 select 문을 하나의 view 로 정의 하시오.
	뷰의 이름 : v_em_dno  

2. 이미 생성된 뷰( v_em_dno ) 에 대해서 급여 역시 출력 할 수 있도록 수정하시오. 

3. 생성된  뷰를 제거 하시오. 

4. 각 부서의 급여의  최소값, 최대값, 평균, 총합을 구하는 뷰를 생성 하시오. 
	뷰이름 : v_sal_emp

5. 이미 생성된 뷰( v_em_dno ) 에 대해서 읽기 전용 뷰로 할 수 있도록 수정하시오. 







시퀀스 문제. 

1. emp01 테이블을 아래와 같이 생성하시오. 

컬럼명	데이터타입	크기	NULL		제약조건
-----------------------------------------------------------------------------------
empno	number		4	NOT NULL	Primary key
ename	varchar2		10	NULL
hiredate	date			NULL

2. emp01 테이블의 사원번호가 자동으로 생성되도록 시퀀스를 생성 하시오. 
   초기값 : 1
   증가값 : 1
   최대값 : 100000

3. 사원번호를 시퀀스로 부터 발급 받으시오. 

