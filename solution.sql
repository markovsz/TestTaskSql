create database BankDb;

create table Banks (
    Id int identity not null,
    Name nvarchar(30) not null,
    primary key (Id)
);

create table Cities(
    Id int identity not null,
    Name nvarchar(30) not null,
    primary key (Id)
);

create table Branches (
    Id int identity not null,
    BankId int not null,
    CityId int not null,
    Address nvarchar(60) not null,
    primary key (Id),
    foreign key (BankId) references Banks(Id),
    foreign key (CityId) references Cities(Id)
);

create table SocialStatuses(
    Id int identity not null,
    Name nvarchar(30) not null,
    primary key (Id)
);

create table Customers(
    Id int identity not null,
    FirstName nvarchar(30) not null,
    LastName nvarchar(30) not null,
    MidName nvarchar(30),
    SocialStatusId int not null,
    primary key (Id),
    foreign key (SocialStatusId) references SocialStatuses(Id)
);

create table Accounts(
    Id int identity not null,
    CustomerId int not null,
    BankId int not null,
    Balance decimal default(0.0) not null
    primary key (Id),
    foreign key (BankId) references Banks(Id),
    foreign key (CustomerId) references Customers(Id)
);

create table Cards(
    Id int identity not null,
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

insert into Banks(Name) values ('bank A');
insert into Banks(Name) values ('bank B');
insert into Banks(Name) values ('bank C');
insert into Banks(Name) values ('bank D');
insert into Banks(Name) values ('bank E');

insert into Cities(Name) values ('Полоцк');
insert into Cities(Name) values ('Новополоцк');
insert into Cities(Name) values ('Витебск');
insert into Cities(Name) values ('Минск');
insert into Cities(Name) values ('Майдугури');

insert into Branches(BankId, CityId, Address) values (1, 1, 'Зыгина 32');
insert into Branches(BankId, CityId, Address) values (2, 1, 'Зыгина 12');
insert into Branches(BankId, CityId, Address) values (2, 2, 'Молодёжная 30, а');
insert into Branches(BankId, CityId, Address) values (1, 4, 'Фрунзе 4');
insert into Branches(BankId, CityId, Address) values (3, 2, 'Молодёжная 4');
insert into Branches(BankId, CityId, Address) values (4, 3, 'Правды 50');
insert into Branches(BankId, CityId, Address) values (3, 5, 'Maiduguri-road 17б');
insert into Branches(BankId, CityId, Address) values (4, 2, 'Молодёжная 100');
insert into Branches(BankId, CityId, Address) values (4, 5, 'Lafia-road 43а');
insert into Branches(BankId, CityId, Address) values (5, 4, 'Правды 61а');
insert into Branches(BankId, CityId, Address) values (3, 3, 'Фрунзе 16');
insert into Branches(BankId, CityId, Address) values (4, 1, 'Стрелецкая 40в');
insert into Branches(BankId, CityId, Address) values (5, 2, 'Молодёжная 59');
insert into Branches(BankId, CityId, Address) values (5, 3, 'Фрунзе 8');
insert into Branches(BankId, CityId, Address) values (5, 5, 'Lafia-road 19');

insert into SocialStatuses(Name) values ('Ребёнок');
insert into SocialStatuses(Name) values ('Пенсионер');
insert into SocialStatuses(Name) values ('Инвалид');
insert into SocialStatuses(Name) values ('Пролетарий');
insert into SocialStatuses(Name) values ('Родитель в многодетной семье');
insert into SocialStatuses(Name) values ('Безработный');

insert into Customers(FirstName, LastName, MidName, SocialStatusId) values ('Mike', 'Iamont', null, 4);
insert into Customers(FirstName, LastName, MidName, SocialStatusId) values ('Igor', 'Operator', 'Yupovich', 4);
insert into Customers(FirstName, LastName, MidName, SocialStatusId) values ('William', 'Akatus', 'Brabovich', 6);
insert into Customers(FirstName, LastName, MidName, SocialStatusId) values ('Una', 'Gi', null, 5);
insert into Customers(FirstName, LastName, MidName, SocialStatusId) values ('Soma', 'Lotos', 'Otoyevna', 6);

insert into Accounts(CustomerId, BankId, Balance) values (1, 1, 10.0);
insert into Accounts(CustomerId, BankId, Balance) values (5, 4, 20.0);
insert into Accounts(CustomerId, BankId, Balance) values (4, 5, 100.0);
insert into Accounts(CustomerId, BankId, Balance) values (3, 3, 30.0);
insert into Accounts(CustomerId, BankId, Balance) values (2, 2, 50.0);

insert into Cards(AccountId, Balance) values (1, 0.0);
insert into Cards(AccountId, Balance) values (1, 5.0);
insert into Cards(AccountId, Balance) values (2, 10.0);
insert into Cards(AccountId, Balance) values (5, 20.0);
insert into Cards(AccountId, Balance) values (3, 60.0);
insert into Cards(AccountId, Balance) values (3, 30.0);
insert into Cards(AccountId, Balance) values (5, 20.0);
insert into Cards(AccountId, Balance) values (5, 10.0);



/*Задания*/

/*Задание №1*/
/*Покажи мне список банков у которых есть филиалы в городе X (выбери один из городов)*/

select distinct b.Name
from dbo.Branches as br
    inner join dbo.Banks as b 
    on br.BankId = b.Id
where br.CityId = 1 /*Полоцк*/


/*Задание №2*/
/*Получить список карточек с указанием имени владельца, баланса и названия банка*/

select cst.FirstName, crd.Balance, bnk.Name
from dbo.Cards as crd
    inner join dbo.Accounts as acc
    on crd.AccountId = acc.Id
    inner join dbo.Customers as cst
    on acc.CustomerId = cst.Id
    inner join dbo.Banks as bnk
    on acc.BankId = bnk.Id

/*Задание №3*/
/*Показать список банковских аккаунтов у которых баланс не совпадает с суммой баланса по карточкам. В отдельной колонке вывести разницу*/

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
/*Вывести кол-во банковских карточек для каждого соц статуса (2 реализации, GROUP BY и подзапросом)*/

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
/*Написать stored procedure которая будет добавлять по 10$ на каждый банковский аккаунт для определенного соц статуса 
(У каждого клиента бывают разные соц. статусы. Например, пенсионер, инвалид и прочее). 
Входной параметр процедуры - Id социального статуса. 
Обработать исключительные ситуации (например, был введен неверные номер соц. статуса. 
Либо когда у этого статуса нет привязанных аккаунтов).*/

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
/*Получить список доступных средств для каждого клиента. 
То есть если у клиента на банковском аккаунте 60 рублей, и у него 2 карточки по 15 рублей на каждой, 
то у него доступно 30 рублей для перевода на любую из карт*/

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
/*Написать процедуру которая будет переводить определённую сумму со счёта на карту этого аккаунта.  
При этом будем считать что деньги на счёту все равно останутся, просто сумма средств на карте увеличится. 
Например, у меня есть аккаунт на котором 1000 рублей и две карты по 300 рублей на каждой. 
Я могу перевести 200 рублей на одну из карт, при этом баланс аккаунта останется 1000 рублей, а на картах будут суммы 300 и 500 рублей соответственно. 
После этого я уже не смогу перевести 400 рублей с аккаунта ни на одну из карт, так как останется всего 200 свободных рублей (1000-300-500). 
Переводить БЕЗОПАСНО. То есть использовать транзакцию*/

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
/*Написать триггер на таблицы Account/Cards чтобы нельзя была занести значения в поле баланс 
если это противоречит условиям  (то есть нельзя изменить значение в Account на меньшее, чем сумма балансов по всем карточкам. 
И соответственно нельзя изменить баланс карты если в итоге сумма на картах будет больше чем баланс аккаунта)*/
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
