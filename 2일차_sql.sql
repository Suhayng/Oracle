-- 2일차 : DQL : Select

-- desc 테이블명 : 테이블의 구조 확인
desc department;

select * from department;

/*
SQL : 구조화된 질의 언어

Select 구문의 전체 필드 내용

Select      <= 컬럼명
Distinct    <= 컬럼내의 값의 중복 제거해라
From        <= 테이블명, 뷰명.
Where       <= 조건
Group By    <= 특정 값을 그룹핑
Having      <= 그룹핑한 값을 정렬
Order by    <= 값을 정렬해서 출력
*/

desc employees;

select * 
from employees;

-- 특정 컬럼만 출력 하기
select Employee_id, email from employees;

-- 특정 컬럼을 여러번 출력
select eno, ename, eno, ename, from employees;

-- 컬럼에 연산을 적용할 수 있다.
select eno, ename, salary, salary * 12 from employees;

-- 컬럼명 알리어스(Alias) : 컬럼의 이름을 변경
    -- 컬럼에 연산을 하거나 함수를 사용하면 컬럼며이 없어진다.
Select eno, ename, salary, salary * 12 as 연봉 from employees;
Select eno as 사원번호, ename as 사원명, salary as 월급, salary * 12 as 연봉 from employees;
Select eno 사원번호, ename 사원명, salary 월급, salary * 12 연봉 from employees;

-- nvl 함수 : 연산시에 null 을 처리하는 함수
select * from employee;

-- nvl 함수를 사용하지 않고 전체 연봉을 계산. (null 이 포함된 컬럼에 연산을 적용하면 null)
    -- null을 0으로 처리해서 연산해야함.    : NVL
select eno 사원번호, ename 사원명, salary 월급, commission 보너스 from employee; 
salary * 12,
salary * 12 + commission     -- 전체 연봉 
from employee;

--nvl 함수를 사용해서 연산
select eno 사원번호, ename 사원명, salary 월급, commission 보너스 from employee; 
salary * 12,
salary * 12 + NVL(commission, 0)    -- 전체 연봉 
from employee;

-- 특정 컬럼의 내용을 중복 제거 후 출력
select * from employee;
select dno from employee;
select distinct dno from employee;

select ename, distinct dno from employee;

-- 조건을 사용해서 검색 (Where)
select * from employee;
select eno 사원번호, ename 사원명, job 직책, manager 사수, manager 직속상관, hiredate 입사날짜,
        salary 월급, commision 보너스, dno 부서번호
from employee

--사원 번호가 7788인 사원의 이름을 검색.
select * from employee
where eno = 7788;

select eno,ename from employee
where eno = 7788;

-- 사원 번호가 7788인 사원의 부서번호, 월급과 입사 날짜를 검색
select dno 부서번호, salary 월급, hiredate 입사 날짜
from emlpoyee
where eno = 7788

desc employee;

select *
from employee
where ename = 'SMITH';

-- 레코드를 가져올 때 
    -- number 일 때는 ''를 붙이지 않는다.
    -- 문자 데이터(char, varchar2)나 날짜 (date) 를 가져올 때는 ''를 처리.
    -- 대소문자를 구분
    
-- 입사 날짜가 '81/12/03' 인 사원 출력    
select ename, hiredate
from employee
where hiredate = '81/12/03';

-- 부서 코드가 10인 모든 사원들을 출력.
select ename, dno
from employee
where dno = 30;

select * from employee;

-- 월급이 3000 이상인 사원의 이름과 부서와 입사날짜를 출력
select
from employee
where salary >= 3000;

-- NULL 검색 : is 키워드 사용 <== 주의 : = 를 사용하면 안된다.
select *
from employee
where commision is null;

--commission 이 300 이상인 사원 이름, 직책, 월급을 출력
select ename, job, salary, commission
from employee
where commision >= 300;

