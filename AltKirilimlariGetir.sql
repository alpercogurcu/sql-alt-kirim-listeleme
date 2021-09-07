;with tree (ogeno, mamul_id, stok_id, parcaAdi, miktar, gerekenMiktar, ID1, ParentID1, carpim) as (

select
usttablo.ogeno, 
usttablo.mamul_id, 
usttablo.stok_id, 
usttablo.parcaAdi, 
usttablo.miktar, 
(usttablo.miktar * @takimsayisi ) as gerekenMiktar, -- usttablo.gerekenMiktar
usttablo.ID1, 
usttablo.ParentID1, 
carpim from tasarim_urunAgaci usttablo 
where mamul_id = @tasarim_mamul_id and ParentID1  = @tasarim_ID1--  in (select ID1 from #BirinciKirimlar)

union all
select 
usttablo.ogeno, 
usttablo.mamul_id, 
usttablo.stok_id, 
usttablo.parcaAdi, 
usttablo.miktar,
CASE 
WHEN usttablo.carpim ='Hayır' then bk.gerekenMiktar
else (usttablo.miktar * bk.gerekenMiktar ) end, 
usttablo.ID1, 
usttablo.ParentID1, 
usttablo.carpim from tasarim_urunAgaci usttablo 
inner join 
tree bk on usttablo.ParentID1 = bk.ID1 
where usttablo.mamul_id = @tasarim_mamul_id 


) 
select * into #altkirimlar from tree 
