-- 5일차 서브쿼리

-- Sub Query : Select 문 내에 Select 문이 있는 쿼리
    -- where 조건절  : SUB QUERY 
    -- having 조건절 : SUB QUERY

select first_name, salary from employees
select salary from employees where ename ='SCOTT';
--select salary from employees where first_name ='Steven';

-- SCOTT 의 월급 보다 같거나 많은 사용자를 출력하라. (서브 쿼리)
select ename, salary from employee where salary >= 3000

select ename, salary 
from employee 
where salary >= (select salary from employee where ename = 'SCOTT')
--select first_name, salary from employees where salary >= 3000

-- SCOTT 과 동일한 부서에 근무하는 사원들 출력하기 (sub query)
select ename, dno
from employee
where dno = (select dno from employee where ename = 'SCOTT' ) 

-- 최소 급여를 받는 사원의 이름, 담당업무, 급여 출력하기 (sub query)
select ename, job, salary
from employee
where salary = (select min(salary) from employee ) 

select * from employees
select first_name, job_id, salary
from employees
where salary = (select min(salary) from employees ) 

 
-- 30번 부서(dno)에서 최소 월급을 받는 사원보다 많은 사원들 이름과 부서번호와 월급을 출력 하기

select dno, salary from employee where dno = 30
select min(salary) from employee where dno = 30

select ename, dno, salary
from employee
where salary > (select min(salary) from employee where dno = 30) 

select first_name, job_id, salary
from employees
where salary > (select min(salary) from employees where job_id = 'AD_VP') 

-- Having 절에 Sub query 사용하기

-- 30번 부서의 최소 월급 보다 큰 각 부서의 최소 월급
select dno, min(salary), count(dno)
from employee
group by dno
having min(salary) > (select min(salary) from employee where dno = 30);

select job_id, min(salary), count(job_id)
from employees
group by job_id
having min(salary) > (select min(salary) from employees where job_id = 'AD_VP');

-- 단일행 서브 쿼리 : sub query 의 결과 값이 단 하나면 출력
         -- 단일행 비교 연산자 : > , = , >= , < , <=, <>, <=
         
-- 다중행 서브 쿼리 : sub query 의 결과 값이 여러개 출력
         -- 다중행 서브 쿼리 연산자 : IN, ANY, SOME, ALL, EXISTS
                -- IN : 메인 쿼리의 비교 조건 ( '=' 연산자로 비교할 경우 ) 이 서브 쿼리의 결과값 중에 하나라도 일치하면 참
                -- ANY, SOME : 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와 하나 이상 일치하면 참
                -- ALL : 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와 모든 값이 일치하면 참
                -- EXISTS : 메인 쿼리의 비교 조건이 서브 쿼리의 결과 값 중에서 만족하는 값이 하나라도 존재하면 참
                
-- IN 연산자 사용하기
select ename, eno, dno, salary 
from employee
order by dno asc

-- 부서별로 최소 월급을 받는 사용자들 출력하기 (sub query 를 반드시 사용하시오)
select dno, min(salary), count(*)
from employee
group by dno

select ename, dno, salary
from employee
where salary in (950, 800, 1300)
    
    -- 서브 쿼리 사용
select ename, dno, salary
from employee
where salary in ( select min(salary) from employee group by dno);

-- ANY 연산자 사용
    -- 서브 쿼리가 반환하는 각각의 값과 비교함
    -- ' < any ' 는 최대값 보다 작음을 나타냄
    -- ' > any ' 는 최소값 보다 큼을 나타냄
    -- ' = ang ' 는 IN 과 동일함
    
-- 예) 직급이 SALESMAN 이 아니면서 급여가 임의의 SALESMAN 보다 작은 사원을 출력
                -- 1600 (최대값) 보다 작은 모든 사언(SALESMAN)이 아님    
select eno, ename, salary, job 
from employee
where salary < any (select salary from employee where job = 'SALESMAN')
               and job <> 'SALESMAN'                  

select ename, job, salary from employee order by job;

-- ALL 연산자
    -- sub query 의 반환한는 모든 값과 비교
    -- ' > all ' 는 최대값 보다 큼을 나타냄
    -- ' < all ' 는 최소값 보다 작음을 나타냄
    
    -- 예) 직급이 'SALESMAN' 아니면서 SALESMAN 인 사원 보다 급여가 적은 사원을 모두 출력
                -- 1250 (최소값) 보다 작은 사원 (직급은 SALESMAN 이 아님)
select eno, ename, job, salary 
from employee
where salary < all (select salary
                    from employee
                    where job = 'SALESMAN'
                    and job <> 'SALESMAN')

select employee_id, first_name, job_id, salary 
from employees
where salary < all (select salary
                    from employees
                    where job_id = 'AD_PRES'
                    and job_id <> 'AD_PRES')

-- 담당 업무가 분석가(ANALYST)인 사원보다 급여가 적으면서 업무가 분석가가 아닌 사원들을 출력
select eno, ename, salary, job
from employee
where salary < all (select salary from employee where job = 'ANALYST')
               and job <> 'ANALYST';


-- 급여가 평균 급여 보다 많은 사원들의 사원번호와 이름을 표시 하되 결과 급여에 대해서 오름차순 정렬하시오.
select eno, eanme, salary
from employee
where salary > (select avg(salary) 
                    from employee)
order by salary asc;                   



7. SELF JOIN을 사용하여 사원의 이름 및 사원번호를 관리자 이름 및 관리자 번호와 함께 출력 하시오. 
 	각열에 별칭값을 한글로 넣으시오. 
