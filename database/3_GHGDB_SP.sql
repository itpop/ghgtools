-- Create by Fred Yang. 2016-10-05

/* GHGDB Functions & Procedures */
USE [ghgdb];
/*  
-- PROCEDURE spUserUpdate
-- creates/updates user info
-- Params:
--  @userId - the specified user id
--  @email - input email address
--  @firstName - input firstname
--  @lastName - input realname
--  @passwd - input password
--  @passwd1 - input new password
--  @phone - input phone number
--  @address - input email
*/
if exists (select 1 from sys.objects where type = 'P' AND name = 'spUserUpdate')
drop procedure spUserUpdate
GO
create procedure spUserUpdate(
	@userId      int		  output,
	@email       varchar(30),
	@passwd      varchar(32),
	@passwd1	 varchar(32),
	@firstName   varchar(30),
	@lastName    varchar(30),
	@phone		 varchar(20),
	@address	 varchar(100),
	@joinDate	 datetime,
	@level		 tinyint,
	@isValid	 bit
)
as
begin
	if not exists (select 1 from dbo.[User] where email = @email) -- new user
	begin
		if @userId is null or @userId = 1
			insert into dbo.[User](email, passwd, firstName, lastName, phone, address, joinDate)
			values(@email, CONVERT(VARCHAR(32), HashBytes('MD5', @passwd), 2),
				@firstName, @lastName, @phone, @address, getdate());
			set @userId = SCOPE_IDENTITY();
	end;
	else -- update
	begin
		if exists (select 1 from dbo.[User] where userId = @userId
			and passwd = CONVERT(VARCHAR(32), HashBytes('MD5', @passwd), 2))
		begin
			if(@passwd1 is null or @passwd1 = '')
				update dbo.[User] set firstName = @firstName, lastName = @lastName,
					phone = @phone, address = @address, level = @level, isValid = @isValid
				where userId = @userId;
			else
				update dbo.[User] set passwd = CONVERT(VARCHAR(32), HashBytes('MD5', @passwd1), 2),
					firstName = @firstName, lastName = @lastName, phone = @phone, address = @address,
					level = @level, isValid = @isValid
				where userId = @userId;
		end;
		else
			set @userId = 1;
	end;
	return
end;


/*  
-- PROCEDURE spUserInfo
--	Returns user info
-- Params:
--	@userId - the specified userId
--  @email  - output email
--  @firstName - output first name
--  @lastName  - output last name
--  @phone  - output phone#
--  @address - output address
*/
if exists (select 1 from sys.objects where type = 'P' AND name = 'spUserInfo')
drop procedure spUserInfo
GO
create procedure spUserInfo(
	@userId		int,
	@email		varchar(30)	output,
	@firstName	varchar(30)	output,
	@lastName	varchar(30)	output,
	@phone		varchar(15)	output,
	@address	varchar(70)	output
)
as
	select @email = email, @firstName = firstName, @lastName = lastName, 
	       @phone = phone, @address = address
	from dbo.[User] where userId = @userId;
return

/*  
-- PROCEDURE spUserRemove
--	deregisters user account
-- Params:
--	@userId - the specified userId
*/
if exists (select 1 from sys.objects where type = 'P' AND name = 'spUserRemove')
drop procedure spUserRemove
GO
create procedure spUserRemove(
	@userId	int
)
as
begin
	update dbo.[User] set isValid = 0 where userId = @userId;
end;

/*  
-- PROCEDURE spUserFindPassword
--	recover password
-- Params:
--  @email - input email
--  @passwd - input password
*/
if exists (select 1 from sys.objects where type = 'P' AND name = 'spUserFindPassword')
drop procedure spUserFindPassword
GO
create procedure spUserFindPassword(
	@email       varchar(30),
	@passwd      varchar(15)
)
as
begin
	update dbo.[User] set passwd = CONVERT(VARCHAR(32), HashBytes('MD5', @passwd), 2)
	where email = @email;
end;

/*  
-- PROCEDURE spUserFind
--	Checks if the current user exists given
--  email and password
-- Params:
--	@email - input email
--  @passwd - input password
--  @userId - output userId
--  @firstName - output firstName
*/
if exists (select 1 from sys.objects where type = 'P' AND name = 'spUserFind')
drop procedure spUserFind
GO
create procedure spUserFind(
	@email		varchar(30),
	@passwd		varchar(15),
	@userId		int			output,
	@firstName  varchar(30)	output
)
as
	select @userId=userId, @firstName=firstName
	from dbo.[User]
	where email = @email
	and passwd = CONVERT(VARCHAR(32), HashBytes('MD5', @passwd), 2)
	and isValid = 1;
