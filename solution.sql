create database BankDb;

create table Banks (
    Id int not null,
    Name nvarchar(30) not null,
    primary key (Id)
);

create table Cities(
    Id int not null,
    Name nvarchar(30) not null,
    primary key (Id)
);

create table Streets(
    Id int not null,
    Name nvarchar(30) not null,
    primary key (Id)
);

create table Branches (
    Id int not null,
    BankId int not null,
    CityId int not null,
    StreetId int not null,
    BuildingNumber int not null,
    BuildingLetter nvarchar(2),
    primary key (Id),
    foreign key (BankId) references Banks(Id),
    foreign key (CityId) references Cities(Id)
);

create table SocialStatuses(
    Id int not null,
    Name nvarchar(30) not null
);

create table Customers(
    Id int not null,
    FirstName nvarchar(30) not null,
    LastName nvarchar(30) not null,
    MidName nvarchar(30),
    SocialStatusId int not null,
    primary key (Id)
);

create table Accounts(
    Id int not null,
    CustomerId int not null,
    BankId int not null,
    Balance decimal default(0.0) not null
    primary key (Id),
    foreign key (BankId) references Banks(Id),
    foreign key (CustomerId) references Customers(Id)
);

create table Cards(
    Id int not null,
    AccountId int not null,
    Balance decimal default(0.0) not null
    primary key (Id),
    foreign key (AccountId) references Accounts(Id)
);

delete from dbo.Cards;
delete from dbo.Branches;
delete from dbo.Accounts;
delete from dbo.Banks;
delete from dbo.Cities;
delete from dbo.Customers;
delete from dbo.SocialStatuses;
delete from dbo.Streets;

insert into Banks(Id, Name) values (1, 'bank A');
insert into Banks(Id, Name) values (2, 'bank B');
insert into Banks(Id, Name) values (3, 'bank C');
insert into Banks(Id, Name) values (4, 'bank D');
insert into Banks(Id, Name) values (5, 'bank E');

insert into Cities(Id, Name) values (1, 'Полоцк');
insert into Cities(Id, Name) values (2, 'Новополоцк');
insert into Cities(Id, Name) values (3, 'Витебск');
insert into Cities(Id, Name) values (4, 'Минск');
insert into Cities(Id, Name) values (5, 'Майдугури');

insert into Streets(Id, Name) values (1, 'Стрелецкая');
insert into Streets(Id, Name) values (2, 'Зыгина');
insert into Streets(Id, Name) values (3, 'Молодёжная');
insert into Streets(Id, Name) values (4, 'Правды');
insert into Streets(Id, Name) values (5, 'Фрунзе');
insert into Streets(Id, Name) values (6, 'Maiduguri-road');
insert into Streets(Id, Name) values (7, 'Lafia-road');

insert into Branches(Id, BankId, CityId, StreetId, BuildingNumber, BuildingLetter) values (1, 1, 1, 2, 32, null);
insert into Branches(Id, BankId, CityId, StreetId, BuildingNumber, BuildingLetter) values (2, 2, 1, 2, 12, null);
insert into Branches(Id, BankId, CityId, StreetId, BuildingNumber, BuildingLetter) values (3, 2, 2, 3, 3, 'а');
insert into Branches(Id, BankId, CityId, StreetId, BuildingNumber, BuildingLetter) values (4, 1, 4, 5, 4, null);
insert into Branches(Id, BankId, CityId, StreetId, BuildingNumber, BuildingLetter) values (5, 3, 2, 3, 4, null);
insert into Branches(Id, BankId, CityId, StreetId, BuildingNumber, BuildingLetter) values (6, 4, 3, 4, 5, null);
insert into Branches(Id, BankId, CityId, StreetId, BuildingNumber, BuildingLetter) values (7, 3, 5, 6, 17, 'б');
insert into Branches(Id, BankId, CityId, StreetId, BuildingNumber, BuildingLetter) values (8, 4, 2, 3, 10, null);
insert into Branches(Id, BankId, CityId, StreetId, BuildingNumber, BuildingLetter) values (9, 4, 5, 7, 43, 'а');
insert into Branches(Id, BankId, CityId, StreetId, BuildingNumber, BuildingLetter) values (10, 5, 4, 4, 61, 'а');
insert into Branches(Id, BankId, CityId, StreetId, BuildingNumber, BuildingLetter) values (11, 3, 3, 5, 16, null);
insert into Branches(Id, BankId, CityId, StreetId, BuildingNumber, BuildingLetter) values (12, 4, 1, 1, 40, 'в');
insert into Branches(Id, BankId, CityId, StreetId, BuildingNumber, BuildingLetter) values (13, 5, 2, 3, 10, null);
insert into Branches(Id, BankId, CityId, StreetId, BuildingNumber, BuildingLetter) values (14, 5, 3, 5, 8, null);
insert into Branches(Id, BankId, CityId, StreetId, BuildingNumber, BuildingLetter) values (15, 5, 5, 7, 19, null);

