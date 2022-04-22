-- 4일차 
/*
   그룹 함수 : 동일한 값에 대해서 그룹핑해서 처리하는 함수 
        group by 절에 특정 컬럼을 정의 할 경우, 해당 컬럼의 동일한 값들을 그룹핑해서 연산을 적용. 
        
    집계함수 : 
        - SUM : 그룹의 합계
        - AVG : 그룹의 평균
        - MAX : 그룹의 최대값
        - MIN : 그룹의 최소값 
        - COUNT : 그룹의 총 개수 (레코드수 record ,로우수 row )
*/

select sum (salary), round (avg (salary),2), max (salary), min (salary) 
from employee; 

--주의 :  집계 함수를 처리 할때, 출력컬럼이 단일 값으로 나오는 컬럼을 정의  

select sum (salary) 
from employee; 

select ename
from employee; 

select * from employee; 

-- 집계함수는 null 값을 처리해서 연산한다. 
select sum (commission), avg(commission), max (commission), min(commission)
from employee; 

-- count () : 레코드 수, 로우 수
    -- NULL 은 처리되지 않는다. 
    -- 테이블의 전체 레코드 수를 가져올 경우 : count(*) 또는 NOT NULL 컬럼을 count() 

desc employee; 
    

select eno from employee; 
select count (eno) from employee;

select commission from employee; 
select count(commission) from employee; 

select count (*) from employee; 
select * from employee; 

--전체 레코드 카운트 
select count(*) from employee; 
select count(eno) from employee; 

-- 중복되지 않는 직업의 갯수 (job)

select job from employee ; 

select count(distinct job) from employee; 

-- 부서의 갯수 (dno) 

select count ( distinct dno) from employee

-- Group by  : 특정 컬럼의 값을 그룹핑 한다. 주로 집계함수를 select 절에서 같이 사용합니다.  
/*
    select  컴럼명, 집계함수처리된컬럼
    from 테이블
    where 조건
    group by 컬럼명 
    having 조건 ( group by한 결과의 조건)
    oder by 정렬 

*/

-- 부서별 평균 급여. 
select dno as 부서번호 , avg(salary) as 평균급여
from employee
group by dno    -- dno 컬럼의 중복된것을 그룹핑 함. 


select dno from employee order by dno;

-- 전체 평균 급여. 
select avg (salary) as 평균급여
from employee;

-- group by를 사용하면서 select 절에 가져올 컬럼을 잘 지정해야 한다. 
select dno , count(dno), sum(salary) , avg(salary), max(commission), min(commission)
from employee
group by dno 

-- 
select job from employee

--동일한 직책을 그룹핑해서 월급의 평균, 합계, 최대값, 최소값을 출력. 
select job, count(job), avg(salary), sum(salary), max(salary), min(salary) 
from employee
group by job     --동일한 직책을 그룹핑해서 집계를 한다.

--여러 컬럼을 그룹핑 하기. 

select dno, job, count(*) ,sum (salary)
from employee
group by dno, job       -- 두 컬럼모두 일치하는 것을 그룹핑  

select dno, job 
from employee 
where dno = 20 and job = 'CLERK'; 

--having : group by 에서 나온 결과를 조건으로 처리 할때. 
   -- 별칭이름을 조건으로 사용하면 안된다. 
   

-- 부서별 월급의 합계가 9000 이상것만 출력. 
select dno , count(*), sum (salary) as 부서별합계 , round (avg(salary) , 2) as 부서별평균
from employee 
group by dno
having sum (salary) >9000 ; 

-- 부서별 월급의 평균이 2000 이상만 출력. 
select dno , count(*), sum (salary) as 부서별합계 , round (avg(salary) , 2) as 부서별평균
from employee 
group by dno
having round (avg(salary) , 2) > 2000.00 ; 

--where 와 having 절이 같이 사용되는 경우 
   -- where : 실제 테이블의 조건으로 검색
   -- having : group by 결과에 대해서 조건을 처리. 
   
select * from employee; 

-- 월급이 1500 이하는 제외하고 각 부서별로 월급의 평균을 구하되 월급의 평균이 2500이상인 것만 출력 하라. 

select dno, count(*) , round (avg (salary)) as 부서별평균
from employee
where salary > 1500
group by dno
having round (avg (salary)) > 2500 

-- ROLLUP 
-- CUBE 
   -- Group by 절에서 사용하는 특수한 함수 
   -- 여러 컬럼을 나열 할 수 있다. 
   -- group by 절의 자세한 정보를 출력...
   
--Rollup, cube를 사용하지 않는 경우
select dno ,  count(*), sum(salary), round(avg(salary))
from employee
group by  dno
order by dno 

