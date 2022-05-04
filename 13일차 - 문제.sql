저장 프로시져 문제 

1. 각 부서별로 최소급여, 최대급여, 평균급여를 출력하는 저장프로시져를 생성하시오. 
	[employee, department ] 테이블 이용
    
    SET SERVEROUTPUT ON
    CREATE OR REPLACE PROCEDURE sp_ex1
    IS  -- 변수 선언부
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
        dbms_output.put_line( '부서번호   최소급여   최대급여   평균급여');
        dbms_output.put_line( '------------------------------------');
        OPEN c1;    -- 커서 시작
        LOOP
            FETCH c1 INTO v_dno, v_min, v_max, v_avg;
            EXIT WHEN c1%notfound;      -- 레코드의 값이 더이상 존재하지 않을 때
               dbms_output.put_line( v_dno || '   ' || v_min ||'   ' || v_max ||'   ' || v_avg );
        END LOOP;
        CLOSE c1;
    END;
    /
    
    EXEC sp_ex1;
    
    select * from employees
   

2.  사원번호, 사원이름, 부서명, 부서위치를 출력하는 저장프로시져를 생성하시오.  
	[employee, department ] 테이블 이용
      CREATE OR REPLACE PROCEDURE sp_ex2
    IS  
        v_eno employee.eno%type;
        v_ename employee.ename%type;
        v_dname department.dname%type;
        v_loc department.loc%type;
        -- 테이블 rowtype 으로 가져와도 됨.
        
        CURSOR c1
        IS
        SELECT eno, ename, dname, loc
        FROM employee e, department d
        WHERE e.dno = d.dno;
        
    BEGIN
        dbms_output.put_line( '사원번호   사원이름   부서명   부서위치');
        dbms_output.put_line( '------------------------------------');
        OPEN c1;    -
        LOOP
            FETCH c1 INTO v_eno, v_ename, v_dname, v_loc
            EXIT WHEN c1%notfound;      -- 레코드의 값이 더이상 존재하지 않을 때
               dbms_output.put_line( v_eno || '   ' || v_ename ||'   ' || v_dname ||'   ' || v_loc );
        END LOOP;
        CLOSE c1;
    END;
    /
    
    EXEC sp_ex2;

3. 급여를 입력 받아  입력받은 급여보다 높은 사원의 사원이름, 급여, 직책을 출력 하세요.
	저장프로시져명 : sp_salary_b
      CREATE OR REPLACE PROCEDURE sp_salary_b (
        v_salary IN employee.salary%type            -- 주의 : INPUT, OUTPUT 매개 변수에는 ; 처리 하면 안됨!
      )
    IS  
        v_emp employee%rowtype; -- 모든 컬럼의 자료형을 선언
        CURSOR c1
        IS
        SELECT ename, salary, job 
        FROM employee 
        WHERE salary > v_salary;
        
    BEGIN
        dbms_output.put_line( '사원이름   급여   직책');
        dbms_output.put_line( '---------------------');
        OPEN c1;    -
        LOOP
            FETCH c1 INTO v_emp.ename, v_emp.salary, v_emp.job
            EXIT WHEN c1%notfound;      -- 레코드의 값이 더이상 존재하지 않을 때
               dbms_output.put_line( v_emp.ename || '   ' || v_emp.salary ||'   ' || v_emp.job );
        END LOOP;
        CLOSE c1;
    END;
    /
    
    EXEC sp_salary_b(2500);
-- 확인 


4. 인풋 매개변수 : emp_c10, dept_c10  두개를 입력 받아 각각 employee, department 테이블을 복사하는 저장프로시져를 생성하세요. 
	저장프로시져명 : sp_copy_table
	
    -- PL/SQL 내부에서 익명 블락에서 테이블을 생성 : GRANT CREATE TABLE TO PUBLIC;  < sys 계정으로 접속 >
    -- 저장 프로스저 실행후 :  REVOLE CREATE TABLE FROM PUBLIC;

    CREATE OR REPLACE PROCEDURE sp_copy_table(
        v_emp IN VARCHAR2 , v_dept IN VARCHAR2    -- 주의 : ';' 을 넣으면 안됨, 자료형의 크기
    )
    IS
        c1 INTEGER;     -- 커서 변수 선언
        v_sql1 VARCHAR2(500);   -- 테이블 생성 쿼리를 담을 변수
        v_sql2 VARCHAR2(500);   
    BEGIN
        v_sql1 := 'CREATE TABLE ' || v_emp || ' AS SELECT * FROM employee';    --'' 앞 뒤 공백 처리!
        v_sql2 := 'CREATE TABLE ' || v_dept || ' AS SELECT * FROM department';
    
        c1 := DBMS_SQL.OPEN_CURSOR;                 -- 커서 오픈
        DBMS_SQL.PARSE(c1, v_sql1, DBMS_SQL.V7);
        DBMS_SQL.PARSE(c1, v_sql2, DBMS_SQL.V7);
        DBMS_SQL.CLOSE_CURSOR(c1);                  -- 커서 종료
    END;
    /

    EXEC sp_copy_table ('emp_c10', 'dept_c10');
    
    SELECT * FROM emp_c10;
    SELECT * FROM dept_c10;

