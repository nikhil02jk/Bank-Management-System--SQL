create database bankmanagement

use bankmanagement
Create Table Customer(
 FName varchar(30) not null,LName varchar(30) not null ,Gender char(1) not null,BirthDate date not null,CIF bigint not null primary key
,ContactNo bigint not null, Address varchar(50) not null,
 HomeBranch int not null ,OpeningDate date not null,  IdentificationNo varchar(15) not null,
Constitution varchar(10) not null , unique (ContactNo),
/*check constraint*/
check (CIF <= 999999999999),check (ContactNo <= 99999999999), check (HomeBranch <= 999999));

insert into Customer(FName,LName,Gender,BirthDate,CIF,ContactNo, Address,HomeBranch,OpeningDate,IdentificationNo,Constitution)
values('archie','andrews','m','2004-09-02','12345','9998887','newzealand','9999','2005-09-04','1113334','individual'),
('betty','cooper','f','2006-08-01','54321','8886664','california','8888','2009-09-04','2223334','individual'),
('jason','blossom','m','2003-03-05','52678','7774442','riverdale','7777','2007-07-05','5551117','individual'),
('veronica','lodge','f','2004-04-01','65389','1112224','newyork','6666','2006-06-05','3338884','individual'),
('cheryl','blossom','f','2001-01-03','63178','6662221','denmark','0011','2002-05-07','9995553','individual'),
('hairam','andrews','m','2009-09-02','123123','999416','newzealand','9999','2005-09-04','1183334','individual'),
('tony','andrews','f','2001-09-02','123508','9298887','newzealand','9999','2005-09-04','1913334','individual'),
('pops','andrews','m','2004-07-02','653187','1998887','newzealand','9999','2005-04-04','88113334','individual'),
('alis','lodge','f','2004-09-07','772345','66998887','riverdale','7777','2007-01-04','4413334','individual'),
('alis','cooper','f','2002-07-02','673187','1798887','newzealand','9999','2005-04-04','41193334','individual'),
('grundi','lodge','f','2004-09-07','7729945','66999087','riverdale','7777','2007-01-04','4477334','individual');




Create Table Employee(PFNo bigint not null primary key, EmpName varchar(30) not null, BirthDate date not null, Designation varchar(25),
Type varchar(7) not null, Capability int not null,
Address varchar(50) not null, ContactNo bigint not null,
JoiningDate date not null, Gender char(1) not null,
check (PFNo <= 99999999), check (Capability<10),
check (ContactNo <= 99999999999));


insert into Employee(PFNo,EmpName,BirthDate,Designation,Type,Capability,Address,ContactNo,JoiningDate,Gender)
values('111111','thomas','1999-09-09','manager','checker','9','bermingham','999888','2003-03-03','m'),
('222222','arthur','1998-08-08','watchman','checker','8','london','777888','2004-04-04','m'),
('333333','polly','1994-04-04','accountant','maker','9','singapore','666888','2005-05-05','f'),
('444444','jhon','1993-03-03','clerk','maker','7','newyork','555888','2006-06-06','m'),
('555555','grace','1992-02-02','accountant','checker','9','paris','444888','2007-07-07','m');



Create Table Accounts(
AccountNo bigint not null primary key, CIF bigint not null,
OpeningDate date not null, AccType varchar(7) not null,
Facility varchar(11) not null, Balance int not null,
InterestRate float not null, check (AccountNo<=99999999999),
check (CIF<=99999999999), check(InterestRate<=10.00));
drop table Accounts


insert into Accounts(AccountNo,CIF,OpeningDate, AccType,Facility,Balance,InterestRate)
values('5551112','12345','2005-09-04','sb','credit','10000','5.30'),
('3330001','54321','2009-09-04','nri','loan','20000','6.60'),
('0001112','52678','2007-07-05','nri','credit','30000','7.70'),
('2227771','65389','2006-06-05','sb','loan','40000','8.80'),
('4441118','63178','2002-05-07','nri','loan','50000','5.50'),
('4441122','123123','2002-05-07','nri','loan','90000','5.50'),
('4441133','123508','2002-05-07','sb','credit','95000','7.50'),
('4441144','653187','2002-05-07','nri','loan','70000','8.50'),
('4441155','772345','2002-05-07','sb','credit','90800','6.50'),
('4441166','673187','2002-05-07','nri','loan','99000','5.50'),
('4441177','7729945','2002-05-07','sb','credit','93000','5.50'),
('44434217','7729945','2002-05-07','nri','loan','88000','5.60');



