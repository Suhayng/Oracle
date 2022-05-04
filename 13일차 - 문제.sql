���� ���ν��� ���� 

1. �� �μ����� �ּұ޿�, �ִ�޿�, ��ձ޿��� ����ϴ� �������ν����� �����Ͻÿ�. 
	[employee, department ] ���̺� �̿�
    
    SET SERVEROUTPUT ON
    CREATE OR REPLACE PROCEDURE sp_ex1
    IS  -- ���� �����
        v_dno employee.dno%type;
        v_min employee.salary%type;
        v_max employee.salary%type;
        v_avg employee.salary%type;
    
        CURSOR c1
        IS
        SELECT dno, min(salary), max(salary), avg(salary)
        FROM employee
        GROUP BY dno;
        
    BEGIN
        dbms_output.put_line( '�μ���ȣ   �ּұ޿�   �ִ�޿�   ��ձ޿�');
        dbms_output.put_line( '------------------------------------');
        OPEN c1;    -- Ŀ�� ����
        LOOP
            FETCH c1 INTO v_dno, v_min, v_max, v_avg;
            EXIT WHEN c1%notfound;      -- ���ڵ��� ���� ���̻� �������� ���� ��
               dbms_output.put_line( v_dno || '   ' || v_min ||'   ' || v_max ||'   ' || v_avg );
        END LOOP;
        CLOSE c1;
    END;
    /
    
    EXEC sp_ex1;
    
    select * from employees
   

2.  �����ȣ, ����̸�, �μ���, �μ���ġ�� ����ϴ� �������ν����� �����Ͻÿ�.  
	[employee, department ] ���̺� �̿�
      CREATE OR REPLACE PROCEDURE sp_ex2
    IS  
        v_eno employee.eno%type;
        v_ename employee.ename%type;
        v_dname department.dname%type;
        v_loc department.loc%type;
        -- ���̺� rowtype ���� �����͵� ��.
        
        CURSOR c1
        IS
        SELECT eno, ename, dname, loc
        FROM employee e, department d
        WHERE e.dno = d.dno;
        
    BEGIN
        dbms_output.put_line( '�����ȣ   ����̸�   �μ���   �μ���ġ');
        dbms_output.put_line( '------------------------------------');
        OPEN c1;    -
        LOOP
            FETCH c1 INTO v_eno, v_ename, v_dname, v_loc
            EXIT WHEN c1%notfound;      -- ���ڵ��� ���� ���̻� �������� ���� ��
               dbms_output.put_line( v_eno || '   ' || v_ename ||'   ' || v_dname ||'   ' || v_loc );
        END LOOP;
        CLOSE c1;
    END;
    /
    
    EXEC sp_ex2;

3. �޿��� �Է� �޾�  �Է¹��� �޿����� ���� ����� ����̸�, �޿�, ��å�� ��� �ϼ���.
	�������ν����� : sp_salary_b
      CREATE OR REPLACE PROCEDURE sp_salary_b (
        v_salary IN employee.salary%type            -- ���� : INPUT, OUTPUT �Ű� �������� ; ó�� �ϸ� �ȵ�!
      )
    IS  
        v_emp employee%rowtype; -- ��� �÷��� �ڷ����� ����
        CURSOR c1
        IS
        SELECT ename, salary, job 
        FROM employee 
        WHERE salary > v_salary;
        
    BEGIN
        dbms_output.put_line( '����̸�   �޿�   ��å');
        dbms_output.put_line( '---------------------');
        OPEN c1;    -
        LOOP
            FETCH c1 INTO v_emp.ename, v_emp.salary, v_emp.job
            EXIT WHEN c1%notfound;      -- ���ڵ��� ���� ���̻� �������� ���� ��
               dbms_output.put_line( v_emp.ename || '   ' || v_emp.salary ||'   ' || v_emp.job );
        END LOOP;
        CLOSE c1;
    END;
    /
    
    EXEC sp_salary_b(2500);
-- Ȯ�� 


