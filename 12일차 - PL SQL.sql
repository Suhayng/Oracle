12일차 - PL/SQL : 오라클에서 프로그래밍 요소를 적용한 SQL, 유연하게 처리해서 적용
        - MSSQL : T-SQL  
        - SQL : 구조화된 질의언어, 단점 : 유연한 프로그래밍 기능을 적용할 수 없다.
        
set serveroutput on     -- PL/SQL 의 출력을 활성화

/* PL SQL 기본 작성 구문*/

begin

    -- PL/SQL 구문 
    
end;
/

-- PL/SQL에서 기본 출력

set serveroutput on
begin
    dbms_output.put_line('Welcome to Oracle');
end;
/

-- PL / SQL 에서 변수 선언하기.

    변수명 := 값
    
    -- 자료형 선언
        1. Oracle 의 자료형을 사용
        2. 참조자료형 : 테이블 컬럼의 선언된 자료형을 참조해서 사용
                %type : 테이블의 특정 컬럼의 자료형을 참조해서 사용
                %rowtype : 테이블 전체 컬럼의 자료형을 모두 참조
    
set serveroutput on
    
declare     -- 변수 선언 (변수 선언부)
    v_eno number(4);                -- 오라클의 자료형
    v_ename employee.ename%type;    -- 참조 자료형 : 테이블의 컬럼의 자료형을 참조해서 적용
begin
    v_eno := 7788;                  -- := 변수의 값을 할당할 때 사용
    v_ename := 'SCOTT';
    
    dbms_output.put_line('사원번호      사원이름');
    dbms_output.put_line('--------------------');
    dbms_output.put_line(v_eno || '     ' || v_ename);
end;
/      

/* 사원번호와 사원이름 출력 하기 */

set serveroutput on
declare 
    v_eno employee.eno%type;
    v_ename emloyee.ename%type;
begin
    dbms_output.put_line('사원번호      사원이름');
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
    
    /* PL/SQL 에서 제어문 사용하기*/
    
    /* If ~ End if 문 사용하기 */
    
    set serveroutput on 
    declare
        v_employee employee%rowtype;    -- rowtype : employee 테이블의 모든 컬럼의 자료형을 참조해서 사용.
                                -- v_employee 변수는 employee 테이블의 모든 컬럼을 참조
        annsal number(7,2) ;    -- 총 연봉을 저장하는 변수
    begin
        select * into v_employee
        from emloyee
        where ename = 'SCOTT'

        if (v_employee.commission is null) then 
            v_employee.commission := 0;
        end if;
        annsal := v_employee.salary*12 + v_employee.commission;
        dbms_output.put_line('사원번호      사원이름');
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

/* PL/SQL 을 사용해서 department 테이블을 변수에 담아서 출력해보세요. 
    조건 dno = 20 을 변수에 담아서 출력해보세요.
*/


1. %type : 변수의 data type 을 테이블의 컬럼 하나하나를 참조해서 할당.
set serveroutput on
declare
     v_dno departmnet.dno%type;
     v_dname department.dname%type;
     v_loc department.loc%type;
