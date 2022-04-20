-- 숫자 함수
/*
    ROUND : 특정 자리수에서 반올림
    TRUNC : 특정 자릿수에서 잘라낸다 (버린다)
    MOD   : 입력한 수 의 나머지 값만 출력
*/

-- round (대상) : 소수점 뒷자리에서 반올림
-- round (대상, 소수점 자리수)
       -- 소수점 자릿수 : 양수일 때 소수점 오른쪽으로 자릿수만큼 이동해서 그 자릿수 뒤에 반올림 <== 주의 
       -- 소수점 자릿수 : 음수일 때 소수점 왼쪽으로 자릿수만큼 이동하고 그 자릿수에서 반올림       
            -- 정수를 반올림
            -- 소수점 자리는 모두 버림 
select 98.7654, ROUND (98.7654), round (98.7654 , 2), round (98.7654, -1), round(98.7654, -2),
        round(98.7654, -3), round (98.7654, 3)  
from dual;

select 12345.6789, round (12345.6789), round (12345.6789, -3), round(123678.123456, -3)
from dual;

-- trunc
select 98.7654, TRUNC (98.7654), TRUNC(98.7654, 2), TRUNC (98.7654, -1) 
from dual; 

-- mod (대상, 나누는 수) : 대상을 나누어서 나머지만 출력
select MOD (31,2), mod (31, 5), mod (31, 8)  
from dual

select * from employee;

select salary, mod (salary, 300) 
from employee;

-- employee 테이블에서 사원번호가 짝수인 사원들만 출력
select *
from employee
where mod(eno, 2)=0;

/* 날짜 함수
        sysdate : 시스템에 저장된 현재 날짜를 출력
        months_between : 두 날짜 사이의 몇 개월 인지를 반환
        add_months : 특정 날짜에 개월수를 더한다.
        next_day : 특정 날짜에서 최초로 도래하는 인자로 받은 요일의 날짜를 반환
        last_day : 달의 마지막 날짜를 반환
        round : 인자로 받은 날짜를 특정 기준으로 반올림
        trunc : 인자로 받은 날짜를 특정 기준으로 버림 
*/

-- 자신의 시스템의 날짜 출력
select sysdate 
from dual

select sysdate -1 as 어제 날짜, sysdate as 오늘 날짜, sysdate + 1 내일 날짜
from dual;

select * from employees
order by hire_date asc;

select hire_date, hire_date -1 , hire_date + 10
from employees;

desc employees;

-- 입사일에서 부터 현재까지의 근무일수를 출력
select round (sysdate - hiredate) as "총 근무 일수"
from employee;

select round ((sysdate - hiredate), 1) as "총 근무 일수"
from employee;

select trunc (sysdate - hiredate) as "총 근무 일수"
from employee;

-- 특정 날짜에서 월(Month)을 기준으로 버림한 날짜 구하기
select hiredate, trunc (hiredate, 'MONTH') 
from employee;

-- 특정 날짜에서 월(Month)을 기준으로 반올림한 날짜 구하기 : 16일 이상일 경우 반올림.
select hiredate, round (hiredate, 'MONTH') 
from employee;

-- months_between (date1, date2) : date1 과 date2 사이의 개월수를 출력

-- 입사일에서 현재까지 각 사원들의 근무한 개월 수 구하기
select ename, sysdate, hiredate, months_between (sysdate, hiredate) as "근무 개월 수" 
from employee; 

select ename, sysdate, hiredate, trunc (months_between (sysdate, hiredate)) as "근무 개월 수" 
from employee;

--add_months (date1, 개월수) : date1 날짜에 개월수를 더한 날짜를 출력

-- 입사한 후 6개월이 지난 시점을 출력
select hiredate , add_months (hiredate, 6) 
from employee;

-- 입사한 후 100일이 지난 시점의 날짜 
select hiredate , hiredate + 100 as "입사 후 100일 날짜" 
from employee;

-- next_day (date, '요일') : date 의 도래하는 요일에 대한 날짜를 출력 하는 함수
select sysdate, next_day (sysdate, '토요일') as '이번주의 토요일의 날짜" 
from employee;

-- last_day (date) : date 에 들어간 달의 마지막 날짜.
select hiredate, last_day ( hiredate)
from employee;
    

--  형 변환 함수  <== 중요
/*  
    TO_CHAR : 날짜형 또는 숫자형 데이터를 문자형으로 변환하는 함수
    TO_DATE : 문자형을 날짜형으로 변환하는 함수
    TO_NUMBER : 문자형을 숫자형으로 변환하는 함수
*/

-- 날짜 함수 사용하기
    --TO_CHAR (date, 'YYYYMMDD')