-- Rollup  : 부서별 합계와 평균을 출력 후 , 막지막 라인에 전체 합계, 평균
select dno ,  count(*), sum(salary), round(avg(salary))
from employee
group by  rollup(dno)
order by dno

--cube  : 부서별 합계와 평균을 출력 후 , 막지막 라인에 전체 합계, 평균
select dno ,  count(*), sum(salary), round(avg(salary))
from employee
group by  cube(dno)
order by dno

-- Rollup : 두 컬럼이상
select dno, job, count(*), MAX(salary), SUM(salary), round(AVG(salary))
from employee
group by rollup (dno, job)   -- 두개의 컬럼이 적용됨, 두 컬럼에 걸쳐서 동일할때 그룹핑. 

select dno, job, count(*), MAX(salary), SUM(salary), round(AVG(salary))
from employee
group by dno, job 
order by dno asc

--cube
select dno, job, count(*), MAX(salary), SUM(salary), round(AVG(salary))
from employee
group by cube (dno, job)
order by dno, job


--JOIN : 여러 테이블을 합쳐서 각 테이블의 컬럼을 가져온다.  
   -- department 와 employee는 원래는 하나의 테이블이 었으나 모델링(중복제거, 성능향상)을 통해서 두 테이블을 분리
   -- 두 테이블의 공통키 컬럼 (dno) , employee 테이블의 dno 컬럼은 department 테이블의 dno 컬럼을 참조한다. 
   -- 두개 이상의 테이블의 컬럼을 JOIN구문 을 사용해서 출력. 
    
select * from department;   -- 부서정보를 저장 하는 테이블
select * from employee;     -- 사원정보를 저장하는 테이블


-- EQUI JOIN  : 오라클에서 제일 많이 사용하는 JOIN , Orale 에서만 사용가능 
    -- from 절 : 조인할 테이블을 ","로 처리,
    -- where 절 : 두 테이블의 공통의 키 컬럼을 " = " 로 처리 
         -- and 절   : 조건을 처리
         

 
--Where 절 : 공통 키 컬럼을 처리한 경우         
select * 
from employee, department 
where department.dno = employee.dno     -- 공통 키 적용
and job = 'MANAGER' ;                    -- 조건을 처리 


-- ANSI 호환 : [INNER] JOIN     <== 모든 SQL에서 사용 가능한 JOIN 
-- ON 절 : 공통 키 컬럼을 처리한 경우 
    -- on 절 : 두 테이블의 공통의 키 컬럼을 " = " 로 처리 
        -- where 절 : 조건을 처리 

select * 
from employee e INNER JOIN department d
on e.dno = d.dno
where job = 'MANAGER';


-- JOIN시 테이블 알리어스  ( 테이블 이름을 별칭으로 두고 많이 사용)
select * 
from employee e, department d
where e.dno = d.dno
and salary > 1500; 


-- select 절에서 공통의 키 컬럼을 출력시에 어느 테이블의 컬럼인지 명시 : dno 
select eno, job, d.dno, dname
from employee e, department d
where e.dno = d.dno 

-- 두 테이블을 JOIN 해서 부서별[명](dname) 로 월급(salary)의 최대값을 출력해 보세요. 
select dname ,count(*) , max(salary) 
from department d , employee e 
where d.dno = e.dno
group by dname 

-- NATURAL JOIN : Oracle 9i 지원 
    -- EQUI JOIN 의 Where 절을 없앰 : 두 테이블의 공통의 키 컬럼을 정의 " = " 
    -- 공통의 키 컬럼을 Oracle 내부적으로 자동으로 감지해서 처리. 
    -- 공통 키컬럼을 별칭 이름을 사용하면 오류가 발생. 
    -- 반드시 공통 키 컬럼은 데이터 타입이 같아야 한다. 
    -- from 절에  natural join 키워드를 사용. 
    
    
 select e.eno, e.ename, d.dname, dno
 from employee e natural join department d 
 
 -- 주의 :  select 절의 공통키 컬럼을 출력시 테이블명을 명시하면 오류 발생. 
 
 -- EQUI JOIN vs NATURAL JOIN 의 공통 키 컬럼 처리 
    -- EQUI JOIN : select 에서 반드시 공통 키 컬럼을 출력 할때 테이블명을 반드시 명시.
    -- NATURAL JOIN : select 에서 반드시 공통 키 컬럼을 출력 할때 테이블명을 반드시 명시하지 않아야 한다. 

--EQUI
select ename, salary, dname, e.dno      --  e.dno : EQUI Join 에서는 명시 
from employee e , department d
where e.dno = d.dno
and salary > 2000

--NATURAL
select ename , salary, dname, dno       -- dno : Natural Join에서는 테이블명을 명시하면 안된다. 
from employee e natural join department d
where salary > 2000


