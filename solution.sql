create database BankDb;

create table Banks (
    Id int identity not null,
    Name nvarchar(30) not null,
    primary key (Id)
);

create table Cities(
    Id int identity not null,
    Name nvarchar(30) unique not null,
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
    Name nvarchar(30) unique not null,
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
    foreign key (CustomerId) references Customers(Id),
    constraint Accounts_Balance_NotNegative check (Balance >= 0.0),
    constraint Accounts_CustomerAndBank_Unique unique(CustomerId, BankId)
);

create table Cards(
    Id int identity not null,
    CardNumber nvarchar(16) not null,
    AccountId int not null,
    Balance decimal default(0.0) not null
    primary key (Id),
    foreign key (AccountId) references Accounts(Id),
    constraint Cards_Balance_NotNegative check (Balance >= 0.0),
    constraint Cards_CardNumber_Length16 check(len(CardNumber) = 16),
    constraint Cards_CardNumber_OnlyDigits Check(CardNumber not like '%[^0-9]%')
);

delete from dbo.Cards;
delete from dbo.Branches;
delete from dbo.Accounts;
delete from dbo.Banks;
delete from dbo.Cities;
delete from dbo.Customers;
delete from dbo.SocialStatuses;

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

insert into Cards(AccountId, CardNumber, Balance) values (1, '9018461930481734', 0.0);
insert into Cards(AccountId, CardNumber, Balance) values (1, '9018461912481734', 5.0);
insert into Cards(AccountId, CardNumber, Balance) values (2, '9018281273123778', 10.0);
insert into Cards(AccountId, CardNumber, Balance) values (5, '9018203480123778', 20.0);
insert into Cards(AccountId, CardNumber, Balance) values (3, '9018904555123778', 60.0);
insert into Cards(AccountId, CardNumber, Balance) values (3, '9018344555123778', 30.0);
insert into Cards(AccountId, CardNumber, Balance) values (5, '1827203480123778', 20.0);
insert into Cards(AccountId, CardNumber, Balance) values (5, '1827461930481734', 10.0);



/*Задания*/

/*Задание №1*/
/*Покажи мне список банков у которых есть филиалы в городе X (выбери один из городов)*/

select distinct b.Name
from dbo.Branches as br
    inner join dbo.Banks as b on br.BankId = b.Id
    inner join dbo.Cities as ct on br.CityId = ct.Id
where ct.Name = 'Полоцк'


/*Задание №2*/
/*Получить список карточек с указанием имени владельца, баланса и названия банка*/

select crd.CardNumber, cst.FirstName, crd.Balance, bnk.Name
from dbo.Cards as crd
    inner join dbo.Accounts as acc on crd.AccountId = acc.Id
    inner join dbo.Customers as cst on acc.CustomerId = cst.Id
    inner join dbo.Banks as bnk on acc.BankId = bnk.Id

/*Задание №3*/
/*Показать список банковских аккаунтов у которых баланс не совпадает с суммой баланса по карточкам. В отдельной колонке вывести разницу*/

select acc.Id, cst.FirstName, cst.LastName, cst.MidName, bnk.Name,
       (acc.Balance - (select coalesce(sum(crd.Balance), 0) 
                      from dbo.Cards as crd
                      where crd.AccountId = acc.Id)) as 'Balance Diff'
from dbo.Accounts as acc
    inner join dbo.Customers as cst on acc.CustomerId = cst.Id
    inner join dbo.Banks as bnk on acc.BankId = bnk.Id
where acc.Balance > (select coalesce(sum(crd.Balance), 0) 
                      from dbo.Cards as crd
                      where crd.AccountId = acc.Id)



/*Задание №4*/
/*Вывести кол-во банковских карточек для каждого соц статуса (2 реализации, GROUP BY и подзапросом)*/

/*через group by*/
select scst.Name, count(crd.Id) as 'Count'
from dbo.SocialStatuses as scst
	left join dbo.Customers as cst on scst.Id = cst.SocialStatusId
    left join dbo.Accounts as acc on cst.Id = acc.CustomerId
    left join dbo.Cards as crd on crd.AccountId = acc.Id
group by scst.Name

/*через подзапросы*/
select scst.Name,
	   (select count(crd.Id)
	    from dbo.Cards as crd
			left join dbo.Accounts as acc on acc.Id = crd.AccountId
			left join dbo.Customers as cst on cst.Id = acc.CustomerId
		where cst.SocialStatusId = scst.Id) as 'Count'
from dbo.SocialStatuses as scst;

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
                                            inner join dbo.Customers as cst on acc.CustomerId = cst.Id
                                         where cst.SocialStatusId = @socialStatusId);
    if (@socStatusId = @socialStatusId and @relatedAccountsCount > 0)
        update dbo.Accounts
        set Balance = Balance + 10
        where CustomerId = (select Id 
                            from dbo.Customers as cst
                            where cst.Id = CustomerId and cst.SocialStatusId = @socialStatusId)
    else
        print 'Operation hasnt been done'
        
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
       (acc.Balance - (select coalesce(sum(crd.Balance),0) 
                      from dbo.Cards as crd
                      where crd.AccountId = acc.Id)) as 'Balance Diff'
