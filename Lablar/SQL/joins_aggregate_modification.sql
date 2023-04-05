/*
********* JOIN'ler **********
*/

select ogr_adi, ana_dal
from ogrenciler o, basvurular b
where o.ogr_id = b.ogr_id;

-- Theta Join --
select ogr_adi, ana_dal
from ogrenciler o inner join basvurular b
on o.ogr_id = b.ogr_id;

-- Inner Join yerine sadece Join yazabiliriz --
select ogr_adi, ana_dal
from ogrenciler o join basvurular b
on o.ogr_id = b.ogr_id;

/*
lise mevcudu 100'den büyük olan, Ank Bilg Müh'e başvuran öğrencilerin listesini döndüren sorgu
*/
select ogr_adi, ort
from ogrenciler o, basvurular b
where o.ogr_id = b.ogr_id 
	and lis_mev > 100 and ana_dal = 'Bilg. Müh.' and okul_adi = 'Ankara';

/*
lise mevcudu 100'den büyük olan, Ank Bilg Müh'e başvuran öğrencilerin listesini döndüren sorgu
JOIN kullanarak
*/
select ogr_adi, ort
from ogrenciler o join basvurular b
on o.ogr_id = b.ogr_id 
where lis_mev > 100 and ana_dal = 'Bilg. Müh.' and okul_adi = 'Ankara';

/*
tüm başvuru yapan öğrencilerin ID, ad, ortalama bilgileri ve 
başvuruda bulundukları okulların adı ve kayıt sayısını döndüren sorgu (query)
*/
select og.ogr_id, ogr_adi, ort, b.okul_adi, kayit_sayisi
from ogrenciler og, okullar ok, basvurular b
where og.ogr_id = b.ogr_id and b.okul_adi = ok.okul_adi;

/*
tüm başvuru yapan öğrencilerin ID, ad, ortalama bilgileri ve 
başvuruda bulundukları okulların adı ve kayıt sayısını döndüren sorgu (query)
JOIN kullanarak (Hatalı!!! Postgresql'de Joinler 2li (binary) olmalıdır)
*/
select og.ogr_id, ogr_adi, ort, b.okul_adi, kayit_sayisi
from ogrenciler og join okullar ok join basvurular b
on og.ogr_id = b.ogr_id and b.okul_adi = ok.okul_adi;

/*
tüm başvuru yapan öğrencilerin ID, ad, ortalama bilgileri ve 
başvuruda bulundukları okulların adı ve kayıt sayısını döndüren sorgu (query)
(Doğru)
*/
select og.ogr_id, ogr_adi, ort, b.okul_adi, kayit_sayisi
from (ogrenciler og join basvurular b on og.ogr_id = b.ogr_id) join okullar ok
on b.okul_adi = ok.okul_adi;

-- Theta Join --
select distinct ogr_adi, ana_dal
from ogrenciler o inner join basvurular b
on o.ogr_id = b.ogr_id;

-- Üstteki query'nin Natural Join karşılığı --
select distinct ogr_adi, ana_dal
from ogrenciler o natural join basvurular b;

-- Natural Join tekrar eden sütun'ları teke indirir (ogr_id) --
select *
from ogrenciler o natural join basvurular b;

/*
lise mevcudu 100'den büyük olan, Ank Bilg Müh'e başvuran öğrencilerin listesini döndüren sorgu
JOIN kullanarak
*/
select ogr_adi, ort
from ogrenciler o join basvurular b
on o.ogr_id = b.ogr_id 
where lis_mev > 100 and ana_dal = 'Bilg. Müh.' and okul_adi = 'Ankara';

/*
Üstteki sorgunun NATURAL JOIN kullanılarak oluşturulmuş dengi
*/
select ogr_adi, ort
from ogrenciler o natural join basvurular b
where lis_mev > 100 and ana_dal = 'Bilg. Müh.' and okul_adi = 'Ankara';

/*
Üstteki sorgunun Inner Join ve USING kullanılarak oluşturulmuş dengi
*/
select ogr_adi, ort
from ogrenciler o join basvurular b using(ogr_id)
where lis_mev > 100 and ana_dal = 'Bilg. Müh.' and okul_adi = 'Ankara';

