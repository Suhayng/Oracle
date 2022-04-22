-- 4���� 
/*
   �׷� �Լ� : ������ ���� ���ؼ� �׷����ؼ� ó���ϴ� �Լ� 
        group by ���� Ư�� �÷��� ���� �� ���, �ش� �÷��� ������ ������ �׷����ؼ� ������ ����. 
        
    �����Լ� : 
        - SUM : �׷��� �հ�
        - AVG : �׷��� ���
        - MAX : �׷��� �ִ밪
        - MIN : �׷��� �ּҰ� 
        - COUNT : �׷��� �� ���� (���ڵ�� record ,�ο�� row )
*/

select sum (salary), round (avg (salary),2), max (salary), min (salary) 
from employee; 

--���� :  ���� �Լ��� ó�� �Ҷ�, ����÷��� ���� ������ ������ �÷��� ����  

select sum (salary) 
from employee; 

select ename
from employee; 

select * from employee; 

-- �����Լ��� null ���� ó���ؼ� �����Ѵ�. 
select sum (commission), avg(commission), max (commission), min(commission)
from employee; 

-- count () : ���ڵ� ��, �ο� ��
    -- NULL �� ó������ �ʴ´�. 
    -- ���̺��� ��ü ���ڵ� ���� ������ ��� : count(*) �Ǵ� NOT NULL �÷��� count() 

desc employee; 
    

select eno from employee; 
select count (eno) from employee;

select commission from employee; 
select count(commission) from employee; 

select count (*) from employee; 
select * from employee; 

--��ü ���ڵ� ī��Ʈ 
select count(*) from employee; 
select count(eno) from employee; 

-- �ߺ����� �ʴ� ������ ���� (job)

select job from employee ; 

select count(distinct job) from employee; 

-- �μ��� ���� (dno) 

select count ( distinct dno) from employee

-- Group by  : Ư�� �÷��� ���� �׷��� �Ѵ�. �ַ� �����Լ��� select ������ ���� ����մϴ�.  
/*
    select  �ķ���, �����Լ�ó�����÷�
    from ���̺�
    where ����
    group by �÷��� 
    having ���� ( group by�� ����� ����)
    oder by ���� 

*/

-- �μ��� ��� �޿�. 
select dno as �μ���ȣ , avg(salary) as ��ձ޿�
from employee
group by dno    -- dno �÷��� �ߺ��Ȱ��� �׷��� ��. 


select dno from employee order by dno;

-- ��ü ��� �޿�. 
select avg (salary) as ��ձ޿�
from employee;

-- group by�� ����ϸ鼭 select ���� ������ �÷��� �� �����ؾ� �Ѵ�. 
select dno , count(dno), sum(salary) , avg(salary), max(commission), min(commission)
from employee
group by dno 

-- 
select job from employee

--������ ��å�� �׷����ؼ� ������ ���, �հ�, �ִ밪, �ּҰ��� ���. 
select job, count(job), avg(salary), sum(salary), max(salary), min(salary) 
from employee
group by job     --������ ��å�� �׷����ؼ� ���踦 �Ѵ�.

--���� �÷��� �׷��� �ϱ�. 

select dno, job, count(*) ,sum (salary)
from employee
group by dno, job       -- �� �÷���� ��ġ�ϴ� ���� �׷���  

select dno, job 
from employee 
where dno = 20 and job = 'CLERK'; 

--having : group by ���� ���� ����� �������� ó�� �Ҷ�. 
   -- ��Ī�̸��� �������� ����ϸ� �ȵȴ�. 
   

-- �μ��� ������ �հ谡 9000 �̻�͸� ���. 
select dno , count(*), sum (salary) as �μ����հ� , round (avg(salary) , 2) as �μ������
from employee 
group by dno
having sum (salary) >9000 ; 

-- �μ��� ������ ����� 2000 �̻� ���. 
select dno , count(*), sum (salary) as �μ����հ� , round (avg(salary) , 2) as �μ������
from employee 
group by dno
having round (avg(salary) , 2) > 2000.00 ; 