insert into SocialStatuses(Id, Name) values (1, 'Ребёнок');
insert into SocialStatuses(Id, Name) values (2, 'Пенсионер');
insert into SocialStatuses(Id, Name) values (3, 'Инвалид');
insert into SocialStatuses(Id, Name) values (4, 'Пролетарий');
insert into SocialStatuses(Id, Name) values (5, 'Родитель в многодетной семье');
insert into SocialStatuses(Id, Name) values (6, 'Безработный');

insert into Customers(Id, FirstName, LastName, MidName, SocialStatusId) values (1, 'Mike', 'Iamont', null, 4);
insert into Customers(Id, FirstName, LastName, MidName, SocialStatusId) values (2, 'Igor', 'Operator', 'Yupovich', 4);
insert into Customers(Id, FirstName, LastName, MidName, SocialStatusId) values (3, 'William', 'Akatus', 'Brabovich', 6);
insert into Customers(Id, FirstName, LastName, MidName, SocialStatusId) values (4, 'Una', 'Gi', null, 5);
insert into Customers(Id, FirstName, LastName, MidName, SocialStatusId) values (5, 'Soma', 'Lotos', 'Otoyevna', 6);

insert into Accounts(Id, CustomerId, BankId, Balance) values (1, 1, 1, 10.0);
insert into Accounts(Id, CustomerId, BankId, Balance) values (2, 5, 4, 20.0);
insert into Accounts(Id, CustomerId, BankId, Balance) values (3, 4, 5, 100.0);
insert into Accounts(Id, CustomerId, BankId, Balance) values (4, 3, 3, 30.0);
insert into Accounts(Id, CustomerId, BankId, Balance) values (5, 2, 2, 50.0);

insert into Cards(Id, AccountId, Balance) values (1, 1, 0.0);
insert into Cards(Id, AccountId, Balance) values (2, 1, 5.0);
insert into Cards(Id, AccountId, Balance) values (3, 2, 10.0);
insert into Cards(Id, AccountId, Balance) values (4, 5, 20.0);
insert into Cards(Id, AccountId, Balance) values (5, 3, 60.0);
insert into Cards(Id, AccountId, Balance) values (6, 3, 30.0);
insert into Cards(Id, AccountId, Balance) values (7, 5, 20.0);
insert into Cards(Id, AccountId, Balance) values (8, 5, 10.0);



/*Задания*/

/*Задание №1*/
select distinct b.Name
from dbo.Branches as br
    inner join dbo.Banks as b 
    on br.BankId = b.Id
where br.CityId = 1 /*Полоцк*/


/*Задание №2*/
select cst.FirstName, crd.Balance, bnk.Name
from dbo.Cards as crd
    inner join dbo.Accounts as acc
    on crd.AccountId = acc.Id
    inner join dbo.Customers as cst
    on acc.CustomerId = cst.Id
    inner join dbo.Banks as bnk
    on acc.BankId = bnk.Id

/*Задание №3*/
select acc.Id, cst.FirstName, cst.LastName, cst.MidName, bnk.Name,
       (acc.Balance - (select sum(crd.Balance) 
                       from dbo.Cards as crd
                       group by crd.AccountId
                       having crd.AccountId = acc.Id)) as 'Balance Diff'
from dbo.Accounts as acc
    inner join dbo.Customers as cst
    on acc.CustomerId = cst.Id
    inner join dbo.Banks as bnk
    on acc.BankId = bnk.Id
where acc.Balance > (select sum(crd.Balance) 
                     from dbo.Cards as crd
                     group by crd.AccountId
                     having crd.AccountId = acc.Id)

