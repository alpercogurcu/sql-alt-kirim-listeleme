# SQL ÜRÜN AĞACI / KATEGORİ AĞACI ALT KIRILIM LİSTELEME

Bu kod bloğu ile, ürün ağacınızdaki veya kategori ağacınızdaki herhangi bir kırıma bağlı olan bütün kırımları sırasıyla alabilirsiniz. 

**Bu kod bloğunu neden kullandım?**
Geliştirmekte olduğum bir proje için, satın alınan mamülün alt kırılımlarını ihtiyaç listesinden eritmem gerekiyordu ki; satınaldıkları bir şeyin alt kırılımlarını tekrardan satınalım - ihtiyaç olarak görmesinler. 

**;WITH** kullanarak tree adında bir sanal tablo oluşturuyorum ve bu tablonun sütunlarını **( )** içinde oluşturuyorum.

```
;with tree (ogeno, mamul_id, stok_id, parcaAdi, miktar, gerekenMiktar, ID1, ParentID1, carpim) as (
```
Sanal tabloma karşılık gelen sütunları sırasıyla tasarim_urunAgaci tablomdan çekiyorum. 

```
select

TABLO ALANLARINIZ,

usttablo.ID1, 
usttablo.ParentID1

from tasarim_urunAgaci usttablo 
where ŞART = @ŞART değişkeni and ŞART  = @Şart Değişkeni
```

Bu yukarıdaki blok benim şart bloğum oluyor, hangi değerleri ve hangi değerlerinin alt değerlerini getireceğimi burada belirliyorum.


Ben ilk olarak satın aldığım yarımamülün bir alt kırılımdaki yarımamül veya hammaddelerini listeleyebildim.


Daha sonra yukarıdaki tablom (usttablo) ile, aşağıda asıl döngüye giren tablomu bağladım (tree) 


```
union all
select 
 
 TABLO ALANLARINIZ,
 
usttablo.ID1, 
usttablo.ParentID1

from tasarim_urunAgaci usttablo 
inner join 
tree bk on usttablo.ParentID1 = bk.ID1 
where usttablo.ŞART = @ŞART DEĞİŞKENİ 
```

Burada ise üst tablomda çektiğim kırımların alt kırımlarını çekip, union all ile sürekli bir birleştirme işlemi içerisine giriyor. 

Üstteki tablomda yer alan kırılımların alt kırılımlarını bulabilmem için, Parent ID'si yukarıdaki tablomun ID'sine eşit olan değerleri getir diyorum ve bunun için tüm değerlerimi listelediğim tasarim_urunAgaci tablomdan faydalanıyorum. 



```
) 
select * into #altkirimlar from tree 
```
 
 sonra da bu işlemler bittikten sonra #altkirilimlar adında tablomu oluşturuyorum.
 
 
 
 SQL dosyasında tablo veya sütun isimlerinde bir değişiklik yapmadan paylaştım.
