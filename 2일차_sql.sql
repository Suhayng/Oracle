-- 2���� : DQL : Select

-- desc ���̺�� : ���̺��� ���� Ȯ��
desc department;

select * from department;

/*
SQL : ����ȭ�� ���� ���

Select ������ ��ü �ʵ� ����

Select      <= �÷���
Distinct    <= �÷����� ���� �ߺ� �����ض�
From        <= ���̺��, ���.
Where       <= ����
Group By    <= Ư�� ���� �׷���
Having      <= �׷����� ���� ����
Order by    <= ���� �����ؼ� ���
*/

desc employees;

select * 
from employees;

-- Ư�� �÷��� ��� �ϱ�
select Employee_id, email from employees;

-- Ư�� �÷��� ������ ���
select eno, ename, eno, ename, from employees;

-- �÷��� ������ ������ �� �ִ�.
select eno, ename, salary, salary * 12 from employees;

-- �÷��� �˸��(Alias) : �÷��� �̸��� ����
    -- �÷��� ������ �ϰų� �Լ��� ����ϸ� �÷����� ��������.
Select eno, ename, salary, salary * 12 as ���� from employees;
Select eno as �����ȣ, ename as �����, salary as ����, salary * 12 as ���� from employees;
Select eno �����ȣ, ename �����, salary ����, salary * 12 ���� from employees;

-- nvl �Լ� : ����ÿ� null �� ó���ϴ� �Լ�
select * from employee;

-- nvl �Լ��� ������� �ʰ� ��ü ������ ���. (null �� ���Ե� �÷��� ������ �����ϸ� null)
    -- null�� 0���� ó���ؼ� �����ؾ���.    : NVL
select eno �����ȣ, ename �����, salary ����, commission ���ʽ� from employee; 
salary * 12,
salary * 12 + commission     -- ��ü ���� 
from employee;

--nvl �Լ��� ����ؼ� ����
select eno �����ȣ, ename �����, salary ����, commission ���ʽ� from employee; 
salary * 12,
salary * 12 + NVL(commission, 0)    -- ��ü ���� 
from employee;

-- Ư�� �÷��� ������ �ߺ� ���� �� ���
select * from employee;
select dno from employee;
select distinct dno from employee;

select ename, distinct dno from employee;

-- ������ ����ؼ� �˻� (Where)
select * from employee;
select eno �����ȣ, ename �����, job ��å, manager ���, manager ���ӻ��, hiredate �Ի糯¥,
        salary ����, commision ���ʽ�, dno �μ���ȣ
from employee

--��� ��ȣ�� 7788�� ����� �̸��� �˻�.
select * from employee
where eno = 7788;

select eno,ename from employee
where eno = 7788;

-- ��� ��ȣ�� 7788�� ����� �μ���ȣ, ���ް� �Ի� ��¥�� �˻�
select dno �μ���ȣ, salary ����, hiredate �Ի� ��¥
from emlpoyee
where eno = 7788

desc employee;

select *
from employee
where ename = 'SMITH';

-- ���ڵ带 ������ �� 
    -- number �� ���� ''�� ������ �ʴ´�.
    -- ���� ������(char, varchar2)�� ��¥ (date) �� ������ ���� ''�� ó��.
    -- ��ҹ��ڸ� ����
    
-- �Ի� ��¥�� '81/12/03' �� ��� ���    
select ename, hiredate
from employee
where hiredate = '81/12/03';

-- �μ� �ڵ尡 10�� ��� ������� ���.
select ename, dno
from employee
where dno = 30;

select * from employee;

-- ������ 3000 �̻��� ����� �̸��� �μ��� �Ի糯¥�� ���
select
from employee
where salary >= 3000;

-- NULL �˻� : is Ű���� ��� <== ���� : = �� ����ϸ� �ȵȴ�.
select *
from employee
where commision is null;

--commission �� 300 �̻��� ��� �̸�, ��å, ������ ���
select ename, job, salary, commission
from employee
where commision >= 300;

-- Ŀ�̼��� ���� ������� �̸� ���
select ename, commission
from employee
where commission is null

-- ���ǿ��� and, or, not

