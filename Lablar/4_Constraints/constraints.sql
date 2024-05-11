-- temel tablo oluşturma syntaxı
-- create table tablo_adı(sütun_adi_1 veri_tipi_1, ..., sütun_adi_N veri_tipi_N)
CREATE TABLE basvurular
(
    tc_no bigint,
    uni_adi character varying(64),
    tarih date,
    sonuc "char"
);

-- tabloya veri kaydetme syntaxı
-- insert into tablo_adi values (v11, ..., v1n), (v21, ..., v2n), ..., (vm1, ..., vmn);
insert into basvurular values (456, 'BAİBÜ', '2023-04-29', 'K'); -- başarılı

insert into basvurular values (456, 'BAİBÜ', 'Pazartesi', 150); -- başarısız

-- tablo'yu içindeki verilerle birlikte yok etme syntaxı
-- drop table tablo_adi
DROP TABLE basvurular;

-------------------------------------------
--- NULL olmama kısıtlaması ---------------
-------------------------------------------

create table ogrenciler (
  ogr_id int,
  ogr_adi text,
  ortalama real not null,
  lise_mevcudu int
);

insert into ogrenciler values (123, 'Ali', 3.5, 1500);
insert into ogrenciler values (null, 'Veli', 3, 1000);
insert into ogrenciler values (456, 'Ayşe', null, 1200);

update ogrenciler set ortalama=null where ogr_id=123;
update ogrenciler set ortalama=null where ogr_id=999;

drop table ogrenciler;

-------------------------------------------
--- Anahtar (Key) kısıtlaması -------------
-------------------------------------------

create table ogrenciler (
  ogr_id int primary key,
  ogr_adi text,
  ortalama real,
  lise_mevcudu int
);

insert into ogrenciler values (123, 'Ali', 3.5, 1500);
insert into ogrenciler values (456, 'Veli', 3, 1000);
insert into ogrenciler values (123, 'Ayşe', null, 1200);

update ogrenciler set ogr_id=123 where ogr_adi='Veli';

-- 2 tane primary key (birincil anahtar) olabilir mi?

drop table ogrenciler;

create table ogrenciler (
  ogr_id int primary key,
  ogr_adi text primary key,
  ortalama real,
  lise_mevcudu int
);

create table ogrenciler (
  ogr_id int primary key,
  ogr_adi text unique,
  ortalama real,
  lise_mevcudu int
);

insert into ogrenciler values (123, 'Ali', 3.5, 1500);
insert into ogrenciler values (456, 'Veli', 3, 1000);
insert into ogrenciler values (789, 'Veli', 2.2, 1200);

-- 1'den fazla niteliği kapsayan anahtar oluşturma

create table okullar (
  okul_adi text,
  sehir text,
  mevcut int,
  primary key (okul_adi, sehir)
);

insert into okullar values ('Parlak', 'Ankara', 15000);
insert into okullar values ('Parlak', 'İstanbul', 25000);
insert into okullar values ('Parlak', 'Ankara', 45000);

create table basvurular (
  ogr_id int,
  okul_adi text,
  ana_dal text,
  karar char(1),
  unique (ogr_id, okul_adi),
  unique (ogr_id, ana_dal)
);

insert into basvurular values 
(123, 'Ankara', 'Bilg', 'K'),
(123, 'Yıldız', 'Elk', 'R'),
(456, 'Ankara', 'Bilg', 'K'),
(456, 'İstanbul', 'Mak', 'K'),
(123, 'İstanbul', 'Bilg', 'R');

insert into basvurular values 
(123, null, null, 'K'),
(123, null, null, 'R');

drop table basvurular;

create table basvurular (
  ogr_id int primary key,
  okul_adi text,
  ana_dal text,
  karar char(1)
);

insert into basvurular values (null, 'Ankara', 'Elk', 'R');

-------------------------------------------
--- Nitelik kontrol kısıtlaması -----------
-------------------------------------------

drop table ogrenciler, okullar, basvurular;