--where �� having ���� ���� ���Ǵ� ��� 
   -- where : ���� ���̺��� �������� �˻�
   -- having : group by ����� ���ؼ� ������ ó��. 
   
select * from employee; 

-- ������ 1500 ���ϴ� �����ϰ� �� �μ����� ������ ����� ���ϵ� ������ ����� 2500�̻��� �͸� ��� �϶�. 

select dno, count(*) , round (avg (salary)) as �μ������
from employee
where salary > 1500
group by dno
having round (avg (salary)) > 2500 

-- ROLLUP 
-- CUBE 
   -- Group by ������ ����ϴ� Ư���� �Լ� 
   -- ���� �÷��� ���� �� �� �ִ�. 
   -- group by ���� �ڼ��� ������ ���...
   
--Rollup, cube�� ������� �ʴ� ���
select dno ,  count(*), sum(salary), round(avg(salary))
from employee
group by  dno
order by dno 

-- Rollup  : �μ��� �հ�� ����� ��� �� , ������ ���ο� ��ü �հ�, ���
select dno ,  count(*), sum(salary), round(avg(salary))
from employee
group by  rollup(dno)
order by dno

--cube  : �μ��� �հ�� ����� ��� �� , ������ ���ο� ��ü �հ�, ���
select dno ,  count(*), sum(salary), round(avg(salary))
from employee
group by  cube(dno)
order by dno

-- Rollup : �� �÷��̻�
select dno, job, count(*), MAX(salary), SUM(salary), round(AVG(salary))
from employee
group by rollup (dno, job)   -- �ΰ��� �÷��� �����, �� �÷��� ���ļ� �����Ҷ� �׷���. 

select dno, job, count(*), MAX(salary), SUM(salary), round(AVG(salary))
from employee
group by dno, job 
order by dno asc

--cube
select dno, job, count(*), MAX(salary), SUM(salary), round(AVG(salary))
from employee
group by cube (dno, job)
order by dno, job


--JOIN : ���� ���̺��� ���ļ� �� ���̺��� �÷��� �����´�.  
   -- department �� employee�� ������ �ϳ��� ���̺��� ������ �𵨸�(�ߺ�����, �������)�� ���ؼ� �� ���̺��� �и�
   -- �� ���̺��� ����Ű �÷� (dno) , employee ���̺��� dno �÷��� department ���̺��� dno �÷��� �����Ѵ�. 
   -- �ΰ� �̻��� ���̺��� �÷��� JOIN���� �� ����ؼ� ���. 
    
select * from department;   -- �μ������� ���� �ϴ� ���̺�
select * from employee;     -- ��������� �����ϴ� ���̺�


-- EQUI JOIN  : ����Ŭ���� ���� ���� ����ϴ� JOIN , Orale ������ ��밡�� 
    -- from �� : ������ ���̺��� ","�� ó��,
    -- where �� : �� ���̺��� ������ Ű �÷��� " = " �� ó�� 
         -- and ��   : ������ ó��
         

 
--Where �� : ���� Ű �÷��� ó���� ���         
select * 
from employee, department 
where department.dno = employee.dno     -- ���� Ű ����
and job = 'MANAGER' ;                    -- ������ ó�� 


-- ANSI ȣȯ : [INNER] JOIN     <== ��� SQL���� ��� ������ JOIN 
-- ON �� : ���� Ű �÷��� ó���� ��� 
    -- on �� : �� ���̺��� ������ Ű �÷��� " = " �� ó�� 
        -- where �� : ������ ó�� 

select * 
from employee e INNER JOIN department d
on e.dno = d.dno
where job = 'MANAGER';


-- JOIN�� ���̺� �˸��  ( ���̺� �̸��� ��Ī���� �ΰ� ���� ���)
select * 
from employee e, department d
where e.dno = d.dno
and salary > 1500; 