/*
Aynı ortalamaya sahip öğrencilerin listesini döndüren sorgu
*/
select o1.ogr_id, o1.ogr_adi, o1.ort, o2.ogr_id, o2.ogr_adi, o2.ort
from ogrenciler o1, ogrenciler o2
where o1.ort = o2.ort and o1.ogr_id < o2.ogr_id;

/*
Yukarıdaki sorgunun Join kullanılan versiyonu
*/
select o1.ogr_id, o1.ogr_adi, o1.ort, o2.ogr_id, o2.ogr_adi, o2.ort
from ogrenciler o1 join ogrenciler o2 using(ort)
where o1.ogr_id < o2.ogr_id;

-- Tablonun kendisi ile Natural Join'i tablonun kendisini döndürür
select *
from ogrenciler o1 natural join ogrenciler o2;

-- Başvuruda bulunan tüm öğrencilerin bilgileri
select ogr_id, ogr_adi, okul_adi, ana_dal
from ogrenciler inner join basvurular using(ogr_id);

-- Başvuruda bulunan ve bulunmayan tüm öğrencilerin bilgileri
select ogr_id, ogr_adi, okul_adi, ana_dal
from ogrenciler left outer join basvurular using(ogr_id);

-- Başvuruda bulunan ve bulunmayan tüm öğrencilerin bilgileri
-- left outer yerine kısaca left
select ogr_id, ogr_adi, okul_adi, ana_dal
from ogrenciler left join basvurular using(ogr_id);

-- Yukardaki sorgunun left outer join olmadan tekrar yazımı
select o.ogr_id, ogr_adi, okul_adi, ana_dal
from ogrenciler o, basvurular b
where o.ogr_id = b.ogr_id
union
select ogr_id, ogr_adi, NULL, NULL
from ogrenciler
where ogr_id not in (select ogr_id from basvurular);

-- Yeni bilgi girişi
insert into basvurular 
values 
(999, 'Boğaziçi', 'Elk. Müh.', 'K'),
(999, 'Boğaziçi', 'Bilg. Müh.', 'R');

-- Başvuruda bulunulan tüm okulların bilgileri
select ogr_id, ogr_adi, okul_adi, ana_dal
from basvurular left outer join ogrenciler using(ogr_id);

-- Başvuruda bulunulan tüm okulların bilgileri
select ogr_id, ogr_adi, okul_adi, ana_dal
from ogrenciler right outer join basvurular using(ogr_id);

-- Tüm öğrencilerin ve başvuruda bulunulan tüm okulların bilgileri
select ogr_id, ogr_adi, okul_adi, ana_dal
from ogrenciler full outer join basvurular using(ogr_id);

/*
***** Limit ve First N *****
*/

-- En yüksek ortalamaya sahip ilk 3 öğrenci
select ort, ogr_id
from ogrenciler
where ort is not null
order by ort desc
limit 3;

select ort, ogr_id
from ogrenciler
where ort is not null
order by ort desc
fetch first 3 rows only;

/*
***** Yığışım (Aggregation) *****
*/

-- yeni kayıt
insert into basvurular values(100, 'Ankara', 'Bilg. Müh.', 'K');
insert into basvurular values(100, 'Ankara', 'Elk. Müh.', 'R');

-- average (avg): aritmetik ortalama
select avg(lis_mev)
from ogrenciler;

-- Bilg Müh'e başvuran en düşük ortalamalı öğrenci
select min(ort)
from ogrenciler natural join basvurular
where ana_dal = 'Bilg. Müh.';

-- Bilg Müh'e başvuran öğrencilerin not ortalaması (Yanlış)
select avg(ort)
from ogrenciler natural join basvurular
where ana_dal = 'Bilg. Müh.';

-- Bilg Müh'e başvuran öğrencilerin not ortalaması (Yanlış)
select avg(ort)
from ogrenciler natural join basvurular
where ana_dal = 'Bilg. Müh.';

-- Bilg Müh'e başvuran öğrencilerin not ortalaması (Doğru)
select avg(ort)
from ogrenciler
where ogr_id in (select ogr_id from basvurular where ana_dal = 'Bilg. Müh.');

-- Kayıt sayısı > 10000 olan okulların sayısını döndüren query
select count(*)
from okullar
where kayit_sayisi > 10000;

-- Ankara üniversitesine başvuran örencilerin sayısı
select count(distinct ogr_id)
from basvurular
where okul_adi = 'Ankara';

