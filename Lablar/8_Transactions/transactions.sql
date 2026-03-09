-- pgadmin
create table musteriler(
    musteri_id integer primary key,
    ad text
);
create table puanlar(
    musteri_id integer references musteriler(musteri_id) on delete set NULL,
    para REAL,
    tip TEXT
);
create table siparisler(
    musteri_id integer references musteriler(musteri_id) on delete set null,
    urun_id integer,
    tarih timestamp
);
insert into musteriler values 
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E');
insert into puanlar values 
(1, 500.25, 'cekilis'),
(1, 250.0, 'harcama'),
(2, 1000.0, 'harcama'),
(3, 15.99, 'promosyon'),
(4, 150.0, 'promosyon');

-- transaction olmadan
-- burada pgadmin ve sqlite browser farklı davranıyor.
-- pgadmin tüm işlemleri hata durumunda geri alırken, 
-- sqlite browser hata alınan sorguya kadarki sorguları gerçekleştiriyor.

-- 1
update puanlar
set para = para - 100.0
where musteri_id = 1 and tip = 'cekilis';
insert into siparisler
values (111, 99, now());

-- 2
begin transaction;
update puanlar
set para = para - 100.0
where musteri_id = 1 and tip = 'cekilis';
insert into siparisler
values (111, 99, now());
commit;

select * from puanlar;

-- 3
begin transaction;
update puanlar
set para = para - 100.0
where musteri_id = 1 and tip = 'cekilis';
rollback;

select * from puanlar;

-- 4
begin transaction;
update puanlar
set para = para - 100.0
where musteri_id = 1 and tip = 'cekilis';
commit;

select * from puanlar;

-- 5 pgadmin + vscode sqltools extension
--- 1. pgadmin
begin transaction;
update puanlar
set para = para - 100.0
where musteri_id = 1 and tip = 'cekilis';

select * from puanlar;
--- 2. sqltools
select * from puanlar;
--- 3. pgadmin
commit;
--- 4. sqltools
select * from puanlar;

-- 6 pgadmin + vscode sqltools extension
--- 1. pgadmin
begin transaction;
update puanlar
set para = para - 100.0
where musteri_id = 1 and tip = 'cekilis';

select * from puanlar;
--- 2. sqltools
select * from puanlar;
--- 3. pgadmin
rollback;
--- 4. sqltools
select * from puanlar;