-- 커미션이 없는 사원들의 이름 출력
select ename, commission
from employee
where commission is null

-- 조건에서 and, or, not

--월급이 500 이상 2500 미만인 사원들의 이름, 사원번호, 입사날짜, 월급을 출력
select ename, dno, hiredate, salary
from employee
where salary >= 500 and salary < 2500;

-- 1. 직책이 SALEMAN 이거나, 부서 코드가 20인 사원 이름, 직책, 월급, 부서코드 출력
select * from employee;
select ename, job, salary, dno
from employee
where job = 'SALESMAN' or dno = 20;

-- 2. commission이 없는 사용자 중에 부서 코드가 20인 사용자의 이름과 부서 코드와 입사 날짜를 출력 
select ename, dno, hiredate
from employee
where commission is null and dno = 20

-- 3. commission이 null 이 아닌 사용자의 이름, 입사날짜, 월급
select ename, hiredate, salary, commission
from employee
where commission is not null

-- 날짜 검색 : 
select * from employee;

-- 1982/1/1 ~ 1983/12/31 사이에 입사한 사원의 이름, 직책, 입사날짜
select ename, job, hiredate
from employee
where hiredate >= '1982/1/1' and hiredate <  '1983/12/31';

-- 1981 년도에 입사한 사원의 이름, 직책, 입사날짜
select ename, job, hiredate
from employee
where hiredate >= '1981/1/1' and hiredate <  '1981/12/31';

-- between A and B : A 이상 B 이하
select ename, job, hiredate
from employee
where hiredate between '1981/1/1' and '1981/12/31';

--IN 연산자

-- commission 이 300, 500, 1400인 사원의 이름, 직책, 입사일을 출력
select * from employee;
select ename, job, hiredate, commission
from employee
where comission = 300 or commission = 500 or commission = 1400;

select ename, job, hiredate, commission
from employee
where comission in(300,500,1400);

-- like : 컬럼내의 특정한 문자열을 검색          <== 글 검색 기능을 사용할 때
    -- % : 뒤에 어떤 글자가 와도 상관 없다.
    -- _ : 한 글자가 어떤 값이 와도 상관 없다.
    
-- F 로 시작하는 이름을 가진 사원을 모두 검색하기
select * from employee
where ename like 'F%';

-- 이름이 ES 로 끝나는 사원 검색
select ename from employee
where ename like '%ES';

-- J로 시작 되고 J 뒤의 두글자가 어떤 것이 와도 상관 없는 사원 출력. 뒤에는 ES 로 마무리
select ename
from employee
where ename like 'J__ES';

-- 마지막 글자가 R 로 끝나는 사원 출력
select *
from employee
where ename like '%R' ;

-- MAN 단어가 들어간 직책을 출력
select *
from employee
where job like '%MAN%';

-- 81년도에 입사한 사원을 출력하기
select *
from employee
where hiredate >= '81/1/1' and hiredate <= '81/12/31';

select *
from employee
where hiredate between  '81/1/1' and '81/12/31';

select *
from employee
where hiredate like '81%';

-- 81년 2월에 입사한 사원만 출력
select *
from emlpoyee
where hiredate like '81/02%';

-- 정렬 : order by, asc (오름차순 정렬), desc (내림차순 정렬)
select *
from emlpoyee
order by eno asc;   -- asc 생략 가능

select *
from emlpoyee
order by eno desc;

-- 이름 컬럼을 정렬
select *
from emlpoyee
order by ename asc;

select *
from emlpoyee
order by ename desc;

--날짜 정렬
select *
from emlpoyee
order by hiredate desc;

--질문 답변형 게시판에서 주로 사용 
select * from employee
order by dno desc;

-- 두 개의 컬럼이 정렬 : 제일 처음 컬럼이 정렬을 하고, 동일한 값에 대해서 두 번째 컬럼을 정렬 
select dno, ename 
from employee
order by dno, ename;

