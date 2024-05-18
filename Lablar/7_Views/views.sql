-- SQLite Tablo Oluşturma --
drop table if exists basvurular;
drop table if exists ogrenciler;
drop table if exists okullar;

CREATE TABLE basvurular (
    ogr_id integer,
    okul_adi text,
    ana_dal text,
    sonuc text
);

CREATE TABLE ogrenciler (
    ogr_id integer,
    ogr_adi text,
    ort real,
    lis_mev integer
);

CREATE TABLE okullar (
    okul_adi text,
    sehir ctext,
    kayit_sayisi integer
);

-- SQLite Veri Girişi --

INSERT INTO basvurular VALUES (100, 'Boğaziçi', 'Bilg. Müh.', 'K');
INSERT INTO basvurular VALUES (102, 'Ankara', 'Bilg. Müh.', 'K');
INSERT INTO basvurular VALUES (102, 'Gazi', 'Elk. Müh.', 'R');
INSERT INTO basvurular VALUES (103, 'Ankara', 'Bilg. Müh.', 'K');
INSERT INTO basvurular VALUES (104, 'Bilkent', 'Bilg. Müh.', 'R');
INSERT INTO basvurular VALUES (105, 'İTÜ', 'Elk. Müh.', 'R');
INSERT INTO basvurular VALUES (105, 'Marmara', 'Genetik Müh.', 'K');
INSERT INTO basvurular VALUES (106, 'BAİBÜ', 'Bilg. Müh.', 'K');
INSERT INTO basvurular VALUES (108, 'Ege', 'Genetik. Müh.', 'K');
INSERT INTO basvurular VALUES (108, 'İYTE', 'Biyoloji', 'R');
INSERT INTO basvurular VALUES (108, 'Boğaziçi', 'Biyoloji', 'K');
INSERT INTO basvurular VALUES (108, 'Ankara', 'İnşaat Müh.', 'R');
INSERT INTO basvurular VALUES (109, 'Gazi', 'Bilg. Müh.', 'R');
INSERT INTO basvurular VALUES (109, 'Bilkent', 'İşletme', 'K');
INSERT INTO basvurular VALUES (110, 'Ege', 'İşletme', 'K');
INSERT INTO basvurular VALUES (111, 'İYTE', 'Bilg. Müh.', 'K');
INSERT INTO basvurular VALUES (112, 'BAİBÜ', 'İktisat', 'R');
INSERT INTO basvurular VALUES (112, 'Ankara', 'İktisat', 'K');
INSERT INTO basvurular VALUES (113, 'Marmara', 'İşletme', 'K');
INSERT INTO basvurular VALUES (114, 'Marmara', 'GSF', 'R');
INSERT INTO basvurular VALUES (115, 'İTÜ', 'Elk. Müh.', 'R');
INSERT INTO basvurular VALUES (115, 'Boğaziçi', 'Elk. Müh.', 'K');
INSERT INTO basvurular VALUES (116, 'BAİBÜ', 'GSF', 'R');
INSERT INTO basvurular VALUES (119, 'BAİBÜ', 'Biyoloji', 'K');


INSERT INTO ogrenciler VALUES (100, 'Gazi', 3.7, 1200);
INSERT INTO ogrenciler VALUES (101, 'Ali', 3, 1000);
INSERT INTO ogrenciler VALUES (102, 'Ayşe', 3.9, 200);
INSERT INTO ogrenciler VALUES (103, 'Hasan', 2.7, 500);
INSERT INTO ogrenciler VALUES (104, 'İsmail', 2.24, 400);
INSERT INTO ogrenciler VALUES (105, 'Kemal', 3.2, 800);
INSERT INTO ogrenciler VALUES (106, 'Tuğçe', 2.7, 700);
INSERT INTO ogrenciler VALUES (107, 'Nimet', 2.9, 700);
INSERT INTO ogrenciler VALUES (108, 'Osman', 4, 1200);
INSERT INTO ogrenciler VALUES (109, 'Ozan', 4, 1600);
INSERT INTO ogrenciler VALUES (110, 'Ali', 2.55, 150);
INSERT INTO ogrenciler VALUES (111, 'Tarık', 3.15, 120);
INSERT INTO ogrenciler VALUES (112, 'Gamze', 3.25, 100);
INSERT INTO ogrenciler VALUES (113, 'Marmara', 3.44, 200);
INSERT INTO ogrenciler VALUES (114, 'Ahmet', 2.75, 100);
INSERT INTO ogrenciler VALUES (115, 'Burçin', 2.27, 600);
INSERT INTO ogrenciler VALUES (116, 'Fatma', 2, 880);
INSERT INTO ogrenciler VALUES (117, 'Ahmet', 2.1, 500);
INSERT INTO ogrenciler VALUES (118, 'Mehmet', 2.88, 400);
INSERT INTO ogrenciler VALUES (119, 'Emine', 3.88, 360);


INSERT INTO okullar VALUES ('Ankara', 'Ankara', 15000);
INSERT INTO okullar VALUES ('Gazi', 'Ankara', 25000);
INSERT INTO okullar VALUES ('Bilkent', 'Ankara', 9000);
INSERT INTO okullar VALUES ('İTÜ', 'İstanbul', 19000);
INSERT INTO okullar VALUES ('Boğaziçi', 'İstanbul', 14000);
INSERT INTO okullar VALUES ('Marmara', 'İstanbul', 27000);
INSERT INTO okullar VALUES ('BAİBÜ', 'Bolu', 15500);
INSERT INTO okullar VALUES ('Ege', 'İzmir', 19000);
INSERT INTO okullar VALUES ('İYTE', 'İzmir', 9000);