select ename, hiredate, to_char(hiredate, 'YYYYMMDD'), to_char(hiredate, 'YYMM')
    to_char (hiredate, 'YYYYMMDD DAY'), to_char(hiredate, 'YYYYMMDD DY')
from employee;    

-- 현재 시스템의 날짜를 출력하고 시간, 초 까지 출력
select sysdate, to_char(sysdate, 'YYYY-MM-DD HH:MI:SS DY')
from dual;

desc employee;

select hiredate, to_char (hiredate, 'YYYY-MM-DD HH:MI:SS DAY')
from employee;

--to_char 에서 숫자와 관련된 형식
/*
    0 : 자릿수를 나타내며 자릿수가 맞지 않을 경우 0으로 채움
    9 : 자릿수를 나타내며 자릿수가 맞지 않을 경우 채우지 않는다.
    L : 각 지역별 통화 기호를 출력
    . : 소수점으로 표현 
    , : 천단위의 구분자 
*/

desc employee;

select ename, salary, to_char(salary, 'L999, 999'), to_char (salary, 'L0000, 000')
from employee;

-- to_date ('char', 'format') : 날짜 형식으로 변환
-- to_date (number, 'format') 
-- 오류 발생 : date - char 
select sysdate , sysdate - '20000101'
from dual

--2000년 1월 1일에서 오늘까지의 일수
select sysdate, trunc(sysdate - to_date(20000101, 'YYYYMMDD'))
from dual


select sysdate, to_date ('02/10/10','YY/MM/DD') ,trunc (sysdate - to_date( '021010', 'YYMMDD' )) as 날짜의차
from dual

select hiredate 
from employee;

select ename, hiredate 
from employee
where hiredate = '81/02/22'

select ename, hiredate 
from employee
where hiredate = to_date (19810222, 'YYYYMMDD')

select ename, hiredate
from employee
where hiredate = '1981-02-22';

select ename, hiredate
from employee
where hiredate = to_date('1981-02-22', 'YYYY-MM-DD') ;

--2000년 12월 25일부터 오늘까지 총 몇달이 지났는지 출력
select trunc (months_between (sysdate , to_date('2000/12/25', 'YYYY/MM/DD'))) as 달의차
from dual;

--to_number : number 데이터 타입으로 변환 
select 100000 - 50000
from dual

--오류 발생 : 문자열 - 문자열
select '100,000' - '50,000' 
from dual;

select to_number('100,000', '999,999') - to_number ('50,000', '999,999')
from dual

--NVL 함수 : null을 다른 값으로 치환해주는 함수 
    -- nvl(expr1, expr2) : expr1 에서 null 을 expr2 로 치환
    
select commission 
from employee;

select commission, NVL ( commission, 0 )
from employee;

select manager 
from employee;

select manager, NVL ( manager, 1111 )
from employee;

-- NVL2 함수
    -- nvl2(expr1, expr2, expr3) : expr1 이 null 이 아니면 expr2 를 출력, expr1이 null 이면 expr3를 출력
    
select salary, commission
from employee

-- NVL 함수로 연봉 계산하기
select salary, salary*12, commission, nvl (commision, 0),
        salary * 12 + commission as 연봉
from employee;

-- NVL2 함수를 사용해서 연봉 계산 하기
select salary, commission, NVL2(commission, salary*12+commission, salary*12) as 연봉
from employee;

-- nullif : 두 표현식을 비교해서 동일한 경우 null 을 반환하고 동일하지 않는 경우 첫번째 표현식을 반환
    -- nullif (expr1, expr2) : 
select nullif ('A', 'A'), nullif('A', 'B')
from dual;

-- coalesce 함수 
coalesce (expr1, expr2, expr3.....expr-n) : 
    -- expr1 이 null 이 아니면 expr1 을 반환하고 
    -- expr1 이 null 이고 expr2 가 null 이 아니면 expr2를 반환하고 
    -- expr1 이 null 이고 expr2가 null 이고 expr3가 null이 아니면 expr3를 반환 한다.

select coalesce ('abc', 'bcd', 'def', 'efg', 'fgi')
from dual;

select coalesce (null, 'bcd', 'def', 'efg', 'fgi')
from dual;

select coalesce (null, null, 'def', 'efg', 'fgi')
from dual;

select coalesce (null, null, null, 'efg', 'fgi')
from dual;

select ename, salary, commission, coalesce (commission, salary, 0)
from employee;

-- decode 함수 : switch case 문과 동일한 구문  
/*
    DECODE ( 표현식, 조건1, 결과1, 
                    조건2, 결과2,
                    조건3, 결과3,
                    기본결과n
             )       
*/