--������ 500 �̻� 2500 �̸��� ������� �̸�, �����ȣ, �Ի糯¥, ������ ���
select ename, dno, hiredate, salary
from employee
where salary >= 500 and salary < 2500;

-- 1. ��å�� SALEMAN �̰ų�, �μ� �ڵ尡 20�� ��� �̸�, ��å, ����, �μ��ڵ� ���
select * from employee;
select ename, job, salary, dno
from employee
where job = 'SALESMAN' or dno = 20;

-- 2. commission�� ���� ����� �߿� �μ� �ڵ尡 20�� ������� �̸��� �μ� �ڵ�� �Ի� ��¥�� ��� 
select ename, dno, hiredate
from employee
where commission is null and dno = 20

-- 3. commission�� null �� �ƴ� ������� �̸�, �Ի糯¥, ����
select ename, hiredate, salary, commission
from employee
where commission is not null

-- ��¥ �˻� : 
select * from employee;

-- 1982/1/1 ~ 1983/12/31 ���̿� �Ի��� ����� �̸�, ��å, �Ի糯¥
select ename, job, hiredate
from employee
where hiredate >= '1982/1/1' and hiredate <  '1983/12/31';

-- 1981 �⵵�� �Ի��� ����� �̸�, ��å, �Ի糯¥
select ename, job, hiredate
from employee
where hiredate >= '1981/1/1' and hiredate <  '1981/12/31';

-- between A and B : A �̻� B ����
select ename, job, hiredate
from employee
where hiredate between '1981/1/1' and '1981/12/31';

--IN ������

-- commission �� 300, 500, 1400�� ����� �̸�, ��å, �Ի����� ���
select * from employee;
select ename, job, hiredate, commission
from employee
where comission = 300 or commission = 500 or commission = 1400;

select ename, job, hiredate, commission
from employee
where comission in(300,500,1400);

-- like : �÷����� Ư���� ���ڿ��� �˻�          <== �� �˻� ����� ����� ��
    -- % : �ڿ� � ���ڰ� �͵� ��� ����.
    -- _ : �� ���ڰ� � ���� �͵� ��� ����.
    
-- F �� �����ϴ� �̸��� ���� ����� ��� �˻��ϱ�
select * from employee
where ename like 'F%';

-- �̸��� ES �� ������ ��� �˻�
select ename from employee
where ename like '%ES';

-- J�� ���� �ǰ� J ���� �α��ڰ� � ���� �͵� ��� ���� ��� ���. �ڿ��� ES �� ������
select ename
from employee
where ename like 'J__ES';

-- ������ ���ڰ� R �� ������ ��� ���
select *
from employee
where ename like '%R' ;

-- MAN �ܾ �� ��å�� ���
select *
from employee
where job like '%MAN%';

-- 81�⵵�� �Ի��� ����� ����ϱ�
select *
from employee
where hiredate >= '81/1/1' and hiredate <= '81/12/31';

select *
from employee
where hiredate between  '81/1/1' and '81/12/31';

select *
from employee
where hiredate like '81%';

-- 81�� 2���� �Ի��� ����� ���
select *
from emlpoyee
where hiredate like '81/02%';

-- ���� : order by, asc (�������� ����), desc (�������� ����)
select *
from emlpoyee
order by eno asc;   -- asc ���� ����

select *
from emlpoyee
order by eno desc;

-- �̸� �÷��� ����
select *
from emlpoyee
order by ename asc;

select *
from emlpoyee
order by ename desc;

--��¥ ����
select *
from emlpoyee
order by hiredate desc;

--���� �亯�� �Խ��ǿ��� �ַ� ��� 
select * from employee
order by dno desc;

-- �� ���� �÷��� ���� : ���� ó�� �÷��� ������ �ϰ�, ������ ���� ���ؼ� �� ��° �÷��� ���� 
select dno, ename 
from employee
order by dno, ename;

select dno, ename 
from employee
order by dno desc, ename desc;

-- Where ���� order by ���� ���� ���� ��
select *
from employee
where commission is null
order by ename desc;

