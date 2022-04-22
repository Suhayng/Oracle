1. 덧셈 연산자를 사용하여 모든 사원에 대해서 $300의 급여 인상을 계산한후 사원이름, 급여, 인상된 급여를 출력하세요. 
desc employee; 

select * 
from employee; 

select eno as 사원번호, ename 사원명, job 직책, manager "직속상관  ID",
    hiredate 입사날짜, salary 월급, commission 보너스, dno 부서번호
from employee; 

select ename, salary, salary + 300 as 인상된급여
from employee; 

2. 사원의 이름, 급여, 연간 총 수입이 많은것 부터 작은순으로 출력 하시오. 
    연간 총 수입은 월급에 12를 곱한후 $100의 상여금을 더해서 계산 하시오. 
    
    select ename, salary, commission from employee; 
    
    select ename, salary,commission,salary *12, salary *12 + NVL(commission,0) + 100 as 총연봉
    from employee;   
     
3. 급여가 2000을 넘는 사원의 이름과 급여를 급여가 많은것 부터 작은순으로 출력하세요. 

desc employee;

select ename, salary    -- 컬럼명
from employee           -- 테이블, 뷰
where salary >= 2000    -- 조건
order by salary desc    -- 정렬 

4. 사원번호가 7788인 사원의 이름과 부서번호를 출력하세요. 
select ename, dno ,eno
from employee
where eno = 7788



5. 급여가 2000에서 3000사이에 포함되지 않는 사원의 이름과 급여를 출력 하세요. 
select ename, salary 
from employee
where salary not between 2000 and 3000; 

6. 1981년 2월 20일부터 81년 5월 1일 사이의 입사한 사원의 이름 담당업무, 입사일을 출력하시오

select ename, job, hiredate
from employee
where hiredate between '1981/2/20' and '1981/5/1'; 

7. 부서번호가 20및 30에 속한 사원의 이름과 부서번호를 출력하되 이름을 기준(내림차순)으로 출력하시오. 
select ename, dno 
from employee
where dno = 20 or dno = 30 
order by ename asc; 

select ename, dno 
from employee
where dno in ( 20, 30 )
order by ename asc; 

8. 사원의 급여가 2000에서 3000사이에 포함되고 부서번호가 20 또는 30인 사원의 이름, 급여와 부서번호를 출력하되 이름을 오름차순으로 출력하세요. 
select ename, salary, dno 
from employee
where (salary between 2000 and 3000) and (dno in (20,30)) 

9. 1981년도 입사한 사원의 이름과 입사일을 출력 하시오 ( like 연산자와 와일드 카드 사용)
select ename, hiredate 
from employee 
where hiredate like '81%';


10. 관리자가 없는 사원의 이름과 담당업무를 출력하세요.
select * from employee; 

select ename, manager
from employee
where manager is null ; 


11. 커밋션을 받을 수 있는 자격이 되는 사원의 이름, 급여, 커미션을 출력하되 급여및 커밋션을 기준으로 내림차순 정렬하여 표시하시오. 
select * from employee
order by commission desc; 

select ename, salary, commission 
from employee
where commission is not null
order by salary asc, commission asc

12. 이름이 세번째 문자인 R인 사원의 이름을 표시하시오.
select ename 
from employee
where ename like '__R%' 

13. 이름에 A 와 E 를 모두 포함하고 있는 사원의 이름을 표시하시오.
select ename 
from employee
where ename like '%A%' and ename like '%E%'

14. 담당 업무가 사무원(CLERK) 또는 영업사원(SALESMAN)이며서 
    급여가 $1600, $950, 또는 $1300 이 아닌 사원의 이름, 담당업무, 급여를 출력하시오.

select ename, job, salary 
from employee
where (job = 'CLERK' or job = 'SALESMAN') and salary not in ( 1600,950, 1300) 
    
15. 커미션이 $500이상인 사원의 이름과 급여 및 커미션을 출력하시오.  
select ename, salary ,commission
from employee
where commission >= 500; 

-- 숫자 함수  
/*
    ROUND :  특정 자릿수에서 반올림. 
    TRUNC :  특정 자릿수에서 잘라낸다. (버린다)
    MOD   :  입력 받은 수를 나눈 나머지 값만 출력
*/

-- round ( 대상 ) : 소숫점 뒷자리에서 반올림 
-- round (대상 , 소숫점자릿수)  :  
    -- 소숫점 잘릿수 : 양수 일때 소숫점 오른쪽으로 자릿수만큼 이동해서 그 자릿수 뒤에서 반올림. <==주의  
    -- 소숫점 자릿수 : 음수 일때 소숫점 왼쪽으로 자릿수만클 이동하고 그 자릿수 에서 반올림.
        -- 정수를 반올림
        -- 소숫점 자리는 모두 버림 