Create Table Transactions(
TransactionID varchar(10) not null primary key,
AccNo bigint not null, transactionType varchar(9) not null,
Amount int not null, MakerId bigint not null,
CheckerId bigint not null, check (AccNo <= 99999999999),

check (MakerId <= 99999999), check (CheckerId <= 99999999));
ALTER TABLE Transactions ADD CONSTRAINT AccNo FOREIGN KEY(AccNo)references Accounts(AccountNo)on delete cascade on update cascade



insert into Transactions(TransactionID,AccNo, transactionType,Amount, MakerId,CheckerId)
values('888111','5551112','credit','200','333333','111111'),
('777222','3330001','debit','3000','444444','222222'),
('666333','0001112','credit','3000','333333','111111'),
('555444','2227771','debit','4000','444444','555555'),
('444333','4441118','credit','5000','333333','222222'),
('444334','4441122','debit','9000','333333','222222'),
('444335','4441133','credit','5000','444444','555555'),
('444336','4441144','debit','2000','333333','111111'),
('444337','4441155','credit','3000','444444','222222'),
('444338','4441166','debit','8000','333333','555555'),
('444339','4441177','credit','3500','444444','222222');
/*drop table Transactions
drop table violationafterupdate*/

select* from Transactions

create table rleviolation(
message varchar (20),
ACC1 bigint,
log_action varchar(20),
log_timestamp date
)

create table violationafterupdate(
message varchar (20),
ACC1 bigint,
log_action varchar(20),
log_timestamp date
)

/*trigger after insert*/

GO
CREATE TRIGGER violationafterinsert on Transactions AFTER INSERT
AS

DECLARE @Amount bigint;
DECLARE @Type varchar(20);
DECLARE @ACC1 bigint;
DECLARE @log_action varchar(20);
select
@Amount=i.Amount,@ACC1=i.AccNo,@Type=i.Transactiontype from inserted i;

set @log_action='inserted record';
if(@Amount<1000 or @Amount>1000000)
insert into rleviolation(message,ACC1  ,log_action,log_timestamp)values('rule violated',@ACC1,@log_action,getdate());
else
insert into rleviolation(message,ACC1,log_action,log_timestamp)values('',@ACC1,@log_action,getdate());
print'after inserted triggered fired'



select* from rleviolation
/*trigger after update*/
GO
CREATE TRIGGER violationafterupdation on Transactions AFTER update
AS

DECLARE @Amount bigint;
DECLARE @Type varchar(20);
DECLARE @ACC1 bigint;
DECLARE @log_action varchar(20);
select
@Amount=i.Amount,@ACC1=i.AccNo,@Type=i.Transactiontype from inserted i;
set @log_action='updated record';
if(@Amount<1000 or @Amount>1000000)
insert into violationafterupdate(message,ACC1  ,log_action,log_timestamp)values('rule violated',@ACC1,@log_action,getdate());
else
insert into violationafterupdate(message,ACC1  ,log_action,log_timestamp)values('',@ACC1,@log_action,getdate());
print'after updated triggered fired'

select* from rleviolation;
update Transactions set Amount=20000 where AccNo=5551112;
select* from violationafterupdate;


/*queries*/

1)Find the fname,lname and cif of all customers who have a loan account at the bank.

select distinct fname,lname,customer.cif
    -> from customer,transactions,accounts
    -> where transactions.accountno=accounts.accountno and transactions.acctype='loan';



2)among the manager who has the highest capability

 select empname,pfno
    -> from employee
    -> where (designation,capability)in (select designation,max(capability)
    ->                                    from employee
    ->                                    where designation='manager'
    ->                                    group by designation);



3) find the fname and balance of an nri resident whose native adress is newzealnd with an intresrt rate above 5.


 select customer.fname,balance
    -> from accounts,customer
    -> where customer.cif = accounts.cif  and accounts.acctype='nri' and  customer.address = 'newzealand' group by fname having count(accounts.interestrate>5.00);
+--------+---------+
| fname  | balance |
+--------+---------+
| hairam |   90000 |
| pops   |   70000 |
| alis   |   99000 |
+--------+---------+
3 rows in set (0.00 sec)