-- Bilg Mühe başvuran öğrencilerin ortalama not ortalaması ile
-- Bilg Mühe başvurmayan öğrencilerin ortalama not ortalaması arasındaki farkı bulan sorgu
select Bil.avg_ort - BilDegil.avg_ort as ortalama_farki
from (select avg(ort) as avg_ort
	  from ogrenciler
	 where ogr_id in (select ogr_id from basvurular where ana_dal = 'Bilg. Müh.')) as Bil,
	 (select avg(ort) as avg_ort
	  from ogrenciler
	 where ogr_id not in (select ogr_id from basvurular where ana_dal = 'Bilg. Müh.')) as BilDegil;
	 
-- Her okula yapılan başvuru sayıları
select okul_adi, count(*) as basvuru_sayisi
from basvurular
group by okul_adi;

-- Şehirlere göre üniversitelerin toplam kayıt sayıları
select sehir, sum(kayit_sayisi)
from okullar
group by sehir;

-- Her okulun ana dallarına yapılan başvurular arasındaki en büyük ve en düşük ortalamalar
select okul_adi, ana_dal, max(ort), min(ort)
from ogrenciler inner join basvurular using(ogr_id)
group by okul_adi, ana_dal;

-- öğrencilerin başvuruda bulunduğu üniversite sayıları
select ogrenciler.ogr_id, count(distinct okul_adi)
from ogrenciler, basvurular
where ogrenciler.ogr_id = basvurular.ogr_id
group by ogrenciler.ogr_id;

-- öğrencilerin başvuruda bulunduğu üniversite sayıları 
-- bir öğrenci hiç bir başvuruda bulunmadıysa yanında 0 yazmalıdır.
select ogrenciler.ogr_id, count(distinct okul_adi)
from ogrenciler, basvurular
where ogrenciler.ogr_id = basvurular.ogr_id
group by ogrenciler.ogr_id
union
select ogr_id, 0
from ogrenciler
where ogr_id not in (select ogr_id from basvurular);

-- 3'ten daha az başvuru yapılmış üniversiteler
select okul_adi
from basvurular
group by okul_adi
having count(*) < 3;

-- 3'ten daha az farklı öğrencinin başvuru yapmış olduğu üniversiteler
select okul_adi
from basvurular
group by okul_adi
having count(distinct ogr_id) < 3;

/*
***** NULL Değerler *****
*/

insert into ogrenciler values
(120, 'Adem', NULL, 900),
(121, 'Keriman', NULL, 1500);

-- ort > 3.0 olan öğrenciler
select *
from ogrenciler
where ort > 3.0;

-- ort > 3.0 veya <= 3.0 olan öğrenciler
select *
from ogrenciler
where ort > 3.0 or ort <= 3.0;

-- ort > 3.0 veya <= 3.0 olan öğrenciler veya ortalaması null olanlar
select *
from ogrenciler
where ort > 3.0 or ort <= 3.0 or ort is null;

-- ort null olmayan öğrencilerin sayısı
select count(*)
from ogrenciler
where ort is not null;

/*
***** Veri Modifikasyonu *****
*/

-- Veri ekleme
insert into okullar values ('Selçuk', 'Konya', 30000);

-- Hiç bir başvuruda bulunmamış öğrenciler
select *
from ogrenciler
where ogr_id not in (select ogr_id
					from basvurular);

-- Insert için veri hazırlama
select ogr_id, 'Selçuk', 'Bilg. Müh.', null
from ogrenciler
where ogr_id not in (select ogr_id
					from basvurular);
					
-- Hiç bir yere başvuruda bulunmamış öğrencileri
-- otomatik olarak Selçuk Bilg Mühe başvurdurtma sorgusu
insert into basvurular
select ogr_id, 'Selçuk', 'Bilg. Müh.', null
from ogrenciler
where ogr_id not in (select ogr_id
					from basvurular);
					
-- Selçuk üniversitesi Bilg Mühe yapılan tüm başvuruları
-- Selçuk Elk Müh'e yönlendirme ve kabul etme
update basvurular
set ana_dal = 'Elk. Müh.', sonuc = 'K'
where okul_adi = 'Selçuk' and ana_dal = 'Bilg. Müh.';

-- Selçuk üniversitesine yapılan tüm başvuruları silme sorgusu
delete
from basvurular
where okul_adi = 'Selçuk';
