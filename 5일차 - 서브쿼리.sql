-- 5���� ��������

-- Sub Query : Select �� ���� Select ���� �ִ� ����
    -- where ������  : SUB QUERY 
    -- having ������ : SUB QUERY

select first_name, salary from employees
select salary from employees where ename ='SCOTT';
--select salary from employees where first_name ='Steven';

-- SCOTT �� ���� ���� ���ų� ���� ����ڸ� ����϶�. (���� ����)
select ename, salary from employee where salary >= 3000

select ename, salary 
from employee 
where salary >= (select salary from employee where ename = 'SCOTT')
--select first_name, salary from employees where salary >= 3000

-- SCOTT �� ������ �μ��� �ٹ��ϴ� ����� ����ϱ� (sub query)
select ename, dno
from employee
where dno = (select dno from employee where ename = 'SCOTT' ) 

-- �ּ� �޿��� �޴� ����� �̸�, ������, �޿� ����ϱ� (sub query)
select ename, job, salary
from employee
where salary = (select min(salary) from employee ) 

select * from employees
select first_name, job_id, salary
from employees
where salary = (select min(salary) from employees ) 

 
-- 30�� �μ�(dno)���� �ּ� ������ �޴� ������� ���� ����� �̸��� �μ���ȣ�� ������ ��� �ϱ�

select dno, salary from employee where dno = 30
select min(salary) from employee where dno = 30

select ename, dno, salary
from employee
where salary > (select min(salary) from employee where dno = 30) 

select first_name, job_id, salary
from employees
where salary > (select min(salary) from employees where job_id = 'AD_VP') 

-- Having ���� Sub query ����ϱ�

-- 30�� �μ��� �ּ� ���� ���� ū �� �μ��� �ּ� ����
select dno, min(salary), count(dno)
from employee
group by dno
having min(salary) > (select min(salary) from employee where dno = 30);

select job_id, min(salary), count(job_id)
from employees
group by job_id
having min(salary) > (select min(salary) from employees where job_id = 'AD_VP');

-- ������ ���� ���� : sub query �� ��� ���� �� �ϳ��� ���
         -- ������ �� ������ : > , = , >= , < , <=, <>, <=
         
-- ������ ���� ���� : sub query �� ��� ���� ������ ���
         -- ������ ���� ���� ������ : IN, ANY, SOME, ALL, EXISTS
                -- IN : ���� ������ �� ���� ( '=' �����ڷ� ���� ��� ) �� ���� ������ ����� �߿� �ϳ��� ��ġ�ϸ� ��
                -- ANY, SOME : ���� ������ �� ������ ���� ������ �˻� ����� �ϳ� �̻� ��ġ�ϸ� ��
                -- ALL : ���� ������ �� ������ ���� ������ �˻� ����� ��� ���� ��ġ�ϸ� ��
                -- EXISTS : ���� ������ �� ������ ���� ������ ��� �� �߿��� �����ϴ� ���� �ϳ��� �����ϸ� ��
                
-- IN ������ ����ϱ�
select ename, eno, dno, salary 
from employee
order by dno asc

-- �μ����� �ּ� ������ �޴� ����ڵ� ����ϱ� (sub query �� �ݵ�� ����Ͻÿ�)
select dno, min(salary), count(*)
from employee
group by dno

select ename, dno, salary
from employee
where salary in (950, 800, 1300)
    
    -- ���� ���� ���
select ename, dno, salary
from employee
where salary in ( select min(salary) from employee group by dno);

-- ANY ������ ���
    -- ���� ������ ��ȯ�ϴ� ������ ���� ����
    -- ' < any ' �� �ִ밪 ���� ������ ��Ÿ��
    -- ' > any ' �� �ּҰ� ���� ŭ�� ��Ÿ��
    -- ' = ang ' �� IN �� ������
    
-- ��) ������ SALESMAN �� �ƴϸ鼭 �޿��� ������ SALESMAN ���� ���� ����� ���
                -- 1600 (�ִ밪) ���� ���� ��� ���(SALESMAN)�� �ƴ�    
select eno, ename, salary, job 
from employee
where salary < any (select salary from employee where job = 'SALESMAN')
               and job <> 'SALESMAN'                  

select ename, job, salary from employee order by job;

-- ALL ������
    -- sub query �� ��ȯ�Ѵ� ��� ���� ��
    -- ' > all ' �� �ִ밪 ���� ŭ�� ��Ÿ��
    -- ' < all ' �� �ּҰ� ���� ������ ��Ÿ��
    
    -- ��) ������ 'SALESMAN' �ƴϸ鼭 SALESMAN �� ��� ���� �޿��� ���� ����� ��� ���
                -- 1250 (�ּҰ�) ���� ���� ��� (������ SALESMAN �� �ƴ�)
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

-- ��� ������ �м���(ANALYST)�� ������� �޿��� �����鼭 ������ �м����� �ƴ� ������� ���
select eno, ename, salary, job
from employee
where salary < all (select salary from employee where job = 'ANALYST')
               and job <> 'ANALYST';


-- �޿��� ��� �޿� ���� ���� ������� �����ȣ�� �̸��� ǥ�� �ϵ� ��� �޿��� ���ؼ� �������� �����Ͻÿ�.
select eno, eanme, salary
from employee
where salary > (select avg(salary) 
                    from employee)
order by salary asc;                   



7. SELF JOIN�� ����Ͽ� ����� �̸� �� �����ȣ�� ������ �̸� �� ������ ��ȣ�� �Բ� ��� �Ͻÿ�. 
 	������ ��Ī���� �ѱ۷� �����ÿ�. 
