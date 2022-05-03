13���� - �������ν��� (Stored Procedure), �Լ�(Function), Ʈ���� (Trigger)

/*
    �������ν����� ����
        1. PL/SQL �� ��� �����ϴ�. �ڵ�ȭ
        2. ������ ������.
            �Ϲ����� SQL ���� : �����м� -> ��ü�̸�Ȯ�� -> ������Ȯ�� -> ����ȭ -> ������ -> ����
            �������ν��� ó�� ���� : �����м� -> ��ü�̸�Ȯ�� -> ������Ȯ�� -> ����ȭ -> ������ -> ����
            �������ν��� �� ��° ���� : ������(�޸𸮿� �ε�) -> ����

        3. �Է� �Ű�����, ��� �Ű������� ����� �� �ִ�.
        4. �Ϸ��� �۾��� ��� ���� ( ���ȭ�� ���α׷����� �����ϴ�.)

*/

1. �������ν��� ����
-- ���� ����� ������ ��� �ϴ� �������ν���
CREATE PROCEDURE sp_salary
IS
    v_salary employee.salary%type;
BEGIN
    SELECT salary INTO v_salary
    FROM employee
    WHERE emame ='SCOTT'
 
    dbms_output.put_line ('SCOTT �� �޿��� : ' || v_salary || ' �Դϴ�' );
    
END;
/

/* �������ν��� ������ Ȯ���ϴ� ������ ���� */
select * from user_source
where name = 'SP_SALARY';

2. ���� ���ν��� ����
EXECUTE sp_salary;      -- ��ü �̸�
EXEC sp_salary;         -- ��� �̸�

3. ���� ���ν��� ����
CREATE or replace PROCEDURE sp_salary   -- sp_salary �� �������� ������ ����, �����ϸ� ����
IS
    v_salary employee.salary%type;      -- ���� ���ν����� is ������� ������ ����
BEGIN
    SELECT salary INTO v_salary, v_commission
    FROM employee
    WHERE emame ='SCOTT'
 
    dbms_output.put_line ('SCOTT �� �޿��� : ' || v_salary || 
                           '���ʽ��� �� ' || v_commission || ' �Դϴ�' );
END;
/

4. ���� ���ν��� ����
drop procedure sp_salary;

---------------------<��ǲ �Ű������� ó���ϴ� ���� ���ν���>-----------------------
create or replace procedure sp_salary_ename (     -- �Է� �Ű� ���� (in) , ��� �Ű������� ���� (out)�� ����
    v_ename in employee.ename%type    -- ������ in �ڷ���  <== ���� << ; �� ����ϸ� �ȵȴ� >>
)
is      -- �������� (���� ���ν������� ����� ���� ���� ���)
    v_salary employee.salary%type;
begin
    select salary into v_salary  -- ���� 
    from employee
    where ename = v_ename;  -- ��ǲ �Ű����� : v_ename

    dbms_output.put_line( v_ename || ' �� �޿��� ' || v_salary || '�Դϴ�' ); 
end;
/

exec sp_salary_ename ('SCOTT');
exec sp_salary_ename ('SMITH');
exec sp_salary_ename ('KING');
select * from employee;

/* �μ���ȣ�� ��ǲ �޾Ƽ� �̸�, ��å, �μ���ȣ�� ����ϴ� ���� ���ν����� �����ϼ��� (Ŀ���� ����ؾ���) */

create or replace procedure sp_dno (
    v_dno in employee.dno%type
)
cursor c1
is
    v_ename in employee.ename%type;
    v_job in employee.job%type;
    v_dno in employee.dno%type;