select e.ename as "사원이름", e.eno as "사원번호", e.manager as "관리자번호", m.ename as "관리자이름"
from employee e, employee m
on e.manager = m.eno

8. OUTER JOIN, SELF JOIN을 사용하여 관리자가 없는 사원을 포함하여 사원번호를 기준으로 내림차순 정렬하여 출력 하시오. 
select e.ename, e.eno, m.ename
from employee e join employee m
on e.manager = m.eno (+)
order by e.eno desc;

9. SELF JOIN을 사용하여 지정한 사원('SCOTT')의 이름, 부서번호, 지정한 사원과 동일한 부서에서 근무하는 사원을 출력하시오. 
   단, 각 열의 별칭은 이름, 부서번호, 동료로 하시오. 
select e.ename 이름 , e.dno 부서번호, m.ename 동료
from employee e, employee m
where e.eno = m.dno 
and e.ename = 'SCOTT'


10. SELF JOIN을 사용하여 WARD 사원보다 늦게 입사한 사원의 이름과 입사일을 출력하시오. 
select m.ename, m.hiredate
from employees e, employees m
where e.hiredate < m.hiredate
and e.ename='WARD'


11. SELF JOIN을 사용하여 관리자 보다 먼저 입사한 모든 사원의 이름 및 입사일을 관리자 이름 및 입사일과 함께 출력하시오. 
    단, 각 열의 별칭을 한글로 넣어서 출력 하시오. 
select e.ename as 사원이름, e.hiredate as 입사날짜, m.ename as 관리자, m. as 관리자입사일
from employee e, employee m
where e.hiredate < m.hiredate
and e.manager = m.eno

<<아래 문제는 모두 Subquery를 사용하여 문제를 푸세요.>>

1. 사원번호가 7788인 사원과 담당 업무가 같은 사원을 표시(사원이름 과 담당업무) 하시오.  
select ename, job
from employee
where job = (select job from employee where eno = 7788);

2. 사원번호가 7499인 사원보다 급여가 많은 사원을 표시 (사원이름 과 담당업무) 하시오. 
select ename, job
from employee
where salary > (select salary from employee where eno = 7499);

3. 최소 급여를 받는 직급별로 사원의 이름, 담당 업무 및 급여를 표시 하시오(그룹 함수 사용)
select ename, job, salary
from employee
where salary = (select min(salary) from employee);

4. 직급에서 평균 급여를 구하고, 가장 작은 직급 평균을 가진 사원 중 급여가 가장 작은 사원의 직급과 급여를 표시하시오.
select job, avg(salary)
from employee
group by job
having avg(salalry) = (select min(avg(salary)) from employee group by job);

5. 각 부서의 최소 급여를 받는 사원의 이름, 급여, 부서번호를 표시하시오.
select ename, salary, dno
from employee
where min(salary) in (select min(salary) from employee group by dno)  


6. 담당 업무가 분석가(ANALYST) 인 사원보다 급여가 적으면서 업무가 분석가가 아닌 사원들을 표시 (사원번호, 이름, 담당업무, 급여) 하시오.
select eno, ename, job, salary
from employee
where salary < any (select salary from employee where job = 'ANALYST')
                and job <> 'ANALYST';

7. 부하직원이 없는 사원의 이름을 표시 하시오. 
select ename
from employee
where eno no in (select manager from employee where manager is not null) 

8. 부하직원이 있는 사원의 이름을 표시 하시오. 
select ename
from employee
where eno in (select manager from employee where manager is not null) 

9. BLAKE 와 동일한 부서에 속한 사원의 이름과 입사일을 표시하는 질의를 작성하시오(단, BLAKE 는 제외). 
select ename, hiredate
from employee
where dno = (select dno from employee where ename = 'BLAKE')
              and ename <> 'BLAKE';

10. 급여가 평균보다 많은 사원들의 사원번호와 이름을 표시하되 결과를 급여에 대해서 오름 차순으로 정렬 하시오. 
select eno, ename, salary
from employee
where salary > (select round(avg(salary)) from employee)
order by salary;

11. 이름에 K 가 포함된 사원과 같은 부서에서 일하는 사원의 사원번호와 이름을 표시하는 질의를 작성하시오. 
select eno, ename
from employee
where dno in (select dno from employee where ename like '%K%');

--12. 부서 위치가 DALLAS 인 사원의 이름과 부서 번호 및 담당 업무를 표시하시오. 
select ename, dno, job
from employee
where dno  = (select dno from department where loc ='DALLAS' );

13. KING에게 보고하는 사원의 이름과 급여를 표시하시오. 
select ename, salary
from employee
where manager = (select eno from employee where ename = 'KING')

14. RESEARCH 부서(department 테이블)의 사원에 대한 부서번호, 사원이름 및 담당 업무를 표시 하시오. 
select dno, ename, job
from employee
where dno = (select dno from department where dname = 'RESEARCH');

15. 평균 급여보다 많은 급여를 받고 이름에 M이 포함된 사원과 같은 부서에서 근무하는 사원의 사원번호, 이름, 급여를 표시하시오. 
select eno, ename, salary
from employee
where salary > (select avg(sal) from employee)
                and select eno in (select dno from employee where ename like '%M%'); 

16. 평균 급여가 가장 적은 업무를 찾으시오. 
select job, avg(salary)
from employee
group by job
having avg(salary) = (select min(avg(salary)) from employee group by job);

17. 담당업무가 MANAGER인 사원이 소속된 부서와 동일한 부서의 사원을 표시하시오. 
selec ename
from employee
where dno = (select dno from employee wherer job = 'MANAGER');