4. ��ǲ �Ű����� : emp_c10, dept_c10  �ΰ��� �Է� �޾� ���� employee, department ���̺��� �����ϴ� �������ν����� �����ϼ���. 
	�������ν����� : sp_copy_table
	
    -- PL/SQL ���ο��� �͸� ������� ���̺��� ���� : GRANT CREATE TABLE TO PUBLIC;  < sys �������� ���� >
    -- ���� ���ν��� ������ :  REVOLE CREATE TABLE FROM PUBLIC;

    CREATE OR REPLACE PROCEDURE sp_copy_table(
        v_emp IN VARCHAR2 , v_dept IN VARCHAR2    -- ���� : ';' �� ������ �ȵ�, �ڷ����� ũ��
    )
    IS
        c1 INTEGER;     -- Ŀ�� ���� ����
        v_sql1 VARCHAR2(500);   -- ���̺� ���� ������ ���� ����
        v_sql2 VARCHAR2(500);   
    BEGIN
        v_sql1 := 'CREATE TABLE ' || v_emp || ' AS SELECT * FROM employee';    --'' �� �� ���� ó��!
        v_sql2 := 'CREATE TABLE ' || v_dept || ' AS SELECT * FROM department';
    
        c1 := DBMS_SQL.OPEN_CURSOR;                 -- Ŀ�� ����
        DBMS_SQL.PARSE(c1, v_sql1, DBMS_SQL.V7);
        DBMS_SQL.PARSE(c1, v_sql2, DBMS_SQL.V7);
        DBMS_SQL.CLOSE_CURSOR(c1);                  -- Ŀ�� ����
    END;
    /

    EXEC sp_copy_table ('emp_c10', 'dept_c10');
    
    SELECT * FROM emp_c10;
    SELECT * FROM dept_c10;

5. dept_c10 ���̺��� dno, dname, loc �÷��� ���� ��ǲ �޾� ��ǲ ���� ���� insert�ϴ� �������ν����� �����Ͻÿ�. 
	�Է� �� : 50  'HR'  'SEOUL'
	�Է� �� : 60  'HR2'  'PUSAN' 
    
    EXEC sp_ex5 (50,'HR','SEOUL');
    EXEC sp_ex5 (60,'HR2','BUSAN');
    
    
    CREATE OR REPLACE PROCEDURE sp_ex5 (
        v_dno IN dept_c10.dno%type, v_dname IN dept_c10.dname%type, v_loc dept_c10.loc%type)
    IS
    BEGIN
        INSERT INTO dept_c10
        VALUES ( v_dno, v_dname, v_loc);
        
        dbms_output.put_line ('���������� �ԷµǾ����ϴ�.')
   
    END;
    /
    

6. emp_c10 ���̺��� ��� �÷��� ���� ��ǲ �޾� ��ǲ ���� ���� insert�ϴ� �������ν����� �����Ͻÿ�. 
	�Է� �� : 8000  'SONG'    'PROGRAMMER'  7788  sysdate  4500  1000  50 
    SELECT * FROM emp_c10;
    
    EXEC sp_ex6 ( 8000,'SONG','PROGRAMMER', 7788, sysdate, 4500, 1000, 50 );

    CREATE OR REPLACE PROCEDURE sp_ex6 (
        v_eno IN emp_c10.eno%type,
        v_ename IN emp_c10.ename%type,
        v_job IN emp_c10.job%type,
        v_manager IN emp_c10.manager%type,
        v_hiredate IN emp_c10.hiredate%type,
        v_salary IN emp_c10.salary%type,
        v_commission IN emp_c10.commission%type,
        v_dno IN emp_c10.dno%type
        )
    IS
    BEGIN
        INSERT INTO emp_c10
        VALUES ( v_eno, v_ename, v_job, v_manager, v_hiredate, v_salary, v_commission,v_dno);
        
        dbms_output.put_line ('���������� �ԷµǾ����ϴ�.')
    END;
    /
    
7. dept_c10 ���̺��� 4�������� �μ���ȣ 50�� HR �� 'PROGRAM' ���� �����ϴ� �������ν����� �����ϼ���. 
	<�μ���ȣ�� �μ����� ��ǲ�޾� �����ϵ��� �Ͻÿ�.> 
	�Է� �� : 50  PROGRAMMER 
    SELECT * FROM dept_c10;
    EXEC sp_ex7 (50, 'PROGRAMMER');
    
    CREATE OR REPLACE PROCEDURE sp_ex7 (
        v_dno IN dept_c10.dno%type,
        v_dname IN dept_c10.dname%type
    )
    IS
    BEGIN
        UPDATE dept_10
        SET dname = v_dname
        WHERE dno = v_dno;
        
        dbms_output.put_lind('���������� ������Ʈ �Ǿ����ϴ�.');
    END;
    /
    
8. emp_c10 ���̺��� �����ȣ�� ��ǲ �޾� ������ �����ϴ� ���� ���ν����� �����Ͻÿ�. 
	�Է� �� : 8000  6000
    CREATE OR REPLACE PROCEDURE sp_ex8 (
        v_eno IN emp_c10.eno%type,
        v_salary IN emp_c10.salary%type
    )
    IS
    
    BEGIN
        UPDATE emp_c10
        SET salary = v_salary
        WHERE eno = v_eno;
        
        dbms_output.put_line('���������� �����Ǿ����ϴ�.')

    END;
    /
    
    EXEC sp_ex8 (8000, 6000);
    
