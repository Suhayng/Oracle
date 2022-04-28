/*
    ��(view) : ������ ���̺��� ��(view)�� �Ѵ�.
        --���̺��� ����Ÿ ���� ������ �ִ�.
        --��� ������ ���� ������ �ʴ´�. ���� �ڵ常 �� �ִ�.
        --�並 ����ϴ� ����:
            1. ������ ���ؼ� : ���� ���̺��� Ư�� �÷��� ������� ���� ���̺����߿� �÷��� ����� �ִ�.
            2. ������ ������ �並 �����ؼ� ���ϰ� ����� �� �ִ�. (������ JOIN ����)
        - ��� �Ϲ������� select ������ �´�.
        - ��� insert,update,delete ������ �ü� ����
        - �信 ���� INSERT�ϸ� ���� ���̺� ����ȵ�. ���� ���̺��� ���������� �����ؾ� �Ѵ�.
        - �信 ���� insert �Ұ�� ���� ���̺��� �������ǿ� ���� insert �� ���� �ְ� �׷��� ���� ���� �ִ�.
        - �׷��Լ��� ������ view���� insert �� �� ����.
    
*/

CREATE TABLE dept_copy60
AS 
SELECT * FROM department;

CREATE TABLE emp_copy60
AS 
SELECT * FROM employee;

--�� ����
CREATE VIEW v_emp_job
AS 
SELECT eno,ename,dno,job
FROM emp_copy60
WHERE job like 'SALESMAN';

--�� ���� Ȯ��
SELECT * FROM user_views;

--���� ���� (select * from ���̸�)
SELECT * FROM v_emp_job;

--������ ���� ������ �信 ����� �α�
CREATE VIEW v_join
as
SELECT e.dno,ename,job, dname, loc
FROM employee e , department d
WHERE e.dno=d.dno
and job = 'SALESMAN';

SELECT * FROM v_join;

-- �並 ����ؼ� ���� ���̺��� �߿��� ���� �����. (����)

SELECT * FROM emp_copy60;

CREATE VIEW simple_emp
as
SELECT ename,job,dno
FROM emp_copy50;

SELECT * FROM simple_emp; --view�� ����ؼ� ���� ���̺��� �߿� �÷��� �����.

SELECT * FROM user_views;

-- �並 �����Ҷ� �ݵ�� ��Ī �̸��� ����ؾ� �ϴ� ���, group by �Ҷ�

CREATE VIEW v_groupping
as
SELECT dno,count(*) groupCount, avg(salary) AVG, SUM(salary) SUM --<�Լ��� �����Ҷ� ��Ī����� �����
FROM emp_copy60
GROUP BY dno;


SELECT * FROM v_groupping;

--�並 �����Ҷ� as ������ select ���� �;��Ѵ�. insert, update, delete ���� �� �� ����.
--CREATE VIEW v_error
--as
--INSERT INTO dno
--VALUES (60,'HR','BUSAN');

--view�� ���� insert �� �� ������? �÷��� ���� ������ �����ϸ� view���� ���� ���� �� �ִ�.
    --���� ���̺� ���� insert �ȴ�.

CREATE VIEW v_dept
as
SELECT dno,dname
FROM dept_copy60;

INSERT INTO v_dept  --view�� ���� INSERT, ���������� ��ġ�Ҷ� insert ����.
VALUES (70, 'HR');

SELECT * FROM dept_copy60;

CREATE or REPLACE VIEW v_dept  --v_dept�� �������� ���� ��� : create �ϰ� ������ ��� : replace 
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
VALUES ('HR3','PUSAN2'); --<-- PRIMARY KEY ���� �Ǿ��־ �ȵ�

SELECT * FROM user_views;

SELECT * FROM v_groupping; --�׷��ε� view���� insert �� �� ����.

CREATE OR REPLACE VIEW v_groupping
as
SELECT dno,count(*) groupCount, round(AVG(salary),2) AVG, SUM(salary) SUM  
FROM emp_copy60
GROUP BY dno;

SELECT * FROM v_groupping;

DROP VIEW v_groupping;


--INSERT, UPDATE, DELETE�� ������ ��
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


--�б⸸ ������ �� ���� : (insert, update, delete ���ϵ��� ����)

CREATE VIEW v_dept10_read_only
as
SELECT dno, dname, loc              
FROM dept_copy60 WITH READ ONLY;    

INSERT INTO v_dept10_read_only      -->read-only�� �ȵ�
VALUES (88,'HR7','BUSAN7');

UPDATE v_dept10_read_only           -->read-only�� �ȵ�
SET dname = 'HR77', loc = 'BUSAN77'
WHERE dno =90;

