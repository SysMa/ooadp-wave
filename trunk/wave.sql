/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     2011/11/15 19:46:22                          */
/*==============================================================*/
use wave

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ActInfo') and o.name = 'FK_ACTINFO_HOLDACT_ORGINFO')
alter table ActInfo
   drop constraint FK_ACTINFO_HOLDACT_ORGINFO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Images') and o.name = 'FK_IMAGES_RELATIONS_ACTINFO')
alter table Images
   drop constraint FK_IMAGES_RELATIONS_ACTINFO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PassAct') and o.name = 'FK_PASSACT_PASSACT_ADMINFO')
alter table PassAct
   drop constraint FK_PASSACT_PASSACT_ADMINFO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PassAct') and o.name = 'FK_PASSACT_PASSACT2_ACTINFO')
alter table PassAct
   drop constraint FK_PASSACT_PASSACT2_ACTINFO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TakeAct') and o.name = 'FK_TAKEACT_TAKEACT_USEINFO')
alter table TakeAct
   drop constraint FK_TAKEACT_TAKEACT_USEINFO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TakeAct') and o.name = 'FK_TAKEACT_TAKEACT2_ACTINFO')
alter table TakeAct
   drop constraint FK_TAKEACT_TAKEACT2_ACTINFO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ActInfo')
            and   name  = 'HoldAct_FK'
            and   indid > 0
            and   indid < 255)
   drop index ActInfo.HoldAct_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ActInfo')
            and   type = 'U')
   drop table ActInfo
go

if exists (select 1
            from  sysobjects
           where  id = object_id('AdmInfo')
            and   type = 'U')
   drop table AdmInfo
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Images')
            and   name  = 'Relationship_3_FK'
            and   indid > 0
            and   indid < 255)
   drop index Images.Relationship_3_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Images')
            and   type = 'U')
   drop table Images
go

if exists (select 1
            from  sysobjects
           where  id = object_id('OrgInfo')
            and   type = 'U')
   drop table OrgInfo
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PassAct')
            and   name  = 'PassAct2_FK'
            and   indid > 0
            and   indid < 255)
   drop index PassAct.PassAct2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PassAct')
            and   name  = 'PassAct_FK'
            and   indid > 0
            and   indid < 255)
   drop index PassAct.PassAct_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PassAct')
            and   type = 'U')
   drop table PassAct
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SupInfo')
            and   type = 'U')
   drop table SupInfo
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('TakeAct')
            and   name  = 'TakeAct2_FK'
            and   indid > 0
            and   indid < 255)
   drop index TakeAct.TakeAct2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('TakeAct')
            and   name  = 'TakeAct_FK'
            and   indid > 0
            and   indid < 255)
   drop index TakeAct.TakeAct_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TakeAct')
            and   type = 'U')
   drop table TakeAct
go

if exists (select 1
            from  sysobjects
           where  id = object_id('UseInfo')
            and   type = 'U')
   drop table UseInfo
go

/*==============================================================*/
/* Table: ActInfo                                               */
/*==============================================================*/
create table ActInfo (
   actid                int                  not null,
   orgname              varchar(20)          null,
   actname              varchar(20)          null,
   actstate             int                  null,
   maxuser              int                  null,
   usenum               int                  null,
   starttime            datetime             null,
   endtime              datetime             null,
   pagestyle            int                  null,
   slogan               text                 null,
   acttext              text                 null,
   constraint PK_ACTINFO primary key nonclustered (actid)
)
go

/*==============================================================*/
/* Index: HoldAct_FK                                            */
/*==============================================================*/
create index HoldAct_FK on ActInfo (
orgname ASC
)
go

/*==============================================================*/
/* Table: AdmInfo                                               */
/*==============================================================*/
create table AdmInfo (
   admname              varchar(20)          not null,
   astate               int                  null,
   apasswd              varchar(20)          null,
   aemail               varchar(20)          null,
   aphone               decimal(15)          null,
   aimage               image                null,
   constraint PK_ADMINFO primary key nonclustered (admname)
)
go

/*==============================================================*/
/* Table: Images                                                */
/*==============================================================*/
create table Images (
   imageid              int                  not null,
   actid                int                  null,
   images               image                null,
   constraint PK_IMAGES primary key nonclustered (imageid)
)
go