-- select ������ ������ Ű �÷��� ��½ÿ� ��� ���̺��� �÷����� ��� : dno 
select eno, job, d.dno, dname
from employee e, department d
where e.dno = d.dno 

-- �� ���̺��� JOIN �ؼ� �μ���[��](dname) �� ����(salary)�� �ִ밪�� ����� ������. 
select dname ,count(*) , max(salary) 
from department d , employee e 
where d.dno = e.dno
group by dname 

-- NATURAL JOIN : Oracle 9i ���� 
    -- EQUI JOIN �� Where ���� ���� : �� ���̺��� ������ Ű �÷��� ���� " = " 
    -- ������ Ű �÷��� Oracle ���������� �ڵ����� �����ؼ� ó��. 
    -- ���� Ű�÷��� ��Ī �̸��� ����ϸ� ������ �߻�. 
    -- �ݵ�� ���� Ű �÷��� ������ Ÿ���� ���ƾ� �Ѵ�. 
    -- from ����  natural join Ű���带 ���. 
    
    
 select e.eno, e.ename, d.dname, dno
 from employee e natural join department d 
 
 -- ���� :  select ���� ����Ű �÷��� ��½� ���̺���� ����ϸ� ���� �߻�. 
 
 -- EQUI JOIN vs NATURAL JOIN �� ���� Ű �÷� ó�� 
    -- EQUI JOIN : select ���� �ݵ�� ���� Ű �÷��� ��� �Ҷ� ���̺���� �ݵ�� ���.
    -- NATURAL JOIN : select ���� �ݵ�� ���� Ű �÷��� ��� �Ҷ� ���̺���� �ݵ�� ������� �ʾƾ� �Ѵ�. 

--EQUI
select ename, salary, dname, e.dno      --  e.dno : EQUI Join ������ ��� 
from employee e , department d
where e.dno = d.dno
and salary > 2000

--NATURAL
select ename , salary, dname, dno       -- dno : Natural Join������ ���̺���� ����ϸ� �ȵȴ�. 
from employee e natural join department d
where salary > 2000


-- ANSI : INNER JOIN
select ename, salary, dname, e.dno
from employee e join department d
on e.dno = d.dno 
where salary > 2000

--NON EQUI JOIN : EQUI JOIN���� Where ���� "=" �� ������� �ʴ� JOIN

select * from salgrade  : ������ ����� ǥ�� �ϴ� ���̺�  

select ename,salary, grade 
from employee, salgrade
where salary between losal and hisal ; 

-- ���̺� 3�� ���� 

select ename, dname, salary, grade
from employee e, department d, salgrade s 
where e.dno = d.dno 
and salary between losal and hisal; 

---------------------------------�׷��Լ� ���� 1-----------------------------------------
--1. 
select * from employee

select max(salary) as �ְ�� , min(salary) as ������ , sum(salalry) as �Ѿ�, round(avg(salary)) as ��ձ޿�
from employee;

--2. 
select job, conut(*), max(salary) �ְ�� , min(salary) ������ , sum(salalry) �Ѿ�, round(avg(salary)) ��ձ޿�
from employee
group by job;

-- rollup, cube : group by ������ ����ϴ� Ư���� Ű����.
select job, conut(*), max(salary) �ְ�� , min(salary) ������ , sum(salalry) �Ѿ�, round(avg(salary)) ��ձ޿�
from employee
group by rollup(job);

select job, conut(*), max(salary) �ְ�� , min(salary) ������ , sum(salalry) �Ѿ�, round(avg(salary)) ��ձ޿�
from employee
group by cube(job)
order by job ;

-- �� �� �̻��� �÷��� �׷���
select dno, job, conut(*), max(salary) �ְ�� , min(salary) ������ , sum(salalry) �Ѿ�, round(avg(salary)) ��ձ޿�
from employee
group by rollup (dno, job)  -- �� �� �̻��� �÷��� �׷��� : �� �÷��� ��� ������ �� �׷���
order by dno asc;

