-- SQLite Tablo Oluşturma --

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
    sehir text,
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

-- Trigger'lar --

---- after insert ----

create trigger t1
after insert on ogrenciler
for each row 
when new.ort > 3 and new.ort < 3.6
begin 
	insert into basvurular values(new.ogr_id, 'BAİBÜ', 'Fizik', NULL);
	insert into basvurular values(new.ogr_id, 'Ankara', 'Kimya', NULL);
end;

insert into ogrenciler values 
(120, 'Tahsin', 3.4, 500),
(121, 'Tuğçe', 2.4, 500),
(122, 'Kamil', 3.5, 500),
(123, 'Esra', 2.8, 500);

---- after delete ----

create trigger t2 
after delete on ogrenciler 
for each row 
begin 
	delete from basvurular where ogr_id = old.ogr_id; 
end;

delete from ogrenciler where ogr_id >= 120;

---- after update ----

create trigger t3
after update of okul_adi on okullar 
for each row 
begin
	update basvurular s
	set okul_adi = new.okul_adi 
	where okul_adi = old.okul_adi;
end;

update okullar 
set okul_adi = 'TBAİBÜ' 
where okul_adi = 'BAİBÜ'; 

---- before insert ----

create trigger t4 
before insert on okullar 
for each row 
when exists (select * from okullar where okul_adi = new.okul_adi)
begin
	select raise(ignore);
end;  

insert into okullar values 
('Gazi', 'İstanbul', 10000),
('Yıldız Teknik', 'İstanbul', 20000),
('DEÜ', 'İzmir', 30000);

---- before update ----

create trigger t5 
before update of okul_adi on okullar
for each row 
when exists (select * from okullar where okul_adi = new.okul_adi)
begin
	select raise(ignore);
end;  

update okullar 
set okul_adi = 'DEÜ'
where okul_adi = 'Ege';

---- after insert ----

create trigger t6
after insert on basvurular
for each row
when (select count(*) from basvurular where okul_adi = new.okul_adi) > 5
begin
    update okullar 
    set okul_adi = okul_adi || ' (DOLDU)'
    where okul_adi = new.okul_adi;
end;

insert into basvurular values 
(102, 'Ankara', 'Bilg. Müh.', NULL),
(103, 'Ankara', 'Biyoloji', NULL),
(104, 'Ankara', 'Matematik', NULL),
(105, 'Ankara', 'Tarih', NULL);

-- urunler tablosu --

CREATE TABLE urunler (
	id INTEGER,
	baslik TEXT NOT NULL,
	aciklama TEXT,
	fiyat INTEGER,
	PRIMARY KEY(id AUTOINCREMENT)
);

insert into urunler(baslik, aciklama, fiyat)
values 
('Kalem', 'Kurşun kalem', 20),
('Kalem', 'Tükenmez kalem', 30),
('Defter', '60 yaprak çizgili defter', 40),
('Defter', '80 yaprak kareli defter', 50),
('Bardak', 'Küçük cam bardak', 10),
('Şarj aleti', 'USB-C Şarj aleti', 150);

-- urun logları tablosu --

create table urun_loglari (
    urun_id integer not null,
    aksiyon text not null,
    zaman text
);

---- delete işlemi için log kaydı oluşturma ----

create trigger urun_silme_kaydi
before delete on urunler 
for each row 
begin
    insert into urun_loglari(urun_id, aksiyon, zaman)
    values(old.id, 'silindi', datetime('now'));
end;

delete from urunler
where fiyat < 40;

---- update işlemi için log kaydı oluşturma ----

create trigger urun_guncelleme_kaydi
after update on urunler 
for each row 
begin 
    insert into urun_loglari values(old.id, 'güncellendi', datetime('now'));
end;

update urunler set fiyat = fiyat * 1.25;

create trigger urun_fiyat_guncelleme_kaydi
after update of fiyat on urunler 
for each row 
begin 
    insert into urun_loglari 
	values(old.id, 'fiyat güncellendi ' || old.fiyat || ' => ' || new.fiyat, datetime('now'));
end;

update urunler set fiyat = 100 where id=3;

---- insert işlemi için log kaydı oluşturma ----

create trigger urun_ekleme_kaydi 
after insert on urunler 
for each row 
begin
    insert into urun_loglari values(new.id, 'eklendi', datetime('now'));
end;

insert into urunler(baslik, aciklama, fiyat)
values('Saat', 'Kol saati', 500);

-- trigger yok etme --

drop trigger urun_silme_kaydi;
drop trigger urun_ekleme_kaydi; 
drop trigger urun_guncelleme_kaydi;