5. dept_c10 테이블에서 dno, dname, loc 컬럼의 값을 인풋 받아 인풋 받은 값을 insert하는 저장프로시져를 생성하시요. 
	입력 값 : 50  'HR'  'SEOUL'
	입력 값 : 60  'HR2'  'PUSAN' 
    
    EXEC sp_ex5 (50,'HR','SEOUL');
    EXEC sp_ex5 (60,'HR2','BUSAN');
    
    
    CREATE OR REPLACE PROCEDURE sp_ex5 (
        v_dno IN dept_c10.dno%type, v_dname IN dept_c10.dname%type, v_loc dept_c10.loc%type)
    IS
    BEGIN
        INSERT INTO dept_c10
        VALUES ( v_dno, v_dname, v_loc);
        
        dbms_output.put_line ('정상적으로 입력되었습니다.')
   
    END;
    /
    

6. emp_c10 테이블에서 모든 컬럼의 값을 인풋 받아 인풋 받은 값을 insert하는 저장프로시져를 생성하시요. 
	입력 값 : 8000  'SONG'    'PROGRAMMER'  7788  sysdate  4500  1000  50 
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
        
        dbms_output.put_line ('정상적으로 입력되었습니다.')
    END;
    /
    
7. dept_c10 테이블에서 4번문항의 부서번호 50의 HR 을 'PROGRAM' 으로 수정하는 저장프로시져를 생성하세요. 
	<부서번호와 부서명을 인풋받아 수정하도록 하시오.> 
	입력 값 : 50  PROGRAMMER 
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
        
        dbms_output.put_lind('정상적으로 업데이트 되었습니다.');
    END;
    /
    
8. emp_c10 테이블에서 사원번호를 인풋 받아 월급을 수정하는 저장 프로시져를 생성하시오. 
	입력 값 : 8000  6000
    CREATE OR REPLACE PROCEDURE sp_ex8 (
        v_eno IN emp_c10.eno%type,
        v_salary IN emp_c10.salary%type
    )
    IS
    
    BEGIN
        UPDATE emp_c10
        SET salary = v_salary
        WHERE eno = v_eno;
        
        dbms_output.put_line('정상적으로 수정되었습니다.')

    END;
    /
    
    EXEC sp_ex8 (8000, 6000);
    
9. 위의 두 테이블명을 인풋 받아 두 테이블을 삭제하는 저장프로시져를 생성 하시오. 
    
     CREATE OR REPLACE PROCEDURE sp_ex9(
        v_emp IN VARCHAR2 , v_dept IN VARCHAR2    -- 주의 : ';' 을 넣으면 안됨, 자료형의 크기
    )
    IS
        c1 INTEGER;     -- 커서 변수 선언
        v_sql1 VARCHAR2(500);   -- 테이블 생성 쿼리를 담을 변수
        v_sql2 VARCHAR2(500);   
    BEGIN
        v_sql1 := 'DROP TABLE ' || v_emp ;    --'' 앞 뒤 공백 처리!
        v_sql2 := 'DROP TABLE ' || v_dept ;
    
        c1 := DBMS_SQL.OPEN_CURSOR;                 -- 커서 오픈
        DBMS_SQL.PARSE(c1, v_sql1, DBMS_SQL.V7);
        DBMS_SQL.PARSE(c1, v_sql2, DBMS_SQL.V7);
        DBMS_SQL.CLOSE_CURSOR(c1);                  -- 커서 종료
    END;
    /
    
    SELECT * FROM emp_c10;
    SELECT * FROM dept_c10;
    
    EXEC sp_ex9 ('emp_c10', 'dept_c10');

10. 사원이름을 인풋 받아서 사원명, 급여, 부서번호, 부서명, 부서위치을 OUT 파라미터에 넘겨주는 프로시저를 PL / SQL에서 호출
    
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
        AND ename = v_ename;        -- v_ename 을 조건으로 해서 
        
    END;
    /
    
    
    DECLARE     -- OUT 파라미터 받을 변수 선언
        v_ename employee.ename%type;
        v_salary employee.salary%type;
        v_dno employee.dno%type;
        v_dname department.dname%type;
        v_loc department.loc%type;
    BEGIN
        -- 익명 블락에서는 EXEC / EXECUTE 를 생략함
        sp_ex10('SCOTT', v_ename, v_salary, v_dno, v_dname, v_loc);
        
        dbms_output.put_line ('사원명   월급   부서번호   부서명   부서위치');
        dbms_output.put_line ('---------------------------------------');
        dbms_output.put_line ( v_ename || '    ' || v_salary || '    ' || v_dno || '    ' || v_dname || '    ' || v_loc );
    END;
    /

11. 사원번호를 받아서 사원명, 급여, 직책, 부서명, 부서위치를 OUT 파라미터에 넘겨주는 프로시저를 PL / SQL에서 호출

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
        
        dbms_output.put_line('사원명   월급   직책   부서명   위치');
        dbms_output.put_line('---------------------------------');
        dbms_output.put_line( v_ename || '    ' || v_salary || '    ' || v_dno || '    ' || v_dname || '    ' || v_loc);
        
    END;
    /