-- �پ��� �Լ� ����ϱ�
/*
    1. ���ڸ� ó���ϴ� �Լ�
        - UPPER : �빮�ڷ� ��ȯ
        - LOWER : �ҹ��ڷ� ��ȯ
        - INITCAP : ù�ڴ� �빮�ڷ� �������� �ҹ��ڷ� ��ȯ
        
        dual ���̺� : �ϳ��� ����� ��� �ϵ��� �ϴ� ���̺�
*/
select '�ȳ��ϼ���' as �ȳ�
from dual 

select 'Oracle mania', upper('Oracle mania'), LOWER ('Oracle mania'), initcap('Oracle mania')
from dual

select * from employees;

select email, lower(email), initcap(email), upper(email) 
from employees;

select * from employees
where email = 'sking';      --�˻��� �ȵ�

select * from employees
where LOWER(email) = 'sking'; 

select email, initcap(email) from employees
where initcap(email) = 'sking'; 

--���� ���̸� ��� �ϴ� �Լ�
    -- length : ������ ���̸� ��ȯ, �����̳� �ѱ� ������� ���� ���� ���� (1byte)
    -- lengthb : ������ ���̸� ��ȯ, ���� 1byte �ѱ� 3byte �� ��ȯ
    
select length('Oracle mania'), length ('����Ŭ �ŴϾ�') from dual;

select lengthb('Oracle mania'), lengthb ('����Ŭ �ŴϾ�') from dual;

select * from employee

select email, length(email), employee_id, length(employee_id) from employees

--���� ���� �Լ� 
    -- concat : ���ڿ� ���ڸ� �����ؼ� ���
    -- substr : ���ڸ� Ư�� ��ġ���� �߶���� �Լ� ( ��� 1byte)
    -- substrib :  ���ڸ� Ư�� ��ġ���� �߶���� �Լ� (���� 1byte, �ѱ� 3byte �� ó��)
    -- instr : ������ Ư�� ��ġ�� �ε��� ���� ��ȯ
    -- instrb : ������ Ư�� ��ġ�� �ε��� ���� ��ȯ (���� 1byte, �ѱ� 3byte �� ó��)
    -- lpad, rpad : �Է� ���� ���ڿ����� Ư�� ���ڸ� ����.
    -- trm : �߶󳻰� ���� ���ڸ� ��ȯ
    
 select 'Oracle', 'mania', concat ('Oracle' , 'mania') from dual  
 
 select * from employees;
 
 select concat (email,'   ' || job_id) from employees;
 
 select '�̸��� :' || email ||  '�̰�, ��å�� : ' || job_id || '�Դϴ�' as �÷� ����
 from employees; 
 
 select '�̸��� : ' || ename || ' �̰�, ���� ��� ����� : ' || manager || '�Դϴ�.'  as ���ӻ�����
 from employee;
 
 -- �̸��� N���� ������ ����� ����ϱ�(substr �Լ� ���)
 select ename from emloyee
 where substr (ename, -1,1) = 'N'
 
 select ename from employee
 where ename like '%N';
 
 -- 87�⵵ �Ի��� ����� ����ϱ� (substr)
 select hire_date, substr( hire_date, 1, 2) from employees;

select * from employee
where hiredate like '87%';

-- instr( ��� ,ã�� ����, ���� ��ġ, �� ��° �߰�) : ��󿡼� ã�� ������ �ε��� ���� ���
select 'Oracle mania' , instr ('Oracle mania, 'O') from dual;

select 'Oracle mania' , instr ('Oracle mania, 'a', 5.2) from dual;

 -- substr (���, ���� ��ġ, ���ⰳ��) : Ư�� ��ġ���� ���ڸ� �߶�´�.
 select 'Oracle mania', substr('Oracle mania', 4, 3), substr('����Ŭ �ŴϾ�', 2, 4) 
 from dual ;
 
  select 'Oracle mania', substr('Oracle mania', -4, 3), substr('����Ŭ �ŴϾ�', -2, 4) 
 from dual ;
 
 select email, substr(email, 3, 2), substr(email, -5, 2) from employees;
 
 select substrb('Oracle mania', 3, 3), substrb ('����Ŭ �ŴϾ�', 3, 6) from dual;
 
