-- basit select
select ogr_id, ogr_adi, ort
from ogrenciler
where ort > 3.0;

-- basvuru yapan ogrencilerin adi ve basvurduklari ana dallar
select ogr_adi, ana_dal
from ogrenciler, basvurular
where ogrenciler.ogr_id = basvurular.ogr_id;

-- tekrarlamayan (unique) basvuru yapan ogrencilerin adi ve basvurduklari ana dallar
select distinct ogr_adi, ana_dal
from ogrenciler, basvurular
where ogrenciler.ogr_id = basvurular.ogr_id;

-- lise mevcudu 400'den büyük olan ve Ankara Üniversitesi Bilgisayar Mühendisliği
-- bölümüne başvuran öğrencilerin adları, ortalamaları ve basvuru sonuclarinin oldugu liste
select ogr_adi, ort, sonuc
from ogrenciler, basvurular
where ogrenciler.ogr_id = basvurular.ogr_id
	and lis_mev > 400 and ana_dal = 'Bilg. Müh.' and okul_adi = 'Ankara';

/* 
kayıt sayısı 5000'den büyük olan ve Bilg. Müh. bölümüne başvuru yapılan 
okulların adlarının listesi (HATALI)
*/
select okul_adi
from okullar, basvurular
where okullar.okul_adi = basvurular.okul_adi
	and kayit_sayisi > 5000 and ana_dal = 'Bilg. Müh.';

/* 
kayıt sayısı 5000'den büyük olan ve Bilg. Müh. bölümüne başvuru yapılan 
okulların adlarının listesi (DOĞRU)
*/
select okullar.okul_adi
from okullar, basvurular
where okullar.okul_adi = basvurular.okul_adi
	and kayit_sayisi > 5000 and ana_dal = 'Bilg. Müh.';
	
/* 
kayıt sayısı 5000'den büyük olan ve Bilg. Müh. bölümüne başvuru yapılan 
okulların adlarının tekrarsız listesi
*/
select distinct okullar.okul_adi
from okullar, basvurular
where okullar.okul_adi = basvurular.okul_adi
	and kayit_sayisi > 5000 and ana_dal = 'Bilg. Müh.';
	
/*
Başvuruda bulunan tüm öğrencilerin ID'si, adı, ortalaması ve başvurdukları okulların
adı ve kayıt sayısının listesi
*/
select ogrenciler.ogr_id, ogr_adi, ort, basvurular.okul_adi, kayit_sayisi 
from ogrenciler, okullar, basvurular 
where ogrenciler.ogr_id = basvurular.ogr_id and basvurular.okul_adi = okullar.okul_adi;

/*
Başvuruda bulunan tüm öğrencilerin ID'si, adı, ortalaması ve başvurdukları okulların
adı ve kayıt sayısının listesi. Liste, ortamaya göre azalan şekilde sıralı olmalıdır.
*/
select ogrenciler.ogr_id, ogr_adi, ort, basvurular.okul_adi, kayit_sayisi 
from ogrenciler, okullar, basvurular 
where ogrenciler.ogr_id = basvurular.ogr_id and basvurular.okul_adi = okullar.okul_adi
order by ort desc;

/*
Başvuruda bulunan tüm öğrencilerin ID'si, adı, ortalaması ve başvurdukları okulların
adı ve kayıt sayısının listesi. Liste, ortamaya göre azalan şekilde ve 
kayit_sayisina göre artan şekilde sıralı olmalıdır.
*/
select ogrenciler.ogr_id, ogr_adi, ort, basvurular.okul_adi, kayit_sayisi 
from ogrenciler, okullar, basvurular 
where ogrenciler.ogr_id = basvurular.ogr_id and basvurular.okul_adi = okullar.okul_adi
order by ort desc, kayit_sayisi;

/*
İçinde "Müh" geçen bölümlere başvuran öğrencilerin ID'si ve 
başvurdukları bölümlerin adlarının listesi
*/
select ogr_id, ana_dal 
from basvurular 
where ana_dal like '%Müh%';

/*
içinde "Müh" geçen başvurulara ait tüm bilgilerin listesi
*/
select * 
from basvurular 
where ana_dal like '%Müh%';

