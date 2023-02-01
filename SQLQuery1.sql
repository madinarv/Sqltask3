
Create database Library

Use Library

Create table Books
(
	Id int Identity Primary key,
	Name nvarchar(100) Check(Len(Name)>=2 AND Len(Name)<=100),
	PageCount int Check(PageCount>10)
)
Create table Authors
(
	Id int Identity Primary key,
	Name nvarchar(50),
	Surname nvarchar(100)
)
Create table BooksAuthors
(
	Id int identity primary key,
	BookId int foreign key references Books(id),
	AuthorId int foreign key references Authors(id),
)
Insert into Books
values
	('Het gevecht met de muze',194),
	('De ark',281),
	(' Lafaard of geus?',126),
	('Maria Sibylla Merian, gedicht',501),
	(' Drie essays over experimentele poëzie',1201),
	('The Mammoth Book of Short Crime Stories',348)

Insert into Authors
values
	('Bertus','Aafjes'),
	('Patricia','Aakhus'),
	('Lesley','Abdela'),
	('Ali ','Abdolrezaei'),
	('Hamid Barole ','Abdu'),
	('Chris van Abkoude ','Iggulden')

Create  View usv_GetBookDetails
as
select Books.Id,Books.Name,Books.PageCount, (Authors.Name+' '+Authors.SurName) as [AuthorFullName]from 
Books
Full join 
BooksAuthors
on Books.Id=BooksAuthors.BookId 
Full join
Authors
on Authors.Id=BooksAuthors.AuthorId


Create procedure usp_UpdateAuthor
@Id int, @Name nvarchar(100),@SurName nvarchar(100)
as
begin
Update Authors set Authors.Name=@Name,Authors.SurName=@Surname where Authors.Id=@Id
end


Create procedure usp_DeleteAuthor
@Id int
as
begin
delete from Authors where Authors.Id=@Id 
end

exec usp_DeleteAuthor 5

Create View usv_GetAuthorDetails
as
select Authors.Id,(Authors.Name+' '+Authors.SurName)as AuthorsFullName,COUNT(*)as BookCount,SUM(Books.PageCount)as MaxPageCount from BooksAuthors 
join
Authors
on
Authors.Id=BooksAuthors.AuthorId
join
Books
on Books.Id=BooksAuthors.BookId
Group By Authors.Id,Authors.Id,(Authors.Name+' '+Authors.SurName)
