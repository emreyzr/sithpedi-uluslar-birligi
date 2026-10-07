--[[
Sithpedi Uluslar Birliği — üye uluslar ve delegeler

Bu sayfa, Birliğin üye listesinin TEK kaynağıdır. Portaldaki "Üye uluslar"
kutusu, üye sayısı, Delegeler sayfasındaki tablo, taleplerdeki ulus denetimi
ve oy sayımı buradaki bilgileri kullanır.

Düzenleme kuralları:
  * Her ulus { ... } bloğu içinde yazılır ve sonuna virgül konur.
  * ad         : Ulusun resmî adı (ekranda görünen ad).
  * sayfa      : Ulusun viki sayfası (yoksa ad ile aynı bırakın).
  * takmaAdlar : Oy ve taleplerde kabul edilen başka yazılışlar.
  * delegeler  : Ulusu temsil eden oyuncular.
      - ad        : Oyuncunun adı (ekranda görünür).
      - sayfa     : (isteğe bağlı) Oyuncunun viki sayfası.
      - kullanici : Oyuncunun VİKİ KULLANICI ADI. Doldurulduğunda talepleri
                    açan delege ve ulus oylamasındaki oylar bu ada göre
                    doğrulanır. Boş bırakılırsa o ulus için doğrulama yapılmaz.

Değişiklikten sonra "Önizle" düğmesiyle hata olmadığını denetleyin; bir virgül
ya da tırnak eksikliği bütün portalı bozabilir.
]]

return {
	uluslar = {
		{
			ad = 'Kan ve Demir İmparatorluğu',
			sayfa = 'Kan ve Demir İmparatorluğu',
			takmaAdlar = { 'Kan ve Demir', 'KvD' },
			delegeler = {
				{ ad = 'Demir Şansölye Emre', sayfa = 'Emre', kullanici = '' },
			},
		},
		{
			ad = 'Antik Roma İmparatorluğu',
			sayfa = 'Antik Roma İmparatorluğu',
			takmaAdlar = { 'Roma İmparatorluğu', 'Roma' },
			delegeler = {
				{ ad = 'İmparator Narkeus', kullanici = '' },
				{ ad = 'İmparatoriçe Meiche', kullanici = '' },
			},
		},
		{
			ad = 'Ütopya',
			sayfa = 'Ütopya',
			takmaAdlar = { 'Ütopya Komünü' },
			delegeler = {
				{ ad = 'Soke', sayfa = 'Soke', kullanici = '' },
				{ ad = 'GiresunPasasi', kullanici = '' },
			},
		},
		{
			ad = 'Babiller',
			sayfa = 'Babiller',
			takmaAdlar = {},
			delegeler = {
				{ ad = 'Ziara', kullanici = '' },
				{ ad = 'Horizon', kullanici = '' },
				{ ad = 'Kuskulu', kullanici = '' },
			},
		},
		{
			ad = 'Güneş Kağanlığı',
			sayfa = 'Güneş Kağanlığı',
			takmaAdlar = {},
			delegeler = {
				{ ad = 'Darth Supreme', kullanici = '' },
			},
		},
		{
			ad = 'Doğru Köyü',
			sayfa = 'Doğru Köyü',
			takmaAdlar = { 'Doğru Köy' },
			delegeler = {},
		},
	},
}