/*==============================================================*/
/* Index: Relationship_3_FK                                     */
/*==============================================================*/
create index Relationship_3_FK on Images (
actid ASC
)
go

/*==============================================================*/
/* Table: OrgInfo                                               */
/*==============================================================*/
create table OrgInfo (
   orgname              varchar(20)          not null,
   ostate               int                  null,
   opasswd              varchar(20)          null,
   oemail               varchar(20)          null,
   ophone               numeric(15)          null,
   oscore               real                 null,
   oimage               image                null,
   orgaddress           varchar(100)         null,
   constraint PK_ORGINFO primary key nonclustered (orgname)
)
go

/*==============================================================*/
/* Table: PassAct                                               */
/*==============================================================*/
create table PassAct (
   admname              varchar(20)          not null,
   actid                int                  not null,
   constraint PK_PASSACT primary key (admname, actid)
)
go

/*==============================================================*/
/* Index: PassAct_FK                                            */
/*==============================================================*/
create index PassAct_FK on PassAct (
admname ASC
)
go

/*==============================================================*/
/* Index: PassAct2_FK                                           */
/*==============================================================*/
create index PassAct2_FK on PassAct (
actid ASC
)
go

/*==============================================================*/
/* Table: SupInfo                                               */
/*==============================================================*/
create table SupInfo (
   supname              varchar(20)          not null,
   spasswd              varchar(20)          null,
   constraint PK_SUPINFO primary key nonclustered (supname)
)
go

/*==============================================================*/
/* Table: TakeAct                                               */
/*==============================================================*/
create table TakeAct (
   username             varchar(20)          not null,
   actid                int                  not null,
   endtime              datetime             null,
   usescore             real                 null,
   orgscore             real                 null,
   constraint PK_TAKEACT primary key (username, actid)
)
go

/*==============================================================*/
/* Index: TakeAct_FK                                            */
/*==============================================================*/
create index TakeAct_FK on TakeAct (
username ASC
)
go

/*==============================================================*/
/* Index: TakeAct2_FK                                           */
/*==============================================================*/
create index TakeAct2_FK on TakeAct (
actid ASC
)
go

/*==============================================================*/
/* Table: UseInfo                                               */
/*==============================================================*/
create table UseInfo (
   username             varchar(20)          not null,
   ustate               int                  null,
   upasswd              varchar(20)          null,
   uemail               varchar(20)          null,
   uphone               numeric(15)          null,
   uscore               real                 null,
   uimage               image                null,
   constraint PK_USEINFO primary key nonclustered (username)
)
go

alter table ActInfo
   add constraint FK_ACTINFO_HOLDACT_ORGINFO foreign key (orgname)
      references OrgInfo (orgname)
go

alter table Images
   add constraint FK_IMAGES_RELATIONS_ACTINFO foreign key (actid)
      references ActInfo (actid)
go

alter table PassAct
   add constraint FK_PASSACT_PASSACT_ADMINFO foreign key (admname)
      references AdmInfo (admname)
go

alter table PassAct
   add constraint FK_PASSACT_PASSACT2_ACTINFO foreign key (actid)
      references ActInfo (actid)
go

alter table TakeAct
   add constraint FK_TAKEACT_TAKEACT_USEINFO foreign key (username)
      references UseInfo (username)
go

alter table TakeAct
   add constraint FK_TAKEACT_TAKEACT2_ACTINFO foreign key (actid)
      references ActInfo (actid)
go

/***************************************************************
compute the user scores and the organization scores when there is 
a record insert into the TakeAct table
*****************************************************************/
create trigger cmpt_score on TakeAct AFTER insert as
begin
	update UserInfo
	set UserInfo.uscore = (select avg(TakeAct.usescore) from TakeAct where TakeAct.username = UserInfo.username)
	update OrgInfo
	set OrgInfo.oscore = (select avg(TakeAct.orgscore) from TakeAct,ActInfo where TakeAct.actid = ActInfo.actid and ActInfo.orgname = OrgInfo.orgname)
end
go
/********************************************************************
check if there are enough administrators passing this Activity plan
*********************************************************************/
create trigger pass_act on PassAct After insert as
begin
	declare @s int
	set @s = (select count(*) from ActInfo,PassAct where ActInfo.actid = PassAct.actid)
	if @s > 6
		begin
			update ActInfo 
			set ActInfo.actstate = 6
		end
end
go