/*Задание №4*/
/*через group by*/
select scst.Name, count(crd.Id)
from dbo.Cards as crd
    inner join dbo.Accounts as acc
    on crd.AccountId = acc.Id
    inner join dbo.Customers as cst
    on acc.CustomerId = cst.Id
    inner join dbo.SocialStatuses as scst
    on cst.SocialStatusId = scst.Id
group by scst.Name

/*через подзапросы*/
select scst.Name, 
       (select count(crd.Id)
        from dbo.Cards as crd
        inner join dbo.Accounts as acc
        on crd.AccountId = acc.Id
        inner join dbo.Customers as cst
        on acc.CustomerId = cst.Id
        group by cst.SocialStatusId
        having cst.SocialStatusId = scst.Id) as 'Count'
from dbo.SocialStatuses as scst

go

/*Задание №5*/
create proc ReplenishTheBalanceOn10Dollars
    @socialStatusId int
as
begin
    declare @socStatusId int = (select Id 
                                from dbo.SocialStatuses as scst 
                                where scst.Id = @socialStatusId);

    declare @relatedAccountsCount int = (select count(acc.Id)
                                         from dbo.Accounts as acc
                                            inner join dbo.Customers as cst
                                            on acc.CustomerId = cst.Id
                                         group by cst.SocialStatusId
                                         having cst.SocialStatusId = @socialStatusId);
    if (@socStatusId = @socialStatusId and @relatedAccountsCount > 0)
        update dbo.Accounts
        set Balance = Balance + 10
        where CustomerId = (select Id 
                            from dbo.Customers as cst
                            where cst.Id = CustomerId and cst.SocialStatusId = @socialStatusId)
        
end
go

/*проверка*/
select * from dbo.Accounts;
go

exec dbo.ReplenishTheBalanceOn10Dollars 5

go
select * 
from dbo.Accounts;

/*Задание №6*/
select acc.Id, cst.FirstName, cst.LastName, cst.MidName,
       (acc.Balance - (select sum(crd.Balance) 
                       from dbo.Cards as crd
                       group by crd.AccountId
                       having crd.AccountId = acc.Id)) as 'Balance Diff'
from dbo.Accounts as acc
    inner join dbo.Customers as cst
    on acc.CustomerId = cst.Id
    inner join dbo.Banks as bnk
    on acc.BankId = bnk.Id
go

/*Задание 7*/
create proc TransferMoneyFromAccountToCard
    @accountId int,
    @cardId int,
    @amountOfMoney decimal
as
begin
    
    declare @accountIdFromTable int = (select Id 
                                       from dbo.Accounts
                                       where Id = @accountId);

    declare @cardIdFromTable int = (select Id 
                                    from dbo.Cards
                                    where Id = @cardId);

    declare @validAmountOfMoneyForTransfer int = (select
                                                  acc.Balance - (select sum(crd.Balance) 
                                                                 from dbo.Cards as crd
                                                                 group by crd.AccountId
                                                                 having crd.AccountId = acc.Id)
                                                  from dbo.Accounts as acc
                                                  where acc.Id = @accountId);

    begin tran moneyTransfer
    if(@accountIdFromTable = @accountId and @cardIdFromTable = @cardId and @validAmountOfMoneyForTransfer > @amountOfMoney)
        update dbo.Cards
        set Balance = Balance + @amountOfMoney
        where Id = @cardId
    commit moneyTransfer

end
go

/*проверка*/
select * from dbo.Accounts;
select * from dbo.Cards;
go
exec dbo.TransferMoneyFromAccountToCard 3, 5, 10.0
go
select * from dbo.Accounts;
select * from dbo.Cards;
go

/*Задание №8*/
create trigger CheckBalanceChangingInAccount
on dbo.Accounts after update
as
begin;
    declare @accountId int = (select top(1) Id from deleted);
    declare @minMoneyBalance int = (select sum(crd.Balance) 
                                    from dbo.Cards as crd
                                    group by crd.AccountId
                                    having crd.AccountId = @accountId);
    declare @newMoneyBalance int = (select top(1) Balance from inserted);
    if(@minMoneyBalance > @newMoneyBalance)
        update dbo.Accounts
        set Balance = (select top(1) Balance from deleted)
        where Id = @accountId;
end;
go


/*проверка*/
select * from dbo.Accounts;
update dbo.Accounts
set Balance = 10
where Id = 3;
select * from dbo.Accounts;
go