from dbo.Accounts as acc
    inner join dbo.Customers as cst on acc.CustomerId = cst.Id
go




/*Задание 7*/
/*Написать процедуру которая будет переводить определённую сумму со счёта на карту этого аккаунта.  
При этом будем считать что деньги на счёту все равно останутся, просто сумма средств на карте увеличится. 
Например, у меня есть аккаунт на котором 1000 рублей и две карты по 300 рублей на каждой. 
Я могу перевести 200 рублей на одну из карт, при этом баланс аккаунта останется 1000 рублей, а на картах будут суммы 300 и 500 рублей соответственно. 
После этого я уже не смогу перевести 400 рублей с аккаунта ни на одну из карт, так как останется всего 200 свободных рублей (1000-300-500). 
Переводить БЕЗОПАСНО. То есть использовать транзакцию*/

create proc TransferMoneyFromAccountToCard
    @cardId int,
    @amountOfMoney decimal
as
begin
    declare @accountId int = (select AccountId 
                                       from dbo.Cards
                                       where Id = @cardId);

    declare @cardIdFromTable int = (select Id 
                                    from dbo.Cards
                                    where Id = @cardId);

    declare @validAmountOfMoneyForTransfer int = (select
                                                  acc.Balance - (select sum(crd.Balance) 
                                                                 from dbo.Cards as crd
                                                                 where crd.AccountId = acc.Id)
                                                  from dbo.Accounts as acc
                                                  where acc.Id = @accountId);

    begin tran moneyTransfer
    if(@cardIdFromTable = @cardId and @validAmountOfMoneyForTransfer > @amountOfMoney)
    begin
        update dbo.Cards
        set Balance = Balance + @amountOfMoney
        where Id = @cardId
        commit tran moneyTransfer
    end
    else
    begin
        print 'Operation hasnt been committed'
        rollback tran moneyTransfer
    end
end
go

/*проверка*/
select * from dbo.Accounts;
select * from dbo.Cards;
go
exec dbo.TransferMoneyFromAccountToCard 5, 1.0 /*корректное значение*/
go
select * from dbo.Accounts;
select * from dbo.Cards;
go

select * from dbo.Accounts;
select * from dbo.Cards;
go
exec dbo.TransferMoneyFromAccountToCard 5, 11.0 /*некорректное значение*/
go
select * from dbo.Accounts;
select * from dbo.Cards;
go




/*Задание №8*/
/*Написать триггер на таблицы Account/Cards чтобы нельзя была занести значения в поле баланс 
если это противоречит условиям  (то есть нельзя изменить значение в Account на меньшее, чем сумма балансов по всем карточкам. 
И соответственно нельзя изменить баланс карты если в итоге сумма на картах будет больше чем баланс аккаунта)*/

create trigger CheckBalanceChangingOnCard
on dbo.Cards after insert, update
as
begin;
    declare @cardId int = (select top(1) Id from inserted);
    declare @accountId int = (select top(1) AccountId from inserted);
    declare @newMoneyBalance int = (select sum(crd.Balance) 
                                 from dbo.Cards as crd
                                 where crd.AccountId = @accountId);
    declare @accountMoneyBalance int = (select Balance from dbo.Accounts
	                                    where Id = @accountId);
    if(@newMoneyBalance > @accountMoneyBalance)
    begin
        print 'Operation havent been committed'
        rollback;
	end
end;
go

/*проверка*/
select * from dbo.Cards;
update dbo.Cards
set Balance = 10 /*корректный ввод*/
where Id = 3;
select * from dbo.Cards;
go

select * from dbo.Cards;
insert into dbo.Cards (AccountId, CardNumber, Balance)
values (3, '1234567891234567', 90) /*слишком большое значение*/
select * from dbo.Cards;
go

select * from dbo.Cards;
update dbo.Cards
set Balance = 101 /*больше, чем нужно*/
where Id = 3;
select * from dbo.Cards;
go



create trigger CheckBalanceChangingInAccount
on dbo.Accounts after update
as
begin;
    declare @accountId int = (select top(1) Id from deleted);
    declare @minMoneyBalance int = (select sum(crd.Balance) 
                                 from dbo.Cards as crd
                                 where crd.AccountId = @accountId);
    declare @newMoneyBalance int = (select top(1) Balance from inserted);
    print @newMoneyBalance;
	print @minMoneyBalance;
    if(@minMoneyBalance > @newMoneyBalance)
    begin
        print 'Operation hasnt been committed'
        rollback;
    end
end;
go


/*проверка*/
select * from dbo.Accounts;
update dbo.Accounts
set Balance = 10 /*меньше, чем нужно*/
where Id = 3;
select * from dbo.Accounts;
go

select * from dbo.Accounts;
update dbo.Accounts
set Balance = 101 /*корректный ввод*/
where Id = 3;
select * from dbo.Accounts;
go