create table ogrenciler (
  id int, ad text,
  ortalama real check (ortalama <= 4 and ortalama >= 0),
  lise_mevcudu int check (lise_mevcudu < 2000)
);

insert into ogrenciler values (123, 'İsmail', 2.5, 1000);
insert into ogrenciler values (123, 'İsmail', 4.5, 1000);
insert into ogrenciler values (123, 'İsmail', 2.5, null);

update ogrenciler set ortalama=null where ad='İsmail';

-------------------------------------------
--- Tuple (kayıt) kontrol kısıtlaması -----
-------------------------------------------

create table basvurular (
  ogr_id int,
  okul text,
  ana_dal varchar(12),
  karar char(1),
  check (karar = 'R' or okul <> 'İTÜ')
);

insert into basvurular values (123, 'Ankara', 'Bilg', 'K');
insert into basvurular values (123, 'Ankara', 'Bilg', 'R');
insert into basvurular values (123, 'İTÜ', 'Bilg', 'K');

drop table ogrenciler, basvurular;

-------------------------------------------
--- Referans bütünlüğü kısıtlaması --------
-------------------------------------------

create table ogrenciler (
  ogr_id int, 
  ad text,
  ortalama real
);

create table basvurular (
  ogr_id int,
  okul text,
  ana_dal varchar(12),
  karar char(1),
  check (ogr_id in (select ogr_id from ogrenciler))
);

-------------------------------------------
--- Otomatik artan sütun değeri -----------
--- Kısıtlamalardan bağımsız ara konu -----
-------------------------------------------

create table urunler (
  urun_id serial primary key,
  baslik varchar(64),
  aciklama text,
  fiyat real
);

insert into urunler values 
(default, 'Kalem', 'Güzel bir kalem', 59.99),
(default, 'Defter', 'Kareli defter', 39.99);

insert into urunler(baslik, aciklama, fiyat)
values('İşaret Parmağı', 'Mavi işaret parmağı', 99.99);

select * from urunler;

-------------------------------------------
--- Referans bütünlüğü kısıtlaması --------
-------------------------------------------

create table okullar (
  okul_adi varchar(32) primary key,
  sehir varchar(32),
  mevcut int
);

create table ogrenciler (
  ogr_id int primary key,
  ogr_adi varchar(32)
);

create table basvurular (
  ogr_id int references ogrenciler(ogr_id),
  okul_adi varchar(32) references okullar(okul_adi),
  sonuc char(1)
);
-- 1
insert into basvurular values (123, 'BAİBÜ', 'K');
-- 2
insert into ogrenciler values (123, 'Ali');
insert into ogrenciler values (456, 'Veli');
insert into okullar values ('BAİBÜ', 'Bolu', 10000);
insert into okullar values ('İTÜ', 'İst', 20000);

insert into basvurular values (123, 'BAİBÜ', 'K');
-- 3
update basvurular set ogr_id=456 where ogr_id=123;
-- 4
delete from okullar where okul_adi = 'BAİBÜ';
-- 5
update okullar set okul_adi = 'TBAİBÜ' where okul_adi = 'BAİBÜ';
-- 6
drop table ogrenciler;
-- 7
drop table basvurular;
-- 8
create table basvurular (
  ogr_id int references ogrenciler(ogr_id) 
    on delete set null,
  okul_adi varchar(32) references okullar(okul_adi) 
    on delete set null 
    on update cascade,
  sonuc char(1)
);

insert into basvurular values 
(123, 'BAİBÜ', 'K'),
(456, 'BAİBÜ', 'R'),
(123, 'İTÜ', 'K'),
(456, 'İTÜ', 'K');
-- 9
delete from ogrenciler where ogr_id = 123;

select * from basvurular;
-- 10
update ogrenciler set ogr_id = 789 where ogr_id = 456;
-- 11
update okullar set okul_adi = 'TBAİBÜ' where okul_adi = 'BAİBÜ';

select * from basvurular;