/*
tüm öğrencilerin ID'si, adı, ortalaması, lise mevcudu, ve ağırlıklı ortalaması
ağırlıklı ortalama = ortalama * lise mevcudu / 1000
*/
select ogr_id, ogr_adi, ort, lis_mev, ort * (lis_mev / 1000.0)
from ogrenciler;

/*
tüm öğrencilerin ID'si, adı, ortalaması, lise mevcudu, ve ağırlıklı ortalaması
ağırlıklı ortalama = ortalama * lise mevcudu / 1000
*/
select ogr_id, ogr_adi, ort, lis_mev, ort * (lis_mev / 1000.0) as agirlikli_ort
from ogrenciler;

/*
******************************************
********* Tablo Değişkenleri *************
********* Table Variables ****************
******************************************
*/

/*
Başvuruda bulunan tüm öğrencilerin ID'si, adı, ortalaması ve başvurdukları okulların
adı ve kayıt sayısının listesi
*/
select og.ogr_id, ogr_adi, ort, b.okul_adi, kayit_sayisi 
from ogrenciler og, okullar ok, basvurular b 
where og.ogr_id = b.ogr_id and b.okul_adi = ok.okul_adi;

/*
Aynı ortalamaya sahip tüm öğrencilerin ID, ad ve ortalamalarının listesi
*/
select o1.ogr_id, o1.ogr_adi, o1.ort, o2.ogr_id, o2.ogr_adi, o2.ort
from ogrenciler o1, ogrenciler o2
where o1.ort = o2.ort;
-- and o1.ogr_id <> o2.ogr_id;
-- and o1.ogr_id < o2.ogr_id;

/* 
tüm okul ve öğrenci adlarının listesi 
*/
select ogr_adi
from ogrenciler
union
select okul_adi 
from okullar;

select ogr_adi as ad
from ogrenciler
union
select okul_adi as ad
from okullar
order by ad;

select ogr_adi as ad
from ogrenciler
union all
select okul_adi as ad
from okullar
order by ad;

-- yeni kayıtlar
insert into ogrenciler values(120, 'Ayşe', 2.9, 500);
insert into basvurular values(120, 'Gazi', 'Elk. Müh.', 'K');

/*
hem Bilg müh hem de Elk müh'e başvuran öğrencilerin ID'lerinin listesi
*/
select ogr_id
from basvurular
where ana_dal = 'Bilg. Müh.'
intersect
select ogr_id
from basvurular
where ana_dal = 'Elk. Müh.';

/*
Bilg müh'e başvurup Elk müh'e başvurMAYAN öğrencilerin ID'lerinin listesi
*/
select ogr_id
from basvurular
where ana_dal = 'Bilg. Müh.'
except
select ogr_id
from basvurular
where ana_dal = 'Elk. Müh.';

/*
************************************************
********* Where kısmındaki iç sorgular *********
************************************************
*/

/*
Elk Müh'e başvuran öğrencilerin adlarının listesi
*/
select ogr_adi
from ogrenciler
where ogr_id in (select ogr_id 
				 from basvurular
				 where ana_dal = 'Elk. Müh.');

/*
Elk Müh'e başvuran öğrencilerin adlarının listesi
*/
select distinct o.ogr_adi
from ogrenciler o, basvurular b
where o.ogr_id = b.ogr_id and b.ana_dal = 'Elk. Müh.';

/*
Bilg müh'e başvurup Elk müh'e başvurMAYAN öğrencilerin ID ve adlarının listesi
*/
select ogr_id, ogr_adi
from ogrenciler
where ogr_id in (select ogr_id 
				 from basvurular where 
				 ana_dal = 'Bilg. Müh.')
   and ogr_id not in (select ogr_id 
				      from basvurular where 
				      ana_dal = 'Elk. Müh.');

-- Elk Müh'e başvuran öğrencilerin ortalamaları
select ort from ogrenciler
where ogr_id in 
	(select ogr_id from basvurular 
	 where ana_dal = 'Elk. Müh.');

-- VS (distinct ile düzeltilemez)
select ort 
from ogrenciler o, basvurular b 
where o.ogr_id = b.ogr_id and b.ana_dal = 'Elk. Müh.'; 