------------------
---- View'lar ----
------------------

-- Bilg. Müh'e kabul alan öğrencilerin view'ı --

create view bm_kabul as 
select ogr_id, okul_adi 
from basvurular 
where ana_dal = 'Bilg. Müh.' and sonuc = 'K';

-- Ankara Bilg. Müh.'e kabul almış ve ortalaması 3.5'ten küçük olan 
-- öğrencilerin ogr id, ad ve ortalamalarının listesini veren sorgu

select ogrenciler.ogr_id, ogr_adi, ort
from ogrenciler, bm_kabul 
where ogrenciler.ogr_id = bm_kabul.ogr_id and okul_adi = 'Ankara' and ort < 3.5;

-- Ankara Bilg. Müh.'e kabul almış öğrencilerin view'ı
-- Bir view oluşturulurken sorgu kısmında başka bir view kullanılabilir.

create view bm_ankara as
select ogrenciler.ogr_id, ogr_adi, ort
from ogrenciler, bm_kabul 
where ogrenciler.ogr_id = bm_kabul.ogr_id and okul_adi = 'Ankara';

-- Ankara Bilg. Müh.'e kabul almış ve ortalaması 3.5'ten küçük olan 
-- öğrencilerin ogr id, ad ve ortalamalarının listesini veren sorgu

select *
from bm_ankara 
where ort < 3.5;

-- tüm tabloları birleştirem "tümü" adında bir view oluşturma

create view tumu as
select o.okul_adi, sehir, kayit_sayisi, ogr.ogr_id, ogr_adi, ort, lis_mev, ana_dal, sonuc
from okullar o, basvurular b, ogrenciler ogr 
where b.okul_adi = o.okul_adi and b.ogr_id = ogr.ogr_id;

-- kayıt sayısı 10000'den büyük olan üniversitelerin Bilg Müh bölümüne
-- 3 üstü ortalama ile başvuru yapmış öğrencilerin id'si, adı, ortalaması ve 
-- başvurdukları üni ismini döndüren sorgu

select ogr_id, ogr_adi, ort, okul_adi 
from tumu 
where ana_dal = 'Bilg. Müh.' and kayit_sayisi > 10000 and ort > 3.0;

-------------------------------------
---- View'larda Değişiklik Yapma ----
-------------------------------------

-- aşağıdaki bm_kabul view'ı üzerindeki silme işlemi gerçekleşebilir mi?

delete from bm_kabul
where ogr_id = 100;

-- aynı işlemi trigger kullanarak gerçekleştirme

create trigger bm_kabul_silme
instead of delete on bm_kabul 
for each row 
begin 
	delete from basvurular 
	where ogr_id = old.ogr_id 
	and okul_adi = old.okul_adi
	and ana_dal = 'Bilg. Müh.' 
	and sonuc = 'K';
end;

delete from bm_kabul
where ogr_id = 100;

-- view güncelleme 

-- bm_kabul view'ındaki 103 id'li öğrencinin başvurusunu Gazi Üniversitesi'ne güncelleme

update bm_kabul 
set okul_adi = 'Gazi'
where ogr_id = 103;

-- aşağıdaki trigger'ı oluştururken ana_dal = 'Biyoloji' yazsaydık ne olurdu?

create trigger bm_kabul_update
instead of update of okul_adi on bm_kabul 
for each row 
begin
	update basvurular 
	set okul_adi = new.okul_adi 
	where ogr_id = old.ogr_id 
	and okul_adi = old.okul_adi 
	and ana_dal = 'Bilg. Müh.' and sonuc = 'K';
end;

update bm_kabul 
set okul_adi = 'Gazi'
where ogr_id = 103;

update bm_kabul 
set ogr_id = 100
where okul_adi = 'Gazi';

-- bilg müh veya elek müh'e başvuran öğrencilerin view'ı

create view bm_ee as
select ogr_id, okul_adi, ana_dal
from basvurular
where ana_dal = 'Bilg. Müh.' or ana_dal = 'Elk. Müh.';

-- bm_ee view'ı için insert işlemi

insert into bm_ee values (107, 'Boğaziçi', 'Bilg. Müh.');

create trigger bm_ee_insert 
instead of insert on bm_ee 
for each row 
begin
	insert into basvurular values (new.ogr_id, new.okul_adi, new.ana_dal, NULL);
end;

insert into bm_ee values (107, 'Boğaziçi', 'Bilg. Müh.');
insert into bm_ee values (107, 'Boğaziçi', 'Biyoloji');

-- düzeltme

drop trigger bm_ee_insert;

create trigger bm_ee_insert 
instead of insert on bm_ee 
for each row 
when new.ana_dal = 'Bilg. Müh.' or new.ana_dal = 'Elk. Müh.'
begin
	insert into basvurular values (new.ogr_id, new.okul_adi, new.ana_dal, NULL);
end;

insert into bm_ee values (108, 'Boğaziçi', 'Biyoloji');

-- lise mevcutlarına göre averaj öğrenci ortalaması view'ı

create view lis_mev_avg_ort as
select lis_mev, avg(ort) as avg_ort 
from ogrenciler
group by lis_mev;

-- aşağıdaki komut mantıklı mı?

update lis_mev_avg_ort
set avg_ort = 3.5
where lis_mev = 1000;

-- lis_mev_avg_ort view'ı üzerinde insert, delete yapmak mantıklı mı?
