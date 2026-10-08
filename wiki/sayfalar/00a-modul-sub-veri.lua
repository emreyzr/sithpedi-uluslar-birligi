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

Komiteler (komiteler = { ... }):
  * numara     : Roma rakamıyla komite numarası.
  * kod        : Talep şablonundaki komite alanına yazılan kısa ad.
  * ad         : Komitenin tam adı.
  * madde      : Kuruluş Bildirgesi'ndeki ilgili madde (yoksa boş).
  * takmaAdlar : komite alanında kabul edilen başka yazılışlar.
  * gorev      : Komiteler sayfasında gösterilen görev tanımı.
Bir komitenin adı değişirse kategori adları da değişir; eski kategorideki
talepler sayfalar yeniden işlendiğinde kendiliğinden yeni kategoriye geçer.

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
	komiteler = {
		{
			numara = 'I',
			kod = 'güvenlik',
			ad = 'Güvenlik Konseyi',
			madde = 'Madde I',
			takmaAdlar = { 'güvenlik konseyi', 'konsey' },
			gorev = 'Diyar üzerindeki barışın kalkanı ve terazisidir. Uluslar arasındaki diplomatik dengelerin korunması, olası sınır veya çıkar çatışmalarının kılıç çekilmeden, masa başında adalete uygun bir şekilde çözülmesi bu konseyin mutlak sorumluluğundadır.',
		},
		{
			numara = 'II',
			kod = 'ulaştırma',
			ad = 'Ulaştırma ve Altyapı Komitesi',
			madde = 'Madde II',
			takmaAdlar = { 'altyapı', 'ulaştırma ve altyapı', 'ulaştırma ve altyapı komitesi' },
			gorev = 'Uzakları yakın kılan, ulusları birbirine bağlayan damarlarımızdır. Birlik üyeleri arasındaki "Interfactional" yolların, devasa köprülerin ve geçitlerin inşasını koordine edecek; medeniyetin her bir köşeye kesintisiz ulaşmasını sağlayacaktır.',
		},
		{
			numara = 'III',
			kod = 'ortak alan',
			ad = 'Ortak Alan Komitesi',
			madde = 'Madde III',
			takmaAdlar = { 'ortak alan komitesi' },
			gorev = 'Birliğimizin kalbinin attığı yerlerin mimarlarıdır. Başta diyara nefes ve hayat veren Atatürk Orman Çiftliği olmak üzere, hiçbir ulusun tekeline girmeyecek, herkesin özgürce bir araya gelebileceği tarafsız toplanma ve sosyal alanların inşasından sorumludur.',
		},
		{
			numara = 'IV',
			kod = 'ticaret',
			ad = 'Ticaret ve İşbirliği Komitesi',
			madde = 'Madde IV',
			takmaAdlar = { 'işbirliği', 'ticaret ve işbirliği', 'ticaret ve işbirliği komitesi' },
			gorev = "Sithpedi topraklarındaki refahın anahtarıdır. Faction'ların köylülerle olan ticareti düzenleyecek, haksız rekabeti önleyecek ve bilgi/kaynak paylaşımını teşvik ederek tüm üye devletlerin ortak ekonomik kalkınmasını destekleyecektir.",
		},
		{
			numara = 'V',
			kod = 'tarih',
			ad = 'Sithpedi Tarihini Araştırma Komitesi',
			madde = 'Madde V',
			takmaAdlar = { 'tarih araştırma', 'tarih komitesi', 'sithpedi tarihini araştırma komitesi' },
			gorev = 'Geçmişimizin bekçileri ve geleceğimizin yazarlarıdır. Eski krallık döneminden, "Kralın Vasiyeti"ne ve Birlik dönemine kadar yaşanan tüm savaşları, barışları, inşa edilen şaheserleri kayıt altına alacak; Sithpedi Külliyatı\'nı gelecek nesiller (ve oyuncular) için koruyacaktır.',
		},
		{
			numara = 'VI',
			kod = 'genel',
			ad = 'Genel Kurul',
			madde = '',
			takmaAdlar = { 'genel kurul' },
			gorev = 'Birliğin bütün üye uluslarından oluşur. Tek bir komitenin görev alanına girmeyen ya da Birliğin bütününü ilgilendiren konular Genel Kurul\'da görüşülür.',
		},
	},
}
