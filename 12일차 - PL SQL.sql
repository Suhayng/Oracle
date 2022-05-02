12���� - PL/SQL : ����Ŭ���� ���α׷��� ��Ҹ� ������ SQL, �����ϰ� ó���ؼ� ����
        - MSSQL : T-SQL  
        - SQL : ����ȭ�� ���Ǿ��, ���� : ������ ���α׷��� ����� ������ �� ����.
        
set serveroutput on     -- PL/SQL �� ����� Ȱ��ȭ

/* PL SQL �⺻ �ۼ� ����*/

begin

    -- PL/SQL ���� 
    
end;
/

-- PL/SQL���� �⺻ ���

set serveroutput on
begin
    dbms_output.put_line('Welcome to Oracle');
end;
/

-- PL / SQL ���� ���� �����ϱ�.

    ������ := ��
    
    -- �ڷ��� ����
        1. Oracle �� �ڷ����� ���
        2. �����ڷ��� : ���̺� �÷��� ����� �ڷ����� �����ؼ� ���
                %type : ���̺��� Ư�� �÷��� �ڷ����� �����ؼ� ���
                %rowtype : ���̺� ��ü �÷��� �ڷ����� ��� ����
    
set serveroutput on
    
declare     -- ���� ���� (���� �����)
    v_eno number(4);                -- ����Ŭ�� �ڷ���
    v_ename employee.ename%type;    -- ���� �ڷ��� : ���̺��� �÷��� �ڷ����� �����ؼ� ����
begin
    v_eno := 7788;                  -- := ������ ���� �Ҵ��� �� ���
    v_ename := 'SCOTT';
    
    dbms_output.put_line('�����ȣ      ����̸�');
    dbms_output.put_line('--------------------');
    dbms_output.put_line(v_eno || '     ' || v_ename);
end;
/      

/* �����ȣ�� ����̸� ��� �ϱ� */

set serveroutput on
declare 
    v_eno employee.eno%type;
    v_ename emloyee.ename%type;
begin
    dbms_output.put_line('�����ȣ      ����̸�');
    dbms_output.put_line('--------------------');

    select eno, ename into v_eno, v_ename
    from employee
    where ename = 'SCOTT';
    
   dbms_output.put_line(v_eno || '     ' || v_ename);

end;
/   

    select eno, ename
    from employee
    where ename = 'SCOTT'
    
    /* PL/SQL ���� ��� ����ϱ�*/
    
    /* If ~ End if �� ����ϱ� */
    
    set serveroutput on 
    declare
        v_employee employee%rowtype;    -- rowtype : employee ���̺��� ��� �÷��� �ڷ����� �����ؼ� ���.
                                -- v_employee ������ employee ���̺��� ��� �÷��� ����
        annsal number(7,2) ;    -- �� ������ �����ϴ� ����
    begin
        select * into v_employee
        from emloyee
        where ename = 'SCOTT'

        if (v_employee.commission is null) then 
            v_employee.commission := 0;
        end if;
        annsal := v_employee.salary*12 + v_employee.commission;
        dbms_output.put_line('�����ȣ      ����̸�');
        dbms_output.put_line('--------------------');
        dbms_output.put_line(v_employee.eno || '     ' || v_employee.ename || '     ' || annsal);
    end;
    /

/*
    v_employee.eno := 7788
    v_employee.ename := 'SCOTT'
    v_employee.job := ANALYST
    v_employee.manager := 7566
    v_employee.hiredate := 87/07/13
    v_employee.salary := 3000
    v_employee.commission := null
    v_employee.dno := 20
*/

select * from employee
where ename = 'SCOTT'

/* PL/SQL �� ����ؼ� department ���̺��� ������ ��Ƽ� ����غ�����. 
    ���� dno = 20 �� ������ ��Ƽ� ����غ�����.
*/


1. %type : ������ data type �� ���̺��� �÷� �ϳ��ϳ��� �����ؼ� �Ҵ�.
set serveroutput on
declare
     v_dno departmnet.dno%type;
     v_dname department.dname%type;
     v_loc department.loc%type;