/*
Bulunduğu şehirde 1'den fazla okul bulunan okulların listesi (yanlış)
*/
select o1.okul_adi, o1.sehir
from okullar o1
where exists (select * 
			 from okullar o2
			 where o2.sehir = o1.sehir);
			 
/*
Bulunduğu şehirde 1'den fazla okul bulunan okulların listesi (doğru)
*/
select o1.okul_adi, o1.sehir
from okullar o1
where exists (select * 
			 from okullar o2
			 where o2.sehir = o1.sehir and o1.okul_adi < o2.okul_adi);

-- VS

select o1.okul_adi, o1.sehir
from okullar o1
where exists (select * 
			 from okullar o2
			 where o2.sehir = o1.sehir and o1.okul_adi != o2.okul_adi);

/*
Kayıt sayısı en fazla olan okul
*/
select o1.okul_adi, o1.kayit_sayisi
from okullar o1 
where not exists (select * 
				 from okullar o2
				 where o2.kayit_sayisi > o1.kayit_sayisi);
				 
/*
ortalaması en yüksek olan öğrenci listesi
*/
select o1.ogr_adi
from ogrenciler o1
where not exists (select * from ogrenciler o2
				 where o2.ort > o1.ort)

-- VS (Yanlış)
select o1.ogr_adi, o1.ort
from ogrenciler o1, ogrenciler o2 
where o1.ort > o2.ort;

-- Alternatif 1
select ogr_adi, ort
from ogrenciler
where ort >= all (select ort from ogrenciler);

-- Alternatif 2
select o1.ogr_adi, o1.ort
from ogrenciler o1
where ort > all (select o2.ort from ogrenciler o2
				where o2.ogr_id != o1.ogr_id);

/*
lise mevcudu en düşük olmayan tüm öğrencilerin listesi
*/
select ogr_id, ogr_adi, lis_mev
from ogrenciler
where lis_mev > any (select lis_mev from ogrenciler);

-- Alternatif
select o1.ogr_id, o1.ogr_adi, o1.lis_mev
from ogrenciler o1
where exists (select * from ogrenciler o2
			 where o2.lis_mev < o1.lis_mev);

/*
************************************************
********* FROM kısmındaki iç sorgular **********
************************************************
*/

/*
Ortalaması ile ağırlıklı ortalaması arasındaki fark 1'den büyük olan öğrenciler
ağırlıklı ortalama = ortalama * lise mevcudu / 1000
*/
select ogr_id, ogr_adi, ort, lis_mev, ort * (lis_mev / 1000.0) as agirlikli_ort
from ogrenciler
where ort * (lis_mev / 1000.0) - ort > 1 
	or ort - ort * (lis_mev / 1000.0) > 1;

select ogr_id, ogr_adi, ort, lis_mev, ort * (lis_mev / 1000.0) as agirlikli_ort
from ogrenciler
where abs(ort * (lis_mev / 1000.0) - ort) > 1; 

select *
from (select ogr_id, ogr_adi, ort, lis_mev, ort * (lis_mev / 1000.0) as agirlikli_ort
	  from ogrenciler) O
where abs(O.agirlikli_ort - ort) > 1;

/*
***********************************************************
********* WITH ile isimlendirilmiş alt query'ler **********
***********************************************************
*/

/*
Ortalaması ile ağırlıklı ortalaması arasındaki fark 1'den büyük olan öğrenciler
ağırlıklı ortalama = ortalama * lise mevcudu / 1000
*/

with aort_tablosu as (
	select ogr_id, round((ort * (lis_mev / 1000.0))::numeric, 2) as agirlikli_ort 
	from ogrenciler
)
select O.ogr_id, ogr_adi, ort, lis_mev, agirlikli_ort
from ogrenciler O, aort_tablosu A 
where O.ogr_id = A.ogr_id
	and abs(ort - agirlikli_ort) > 1;

-- Alternatif

with aort_tablosu(ogr_id, agirlikli_ort) as (
	select ogr_id, round((ort * (lis_mev / 1000.0))::numeric, 2)
	from ogrenciler
)
select O.ogr_id, ogr_adi, ort, lis_mev, agirlikli_ort
from ogrenciler O, aort_tablosu A 
where O.ogr_id = A.ogr_id
	and abs(ort - agirlikli_ort) > 1;
