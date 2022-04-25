6���� - CRUD ( Create, Read, Update, Delete)

-- Object (��ü) : DataBase �� ���� (XE, <= Express Edition (���� ����), 
--                 Standard(����), Enterprise Edition(����))
        -- 1. ���̺�, 2. ��, 3. �������ν���, 4. Ʈ����, 5. ���ؽ�, 6. �Լ�, 7. ������       <== DDL (Create, Alter, Drop)

-- ���̺� ���� ( Create ) -- DDL ��ü ����
/*
    Create Table ���̺�� (
        �÷���  �ڷ���  ����뿩�� [��������],
        �÷���  �ڷ���  ����뿩�� [��������],
        �÷���  �ڷ���  ����뿩�� [��������]
    );
*/


Create Table dept (
    dno number(2) not null,
    dname varchar(14) not null,
    loc varchar2(13) null
    );
    
select * from dept;

-- DML : ���̺��� ��(���ڵ�, �ο�)�� �ְ�(insert), ����(update), ����(delete) 
    -- Ʈ�������� �߻� ��Ŵ : log �� ����� ���� �ϰ� Database �� �����Ѵ�.
  
    begin transaction;  -- Ʈ�� ��� ����   ( insert, update, delete ������ ���۵Ǹ� �ڵ����� ���� )
    rollback;           -- Ʈ�� ����� �ѹ� ( RAM�� ����� Ʈ������� ���� )
    commit;             -- Ʈ�� ����� ���� ( ���� DataBase�� ������ ���� )
    
  
  /*
     insert into ���̺�� (�÷���1, �÷���2, �÷���3)
     values (10, 'MANAGER','SEOUL');
  */
  
    
insert into dept (dno, dname, loc)
values (10, 'MANAGER','SEOUL');

-- insert, update, delete ������ �ڵ����� Ʈ������� ���� (begin transaction;) - RAM ���� ����Ǿ� �ִ� ����

rollback;
commit;

/*
    insert �� �÷����� ����
    insert into dept 
    values (��1, ��2, ��3)
*/

select * from dept;

insert into dept
values (20, 'ACCOUNTING', 'BUSAN');

commit;

desc dept;

/*NULL ��� �÷��� ���� ���� �ʱ�*/
insert int dept (dno, dname)
value (30, 'RESEARCH');

/*
    ��������
        -- �ߺ��� ���� ���� �� ����.
        -- UNIQUE : �ߺ����� �ʴ� ������ ���� ����. �ϳ��� ���̺��� ���� �÷��� ������ �� �ִ�.
                - NULL �����. NULL �� 
        �ߺ��� ���� ���� �� ����.

*/