DELETE v_dept10_read_only           -->read-only�� �ȵ�
WHERE dno=90;









-- 10 : ������ ���Ἲ�� ���� ����, 11 ��

1. employee ���̺��� ������ �����Ͽ� emp_sample �� �̸��� ���̺��� ����ÿ�. ��� ���̺��� �����ȣ �÷��� ���̺� ������ primary key ���������� �����ϵ� �������� �̸��� my_emp_pk�� �����Ͻÿ�. 

-- ���̺� ������ �� ���� ������ ������� �ʴ´�. alter table �� ����ؼ� �־���� �Ѵ�.
create table emp_sample
as
select * from employee
where 0 = 1;

select * from emp_sample;

alter table emp_sample
add comstraint PK_emp_sample_eno Primary Key(eno);

select * from user_constraints
where table_name = 'EMP_SAMPLE'

2. department ���̺��� ������ �����Ͽ� dept_sample �� �̸��� ���̺��� ����ÿ�. �μ� ���̺��� �μ���ȣ �÷��� ������ primary key ���� ������ �����ϵ� ���� �����̸��� my_dept_pk�� �����Ͻÿ�. 

create table dept_sample
as
select * from department
where 0 =1

alter table dept_sample
add constraint PK_ dept_sample_dno Primary Key (dno);

select * from user_constraints
where table_name = 'DEP_SAMPLE'

3. ��� ���̺��� �μ���ȣ �÷��� �������� �ʴ� �μ��� ����� �������� �ʵ��� �ܷ�Ű ���������� �����ϵ� ���� �����̸��� my_emp_dept_fk �� �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]

select * from emp_sample;
select * from dept_sample;

alter table emp_sample
add constraint FK_emp_sample_dno_dept_sample Foreign Key (dno) reference dept_sample(dno);

select * from user_constraints
where table_name in ('EMP_SAMPLE', 'DEPT_SAMPLE');

4. ������̺��� Ŀ�Լ� �÷��� 0���� ū ������ �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]

select * from emp_sample

alter table emp_sample
add constraint CK_emp_sample_commission check (commission >= 0)

--------------------------------------------------------------------------------------
5. ������̺��� ���� �÷��� �⺻ ������ 1000 �� �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]

alter emp

6. ������̺��� �̸� �÷��� �ߺ����� �ʵ���  ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]

7. ������̺��� Ŀ�Լ� �÷��� null �� �Է��� �� ������ ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]

8. ���� ������ ��� ���� ������ ���� �Ͻÿ�. 

-- ���� ���� ���Ž� : Foreign Key �����ϸ� ���Ű� �ȵȴ�.
    -- 1. Foreign Key �� ���� ���� �� Primary Key ����
    -- 2. Primary Key �� ������ �� cascade �ɼ��� ��� : Foreign Key ���� ���� �ǰ� Primary Key �� ���ŵ�.
    
altder table dept_sample
drop Priamry Key cascade;

alter table emp_sample
drop comstraint PK_EMP_SAMPLE_ENO;

alter table emp_sample
drop comstraint CK_EMP_SAMPLE_COMMISSION;

�� ���� 

1. 20�� �μ��� �Ҽӵ� ����� �����ȣ�� �̸��� �μ���ȣ�� ����ϴ� select ���� �ϳ��� view �� ���� �Ͻÿ�.
	���� �̸� : v_em_dno  

2. �̹� ������ ��( v_em_dno ) �� ���ؼ� �޿� ���� ��� �� �� �ֵ��� �����Ͻÿ�. 

3. ������  �並 ���� �Ͻÿ�. 

4. �� �μ��� �޿���  �ּҰ�, �ִ밪, ���, ������ ���ϴ� �並 ���� �Ͻÿ�. 
	���̸� : v_sal_emp

5. �̹� ������ ��( v_em_dno ) �� ���ؼ� �б� ���� ��� �� �� �ֵ��� �����Ͻÿ�. 







������ ����. 

1. emp01 ���̺��� �Ʒ��� ���� �����Ͻÿ�. 

�÷���	������Ÿ��	ũ��	NULL		��������
-----------------------------------------------------------------------------------
empno	number		4	NOT NULL	Primary key
ename	varchar2		10	NULL
hiredate	date			NULL

2. emp01 ���̺��� �����ȣ�� �ڵ����� �����ǵ��� �������� ���� �Ͻÿ�. 
   �ʱⰪ : 1
   ������ : 1
   �ִ밪 : 100000

3. �����ȣ�� �������� ���� �߱� �����ÿ�. 