select dno, job, conut(*), max(salary) �ְ�� , min(salary) ������ , sum(salalry) �Ѿ�, round(avg(salary)) ��ձ޿�
from employee
group by cube (dno, job)  -- �� �� �̻��� �÷��� �׷��� : �� �÷��� ��� ������ �� �׷���(�� �� �÷� ��� �׷����ؼ� ���)
order by dno asc;


--3. 
select distinct job
from employee; --�ߺ� ���Ÿ� ��

select job, count(*)
from employee
group by job;

--4.
select count(distinct manager) �����ڼ� -- count �� null �� �������� �ʴ´�.
from employee;

--5.
select (max(salary)- min(salary)) "DIFFRENCE"
from employee;

--6. where, having ��� ���
select job, min(salary) �����޿�
from employee
where manager is not null 
group by job
--having min(salary) > 2000 (����)
having not min(salary) < 2000

--7.
select dno �μ���ȣ , count(*) ����� , round(avg(salary), 2) ��ձ޿�
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




--------------------------------���� 2 ---------------------------------------
/*    
-- ****�߿�****
  - ���� ���� : ���̺��� �÷��� �Ҵ�Ǿ �������� ���Ἲ�� Ȯ��
     -- Primary Key : ���̺� �� ���� ����� �� �ִ�. �ϳ��� �÷�, �� �� �̻��� �׷����ؼ� ����
                      �ߺ��� ���� ���� �� ����. NULL �� ���� �� ����.
     -- UNIQUE      : ���̺� ���� �÷��� �Ҵ� �� �� �ִ�. �ߺ��� ���� ���� �� ����. 
                      NULL �� ���� �� �ִ�. -> �� �� ���� ���� �� �ִ�. 
     -- Foreign Key : �ٸ� ���̺��� Ư�� �÷��� ���� �����ؼ��� ���� �� �ִ�.
                -- �ڽ��� �÷��� ������ ���� �Ҵ����� ���Ѵ�.
     -- NOT NULL    : NULL ���� �÷��� �Ҵ��� �� ����.
     -- CHECK       : �÷��� ���� �Ҵ��� �� üũ�ؼ� (���ǿ� ����) ���� �Ҵ�.
     -- Default     : ���� ���� ���� �� �⺻���� �Ҵ�.    
*/    


--1. EQUI ������ ����Ͽ� SCOTT ����� �μ� ��ȣ�� �μ� �̸��� ��� �Ͻÿ�. 
    -- �� ���̺��� ������ �� ������ Ű �÷��� ã�ƾ� �Ѵ�.
    select * from employee;
    select * from department;

    select *
    from department, emloyee; -- ī��þ� ��
    
    select *
    from employee, department 
    where employee.dno = department.dno

    select e.dno �μ���ȣ, dname �μ��̸�, ename     -- dno �� ����Ű �÷�.
    from employee e, department d
    where e.dno = d.dno
    and ename = 'SCOTT'
    
--2. INNER JOIN�� ON �����ڸ� ����Ͽ� ����̸��� �Բ� �� ����� �Ҽӵ� �μ��̸��� �������� ����Ͻÿ�. 
    select ename ����̸�, dname �μ��̸� , loc ������
    from employee e inner join department d
    on e.dno = d.dno 

--3. INNER JOIN�� USING �����ڸ� ����Ͽ� 10�� �μ��� ���ϴ� ��� ��� ������ ������ ���(�ѹ����� ǥ��)�� �μ��� �������� �����Ͽ� ��� �Ͻÿ�. 
    -- JOIN ���� USING �� ����ϴ� ��� 
        -- NATURAL JOIN : ���� Ű �÷��� Oracle ���ο��� �ڵ� ó��, 
        --                �ݵ�� �� ���̺��� ����Ű �÷��� ������ Ÿ���� ���ƾ� �Ѵ�.
        -- �� ���̺��� ����Ű �÷��� ������ Ÿ���� �ٸ� ��� USING �� ����Ѵ�.
        -- �� ���̺��� ����Ű �÷��� �������� ��� USING �� ����Ѵ�.
        
     desc employee;
     desc department;

    select dno, job, loc
    form employee e inner join department d
    using (dno) 
    where dno = 10
    