return

/*  
-- PROCEDURE spUserCheckEmail
--	Checks the availability for email
-- Params:
--	@email - input email
--  @result - output result. 1-exist; 0- not exist
*/
if exists (select 1 from sys.objects where type = 'P' AND name = 'spUserCheckEmail')
drop procedure spUserCheckEmail
GO
create procedure spUserCheckEmail(
	@email	varchar(30),
	@result int		OUTPUT
)
as
	if exists (select 1 from dbo.[User] where email = @email)
		set @result = 1;
return


/*  
-- PROCEDURE spUserIdByUserName
--	gets userId by email
-- Params:
--	@email - input email
-- Outputs:
--  userId
*/
if exists (select 1 from sys.objects where type = 'P' AND name = 'spUserIdByEmail')
drop procedure spUserIdByEmail
GO
create procedure spUserIdByEmail(
	@email	varchar(30)
)
as
begin
	select userId from dbo.[User] where email = @email;
end;

/*  
-- PROCEDURE spUserFirstNameByEmail
--	gets first name by email
-- Params:
--	@email - input email
-- Outputs:
--  first name
*/
if exists (select 1 from sys.objects where type = 'P' AND name = 'spUserFirstNameByEmail')
drop procedure spUserFirstNameByEmail
GO
create procedure spUserFirstNameByEmail(
	@email	varchar(30)
)
as
begin
	select firstName from dbo.[User] where email = @email;
end;

/*  
-- PROCEDURE spContactUpdate
--	stores/updates the current user's contact post
-- Params:
--  @contactName - contact name
--	@email - user email
--	@subject - feedback, registration issue or others
--	@message - detailed content
*/
if exists (select 1 from sys.objects where type = 'P' AND name = 'spContactUpdate')
drop procedure spContactUpdate
GO
create procedure spContactUpdate(
	@contactId   int,
	@contactName varchar(30),
	@email		 varchar(30),
	@subject	 varchar(50),
	@message	 text
)
as
begin
	if @contactId is null or @contactId = 0
		insert into dbo.Contact(contactName, email, subject, message) 
		values(@contactName, @email, @subject, @message);
	else
		update dbo.Contact set isReplied = 1 where contactId = @contactId;
end;

if exists (select 1 from sys.objects where type = 'P' AND name = 'spSourceByComp')
drop procedure spSourceByComp
GO
create procedure spSourceByComp(
	@result			varchar(300)	out,
	@scenarioYear	char(4),
	@transport		bit  -- 0-w/o, 1-transportation only
)
as
begin
	declare @compCount int;
	declare @id int;
	declare @tonnage int;
	declare @first bit;

	set @result = '';
	set @id = 1;
	select @compCount = count(*) from dbo.[Composition];
	
	while @id <= @compCount 
	begin
		set @first = 1;
		if (@transport = 0)
			declare cur cursor for select tonnageWT 
			from dbo.[SourceBycomp] where compositionId = @id 
			and scenarioYear = @scenarioYear;
		else
			declare cur cursor for select tonnageTO 
			from dbo.[SourceBycomp] where compositionId = @id 
			and scenarioYear = @scenarioYear;
			
		open cur;
		fetch next from cur into @tonnage;
		
		while @@fetch_status = 0
		begin
			if (@first = 1)
			begin
				set @result = @result + convert(varchar,@tonnage);
				set @first = 0;
			end
			else
				set @result = @result + ', ' + convert(varchar,@tonnage);
			fetch next from cur into @tonnage;
		end;
		close cur;
		deallocate cur;
		set @result = @result + ';';
		set @id = @id + 1;
	end;

	set @first = 1;
	if (@transport = 0)
		declare curTotal cursor for select sum(tonnageWT) 
		from dbo.SourceByComp group by sourceId;
	else
		declare curTotal cursor for select sum(tonnageTO) 
		from dbo.SourceByComp group by sourceId;
	open curTotal;
	fetch next from curTotal into @tonnage;

	while @@fetch_status = 0
	begin
		if (@first = 1)
		begin
			set @result = @result + convert(varchar,@tonnage);
			set @first = 0;
		end
		else
			set @result = @result + ', ' + convert(varchar,@tonnage);
		fetch next from curTotal into @tonnage;
	end;
	close curTotal;
	deallocate curTotal;
	return
