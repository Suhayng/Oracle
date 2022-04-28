-- �ٽ� �ۼ��ϱ�



--  ������ ������ ����

select * from user_sequences;

alter sequence emp_seq_no
	maxvalues 1000;     -- �ִ밪 : 1000

alter sequence emp_seq_no
	cycle;		-- �ִ밪�� ����ǰ� �ٽ� ó������ ��ȯ

alter sequence emp_seq_no
	nocycle;		

drop sequence sampt_seq;

/*
    INDEX : ���̺��� �÷��� ����, Ư�� �÷��� �˻��� ������ ����� �� �ֵ��� �Ѵ�.
	- INDEX page : �÷��� �߿� Ű���带 �ɷ��� ��ġ ������ ��� ���� �������� INDEX page �� �Ѵ�. 
		- DB ������ 10% 
	- ����(index) : å�� ����, å�� ������ �߿� Ű���带 �����ؼ� ��ġ�� �˷���.
	- ���̺� ��ĵ : ���ڵ��� ó�� ~ ���������� �˻� (�˻� �ӵ��� ������. ), �ε����� ������� �ʰ� �˻�.
		- Index �� �����Ǿ� ���� �ʴ� �÷��� ���̺� ��ĵ�� �Ѵ�.
	- Primary key, Unique Ű�� ����� �÷��� Index Page �� �����Ǿ� �˻��� ������ �Ѵ�.
	- Where ������ ���� �˻��� �ϴ� �÷��� Index �� ����
	- ���̺��� �˻��� �����ϴ� �÷��� Index ����.
		- ���̺� ��ĵ�� ���� �ʰ� Index Page �� �˻��ؼ� ��ġ�� ������ ã�´�.
	- Index �� ������ �� ���ϰ� ���� �ɸ���. �ַ� ���� �ð��� ���ؼ� �߰��� ������.	
	- Index �� �� �����ؾ� �Ѵ�. 
*/

-- Index ������ ����Ǿ� �ִ� ������ ���� .
	-- user_columns, user_ind_columnss

select * from user_tab_columns;
select * from user_ind_columns;

select * from user_tab_columns
where table_name in ('EMPLOYEE', 'DEPARTMENT')

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMPLOYEE', 'DEPARTMENT');

select * from employee;	-- ENO �÷��� Primary Key <== �ڵ����� Index �� ������.

/*
    Index �ڵ� ����, (Primary Key, Unique) �÷����� Index Page �� �ڵ����� �����ȴ�.
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
where ename = 'KING' ;	-- ename �÷��� index �� �����Ƿ� KING �� �˻��ϱ� ���ؼ� ���̺� ��ĵ �Ѵ�.

select * from emp_copy90
where job = 'SALESMAN'  	-- 


-- ename �÷��� index �����ϱ� (�߰��� �۾��ؾ� �Ѵ�. ���ϰ� ���� �ɸ���.)

-- �÷��� index�� �����Ǿ� ���� ������ ���̺� ��ĵ�� �Ѵ�. ó������ �ϳ��ϳ� �˻��Ѵ�.
-- �÷��� index�� �����Ǿ� ������ Index Page (å�� ����) �� �˻��Ѵ�. ������ �˻��Ѵ�.

create index id_emp_ename
on emp_copy90(ename)

drop index id_emp_ename;

/*
     Index �� �ֱ������� REBUILD �� ��� �Ѵ�. ( 1����, 1�� )
	- Index �� �������� (Insert, update, delete) ����ϰ� �Ͼ��
	
*/

-- Index REBUIOLD �� �ؾ� �ϴ� ���� ��� : 
	--Index �� Tree ���̰� 4 �̻��� ��찡 ��ȸ�� �Ǹ� Rebulid �� �ʿ䰡 �ִ�.

SELECT I.TABLESPACE_NAME,I.TABLE_NAME,I.INDEX_NAME, I.BLEVEL,
       DECODE(SIGN(NVL(I.BLEVEL,99)-3),1,DECODE(NVL(I.BLEVEL,99),99,'?','Rebuild'),'Check') CNF
FROM   USER_INDEXES I
WHERE   I.BLEVEL > 4
ORDER BY I.BLEVEL DESC

-- Index rebuild : 

alter index id_emp_ename rebuild; 	-- index�� ���Ӱ� ����

select * from emp_copy90;

/*
     Index �� ����ؾ� �ϴ� ��� 
	1. ���̺��� ��(�ο�, ���ڵ�)�� ������ ���� ��� 
	2. where ������ ���� ���Ǵ� �÷�.   
	3. Join �� ���Ǵ� Ű �÷�. 
	4. �˻� ����� ���� ���̺� �������� 2~4% �Ǵ� ���
	5. �ش� �÷��� null �� �����ϴ� ��� ( ������ null �� ���� )

     Index �� ����ϸ� ������ ���
	1. ���̺��� ���� ������ ���� ���
	2. �˻� ����� ���� ���̺��� ���� ������ �����ϴ� ���
	3. insert, update, delete�� ����ϰ� �Ͼ�� �÷�. 
*/

/*
     Index ����
	1. ���� �ε��� (Unique Index) : �÷��� �ߺ����� �ʴ� ������ ���� ���� Index (Primary Key, Unique)
	2. ���� �ε��� (Single Index) : �� �÷��� �ο� �Ǵ� Index
	3. ���� �ε��� (Composit Index) : ���� �÷��� ��� ������ Index
	4. �Լ� �ε��� (Function Base Index) : �Լ��� ������ �÷��� ������ Index	
*/

select * from emp_copy90;

-- ���� �ε��� ����
create index inx_emp_copy90_salary
on emp_copy90 (salary) 

-- ���� �ε��� ���� : �� �÷� �̻��� �����ؼ� �ε��� ����
create table dept_copy91
as 
select * from department;

create index idx_dept_copy90_dname_loc
on dept_copy91 (dname, loc)

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('dept_copy91');

-- �Լ� ��� �ε��� : �Լ��� ������ �÷��� �ο��Ǵ� index

create table emp_copy91
as
select * from employee;

create index idx_empcopy91_allsal
on emp_copy91 (salary * 12) 		-- �÷��� �Լ�, ������ ������ �ε���

/* �ε��� ���� */

drop indexs idx_empcopy91_allsal

/* ���� ����    
    - ������ : DBMS �� �������� ��� 		
    	- �� ����ں��� ������ ���� : DBMS �� ������ �� �ִ� ����ڸ� ����. 		
	   (���� (Authentication : Credential ( Identity + Password) Ȯ��
	   (�㰡 (Authorization : ������ ����ڿ��� Oracle �� �ý��� ����, ��ü ( ���̺�, ��, Ʈ����, �Լ� ) ����
		- System Privileges : Oracle �� �������� ���� �Ҵ�
		- Object Privilleges : ���̺�, ��, Ʈ����, �Լ�, ���� ���ν���, ������, �ε��� ) ���� ����.
*/