begin
     select dno, dname, loc into v_dno, v_dname, v_loc
     from department
     where dno=20;
     
     dbms_output.put_line('�μ���ȣ   �μ���   ��ġ');
     dbms_output.put_line('--------------------------');
     dbms_output.put_line(v_dno // '     ' // v_dname // '    ' // v_loc );
end;
/

2. %rowtype : ���̺��� ��� �÷��� �����ؼ� ���
set serveroutput on
declare
     v_department department%rowtype;
begin
     select dno, dname, loc into v_department
     from department
     where dno=20;
     
     dbms_output.put_line('�μ���ȣ   �μ���   ��ġ');
     dbms_output.put_line('--------------------------');
     dbms_output.put_line(v_department.dno // '     ' // v_department.dname // '    ' // v_department.loc );
end;
/
     	     
/* IF ~ ELSIF - END IF */

set serveroutput on
declare
      v_eno employee.eno%type;
      v_ename employee.ename%type;
      v_dno employee.dno%type;
      v_dname department.dname%type := null
begin
      select eno, ename, dno into v_eno, v_ename, v_dno
      from employee
      where ename = 'SCOTT'
      
      if (v_dno = 10) then
          v_dname = 'ACCOUNT';
      elsif (v_dno = 20) then
          v_dname := 'RESEARCH';
      elsif (v_dno = 30) then
          v_dname := 'SALES';
      elsif (v_dno = 40) then
          v_dname := 'OPERATIONS';
      end if;

       dbms_output.put_line('�����ȣ'   '�����'   '�μ���')
       dbms_output.put_line('---------------------------------')
       dbms_output.put_line( v_eno  // '     ' // v_ename // '     ' //  v_dname)   	
end;
/

select * from employee where ename = 'SCOTT';

/* employee ���̺��� eno, ename, salary, dno�� PL/SQL �� ����ؼ� ���
   ������ ���ʽ� 1400 �� ����� ���ؼ�  */

1. %type
set serveroutput on
declare
     v_eno employee.eno%type;
     v_ename employee.ename%type;
     v_salary employee.salary%type;
     v_dno employee.dno%type;
begin
     select eno, ename, salary, dno into v_eno, v_ename, v_salary, v_dno
     from emlpoyee
     where commission = 1400;
     
     dbms_output.put_line('�����ȣ   �����   �޿�   �μ���ȣ');
     dbms_output.put_line('----------------------------------------');
     dbms_output.put_line(v_eno ||  '     ' || v_ename || '     ' ||  v_salary  ||  '     ' || v_dno  );
end;
/

2. %rowtype
set serveroutput on
declare
     v_employee employee%rowtype;
begin
     select eno, ename, salary, dno into v_employee
     where commission = 1400;
     
    dbms_output.put_line('�����ȣ   �����   �޿�   �μ���ȣ');
     dbms_output.put_line('----------------------------------------');
     dbms_output.put_line(v_employee.eno ||  '     ' || v_employee.ename || '     ' ||  v_employee.salary  ||  '     ' || v_employee.dno  );
end;
/

select * from employee;

/* Ŀ�� (cusor)  : PL/SQL ���� select �� ����� ���� ���ڵ尡 �ƴ϶� ���ڵ� ���� ���, Ŀ���� �ʿ��ϴ�.
*/

declare 
    cursor Ŀ����			-- 1. Ŀ�� ����
    is
    Ŀ���� ������ select ���� 
begin
     open Ŀ���� ;			-- 2. Ŀ�� ����
     loop
         fetch ����			-- 3. Ŀ���� �̵��ϰ� ���	
     end loop;
     close Ŀ����;			-- 4. Ŀ���� ����
end;
/

/* Ŀ���� ����ؼ� department ���̺��� ��� ������ ����ϱ� */

set serveroutput on 
declare
     v_dept department%type;		-- ���� ���� 
     cursor c1			-- 1. Ŀ�� ����
     is
     select * from department;		
begin
    dbms_output.put_line('�μ���ȣ   �μ���   �μ���ġ');
    dbms_output.put_line('-------------------------------');
    open c1;			-- 2. Ŀ�� ����
    loop
          fetch c1 into v_dept.dno, v_dept.dname, v_dept.loc;	-- 3. Ŀ���� �̵��ϰ� ���
          exit when c1%notfound;
          dbms_output.put_line(v_dept.dno ||  '      '  || v_dept.dname  ||  '      '  || v_dept.loc);
    end loop; 
    close c1;			-- 4. Ŀ�� ����
end;
/

/* Ŀ���� �Ӽ��� ��Ÿ���� �Ӽ��� 
   Ŀ����%notfound : Ŀ�� ���� ���� ��� �ڷᰡ FETCH �Ǿ��ٸ� true 
   Ŀ����%found : Ŀ�� ���� ���� FETCH ���� ���� �ڷᰡ �����ϸ� ture
   Ŀ����%isopen : Ŀ���� ���µǾ��ٸ� true 
   Ŀ����%rowcount : Ŀ���� ���� ���ڵ� ����
*/

/*
      �����, �μ���, �μ���ġ, ���� �� ��� �ϼ���. (PL/SQL �� ����ؼ� ����ϼ���) <Ŀ���� �̿�>
*/

2. rowtype �� ����ؼ� ó��

set serveroutput on 
declare
     v_emp employee%rowtype;
     v_dept department%rowtype; 		
     cursor c2			
     is
     select ename, dname, loc, salary 
     from employee e, department d
     where e.dno = d.dno;		-- ; ���� �ϸ� �ȵ�!		
begin
    dbms_output.put_line('�����ȣ   �μ���   �μ���ġ   ����');
    dbms_output.put_line('---------------------------------------');
    open c2;		
    loop
          fetch c2 into v_emp.ename, v_dept.dname, v_dept.loc, v_emp.salary;	
          exit when c2%notfound;
          dbms_output.put_line( v_emp.ename ||  '      '  ||  v_dept.dname ||  '      '  || v_dept.loc ||  '      '  ||  v_emp.salary);
    end loop; 
    close c2;			
end;
/