select 98.7654 , ROUND (98.7654), round (98.7654, 2) , round (98.7654, -1), round (98.7654, -2)
   ,  round (98.7654 , -3), round (98.7654, 3) 
from dual

select 12345.6789, round (12345.6789), round (12345.6789, -3), round  (123678.123456, -3)
from dual;

select 98.7654 , TRUNC (98.7654), TRUNC (98.7654, 2) , TRUNC (98.7654, -1 ) 
from dual 

-- mod (대상, 나누는수) : 대상을 나누어서 나머지만 출력 

select mod (31,2), mod (31, 5), mod (31, 8)
from dual

select * from employee; 

select salary , mod (salary, 300) 
from employee; 

--employee 테이블에서 사원번호가 짝수인 사원들만 출력. (MOD 함수를 사용)
select * 
from employee 
where MOD ( eno , 2) = 0 ; 

/* 날짜 함수 
    sysdate : 시스템에 저장된 현재 날짜를 출력. 
    months_between : 두 날짜 사이의 몇 개월인지를 반환 
    add_months : 특정 날짜에 개월수를 더한다. 
    next_day : 특정 날짜에서 최초로 도래하는 인자로 받은 요일의 날짜를 반환. 
    last_day : 달의 마지막 날짜를 반환 
    round   : 인자로 받은 날짜를 특정 기준으로 반올림. 
    trunc   : 인자로 받은 날짜를 특정 기준으로 버림 .
*/

-- 자신의 시스템의 날짜 출력. 
select sysdate 
from dual; 

select sysdate -1 as 어제날짜, sysdate as 오늘날짜, sysdate + 1 내일날짜 
from dual; 

select * from employee
order by hiredate asc ; 

select hiredate , hiredate - 1 , hiredate + 10 
from employee; 

desc employee

-- 입사일에서 부터 현재까지의 근무일수를 출력  
select Round (sysdate - hiredate) as "총 근무 일수"   
from employee;

select Round ((sysdate - hiredate),2) as "총 근무 일수"   
from employee;

select trunc (sysdate - hiredate) as "총 근무 일수"   
from employee;

-- 특정 날짜에서 월(Month)을 기준으로 버림한 날짜 구하기 

select hiredate, trunc (hiredate, 'MONTH') 
from employee; 

-- 특정 날짜에서 월(Month)을 기준으로 반올림한  날짜 구하기 : 16일 이상일 경우 반올림. 
select hiredate, round (hiredate, 'MONTH') 
from employee; 

-- months_between(date1, date2) : date1과 date2 사이의 개월수를 출력. 

-- 입사일에서 현재까지 각 사원들의 근무한 개월 수 구하기  
select ename, sysdate, hiredate , months_between (sysdate,hiredate) as "근무 개월수"
from employee; 

select ename, sysdate, hiredate , trunc (months_between (sysdate,hiredate)) as "근무 개월수"
from employee; 


--add_months ( date1, 개월수) : date1 날짜에 개월수를 더한 날짜를 출력. 

-- 입사한후 6개월이 지난 시점을 출력. 
select hiredate, add_months (hiredate , 6) 
from employee;

-- 입사한 후 100일이 지난 시점의 날짜. 
select hiredate, hiredate + 100 as "입사후100일 날짜"
from employee;

--next_day (date, '요일') : date 의 도래하는 요일에 대한 날짜를 출력 하는 함수 

select sysdate, next_day (sysdate,'토요일') as "이번주의 토요일의 날짜"
from dual; 

-- last_day (date) : date 에 들어간 달의 마지막 날짜. 

select hiredate , last_day (hiredate) 
from employee; 

-- 형 변환 함수    <== 중요. 
/*
    TO_CHAR  : 날짜형 또는 숫자형 을 문자형으로 변환하는 함수 
    TO_DATE  : 문자형을 날짜형으로 변환 하는 함수 
    TO_NUMBER : 문자형을 숫자형으로 변환하는 함수 . 
*/

--날짜 함수 사용하기 
--TO_CHAR (date, 'YYYYMMDD')
select ename, hiredate , to_char(hiredate, 'YYYYMMDD'), to_char (hiredate, 'YYMM'),
    to_char (hiredate, 'YYYYMMDD DAY'), to_char(hiredate, 'YYYYMMDD DY')
from employee; 

--현재 시스템의 오늘 날짜를 출력하고 시간 초까지 출력.

select sysdate , to_char( sysdate, 'YYYY-MM-DD HH:MI:SS DY')
from dual; 

desc employee; 

select hiredate , to_char (hiredate , 'YYYY-MM-DD HH:MI:SS DY')
from employee;