end;

if exists (select 1 from sys.objects where type = 'P' AND name = 'spDestByComp')
drop procedure spDestByComp
GO
create procedure spDestByComp(
	@result			varchar(300)	out,
	@scenarioYear	char(4),
	@transport		bit  -- 0-w/o, 1-transportation only
)
as
begin
	declare @destCount int;
	declare @id int;
	declare @tonnage int;
	declare @waste int;
	declare @transportation int;
	declare @electricity int;
	declare @first bit;

	set @result = '';
	set @id = 1;
	select @destCount = count(*) from dbo.[Destination];
	
	while @id <= @destCount 
	begin
		set @first = 1;
		if (@transport = 0)
			declare cur cursor for select tonnageWT 
			from dbo.[DestBycomp] where destinationId = @id 
			and scenarioYear = @scenarioYear;
		else
			declare cur cursor for select tonnageTO 
			from dbo.[DestBycomp] where destinationId = @id 
			and scenarioYear = @scenarioYear;
			
		open cur;
		fetch next from cur into @tonnage;
		
		while @@fetch_status = 0
		begin
			if (@first = 1)
			begin
				set @result = @result + convert(varchar,@tonnage);
				set @first = 0;
			end
			else
				set @result = @result + ', ' + convert(varchar,@tonnage);
			fetch next from cur into @tonnage;
		end;
		close cur;
		deallocate cur;
		select @waste = waste, @transportation = transportation, @electricity = electricity
		from dbo.[DestinationWaste] where destinationId = @id and scenarioYear = @scenarioYear;
		set @result = @result + ', ' + convert(varchar,@waste) + ', ' 
		              + convert(varchar,@transportation)
		              + ', ' + convert(varchar,@electricity) + ';';
		set @id = @id + 1;
	end;
	set @result = substring(@result, 1, len(@result) -1);
	return
end;

-- spGetSource
if exists (select 1 from sys.objects where type = 'P' AND name = 'spGetSource')
drop procedure spGetSource
GO
create procedure spGetSource(
	@result		varchar(100)	out
)
as
begin
	declare @source varchar(50);
	declare @first bit;
	
	set @first = 1;
	set @result = '';
	declare cur cursor for select sourceName from dbo.[Source]
	
	open cur;
	fetch next from cur into @source;
	
	while @@fetch_status = 0
	begin
		if (@first = 1)
		begin
			set @result = @result + @source;
			set @first = 0;
		end
		else
			set @result = @result + ', ' + @source;
		fetch next from cur into @source;
	end;
	close cur;
	deallocate cur;
	return
end;

-- spGetDestination
if exists (select 1 from sys.objects where type = 'P' AND name = 'spGetDestination')
drop procedure spGetDestination
GO
create procedure spGetDestination(
	@result		varchar(100)	out
)
as
begin
	declare @destination varchar(50);
	declare @first bit;
	
	set @first = 1;
	set @result = '';
	declare cur cursor for select destinationName from dbo.[Destination]
	
	open cur;
	fetch next from cur into @destination;
	
	while @@fetch_status = 0
	begin
		if (@first = 1)
		begin
			set @result = @result + @destination;
			set @first = 0;
		end
		else
			set @result = @result + ', ' + @destination;
		fetch next from cur into @destination;
	end;
	close cur;
	deallocate cur;
	return
end;

-- get composition
if exists (select 1 from sys.objects where type = 'P' AND name = 'spGetComposition')
drop procedure spGetComposition
GO
create procedure spGetComposition(
	@result		varchar(100)	out
)
as
begin
	declare @composition varchar(50);
	declare @first bit;
	
	set @first = 1;
	set @result = '';
	declare cur cursor for select compositionName from dbo.[Composition]
	
	open cur;
	fetch next from cur into @composition;
	
	while @@fetch_status = 0
	begin
		if (@first = 1)
		begin
			set @result = @result + @composition;
			set @first = 0;
		end
		else
			set @result = @result + ', ' + @composition;
		fetch next from cur into @composition;
	end;
	close cur;
	deallocate cur;
	return
end;


