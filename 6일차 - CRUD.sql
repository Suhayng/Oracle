6일차 - CRUD ( Create, Read, Update, Delete)

-- Object (객체) : DataBase 의 존재 (XE, <= Express Edition (무료 버전), 
--                 Standard(유료), Enterprise Edition(유료))
        -- 1. 테이블, 2. 뷰, 3. 저장프로시져, 4. 트리거, 5. 인텍스, 6. 함수, 7. 시퀀스       <== DDL (Create, Alter, Drop)

-- 테이블 생성 ( Create ) -- DDL 객체 생성
/*
    Create Table 테이블명 (
        컬럼명  자료형  널허용여부 [제약조건],
        컬럼명  자료형  널허용여부 [제약조건],
        컬럼명  자료형  널허용여부 [제약조건]
    );
*/


Create Table dept (
    dno number(2) not null,
    dname varchar(14) not null,
    loc varchar2(13) null
    );
    
select * from dept;

-- DML : 테이블의 값(레코드, 로우)을 넣고(insert), 수정(update), 삭제(delete) 
    -- 트렌젝션을 발생 시킴 : log 에 기록을 먼저 하고 Database 에 적용한다.
  
    begin transaction;  -- 트랜 잭션 시작   ( insert, update, delete 구문이 시작되면 자동으로 시작 )
    rollback;           -- 트랜 잭션을 롤백 ( RAM에 적용된 트랜잭션을 삭제 )
    commit;             -- 트랜 잭션을 적용 ( 실제 DataBase에 영원히 적용 )
    
  
  /*
     insert into 테이블명 (컬럼명1, 컬럼명2, 컬럼명3)
     values (10, 'MANAGER','SEOUL');
  */
  
    
insert into dept (dno, dname, loc)
values (10, 'MANAGER','SEOUL');

-- insert, update, delete 구문은 자동으로 트랜잭션이 시작 (begin transaction;) - RAM 에만 적용되어 있는 상태

rollback;
commit;

/*
    insert 시 컬럼명을 생략
    insert into dept 
    values (값1, 값2, 값3)
*/

select * from dept;

insert into dept
values (20, 'ACCOUNTING', 'BUSAN');

commit;

desc dept;

/*NULL 허용 컬럼에 값을 넣지 않기*/
insert int dept (dno, dname)
value (30, 'RESEARCH');

/*
    제약조건
        -- 중복된 값을 넣을 수 없다.
        -- UNIQUE : 중복되지 않는 고유한 값을 저장. 하나의 테이블에서 여러 컬럼에 지정할 수 있다.
                - NULL 허용함. NULL 을 
        중복된 값을 넣을 수 없다.

*/