select e.ename as "����̸�", e.eno as "�����ȣ", e.manager as "�����ڹ�ȣ", m.ename as "�������̸�"
from employee e, employee m
where e.manager = m.ename

8. OUTER JOIN, SELF JOIN�� ����Ͽ� �����ڰ� ���� ����� �����Ͽ� �����ȣ�� �������� �������� �����Ͽ� ��� �Ͻÿ�. 
select e.ename, e.eno, m.ename
from employee e join employee m
on e.manager = m.eno (+)
order by e.eno desc;

--9. SELF JOIN�� ����Ͽ� ������ ���('SCOTT')�� �̸�, �μ���ȣ, ������ ����� ������ �μ����� �ٹ��ϴ� ����� ����Ͻÿ�. 
   ��, �� ���� ��Ī�� �̸�, �μ���ȣ, ����� �Ͻÿ�. 
select e.ename �̸� , e.dno �μ���ȣ, m.ename ����
from employee e, employee m
where e.ename = m.ename
and e.dno = 


--10. SELF JOIN�� ����Ͽ� WARD ������� �ʰ� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�. 
select e.first_name, e.hire_date, m.first_name 
from employees e, employees m
where e.first_name = m.first_name
and e.hire_date > (select hire_date from employees where first_name = 'David')


--11. SELF JOIN�� ����Ͽ� ������ ���� ���� �Ի��� ��� ����� �̸� �� �Ի����� ������ �̸� �� �Ի��ϰ� �Բ� ����Ͻÿ�. 
    ��, �� ���� ��Ī�� �ѱ۷� �־ ��� �Ͻÿ�. 
select e.ename as ����̸�, e.hiredate as �Ի糯¥, e.dname as �������̸�, m. as �������Ի���
from employee e, employee m
where e.hiredate < (select 

<<�Ʒ� ������ ��� Subquery�� ����Ͽ� ������ Ǫ����.>>

1. �����ȣ�� 7788�� ����� ��� ������ ���� ����� ǥ��(����̸� �� ������) �Ͻÿ�.  
select ename, job
from employee
where ename = (select ename from employee where dno = 7788);

2. �����ȣ�� 7499�� ������� �޿��� ���� ����� ǥ�� (����̸� �� ������) �Ͻÿ�. 
select ename, job
from employee
where salary > (select ename from employee where dno = 7499);

--3. �ּ� �޿��� �޴� ���޺��� ����� �̸�, ��� ���� �� �޿��� ǥ�� �Ͻÿ�(�׷� �Լ� ���)
select ename, job, salary
from employee
where salary < (select min(salary) from employee)
group by job;

select first_name, job_id, salary 
from employees
group by job_id;
having salary < (select min(salary) from employees)

select * from employees

4. ���޿��� ��� �޿��� ���ϰ�, ���� ���� ���� ����� ���� ��� �� �޿��� ���� ���� ����� ���ް� �޿��� ǥ���Ͻÿ�.
select job, min(salary)
from employee
where salalry <= (select min(salary) from employee)
group by rollup(job)

--5. �� �μ��� �ּ� �޿��� �޴� ����� �̸�, �޿�, �μ���ȣ�� ǥ���Ͻÿ�.
select ename, salary, dno
from employee
where salary in (select min(salary) from employee group by dno)  


6. ��� ������ �м���(ANALYST) �� ������� �޿��� �����鼭 ������ �м����� �ƴ� ������� ǥ�� (�����ȣ, �̸�, ������, �޿�) �Ͻÿ�.
select eno, ename, job, salary
from employee
where salary < (select salary from employee where job = 'ANALYST'
                and job <> 'ANALYST')

--7. ���������� ���� ����� �̸��� ǥ�� �Ͻÿ�. 
select ename
from employee
where ename = (select ename from employee where dname is null) 

--8. ���������� �ִ� ����� �̸��� ǥ�� �Ͻÿ�. 
select ename
from employee
where ename = (select ename from employee where dname is not null) 

9. BLAKE �� ������ �μ��� ���� ����� �̸��� �Ի����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�(��, BLAKE �� ����). 
select ename, hiredate
from employee
where dno in (select dno from employee where ename = 'BLAKE'
              and ename <> 'BLAKE')

10. �޿��� ��պ��� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ����� �޿��� ���ؼ� ���� �������� ���� �Ͻÿ�. 
select eno, ename,salary
from employee
where salary > (select round(avg(salary)) from employee)
order by salary;

11. �̸��� K �� ���Ե� ����� ���� �μ����� ���ϴ� ����� �����ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. 
select eno, ename
from employee
where dno = (select dno from employee where ename like '%K%')

--12. �μ� ��ġ�� DALLAS �� ����� �̸��� �μ� ��ȣ �� ��� ������ ǥ���Ͻÿ�. 
select ename, dno, job, loc
from employee
where loc = (select )

13. KING���� �����ϴ� ����� �̸��� �޿��� ǥ���Ͻÿ�. 
select ename, salary
from employee
where ename = (select ename from employee where manager = 'KING')

14. RESEARCH �μ�(department ���̺�)�� ����� ���� �μ���ȣ, ����̸� �� ��� ������ ǥ�� �Ͻÿ�. 



15. ��� �޿����� ���� �޿��� �ް� �̸��� M�� ���Ե� ����� ���� �μ����� �ٹ��ϴ� ����� �����ȣ, �̸�, �޿��� ǥ���Ͻÿ�. 

16. ��� �޿��� ���� ���� ������ ã���ÿ�. 

17. �������� MANAGER�� ����� �Ҽӵ� �μ��� ������ �μ��� ����� ǥ���Ͻÿ�. 