--to_char 에서  숫자와 관련된 형식 
/*
    0 : 자릿수를 나타내며 자릿수가 맞지 않을 경우 0으로 채움니다. 
    9 : 자릿수를 나타내며 자릿수가 맞지 않을 채우지 않습니다. 
    L : 각 지역별 통화 기호를 출력
    . : 소숫점으로 표현 
    , : 천단위의 구분자 
*/ 
desc employee; 

select ename , salary, to_char(salary, 'L999,999'), to_char (salary, 'L0000,000')
from employee;

-- to_date ('char', 'format') : 날짜형식으로 변환. 
-- to_date (number, 'format') : 날짜형식으로 변환.

--오류 발생 : date - char 
select sysdate , sysdate - '20000101'
from dual 

--2000년 1월 1일에서 오늘까지의 일수 
select sysdate, trunc (sysdate - to_date(20000101, 'YYYYMMDD') )
from dual

select sysdate, to_date ('02/10/10', 'YY/MM/DD') ,trunc (sysdate - to_date ('021010', 'YYMMDD')) as 날짜의차
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
where hiredate = to_date ('1981-02-22' , 'YYYY-MM-DD') 

--2000년 12월 25일부터 오늘까지 총 몇 달이 지났는지 출력.
select trunc (months_between (sysdate , to_date('2000/12/25', 'YYYY/MM/DD'))) as 달의차
from dual 

-- to_number  : number 데이터 타입으로 변환  ,
select 100000 - 50000
from dual

--오류 발생 : 문자열 - 문자열 
select '100,000' - '50,000' 
from dual 

select to_number('100,000', '999,999') - to_number ('50,000', '999,999')
from dual

--NVL 함수 : null을 다른 값으로 치환 해주는 함수 
  -- nvl(expr1, expr2) : expr1 에서  null 을  expr2  로 치환 
  
select commission 
from employee; 

select commission, NVL ( commission, 0) 
from employee

select manager 
from employee;

select manager, NVL ( manager, 1111)
from employee;

-- NVL2 함수
  -- nvl2(expr1, expr2, expr3) : expr1 이 null이 아니면 expr2 를 출력, expr1이 null이면 expr3를 출력. 
 
 select salary, commission 
 from employee
 
--NVL 함수로 연봉 계산하기 
select salary, salary *12, commission, nvl (commission, 0), 
    salary * 12 + nvl(commission,0) as 연봉 
from employee; 

-- NVL2 함수를 사용해서 연봉 계산 하기 
select salary, commission, NVL2( commission , salary*12+commission, salary*12) as 연봉
from employee; 

-- nullif  : 두 표현식을 비교해서  동일한 경우   Null 을 반환하고 동일하지 않는 경우 첫번째 표현식을 반환. 
   -- nullif (expr1, expr2) :  
select nullif ('A', 'A'), nullif ('A', 'B') 
from dual

--coalesce  함수 
coalesce (expr1, expr2, expr3.....expr-n)  : 
    -- expr1  이  null  이아니면  expr1  을 반환하고,  
    -- expr1 이   null 이고  expr2 가   null이아니면  expr2를 반환 하고
    -- expr1 이  null 이고  expr2가 null 이고 expr3가 null이 아니면 expr3를 반환 한다. .....
    
 select coalesce ('abc','bcd','def','efg','fgi')
 from dual;
 
  select coalesce (null,'bcd','def','efg','fgi')
 from dual;
 
    select coalesce (null,null,'def','efg','fgi')
 from dual;  
 
select coalesce (null,null,null,'efg','fgi')
 from dual;
 
 select ename, salary,commission, coalesce (commission,salary,0) 
 from employee; 
 
 --decode 함수  : switch case  문과 동일한 구문  
 /*
    DECODE ( 표현식, 조건1, 결과1,
                    조건2, 결과2, 
                    조건3, 결과3,
                    기본결과n
            )
 */
 
 select ename, dno, decode (dno, 10, 'ACCOUNTING',
                                 20, 'RESEARCH',
                                 30, 'SALES',
                                 40, 'OPERATIONS',
                                 'DEFAULT') as  DNAME
from employee;

--완료시간 : 4:50분까지
-- dno컬럼이 10번 부서일 경우 월급에서 + 300을 처리 하고, 20 번 부서일 경우 월급에 +500 을 
--    부서번호가 30일 경우 월급에 + 700을 해서 이름, 월급, 부서별월급플러스 한 결과를 출력.
select ename, salary, dno , decode (dno , 10 , salary  + 300,
                                          20, salary + 500, 
                                          30, salary + 700)
                                          as "부서별월급플러스결과" 
from employee 
order by dno asc; 
    

 select * from employee; 
 
 -- case :  if ~ else if, else if ~~~
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
order by dno 
 
 
 
 다양한 함수를 사용하여 아래의 내용을 풀이 하시오. 