select ename, dno, decode (dno, 10, 'ACCONTING',
                                20, 'RESEARCH',
                                30, 'SALES',
                                40, 'OPERATIONS',
                                'DEFAULT') as DNAME
from employee;                               


--dno 컬럼이 10번 부서일 경우 월급에서 +300 을 처리하고, 20 번 부서일 경우 월급에 +500 을
--부서 번호가 30일 경우 월급에 + 700 을 해서 이름, 월급, 부서별 월급 + 한 결과 출력

select ename, salary, decode (dno, 10, salary+300,
                                   20, salary+500,
                                   30, salary+700,
                               ) as "부서별 플러스 월급"
from employee                               
order by dno asc;

-- case : if ~ else if, else if 
    /*
        case 표현식 WHEN 조건1 THEN 결과1
                   WHEN 조건2 THEN 결과2
                   WHEN 조건3 THEN 결과3
                   ELSE 결과n
         END          
    */

select ename, dno, case when dno=10 then 'ACCOUNTING'
                        when dno=20 then 'RESEARCH'
                        when dno=30 then 'SALES'
                        ELSE 'DEFAULT'
                    END as 부서명
from employee
order by dno asc;



--1. SUBSTR 함수를 사용하여 사원들의 입사한 년도와 입사한 달만 출력 하시오. 
select substr (hiredate, 1, 5) 
from employee;

--2. SUBSTR 함수를 사용하여 4월에 입사한 사원을 출력 하시오. 
select ename, hiredate
from employee
where substr (hiredate, 4, 2) ='04';

--3. MOD 함수를 사용하여 직속상관이 홀수인 사원만 출력하시오. 
select * from employee
where mod(manager,2) = 1;

--3-1. MOD 함수를 사용하여 월급이 3의 배수인 사원들만 출력하세요.
select * from employee
where mod(salary, 3) = 0;

--4. 입사한 년도는 2자리 (YY), 월은 (MON)로 표시하고 요일은 약어 (DY)로 지정하여 출력 하시오. 
select to_char(hiredate, 'YY MON DY') as 입사연도
from employee;

--5. 올해 몇 일이 지났는지 출력 하시오. 현재 날짜에서 올해 1월 1일을 뺀 결과를 출력하고 TO_DATE 함수를 사용하여
--   데이터 형식을 일치 시키시오. 
select sysdate, trunc(sysdate - to_date('22/01/01', 'YY/MM/DD'))
from dual;

--5-1. 자신이 태어난 날짜에서 현재까지 몇 일이 지났는지 출력 하세요. 
select sysdate, trunc(sysdate - to_date(19970321, 'YYYYMMDD'))
from dual;

--5-2. 자신이 태어난 날짜에서 현재까지 몇 개월이 지났는지 출력 하세요.
select trunc (months_between (sysdate, (to_date('1997/03/21', 'YYYY/MM/DD'))))
from dual;

--6. 사원들의 상관 사번을 출력하되 상관이 없는 사원에 대해서는 null 갑대신 0으로 출력 하시오. 
select ename, manager, nvl (manager , 0)
from employee;

--7.  DECODE 함수로 직급에 따라 급여를 인상하도록 하시오. 직급이 'ANAIYST' 사원은 200 , 'SALESMAN' 사원은 180,
    'MANAGER'인 사원은 150, 'CLERK'인 사원은 100을 인상하시오. 
    select ename, job, salary, decode (job, 'ANALYST', salary+200,
                                            'SALESMAN', salary+180,
                                             'MANAGER', salary+150,
                                             'CLERK', salary+100,
                                             'DEFAULT') as 인상된급여
   from employee;

--8. 사원번호, 
--[사원번호 2자리만 출력 나머지는 * 가림] as "가린번호", 
--이름, 
--[이름의 첫자만 출력 총 4자리, 3자리는 *로 가림] as "가린이름"
select eno, substr(eno, 1, 2 )
from employee

select employee_id, concat(substr(employee_id, 1, 2),    ), first_name, concat(substr(first_name, 1, 4), lpad(first_name, 5, 3)
from employees

-- 9. 주민번호를 출력하되 801210-1****** 출력 하도록, 전화번호 : 010-11******  dual 테이블 사용



/* 10. 사원번호, 사원명, 직속상관, 
    [직속상관의 사원번호가 없을 경우 : 0000
     직속상관의 사원번호 앞 두 자리가 75일 경우 : 5555
     직속상관의 사원번호 앞 두 자리가 76일 경우 : 6666
     직속상관의 사원번호 앞 두 자리가 77일 경우 : 7777
     직속상관의 사원번호 앞 두 자리가 78일 경우 : 8888
     
*/





    