9. ���� �� ���̺���� ��ǲ �޾� �� ���̺��� �����ϴ� �������ν����� ���� �Ͻÿ�. 
    
     CREATE OR REPLACE PROCEDURE sp_ex9(
        v_emp IN VARCHAR2 , v_dept IN VARCHAR2    -- ���� : ';' �� ������ �ȵ�, �ڷ����� ũ��
    )
    IS
        c1 INTEGER;     -- Ŀ�� ���� ����
        v_sql1 VARCHAR2(500);   -- ���̺� ���� ������ ���� ����
        v_sql2 VARCHAR2(500);   
    BEGIN
        v_sql1 := 'DROP TABLE ' || v_emp ;    --'' �� �� ���� ó��!
        v_sql2 := 'DROP TABLE ' || v_dept ;
    
        c1 := DBMS_SQL.OPEN_CURSOR;                 -- Ŀ�� ����
        DBMS_SQL.PARSE(c1, v_sql1, DBMS_SQL.V7);
        DBMS_SQL.PARSE(c1, v_sql2, DBMS_SQL.V7);
        DBMS_SQL.CLOSE_CURSOR(c1);                  -- Ŀ�� ����
    END;
    /
    
    SELECT * FROM emp_c10;
    SELECT * FROM dept_c10;
    
    EXEC sp_ex9 ('emp_c10', 'dept_c10');

10. ����̸��� ��ǲ �޾Ƽ� �����, �޿�, �μ���ȣ, �μ���, �μ���ġ�� OUT �Ķ���Ϳ� �Ѱ��ִ� ���ν����� PL / SQL���� ȣ��
    
    CREATE OR REPLACE PROCEDURE sp_ex10 (
        v_ename IN employee.ename%type,
        v_o_ename OUT employee.ename%type,
        v_salary OUT employee.salary%type,
        v_dno OUT employee.dno%type,
        v_dname OUT department.dname%type,
        v_loc OUT department.loc%type
    )
    IS
    BEGIN
        SELECT ename, salary, e.dno, dname, loc INTO v_o_ename, v_salary, v_dno, v_dname, v_loc
        FROM employee e, department d
        WHERE e.dno = d.dno
        AND ename = v_ename;        -- v_ename �� �������� �ؼ� 
        
    END;
    /
    
    
    DECLARE     -- OUT �Ķ���� ���� ���� ����
        v_ename employee.ename%type;
        v_salary employee.salary%type;
        v_dno employee.dno%type;
        v_dname department.dname%type;
        v_loc department.loc%type;
    BEGIN
        -- �͸� ��������� EXEC / EXECUTE �� ������
        sp_ex10('SCOTT', v_ename, v_salary, v_dno, v_dname, v_loc);
        
        dbms_output.put_line ('�����   ����   �μ���ȣ   �μ���   �μ���ġ');
        dbms_output.put_line ('---------------------------------------');
        dbms_output.put_line ( v_ename || '    ' || v_salary || '    ' || v_dno || '    ' || v_dname || '    ' || v_loc );
    END;
    /

11. �����ȣ�� �޾Ƽ� �����, �޿�, ��å, �μ���, �μ���ġ�� OUT �Ķ���Ϳ� �Ѱ��ִ� ���ν����� PL / SQL���� ȣ��

    CREATE OR REPLACE PROCEDURE ex11 (
        v_eno IN employee.eno%type,
        v_ename OUT employee.ename%type,
        v_salary OUT employee.salary%type,
        v_job OUT employee.job%type,
        v_dname OUT department.dname%type,
        v_loc OUT department.loc%type
    )
    IS
    BEGIN
        SELECT ename, salary, job, dname, loc INTO v_ename, v_salary, v_job, v_dname, v_loc
        FROM employee e, department d
        WHERE e.dno = d.dno
        AND eno = v_eno;
     END;
     /
            
    DECLARE 
            v_ename employee.ename%type,
            v_salary employee.salary%type,
            v_job employee.job%type,
            v_dname department.dname%type,
            v_loc department.loc%type
    BEGIN
    
        sp_ex11(7888, v_ename, v_salary, v_job, v_dname, v_loc);
        
        dbms_output.put_line('�����   ����   ��å   �μ���   ��ġ');
        dbms_output.put_line('---------------------------------');
        dbms_output.put_line( v_ename || '    ' || v_salary || '    ' || v_dno || '    ' || v_dname || '    ' || v_loc);
        
    END;
    /