완료시간 : 6: 10분까지 . p.jangwoo@gmail.com, 조장님들에게도 전송. 

1. SUBSTR 함수를 사용하여 사원들의 입사한 년도와 입사한 달만 출력 하시오. 
select * from employee; 
select substr ( hiredate, 1,5 ) as 년월 
from employee; 

2. SUBSTR 함수를 사용하여 4월에 입사한 사원을 출력 하시오.
select ename, hiredate 
from employee
where  substr (hiredate, 4, 2)  = 04; 

3. MOD 함수를 사용하여 직속상관이 홀수인 사원만 출력하시오. 
select ename, manager 
from employee
where MOD (manager , 2) = 1; 

3-1. MOD 함수를 사용하여 월급이 3의 배수인 사원들만 출력하세요.

select ename, salary 
from employee
where MOD ( salary , 3) = 0 ; 

4. 입사한 년도는 2자리 (YY), 월은 (MON)로 표시하고 요일은 약어 (DY)로 지정하여 출력 하시오. 
select hiredate , to_char ( hiredate, 'YY MON DD DY') as 출력결과 
from employee; 

5. 올해 몇 일이 지났는지 출력 하시오. 현재 날짜에서 올해 1월 1일을 뺀 결과를 출력하고 TO_DATE 함수를 사용하여
   데이터 형식을 일치 시키시오.
  select trunc (sysdate - to_date ( 20220101 , 'YYYYMMDD')) as 올해날짜수 from dual  
   

5-1. 자신이 태어난 날짜에서 현재까지 몇 일이 지났는지 출력 하세요. 
 select trunc (sysdate - to_date ( 19800101 , 'YYYYMMDD')) as 총날짜수 from dual  

5-2. 자신이 태어난 날짜에서 현재까지 몇 개월이 지났는지 출력 하세요.
select trunc( months_between (sysdate , to_date ( 19800101 , 'YYYYMMDD'))) as 총개월수 from dual  

6. 사원들의 상관 사번을 출력하되 상관이 없는 사원에 대해서는 null 갑대신 0으로 출력 하시오.
select ename, manager , nvl (manager, 0), nvl2 (manager, manager,0)
from employee; 


7.  DECODE 함수로 직급에 따라 급여를 인상하도록 하시오. 직급이 'ANALYST' 사원은 200 , 'SALESMAN' 사원은 180,
    'MANAGER'인 사원은 150, 'CLERK'인 사원은 100을 인상하시오. 
 
 select ename, job, salary, decode ( job, 'ANANYST', salary + 200, 
                                           'SALESMAN' , salary + 180, 
                                           'MANAGER' , salary + 150, 
                                           'CLERK' , salary + 100
                                           ) as 인상된급여
 from employee; 
 
 select distinct job 
 from employee
 
    
================= 추가문제 ====================
8.   사원번호,
      [사원번호 2자리만출력 나머지는 *가림 ] as "가린번호", 
      이름, 
       [이름의 첫자만 출력 총 네자리, 세자리는 * 가림] as "가린이름"
       
    select eno, rpad (substr (eno , 1 ,2) , length(eno), '*')  as 가린번호 ,  
    ename, rpad ( substr (ename, 1,1), 4,'*')
    from employee;
    
        select eno, rpad (substr (eno , 1 ,2) , length(eno), '*')  as 가린번호 ,  
    ename, rpad ( substr (ename, 1,1), length (ename),'*')
    from employee;
      
    select ename, length(ename)
    from employee; 
       
9.  주민번호:   를 출력하되 801210-1*******   출력 하도록 , 전화 번호 : 010-12*******
	dual 테이블 사용
    
    select  RPAD (substr ('801210-1234578', 1,8) , length ('801210-1234578'), '*') as 주민번호,
            RPAD ( substr ('010-1234-5678', 1,6), length ('010-1234-5678'), '*') as 전화번호
    from dual 
    

10. 사원번호, 사원명, 직속상관, 
	[직속상관의 사원번호가 없을 경우 : 0000
	 직속상관의 사원번호가  앞 2자리가 75일 경우 : 5555
	직속상관의 사원번호가  앞 2자리가 76일 경우 : 6666
	직속상관의 사원번호가  앞 2자리가 77일 경우 : 7777
	직속상관의 사원번호가  앞 2자리가 78일 경우 : 8888
	그외는 그대로 출력. ] 
    select eno, ename, manager, case when manager is null then '0000'
                                     when substr(manager,1,2) = 75 then '5555'
                                     when substr(manager,1,2) = 76 then '6666'
                                     when substr(manager,1,2) = 77 then '7777'
                                     when substr(manager,1,2) = 78 then '8888'
                                     else to_char (manager, '9999')
                                end as 직속상관처리 
    from employee; 

 
 






































