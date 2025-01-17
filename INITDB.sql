if exists (SELECT * FROM sys.objects where name='source_adresa') drop table dbo.source_adresa;
if exists (SELECT * FROM sys.objects where name='source_facultate') drop table dbo.source_facultate;

--wizzard import of files


CREATE TABLE [dbo].[source_facultate](
	[id_facultate] [int] NULL,
	[universitate] [varchar](100) NULL,
	[facultate] [varchar](100) NULL,
	[specializare] [varchar](100) NULL,
	[medie_intrare] [float] NULL,
	[localitate] [varchar](100) NULL,
	[judet] [varchar](100) NULL,
	[materii_bac] [varchar](100) NULL
)
;

CREATE TABLE [dbo].[source_adresa](
	[ID] [int] NOT NULL,
	[JUDET] [varchar](50) NULL,
	[LOCALITATE] [varchar](100) NULL,
	[SIIIR] [varchar](20) NULL,
	[UNITATE_INVATAMANT] [varchar](200) NULL
)
;

CREATE TABLE [dbo].[source_persoana](
	[cod_candidat] [int] NULL,
	[sex] [varchar](10) NULL,
	[specializare] [varchar](100) NULL,
	[profil] [varchar](50) NULL,
	[fileira] [varchar](50) NULL,
	[siiir] [varchar](20) NULL,
	[an] [int] NULL,
	[sesiune] [varchar](50) NULL
);

CREATE TABLE [dbo].[source_rezultate_bac](
	[cod_candidat] [int] NULL,
	[subiect_ea] [varchar](50) NULL,
	[subiect_eb] [varchar](50) NULL,
	[subiect_ec] [varchar](50) NULL,
	[subiect_ed] [varchar](100) NULL,
	[nota_ea] [float] NULL,
	[nota_eb] [float] NULL,
	[nota_ec] [float] NULL,
	[nota_ed] [float] NULL,
	[status] [varchar](50) NULL,
	[medie] [float] NULL,
	[an] [int] NULL,
	[sesiune] [varchar](50) NULL,
	[materii_bac] [varchar](200) NULL
);

-- bulk insert source_adresa 
-- from 'C:\Users\DSAMOILA\Desktop\Dani\Master\IBD\Proiect\Dataset\adresa.csv'
-- ;

-- bulk insert source_adresa 
-- from 'C:\Users\DSAMOILA\Desktop\Dani\Master\IBD\Proiect\Dataset\facultati_filtrate_processed.csv'
-- ;

-- bulk insert source_adresa 
-- from 'C:\Users\DSAMOILA\Desktop\Dani\Master\IBD\Proiect\Dataset\persoane_promovate.csv'
-- ;

-- bulk insert source_adresa 
-- from 'C:\Users\DSAMOILA\Desktop\Dani\Master\IBD\Proiect\Dataset\rezultate_bac_promovat_processed.csv'
-- ;




--created copies for target tables 

CREATE TABLE [dbo].[c_facultate](
	[id_facultate] [int] NULL,
	[universitate] [varchar](100) NULL,
	[facultate] [varchar](100) NULL,
	[specializare] [varchar](100) NULL,
	[medie_intrare] [float] NULL,
	[localitate] [varchar](100) NULL,
	[judet] [varchar](100) NULL,
	[materii_bac] [varchar](100) NULL
)
;

CREATE TABLE [dbo].[c_adresa](
	[ID] [int] NOT NULL,
	[JUDET] [varchar](50) NULL,
	[LOCALITATE] [varchar](100) NULL,
	[SIIIR] [varchar](20) NULL,
	[UNITATE_INVATAMANT] [varchar](200) NULL
)
;

CREATE TABLE [dbo].[c_persoana](
	[cod_candidat] [int] NULL,
	[sex] [varchar](10) NULL,
	[specializare] [varchar](100) NULL,
	[profil] [varchar](50) NULL,
	[fileira] [varchar](50) NULL,
	[siiir] [varchar](20) NULL,
	[an] [int] NULL,
	[sesiune] [varchar](50) NULL
);

CREATE TABLE [dbo].[c_rezultate_bac](
	[cod_candidat] [int] NULL,
	[subiect_ea] [varchar](50) NULL,
	[subiect_eb] [varchar](50) NULL,
	[subiect_ec] [varchar](50) NULL,
	[subiect_ed] [varchar](100) NULL,
	[nota_ea] [float] NULL,
	[nota_eb] [float] NULL,
	[nota_ec] [float] NULL,
	[nota_ed] [float] NULL,
	[status] [varchar](50) NULL,
	[medie] [float] NULL,
	[an] [int] NULL,
	[sesiune] [varchar](50) NULL,
	[materii_bac] [varchar](200) NULL
);

--created also a principal table which will create the view on it

CREATE TABLE [dbo].[p_facultate](
	[id_facultate] [int] NULL,
	[universitate] [varchar](100) NULL,
	[facultate] [varchar](100) NULL,
	[specializare] [varchar](100) NULL,
	[medie_intrare] [float] NULL,
	[localitate] [varchar](100) NULL,
	[judet] [varchar](100) NULL,
	[materii_bac] [varchar](100) NULL
)
;

CREATE TABLE [dbo].[p_adresa](
	[ID] [int] NOT NULL,
	[JUDET] [varchar](50) NULL,
	[LOCALITATE] [varchar](100) NULL,
	[SIIIR] [varchar](20) NULL,
	[UNITATE_INVATAMANT] [varchar](200) NULL
)
;

CREATE TABLE [dbo].[p_persoana](
	[cod_candidat] [int] NULL,
	[sex] [varchar](10) NULL,
	[specializare] [varchar](100) NULL,
	[profil] [varchar](50) NULL,
	[fileira] [varchar](50) NULL,
	[siiir] [varchar](20) NULL,
	[an] [int] NULL,
	[sesiune] [varchar](50) NULL
);

CREATE TABLE [dbo].[p_rezultate_bac](
	[cod_candidat] [int] NULL,
	[subiect_ea] [varchar](50) NULL,
	[subiect_eb] [varchar](50) NULL,
	[subiect_ec] [varchar](50) NULL,
	[subiect_ed] [varchar](100) NULL,
	[nota_ea] [float] NULL,
	[nota_eb] [float] NULL,
	[nota_ec] [float] NULL,
	[nota_ed] [float] NULL,
	[status] [varchar](50) NULL,
	[medie] [float] NULL,
	[an] [int] NULL,
	[sesiune] [varchar](50) NULL,
	[materii_bac] [varchar](200) NULL
);

--views on the principal tables

create view persoana AS
select * from p_persoana;

create view rezultate_bac AS
select * from p_rezultate_bac;

create view adresa AS
select * from p_adresa;

create view facultate AS
select * from p_facultate;

--initial insert from the source

insert into p_adresa
select * from source_adresa;

insert into p_facultate
select * from source_facultate;

insert into p_rezultate_bac
select * from source_rezultate_bac;

insert into p_persoana
select * from source_persoana;