begin
    select ename, job, dno into v_emp
    from employee
    where dno = v_dno;
    
    dbms_output.put_line('�̸�   ��å   �μ���ȣ);   
    dbms_output.put_line('-----------------------');
    for v_emp in c1 loop
        dbms_output.put_line ( v_ename|| '   ' || v_job || '   ' || v_dno);
    end loop;
 
exec sp_dno ();   

/* ���̺� �̸��� ��ǲ �޾Ƽ� employee ���̺��� �����ؼ� �����ϴ� ���� ���ν����� �����ϼ���. 
    ��ǲ �� : emp_copy89 
*/

create or replace procedure sp_createTable (
    v_name varcahr2
)
is
    cursor1 INTEGER;
    v_sql varchar2(100);    -- SQL ������ �����ϴ� ����
begin 
    v_sql = 'CREATE TABLE' || v_name || ' as select * from employee ';  -- ���̺� ���������� ������ �Ҵ�.
    
    cursor1 := DBMS_SQL.OPEN_CURSOR;                    -- Ŀ�� ���
    DBMS_SQL.parse ( cursor1, v_sql, dbms_sql.v7);      -- Ŀ���� ����ؼ� sql ������ ����
    DBMS_SQL.close_cursor(cursor1);                     -- Ŀ�� ���� 
end;
/    

grant create table to public;       -- sys �������� ����

exec sp_createTable ('emp_copy89');

select * from emp_copy89;
drop table emp_copy89;


----------------------------< ��� �Ű����� ��� >--------------------------------
/* ���� ���ν��� : ��� �Ű������� ����(��������), �Լ� : ��� �Ű������� �ϳ��� ����
    -- OUT Ű���带 ���
    -- ���� ���ν����� ȣ��� ���� ��� �Ű����� ���� ���� �� ȣ���� ����.
    -- ȣ��� ��� �Ű����� �̸� �տ� ':������(��¸Ű�������)'
    -- ��� �Ű������� ����ϱ� ���ؼ� PRINT ��ɹ��̳� PL/SQL�� ����ؼ� ����� �� �ִ�.
*/

create or replace procedure sp_salary_ename2 (      -- �Է�/��� �Ű����� �����
    v_ename in employee.ename%type,     -- �Է� �Ű� ����
    v_salary out employee.salary%type   -- ��� �Ű� ����
)
is
begin
    select salary into v_salary
    from emloyee
    where ename = v_ename;
    
end;
/

select * from user_source where name = 'SP_SALARY_ENAME2'   -- ������ �������� Ȯ��

-- �ּ� ó�� ���� : 
variable var_salary varchar(50);   
exec sp_salary_ename2 ('SCOTT', :var_salary);  -- :var_salary   <== : ����
print var_salary;

select * from  user_source where name = 'SP_SALARY_ENAME2'  -- ������ �������� Ȯ��

-- OUT �Ķ���͸� ������ ������ ���� ���ν��� ���� �� ��� (PL/SQL)
-- �����ȣ�� ��ǲ �޾Ƽ� ����̸�, �޿�, ��å OUT �Ķ���Ϳ� �Ѱ��ִ� ���ν����� PL/SQL�� ����ؼ� ���
create or replace procedure sel_empno (     --IN, OUT : �ڷ����� �����ڷ���(%type), 
    v_eno in number,                        --�⺻ �ڷ��� ����Ʈ���� ����
    v_ename out varchar2,
    v_sal out number,
    v_job out varchar2
)
is
begin
    select eno, salary job into v_eno, v_sal, v_job
    from employee
    where eno = v_eno;
end;
/


-- PL/SQL �� ����ؼ� ���� ���ν��� ȣ��
declare
    var_ename varchar(50);
    var_sal number;
    var_job varchar(50);
begin
    -- �͸� ��Ͽ����� �������ν��� ȣ��� exec �� ������ �ʴ´�.
    sel_empno (7788, var_ename, var_sal, var_job);  -- �������ν��� ȣ��
    dbms_output.put_line('��ȸ��� : ' || var_name || '   ' || var_sal || '   ' || var_job);
end;
/

/* �Լ� (Function) : ���� �־ �ϳ��� ���� ��ȯ �޾ƿ´�.           <== SQL ���� ������ ��� ����
    - ��, ���� ���ν����� out �Ű� ������ ������ ��ȯ �޾ƿ� �� �ִ�. <== SQL ���� �������� ��� �Ұ�
*/

create or replace function fn_salary_ename (    -- ��ǲ �Ű�����
    v_ename in employee.ename%type
)
RETURN number           -- ȣ���ϴ� ������ ���� ������. ������ �ڷ���.
is
    v_salary number(7,2);
begin
    select salary into v_salary
    from employee
    where ename = v_ename;        -- ��ǲ �Ű� ����
    RETURN v_salary;
end;

/* �Լ��� ������ ����*/
select * from user_source
where name = 'FN_SALARY_ENAME';

-- 1. �Լ� ���
variable var_salary number;
exec :var_salary := fn_salary_ename('SCOTT');
print v_salary;

-- 2. �Լ� ��� (SQL    ���� ������ �Լ� ���)
select ename, fn_salary_ename('SCOTT') as ����
from employee
where ename = 'SCOTT';

-- 3. �Լ� ����
drop function fn_salary_ename;



