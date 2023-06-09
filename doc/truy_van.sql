use WEB_BQA1
go

select ProductDetails.ProductDetailID, Products.ProcductName ,Sizes.Size, Colors.Color, Products.Price, Products.[Description], ProductDetails.Quantity
from ProductDetails inner join Products on ProductDetails.ProductID = Products.ProductID
inner join Colors on ProductDetails.ColorID = Colors.ColorID
inner join Sizes on ProductDetails.SizeID = Sizes.SizeID
where Products.ProductID = '1'

select Colors.Color, SUM(ProductDetails.Quantity) as SoLuong from ProductDetails inner join Colors on ProductDetails.ColorID = Colors.ColorID where ProductDetails.ProductID = 1 group by Colors.Color
select Sizes.Size, SUM(ProductDetails.Quantity) as SoLuong from ProductDetails inner join Sizes on ProductDetails.SizeID = Sizes.SizeID where ProductDetails.ProductID = 1 group by Sizes.Size

select * from Customers

select * from Sizes

update Sizes
set Size = 'XXXL'
where SizeID = '6'

select * from Products inner join ImagePrducts on ImagePrducts.ProductID = Products.ProductID where Products.ProductID = 1

select ProductDetails.ProductDetailID from ProductDetails inner join Sizes on ProductDetails.SizeID = Sizes.SizeID inner join Colors on Colors.ColorID = ProductDetails.ColorID where ProductDetails.ProductID = 1 and Sizes.Size = 'S' and Colors.Color = 'Blue'
select Products.ProcductName, Sizes.Size, Colors.Color, ImagePrducts.Image1, Products.Price from ProductDetails inner join Products on ProductDetails.ProductID = Products.ProductID inner join Sizes on ProductDetails.SizeID = Sizes.SizeID inner join Colors on Colors.ColorID = ProductDetails.ColorID inner join ImagePrducts on ProductDetails.ProductID = ImagePrducts.ProductID where ProductDetailID = 51

select * from Customers
insert into Customers(Fullname, [Address], Email, PhoneNumber) values
('Nguyen Quang Huy', 'Ha Tay, Ha Noi', 'Huy001122@nuce.edu.ev', '0010020030')
select * from Products

select * from ProductDetails

select * from Customers

select * from Orders

select * from OrderDetails
go
create trigger trigger_OrderDetails_insert
on OrderDetails
after insert
as
begin
	declare @sl_dat int
	declare @id int

	select @id = ProductDetailID, @sl_dat = Quantity from inserted

	update ProductDetails
	set Quantity = Quantity - @sl_dat
	where ProductDetailID = @id
end
go
insert into Orders(OrderDate, TotalAmount, CustomerID, ShippingFreeID)
values(GETDATE(),'999', '2', '1');
declare @OrderID int;
set @OrderID = SCOPE_IDENTITY();
insert into OrderDetails(OrderID, Quantity, ProductDetailID)
values(@OrderID, '3', '2')