-- ANSI : INNER JOIN
select ename, salary, dname, e.dno
from employee e join department d
on e.dno = d.dno 
where salary > 2000

--NON EQUI JOIN : EQUI JOIN에서 Where 절의 "=" 를 사용하지 않는 JOIN

select * from salgrade  : 월급의 등급을 표시 하는 테이블  

select ename,salary, grade 
from employee, salgrade
where salary between losal and hisal ; 

-- 테이블 3개 조인 

select ename, dname, salary, grade
from employee e, department d, salgrade s 
where e.dno = d.dno 
and salary between losal and hisal; 

---------------------------------그룹함수 문제 1-----------------------------------------
--1. 
select * from employee

select max(salary) as 최고액 , min(salary) as 최저액 , sum(salalry) as 총액, round(avg(salary)) as 평균급여
from employee;

--2. 
select job, conut(*), max(salary) 최고액 , min(salary) 최저액 , sum(salalry) 총액, round(avg(salary)) 평균급여
from employee
group by job;

-- rollup, cube : group by 절에서 사용하는 특수한 키워드.
select job, conut(*), max(salary) 최고액 , min(salary) 최저액 , sum(salalry) 총액, round(avg(salary)) 평균급여
from employee
group by rollup(job);

select job, conut(*), max(salary) 최고액 , min(salary) 최저액 , sum(salalry) 총액, round(avg(salary)) 평균급여
from employee
group by cube(job)
order by job ;

-- 두 개 이상의 컬럼을 그룹핑
select dno, job, conut(*), max(salary) 최고액 , min(salary) 최저액 , sum(salalry) 총액, round(avg(salary)) 평균급여
from employee
group by rollup (dno, job)  -- 두 개 이상의 컬럼을 그룹핑 : 두 컬럼이 모두 만족될 때 그룹핑
order by dno asc;

select dno, job, conut(*), max(salary) 최고액 , min(salary) 최저액 , sum(salalry) 총액, round(avg(salary)) 평균급여
from employee
group by cube (dno, job)  -- 두 개 이상의 컬럼을 그룹핑 : 두 컬럼이 모두 만족될 때 그룹핑(앞 뒤 컬럼 모두 그룹핑해서 출력)
order by dno asc;


--3. 
select distinct job
from employee; --중복 제거만 됨

select job, count(*)
from employee
group by job;

--4.
select count(distinct manager) 관리자수 -- count 는 null 을 포함하지 않는다.
from employee;

--5.
select (max(salary)- min(salary)) "DIFFRENCE"
from employee;

--6. where, having 모두 사용
select job, min(salary) 최저급여
from employee
where manager is not null 
group by job
--having min(salary) > 2000 (가능)
having not min(salary) < 2000

--7.
select dno 부서번호 , count(*) 사원수 , round(avg(salary), 2) 평균급여
from employee
group by dno

--8.
select dcode (dno, 10, "ACCOUNTING"
                   20, "RESEARCH"
                   30, "SALES") as Dname, 
       dcode (dno, 10, "NEWYORK"
                   20, "DALAS"
                   30, "CHICAGO") as Location, 
        count(*) as "Number of people", round(avg(salary)) as Salary 
from employee
group by job




--------------------------------문제 2 ---------------------------------------
/*    
-- ****중요****
  - 제약 조건 : 테이블의 컬럼에 할당되어서 데이터의 무결성을 확보
     -- Primary Key : 테이블에 한 번만 사용할 수 있다. 하나의 컬럼, 두 개 이상을 그룹핑해서 적용
                      중복된 값을 넣을 수 없다. NULL 을 넣을 수 없다.
     -- UNIQUE      : 테이블 여러 컬럼에 할당 할 수 있다. 중복된 값을 넣을 수 없다. 
                      NULL 을 넣을 수 있다. -> 단 한 번만 넣을 수 있다. 
     -- Foreign Key : 다른 테이블의 특정 컬럼의 값을 참조해서만 넣을 수 있다.
                -- 자신의 컬럼에 임의의 값을 할당하지 못한다.
     -- NOT NULL    : NULL 값을 컬럼에 할당할 수 없다.
     -- CHECK       : 컬럼에 값을 할당할 때 체크해서 (조건에 만족) 값을 할당.
     -- Default     : 값을 넣지 않을 때 기본값이 할당.    
*/    


--1. EQUI 조인을 사용하여 SCOTT 사원의 부서 번호와 부서 이름을 출력 하시오. 
    -- 두 테이블을 조인할 때 공통의 키 컬럼을 찾아야 한다.
    select * from employee;
    select * from department;

    select *
    from department, emloyee; -- 카디시안 곱
    
    select *
    from employee, department 
    where employee.dno = department.dno

    select e.dno 부서번호, dname 부서이름, ename     -- dno 는 공통키 컬럼.
    from employee e, department d
    where e.dno = d.dno
    and ename = 'SCOTT'
    
