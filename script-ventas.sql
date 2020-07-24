-- // ARCHIVOS PROVEÍDOS POR JC SOURCE CODE ATRAVÉZ DEL CURSO DE C# Y SQL SERVER // --
-- // NO TE OLVIDES DE COMPARTIR, DE DARLE ME GUSTA Y DE SUSCRIBIRTE AL CANAL // --

-- // CREACION DE LA TABLA VENTAS // --
create table ventas(
	idventas int identity primary key,
	numeroventas nvarchar(15),
	fecha date,
	estado nvarchar(15),
	idclientes int

	constraint fk_idclientess foreign key (idclientes) references clientes (idclientes)
)
go

-- // CREACION DE LA TABLA DETALLES DE LA VENTAS // --
create table detallesventas(
	cantidad int,
	descripcion nvarchar(256),
	precio decimal,
	gravadas decimal,
	totales decimal,
	idventas int

	constraint fk_idventas foreign key (idventas) references ventas (idventas)

	on update cascade
	on delete cascade
)
go

-- // PROCEDIMIENTOS ALMACENADOS APLICADO A LA TABLA VENTAS Y DETALLES DE LA VENTA // --
-- // PROCEDIMIENTO INSERTAR VENTAS // --
create proc spinsertar_ventas
	@idventas int=null output,
	@numeroventas nvarchar(15),
	@fecha date,
	@estado nvarchar(15),
	@idclientes int
as
	insert into ventas values (@numeroventas, @fecha, @estado, @idclientes)

	-- // OBTENEMOS EL ID AUTOGENERADO // --
	set @idventas=@@IDENTITY
go

-- // PROCEDIMIENTO INSERTAR DETALLES DE LA VENTA // --
create proc spinsertar_detallesventas
	@cantidad int,
	@descripcion varchar(256),
	@precio decimal,
	@gravadas decimal,
	@totales decimal,
	@idventas int
as
	insert into detallesventas values (@cantidad, @descripcion, @precio, @gravadas, @totales, @idventas)
go

-- // PROCEDIMIENTO ANULAR REGISTROS VENTA // --
create proc spanular_ventas
	@idventas int
as
	update ventas set estado='ANULADO' where idventas = @idventas
go

-- // PROCEDIMIENTO MOSTRAR REGISTROS VENTAS //--
create proc spmostrar_ventas
as
	SELECT	dbo.ventas.idventas, dbo.ventas.numeroventas, dbo.ventas.fecha, dbo.ventas.estado, dbo.ventas.idclientes, dbo.clientes.cioruc, dbo.clientes.razonsocial
	FROM	dbo.ventas INNER JOIN dbo.clientes ON dbo.ventas.idclientes = dbo.clientes.idclientes
go

--PROCEDIMIENTO BUSCAR VENTAS POR FECHAS
create proc spbuscar_ventas
	@fechainicial varchar(20),
	@fechafinal varchar(20)
as
	SELECT	dbo.ventas.idventas, dbo.ventas.numeroventas, dbo.ventas.fecha, dbo.ventas.estado, dbo.ventas.idclientes, dbo.clientes.cioruc, dbo.clientes.razonsocial
	FROM	dbo.ventas INNER JOIN dbo.clientes ON dbo.ventas.idclientes = dbo.clientes.idclientes
	WHERE	dbo.ventas.fecha>=@fechainicial and dbo.ventas.fecha<=@fechafinal
go