--4. NATUAL JOIN�� ����Ͽ� Ŀ�Լ��� �޴� ��� ����� �̸�, �μ��̸�, �������� ��� �Ͻÿ�. 
    select ename, dname, loc, commission 
    from employee e Natural join department d -- on �� ����
    where commission is not null    
    
--5. EQUI ���ΰ� WildCard�� ����Ͽ� �̸��� A �� ���Ե� ��� ����� �̸��� �μ����� ��� �Ͻÿ�. 
    select ename, dname
    from employee e, department d
    where e.dno = d.dno
    and ename like '%A%';

--6. NATURAL JOIN�� ����Ͽ� NEW YORK�� �ٹ��ϴ� ��� ����� �̸�, ����, �μ���ȣ �� �μ����� ����Ͻÿ�. 
    select ename, job, dno, loc
    from employee natural join department d
    where loc = 'NEW YORK';


-- 04. 22

-- SELF JOIN : �ڱ� �ڽ��� ���̺��� ���� �Ѵ�. (�ַ� ����� ��� ������ ����� �� ���, ������)
    -- ��Ī�� �ݵ�� ����ؾ� �Ѵ�.
    -- select �� : ���̺��̸���Ī.�÷���  ,  

select eno, ename, manager 
from employee 
where manager = '7788'

select * from employee;

-- self join �� ����ؼ� ����� ���� ��� �̸�

-- EQUI JOIN ���� Self join �� ó�� (Oracle ������ ��� ����)
select e.eno as "�����ȣ", e.ename as "����̸�", e.manager as "���ӻ����ȣ", m.ename as "���ӻ���̸�"
from employee e, employee m     -- self join : 
where e.manager = m.eno
order by e.ename asc;
  
--   
select * from employees;
    
select e.ename || '�� ���ӻ���� ' || e.manager || ' �Դϴ�.'
from employee e, employee m
where e.manager = m.eno
order by e.ename asc;

select eno, ename, manager, eno, name 
from employee;

-- ANSI ȣȯ : INNER JOIN ���� ó��
select e.eno as "�����ȣ", ename as "����̸�", manager as "���ӻ����ȣ", d.ename as "���ӻ���̸�"
from employee e inner join employee m    
on e.manager = m.eno
order by ename asc;

--
select * from employee;
    
select e.ename || '�� ���ӻ���� ' || e.manager || ' �Դϴ�.'
from employee e inner join employee m
on e.manager = m.eno
order by e.ename asc;


-- OUTER JOIN : 
    -- Ư�� �÷��� �� ���̺��� ���������� �ʴ� ������ ��� �ؾ� �� ��
    -- ���������� �ʴ� �÷��� NULL ���
    -- + ��ȣ�� ����ؼ� ��� : Oracle
    -- ANSI ȣȯ : OUTER JOIN ������ ����ؼ� ��� <== ��� DBMS ���� ȣȯ
    
    --Oracle
    select e.ename, m.ename
    from employee e join employee m
    on e.manager = m.eno (+)
    order by e.ename asc;
  
    select e.first_name, m.first_name
    from employees e join employees m
    on e.manager_id = m.employee_id (+)
    order by e.first_name asc;
      
    --ANSI ȣȯ ����ؼ� ���.
        -- Left Outer Join : �������� �κ��� ������ ���� ���̺��� ������ ��� ���
        -- Right Outer Join : �������� �κ��� ������ ������ ���̺��� ������ ��� ��� 
        -- Full Outer Join : �������� �κ��� ������ ���� ���̺��� ������ ��� ��� 
    
    select e.ename, m.ename
    from employee e Left outer join employee m
    on e.manager = m.eno
    order by e.ename asc;
