--2. INNER JOIN과 ON 연산자를 사용하여 사원이름과 함께 그 사원이 소속된 부서이름과 지역명을 출력하시오. 
    select ename 사원이름, dname 부서이름 , loc 지역명
    from employee e inner join department d
    on e.dno = d.dno 

--3. INNER JOIN과 USING 연산자를 사용하여 10번 부서에 속하는 모든 담당 업무의 고유한 목록(한번씩만 표시)을 부서의 지역명을 포함하여 출력 하시오. 
    -- JOIN 에서 USING 를 사용하는 경우 
        -- NATURAL JOIN : 공통 키 컬럼을 Oracle 내부에서 자동 처리, 
        --                반드시 두 테이블의 공통키 컬럼의 데이터 타입이 같아야 한다.
        -- 두 테이블의 공통키 컬럼의 데이터 타입이 다른 경우 USING 을 사용한다.
        -- 두 테이블의 공통키 컬럼이 여러개인 경우 USING 을 사용한다.
        
     desc employee;
     desc department;

    select dno, job, loc
    form employee e inner join department d
    using (dno) 
    where dno = 10
    
--4. NATUAL JOIN을 사용하여 커밋션을 받는 모든 사원의 이름, 부서이름, 지역명을 출력 하시오. 
    select ename, dname, loc, commission 
    from employee e Natural join department d -- on 절 생략
    where commission is not null    
    
--5. EQUI 조인과 WildCard를 사용하여 이름에 A 가 포함된 모든 사원의 이름과 부서명을 출력 하시오. 
    select ename, dname
    from employee e, department d
    where e.dno = d.dno
    and ename like '%A%';

--6. NATURAL JOIN을 사용하여 NEW YORK에 근무하는 모든 사원의 이름, 업무, 부서번호 및 부서명을 출력하시오. 
    select ename, job, dno, loc
    from employee natural join department d
    where loc = 'NEW YORK';


-- 04. 22

-- SELF JOIN : 자기 자신의 테이블을 조인 한다. (주로 사원의 상사 정보를 출력할 때 사용, 조직도)
    -- 별칭을 반드시 사용해야 한다.
    -- select 절 : 테이블이름별칭.컬럼명  ,  

select eno, ename, manager 
from employee 
where manager = '7788'

select * from employee;

-- self join 을 사용해서 사원의 직속 상관 이름

-- EQUI JOIN 으로 Self join 을 처리 (Oracle 에서만 사용 가능)
select e.eno as "사원번호", e.ename as "사원이름", e.manager as "직속상관번호", m.ename as "직속상관이름"
from employee e, employee m     -- self join : 
where e.manager = m.eno
order by e.ename asc;
  
--   
select * from employees;
    
select e.ename || '의 직속상관은 ' || e.manager || ' 입니다.'
from employee e, employee m
where e.manager = m.eno
order by e.ename asc;

select eno, ename, manager, eno, name 
from employee;

-- ANSI 호환 : INNER JOIN 으로 처리
select e.eno as "사원번호", ename as "사원이름", manager as "직속상관번호", d.ename as "직속상관이름"
from employee e inner join employee m    
on e.manager = m.eno
order by ename asc;

--
select * from employee;
    
select e.ename || '의 직속상관은 ' || e.manager || ' 입니다.'
from employee e inner join employee m
on e.manager = m.eno
order by e.ename asc;


-- OUTER JOIN : 
    -- 특정 컬럼의 두 테이블에서 공통적이지 않는 내용을 출력 해야 할 때
    -- 공통적이지 않는 컬럼은 NULL 출력
    -- + 기호를 사용해서 출력 : Oracle
    -- ANSI 호환 : OUTER JOIN 구문을 사용해서 출력 <== 모든 DBMS 에서 호환
    
    --Oracle
    select e.ename, m.ename
    from employee e join employee m
    on e.manager = m.eno (+)
    order by e.ename asc;
  
    select e.first_name, m.first_name
    from employees e join employees m
    on e.manager_id = m.employee_id (+)
    order by e.first_name asc;
      
    --ANSI 호환 사용해서 출력.
        -- Left Outer Join : 공통적인 부분이 없더라도 왼쪽 테이블은 무조건 모두 출력
        -- Right Outer Join : 공통적인 부분이 없더라도 오른쪽 테이블은 무조건 모두 출력 
        -- Full Outer Join : 공통적인 부분이 없더라도 양쪽 테이블은 무조건 모두 출력 
    
    select e.ename, m.ename
    from employee e Left outer join employee m
    on e.manager = m.eno
    order by e.ename asc;
