select dno, ename 
from employee
order by dno desc, ename desc;

-- Where 절과 order by 절이 같이 사용될 때
select *
from employee
where commission is null
order by ename desc;

-- 다양한 함수 사용하기
/*
    1. 문자를 처리하는 함수
        - UPPER : 대문자로 변환
        - LOWER : 소문자롤 변환
        - INITCAP : 첫자는 대문자로 나머지는 소문자로 변환
        
        dual 테이블 : 하나의 결과를 출력 하도록 하는 테이블
*/
select '안녕하세요' as 안녕
from dual 

select 'Oracle mania', upper('Oracle mania'), LOWER ('Oracle mania'), initcap('Oracle mania')
from dual

select * from employees;

select email, lower(email), initcap(email), upper(email) 
from employees;

select * from employees
where email = 'sking';      --검색이 안됨

select * from employees
where LOWER(email) = 'sking'; 

select email, initcap(email) from employees
where initcap(email) = 'sking'; 

--문자 길이를 출력 하는 함수
    -- length : 문자의 길이를 반환, 영문이나 한글 관계없이 글자 수를 리턴 (1byte)
    -- lengthb : 문자의 길이를 반환, 영문 1byte 한글 3byte 로 변환
    
select length('Oracle mania'), length ('오라클 매니아') from dual;

select lengthb('Oracle mania'), lengthb ('오라클 매니아') from dual;

select * from employee

select email, length(email), employee_id, length(employee_id) from employees

--문자 조작 함수 
    -- concat : 문자와 문자를 연결해서 출력
    -- substr : 문자를 특정 위치에서 잘라오는 함수 ( 모두 1byte)
    -- substrib :  문자를 특정 위치에서 잘라오는 함수 (영문 1byte, 한글 3byte 로 처리)
    -- instr : 문자의 특정 위치의 인덱스 값을 반환
    -- instrb : 문자의 특정 위치의 인덱스 값을 반환 (영문 1byte, 한글 3byte 로 처리)
    -- lpad, rpad : 입력 받은 문자열에서 특수 문자를 적용.
    -- trm : 잘라내고 남은 문자를 반환
    
 select 'Oracle', 'mania', concat ('Oracle' , 'mania') from dual  
 
 select * from employees;
 
 select concat (email,'   ' || job_id) from employees;
 
 select '이름은 :' || email ||  '이고, 직책은 : ' || job_id || '입니다' as 컬럼 연결
 from employees; 
 
 select '이름은 : ' || ename || ' 이고, 직속 상관 사번은 : ' || manager || '입니다.'  as 직속상관출력
 from employee;
 
 -- 이름이 N으로 끝나는 사원들 출력하기(substr 함수 사용)
 select ename from emloyee
 where substr (ename, -1,1) = 'N'
 
 select ename from employee
 where ename like '%N';
 
 -- 87년도 입사한 사원들 출력하기 (substr)
 select hire_date, substr( hire_date, 1, 2) from employees;

select * from employee
where hiredate like '87%';

-- instr( 대상 ,찾을 글자, 시작 위치, 몇 번째 발견) : 대상에서 찾을 글자의 인덱스 값을 출력
select 'Oracle mania' , instr ('Oracle mania, 'O') from dual;

select 'Oracle mania' , instr ('Oracle mania, 'a', 5.2) from dual;

 -- substr (대상, 시작 위치, 추출개수) : 특정 위치에서 문자를 잘라온다.
 select 'Oracle mania', substr('Oracle mania', 4, 3), substr('오라클 매니아', 2, 4) 
 from dual ;
 
  select 'Oracle mania', substr('Oracle mania', -4, 3), substr('오라클 매니아', -2, 4) 
 from dual ;
 
 select email, substr(email, 3, 2), substr(email, -5, 2) from employees;
 
 select substrb('Oracle mania', 3, 3), substrb ('오라클 매니아', 3, 6) from dual;
 