begin
     select dno, dname, loc into v_dno, v_dname, v_loc
     from department
     where dno=20;
     
     dbms_output.put_line('부서번호   부서명   위치');
     dbms_output.put_line('--------------------------');
     dbms_output.put_line(v_dno // '     ' // v_dname // '    ' // v_loc );
end;
/

2. %rowtype : 테이블의 모든 컬럼을 참조해서 사용
set serveroutput on
declare
     v_department department%rowtype;
begin
     select dno, dname, loc into v_department
     from department
     where dno=20;
     
     dbms_output.put_line('부서번호   부서명   위치');
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

       dbms_output.put_line('사원번호'   '사원명'   '부서명')
       dbms_output.put_line('---------------------------------')
       dbms_output.put_line( v_eno  // '     ' // v_ename // '     ' //  v_dname)   	
end;
/

select * from employee where ename = 'SCOTT';

/* employee 테이블의 eno, ename, salary, dno을 PL/SQL 을 사용해서 출력
   조건은 보너스 1400 인 사원에 대해서  */

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
     
     dbms_output.put_line('사원번호   사원명   급여   부서번호');
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
     
    dbms_output.put_line('사원번호   사원명   급여   부서번호');
     dbms_output.put_line('----------------------------------------');
     dbms_output.put_line(v_employee.eno ||  '     ' || v_employee.ename || '     ' ||  v_employee.salary  ||  '     ' || v_employee.dno  );
end;
/

select * from employee;

/* 커서 (cusor)  : PL/SQL 에서 select 한 결과가 단일 레코드가 아니라 레코드 셋인 경우, 커서가 필요하다.
*/

declare 
    cursor 커서명			-- 1. 커서 선언
    is
    커서를 부착할 select 구문 
begin
     open 커서명 ;			-- 2. 커서 오픈
     loop
         fetch 구문			-- 3. 커서를 이동하고 출력	
     end loop;
     close 커서명;			-- 4. 커서를 종료
end;
/

/* 커서를 사용해서 department 테이블의 모든 내용을 출력하기 */

set serveroutput on 
declare
     v_dept department%type;		-- 변수 선언 
     cursor c1			-- 1. 커서 선언
     is
     select * from department;		
begin
    dbms_output.put_line('부서번호   부서명   부서위치');
    dbms_output.put_line('-------------------------------');
    open c1;			-- 2. 커서 오픈
    loop
          fetch c1 into v_dept.dno, v_dept.dname, v_dept.loc;	-- 3. 커서를 이동하고 출력
          exit when c1%notfound;
          dbms_output.put_line(v_dept.dno ||  '      '  || v_dept.dname  ||  '      '  || v_dept.loc);
    end loop; 
    close c1;			-- 4. 커서 종료
end;
/

/* 커서의 속성을 나타내는 속성값 
   커서명%notfound : 커서 영역 내의 모든 자료가 FETCH 되었다면 true 
   커서명%found : 커서 영역 내의 FETCH 되지 않은 자료가 존재하면 ture
   커서명%isopen : 커서가 오픈되었다면 true 
   커서명%rowcount : 커서가 얻어온 레코드 개수
*/

/*
      사원명, 부서명, 부서위치, 월급 을 출력 하세요. (PL/SQL 을 사용해서 출력하세요) <커서를 이용>
*/

2. rowtype 를 사용해서 처리

set serveroutput on 
declare
     v_emp employee%rowtype;
     v_dept department%rowtype; 		
     cursor c2			
     is
     select ename, dname, loc, salary 
     from employee e, department d
     where e.dno = d.dno;		-- ; 생략 하면 안됨!		
begin
    dbms_output.put_line('사원번호   부서명   부서위치   월급');
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

/* cursor for loop 문으로 커서를 사용해서 여러 레코드셋 출력하기
    - open, close 를 생략해서 사용
    - 한 테이블의 전체 내용을 출력할 때 사용
*/
select * from employees
select * from departments

set serveroutput on

declare
    v_dept department%rowtype;
    cursor c1                   -- 커서 선언
    is
    select dno, dname, loc 
    from deprtment;
begin
    dbms_output.put_line('부서번호   부서명   지역명');   
    dbms_output.put_line('-----------------------');
    for d_dept in c1 loop
        dbms_output.put_line ( v_dept.dno || '   ' || v_dept.dname || '   ' || v_dept.loc);
    end loop;
end;
/

/* employee 테이블의 모든 내용을 cursor for loop 를 사용해서 출력해보세요*/

set serveroutput on

declare
    v_emp employee%rowtype;
    cursor c1                   -- 커서 선언
    is
    select eno, ename, dno
    from employee;
begin
    dbms_output.put_line('사원번호   사원명   부서번호');   
    dbms_output.put_line('-----------------------');
    for v_emp in c1 loop
        dbms_output.put_line ( v_emp.eno || '   ' || v_emp.ename || '   ' || v_emp.dno);
    end loop;
end;
/

/* employee 테이블의 사원번호, 사원명, 월급을 출력 월급이 2000 이상, 부서가 20, 30 부서만 출력 
    cursor for loop 를 사용
*/
set serveroutput on

declare
    v_emp employee%rowtype;
    cursor c1                   -- 커서 선언
    is
    select eno, ename, salary 
    from employee
    where salary > 2000 
    and (dno = 20 or dno = 30) ;
begin
    dbms_output.put_line('사원번호   사원명   월급);   
    dbms_output.put_line('-----------------------');
    for v_emp in c1 loop
        dbms_output.put_line ( v_emp.eno || '   ' || v_emp.ename || '   ' || v_emp.salary);
    end loop;
end;
/


/*
    트리거 (Trigger) : 권총의 방아쇠 (트리거), 방아쇠를 당기면 총알이 발사됨.
       - 테이블에 부착되어 있다.
       - 테이블에 이벤트가 발생될 때 자동으로 작동되는 프로그램 코드
       - 테이블에 발생되는 이벤트 (Insert, Update, Delete)
       - 트리거에서 정의된 begin ~ end 사이의 문장이 실행됨.
       - before 트리거 : 테이블에서 트리거를 먼저 실행 후 INSERT, UPDATE, DELETE 가 적용
       - after 트리거 : INSERT, UPDATE, DELETE 가 실행 후 트리거를 실행.
       - 예) 주문 테이블에 값을 넣었을 때 배송 테이블에 자동으로 저장
       - 예) 중요 테이블의 로그를 남길 때도 사용됨.
       - :new 
       - :old
       - 트리거는 하나의 테이블에 총 3개까지 부착됨. (INSERT, UPDATE, DELETE)
*/

-- 실습 테이블 2개 생성 : 테이블의 구조만 복사 
CREATE TAbLE dept_original
AS
SELECT * FROM departments
WHERE 0=1 ;

CREATE TAbLE dept_copy
AS
SELECT * FROM departments
WHERE 0=1 ;

SELECT * FROM dept_original;
SELET * FROM dept_copy;

-- 트리거 생성 (dept_original 테이블에 부착, INSERT 이벤트가 발생될 때 자동으로 작동)

CREATE OR REPLACE TRIGGER tri_sample1
        -- 트리거가 부착될 테이블, 이벤트(INSERT, UPDATE, DELETE), BEFORE, AFTER
    AFTER INSERT        -- insert 이벤트가 작동 후 트리거가 작동 (BEGIN ~ END 사이의 코드)
    ON dept_original    -- on 부착될 테이블
    FOR EACH ROW        -- 모든 row 에 대해서 
        

BEGIN           -- 트리거가 실행할 코드
    IF inserting THEN 
        dbms_output.put_line('Insert Treigger 발생 !!!');
        INSERT INTO dept_copy
        VALUES ( :new.dno, :new.dname, :new.loc);      -- new 가상 임시 테이블
        
    END IF;
END;
/

/* 트리거 확인 데이터 사전 : user_source */
SELECT * FROM user_source WHERE name = 'TRI_SAMPLE1';

SELECT * FROM dept_original;
SELECT * FROM dept_copy;

INSERT INTO dept_original
VALUES (12, 'PROGRAM', 'BUSAN');


/* delete 트리거 : dept_original 에서 제거 => dept_copy 에서 해당 내용을 제거 */

CREATE OR REPLACE TRIGGER tri_del
    -- 트리거가 작동시킬 테이블, 이벤트
    AFTER DELETE        -- 원본 테이블의 delete 를 먼저 실행 후 트리거 작동
    ON dept_original    -- dept_original 테이블에 트리거 부착
    FOR EACH ROW
BEGIN   -- 트리거가 작동할 코드
    dbms_output.put_line('Delete Trigger 발생됨 !!!');
    DELETE dept_copy
    WHERE dept_copy.dno = :old.dno;     --dep_original 에서 삭제되는 가상 임시 테이블 : old
END;
/

SELECT * FROM dept_original;
SELECT * FROM dept_copy;

DELETE dept_original
WHERE dno = 14;

/* update 트리거 */
    
CREATE OR REPLACE TRIGGER tri_update
    AFTER UPDATE        
    ON dept_original    
    FOR EACH ROW
BEGIN   
    dbms_output.put_line('Delete Trigger 발생됨 !!!');
    UPDATE dept_copy
    SET dept_copy.dname = :new.dname
    WHERE dept_copy.dno = 13;     
END;
/

SELECT * FROM dept_original;        -- 주문 테이블 가정
SELECT * FROM dept_copy;            -- 배송 테이블 가정

UPDATE dept_original
SET dname = 'prog'
WHERE dno = 13;