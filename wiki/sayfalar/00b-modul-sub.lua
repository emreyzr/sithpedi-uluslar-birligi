--[[
Sithpedi Uluslar Birliği — portal modülü

Üye ve delege bilgileri Modül:SUB/veri sayfasından okunur.

İşlevler (şablonlar üzerinden çağrılır):
  ulus           {{SUB Üye ulus}}      Adı üye ulusa çevirir (boş = üye değil)
  uyeSayisi      Portal               Üye ulus sayısı
  uyeListesi     Portal               Üye ulusların madde işaretli listesi
  delegeTablosu  Delegeler sayfası    Ulus / delege / viki hesabı tablosu
  acanDurumu     {{SUB Talep}}        Talebi açanın kayıtlı delege olup olmadığı
  talepUyarisi   {{SUB Talep}}        Ulus veya delege uyuşmazlığı uyarısı
  oylama         {{SUB Oylama}}       Oy kuralları, otomatik sayım ve sonuç
]]

local p = {}

local veri = mw.loadData('Modül:SUB/veri')
local dil = mw.getContentLanguage()

local DELEGELER_SAYFASI = 'Portal:Sithpedi Uluslar Birliği/Delegeler'
local YONERGE_SAYFASI = 'Portal:Sithpedi Uluslar Birliği/Talep yönergesi'

------------------------------------------------------------------------
-- Yardımcılar
------------------------------------------------------------------------

-- mw.loadData tabloları # işlecini desteklemez; öğeleri sayarak uzunluk bulunur
local function uzunluk(t)
	local n = 0
	for _ in ipairs(t or {}) do
		n = n + 1
	end
	return n
end

local function bos(s)
	return s == nil or mw.text.trim(s) == ''
end

-- Türkçe büyük/küçük harf farkını gözetmeden karşılaştırma anahtarı
local function anahtar(s)
	s = mw.text.trim(s or '')
	s = mw.ustring.gsub(s, 'İ', 'i')
	s = mw.ustring.gsub(s, 'I', 'ı')
	s = mw.ustring.lower(s)
	s = mw.ustring.gsub(s, '\204\135', '') -- U+0307 birleşik nokta
	s = mw.ustring.gsub(s, '%s+', ' ')
	return s
end

-- Kullanıcı adını viki biçimine getirir (alt çizgi → boşluk, ilk harf büyük)
local function kullaniciAdi(s)
	if bos(s) then
		return nil
	end
	s = mw.text.trim((s:gsub('_', ' ')))
	s = mw.ustring.gsub(s, '%s+', ' ')
	return dil:ucfirst(s)
end

-- Ad → ulus kaydı ve kullanıcı adı → ulus kaydı dizinleri
local ulusDizini, kullaniciDizini = {}, {}
for _, u in ipairs(veri.uluslar) do
	ulusDizini[anahtar(u.ad)] = u
	if u.sayfa then
		ulusDizini[anahtar(u.sayfa)] = u
	end
	for _, t in ipairs(u.takmaAdlar or {}) do
		ulusDizini[anahtar(t)] = u
	end
	for _, d in ipairs(u.delegeler or {}) do
		local k = kullaniciAdi(d.kullanici)
		if k then
			kullaniciDizini[k] = u
		end
	end
end

local function ulusBul(ad)
	if bos(ad) then
		return nil
	end
	-- [[Bağlantı|metin]] ve kalın/italik biçimlendirmeyi temizle
	ad = ad:gsub('%[%[([^|%]]*)|?[^%]]*%]%]', '%1'):gsub("'''?", '')
	return ulusDizini[anahtar(ad)]
end

-- Ulusun doğrulama için kayıtlı viki hesabı var mı?
local function kayitliHesapVar(u)
	for _, d in ipairs(u.delegeler or {}) do
		if kullaniciAdi(d.kullanici) then
			return true
		end
	end
	return false
end

local function ulusunDelegesiMi(kullanici, u)
	for _, d in ipairs(u.delegeler or {}) do
		if kullaniciAdi(d.kullanici) == kullanici then
			return true
		end
	end
	return false
end

-- İmzadan kullanıcı adını çıkarır: [[Kullanıcı:Ad|...]], [[User:Ad]],
-- [[Özel:Katkılar/1.2.3.4]]
local IMZA_KALIPLARI = {
	'%[%[%s*[Kk]ullanıcı%s*:%s*([^|%]/#]+)',
	'%[%[%s*[Uu]ser%s*:%s*([^|%]/#]+)',
	'%[%[%s*Özel%s*:%s*Katkılar/([^|%]#]+)',
	'%[%[%s*[Ss]pecial%s*:%s*Contributions/([^|%]#]+)',
}

local function imzaBul(metin)
	local enIyiKonum, enIyiAd
	for _, kalip in ipairs(IMZA_KALIPLARI) do
		local bas, _, ad = metin:find(kalip)
		if bas and (not enIyiKonum or bas < enIyiKonum) then
			enIyiKonum, enIyiAd = bas, ad
		end
	end
	return kullaniciAdi(enIyiAd), enIyiKonum
end

local function ulusBaglantisi(u)
	if u.sayfa and u.sayfa ~= u.ad then
		return '[[' .. u.sayfa .. '|' .. u.ad .. ']]'
	end
	return '[[' .. u.ad .. ']]'
end

local function argumanlar(frame)
	local a = {}
	for k, v in pairs(frame:getParent().args) do
		a[k] = v
	end
	for k, v in pairs(frame.args) do
		a[k] = v
	end
	return a
end

------------------------------------------------------------------------
-- Üye bilgileri
------------------------------------------------------------------------

function p.ulus(frame)
	local a = argumanlar(frame)
	local u = ulusBul(a[1])
	if not u then
		return ''
	end
	if not bos(a[2]) then
		return ulusBaglantisi(u)
	end
	return u.ad
end

function p.uyeSayisi()
	return tostring(uzunluk(veri.uluslar))
end

function p.uyeListesi()
	local satirlar = {}
	for _, u in ipairs(veri.uluslar) do
		table.insert(satirlar, '* ' .. ulusBaglantisi(u))
	end
	return table.concat(satirlar, '\n')
end

function p.delegeTablosu(frame)
	local hesaplar = not bos(frame.args.hesaplar)
	local satirlar = { '{| class="wikitable" style="width:100%;"' }
	table.insert(satirlar, hesaplar and '! Ulus !! Delege !! Viki hesabı' or '! Ulus !! Delegeler')
	for _, u in ipairs(veri.uluslar) do
		local delegeler = u.delegeler or {}
		local delegeSayisi = uzunluk(delegeler)
		if hesaplar then
			if delegeSayisi == 0 then
				table.insert(satirlar, '|-\n| ' .. ulusBaglantisi(u) .. " || colspan=\"2\" | ''Henüz belirlenmedi''")
			end
			for i, d in ipairs(delegeler) do
				local k = kullaniciAdi(d.kullanici)
				local ad = d.sayfa and ('[[' .. d.sayfa .. '|' .. d.ad .. ']]') or d.ad
				local hesap = k and ('[[Kullanıcı:' .. k .. '|' .. k .. ']]') or "''kayıtlı değil''"
				local ulusHucresi = ''
				if i == 1 then
					ulusHucresi = (delegeSayisi > 1 and ('rowspan="' .. delegeSayisi .. '" | ') or '') .. ulusBaglantisi(u) .. ' || '
				end
				table.insert(satirlar, '|-\n| ' .. ulusHucresi .. ad .. ' || ' .. hesap)
			end
		else
			local adlar = {}
			for _, d in ipairs(delegeler) do
				table.insert(adlar, d.sayfa and ('[[' .. d.sayfa .. '|' .. d.ad .. ']]') or d.ad)
			end
			local hucre = #adlar > 0 and table.concat(adlar, ' · ') or "''Henüz belirlenmedi''"
			table.insert(satirlar, '|-\n| ' .. ulusBaglantisi(u) .. ' || ' .. hucre)
		end
	end
	table.insert(satirlar, '|}')
	return table.concat(satirlar, '\n')
end

------------------------------------------------------------------------
-- Talep başlığı denetimleri
------------------------------------------------------------------------

-- Açan kişinin durumu: 'dogrulandi', 'uyusmuyor', 'dogrulanamadi' veya nil
local function acanDurumu(acan, ulusAdi)
	local u = ulusBul(ulusAdi)
	local kullanici = imzaBul(acan or '')
	if not u or not kullanici then
		return nil, u, kullanici
	end
	if not kayitliHesapVar(u) then
		return 'dogrulanamadi', u, kullanici
	end
	if ulusunDelegesiMi(kullanici, u) then
		return 'dogrulandi', u, kullanici
	end
	return 'uyusmuyor', u, kullanici
end

function p.acanDurumu(frame)
	local a = argumanlar(frame)
	local durum = acanDurumu(a['açan'], a.ulus)
	if durum == 'dogrulandi' then
		return ' <span class="sub-dogrulama sub-dogrulama-tamam" title="Bu kullanıcı, Modül:SUB/veri sayfasında bu ulusun delegesi olarak kayıtlıdır.">✓ kayıtlı delege</span>'
	elseif durum == 'dogrulanamadi' then
		return ' <span class="sub-dogrulama" title="Bu ulus için kayıtlı viki hesabı olmadığından denetim yapılamadı.">doğrulanamadı</span>'
	end
	return ''
end

function p.talepUyarisi(frame)
	local a = argumanlar(frame)
	local durum, u, kullanici = acanDurumu(a['açan'], a.ulus)
	if not u then
		return '<div class="sub-talep-uyari">\'\'\'Uyarı:\'\'\' Bu talepte geçerli bir üye ulus belirtilmemiş. '
			.. 'Talepler yalnızca üye ulusların [[' .. DELEGELER_SAYFASI .. '|delegeleri]] tarafından açılabilir. '
			.. 'Talebi açan delege, <code>ulus</code> alanına temsil ettiği ulusu yazmalıdır.</div>'
	end
	if durum == 'uyusmuyor' then
		return '<div class="sub-talep-uyari">\'\'\'Uyarı:\'\'\' Talebi açan [[Kullanıcı:' .. kullanici .. '|' .. kullanici
			.. ']], ' .. u.ad .. ' ulusunun [[' .. DELEGELER_SAYFASI .. '|kayıtlı delegeleri]] arasında değil. '
			.. '[[' .. YONERGE_SAYFASI .. '|Talep yönergesi]] uyarınca bu talep bir delege tarafından '
			.. '<code>geri çekildi</code> durumuna alınabilir.</div>'
	end
	return ''
end

------------------------------------------------------------------------
-- Oylama
------------------------------------------------------------------------

local SECENEKLER = {
	{ kod = 'evet', ad = 'Evet' },
	{ kod = 'hayir', ad = 'Hayır' },
	{ kod = 'cekimser', ad = 'Çekimser' },
}

local BASLIK_ANAHTARLARI = {
	[anahtar('Evet')] = 'evet',
	[anahtar('Kabul')] = 'evet',
	[anahtar('Hayır')] = 'hayir',
	[anahtar('Ret')] = 'hayir',
	[anahtar('Çekimser')] = 'cekimser',
}

local function oyUsulu(deger)
	local k = anahtar(deger)
	if k == 'oyuncu' or k == 'oyuncu başına' then
		return 'oyuncu'
	end
	return 'ulus'
end

local function esikTuru(deger)
	local k = anahtar(deger)
	if k == 'üçte iki' or k == '2/3' then
		return 'ucteiki'
	elseif k == 'oybirliği' then
		return 'oybirligi'
	end
	return 'salt'
end

local ESIK_METNI = {
	salt = 'Salt çoğunluk (evet oyları, hayır oylarından fazla olmalıdır).',
	ucteiki = 'Üçte iki çoğunluk (evet oyları, geçerli oyların en az üçte ikisi olmalıdır).',
	oybirligi = 'Oybirliği (hiç hayır oyu olmamalıdır).',
}

local function cogunlukSaglandi(esik, evet, hayir)
	if esik == 'ucteiki' then
		return evet > 0 and evet >= 2 * hayir
	elseif esik == 'oybirligi' then
		return evet > 0 and hayir == 0
	end
	return evet > hayir
end

-- Sayfa metnindeki Evet / Hayır / Çekimser başlıkları altındaki numaralı
-- satırları sırasıyla döndürür: { secenek = 'evet', metin = '...' }
local function oySatirlari(metin)
	metin = metin:gsub('<!%-%-.-%-%->', '')
	local satirlar, secenek = {}, nil
	for satir in mw.text.gsplit(metin, '\n', true) do
		local _, baslik = satir:match('^(=+)%s*(.-)%s*=+%s*$')
		if baslik then
			secenek = BASLIK_ANAHTARLARI[anahtar(baslik:gsub("'''?", ''))]
		elseif secenek then
			local icerik = satir:match('^#%s*(.*)$')
			if icerik and not icerik:match('^[#:%*]') and not bos(icerik) then
				table.insert(satirlar, { secenek = secenek, metin = icerik })
			end
		end
	end
	return satirlar
end

local function oylariSay(usul)
	local baslik = mw.title.getCurrentTitle()
	local metin = baslik:getContent() or ''
	local sayilar = { evet = 0, hayir = 0, cekimser = 0 }
	local gecersiz = {}
	local kullananUluslar = {}
	local kullananlar = {}

	local function reddet(satir, neden)
		table.insert(gecersiz, { satir = satir, neden = neden })
	end

	for _, s in ipairs(oySatirlari(metin)) do
		local m = s.metin
		local kullanici, imzaKonumu = imzaBul(m)
		if m:find('<s>', 1, true) or m:find('<del>', 1, true) or m:find('<strike>', 1, true) then
			reddet(s, 'üstü çizilmiş (geri çekilmiş) oy')
		elseif not kullanici then
			reddet(s, 'imzasız oy')
		elseif usul == 'oyuncu' then
			if kullananlar[kullanici] then
				reddet(s, kullanici .. ' daha önce oy kullanmış; yalnızca ilk oy sayılır')
			else
				kullananlar[kullanici] = true
				sayilar[s.secenek] = sayilar[s.secenek] + 1
			end
		else
			local yazilan = m:sub(1, (imzaKonumu or #m + 1) - 1)
			yazilan = mw.ustring.gsub(yazilan, '[%s%-–—:,%.]+$', '')
			local yazilanUlus = ulusBul(yazilan)
			local kayitliUlus = kullaniciDizini[kullanici]
			local u = yazilanUlus or kayitliUlus
			if not u then
				if bos(yazilan) then
					reddet(s, 'ulus belirtilmemiş')
				else
					reddet(s, '"' .. mw.text.nowiki(mw.text.trim(yazilan)) .. '" Birliğe üye bir ulus değil')
				end
			elseif kayitliHesapVar(u) and not ulusunDelegesiMi(kullanici, u) then
				reddet(s, kullanici .. ', ' .. u.ad .. ' ulusunun kayıtlı delegesi değil')
			elseif kullananUluslar[u.ad] then
				reddet(s, u.ad .. ' zaten oy kullandı; ulus başına yalnızca ilk oy sayılır')
			else
				kullananUluslar[u.ad] = true
				sayilar[s.secenek] = sayilar[s.secenek] + 1
			end
		end
	end
	return sayilar, gecersiz, kullananUluslar
end

function p.oylama(frame)
	local a = argumanlar(frame)
	local usul = oyUsulu(a.oylama)
	local esik = esikTuru(a['eşik'])
	local sayilar, gecersiz, kullananUluslar = oylariSay(usul)

	local out = {}
	local function ekle(s)
		table.insert(out, s)
	end

	ekle('<div class="sub-oylama">')
	ekle('<div class="sub-oylama-baslik">Oylama kuralları</div>')
	if usul == 'oyuncu' then
		ekle("* '''Oy usulü:''' Oyuncu başına bir oy. Birliğe üye ulusların her oyuncusu kendi adına bir kez oy kullanabilir; bir oyuncunun yalnızca ilk oyu sayılır.")
	else
		ekle("* '''Oy usulü:''' Ulus başına bir oy. Her üye ulus, [[" .. DELEGELER_SAYFASI
			.. "|delegelerinden]] biri aracılığıyla tek bir oy kullanır; bir ulus adına yalnızca ilk oy sayılır.")
	end
	ekle("* '''Gerekli çoğunluk:''' " .. ESIK_METNI[esik] .. ' Çekimser oylar hesaba katılmaz.')
	ekle("* '''Oylamanın bitişi:''' " .. (bos(a['bitiş']) and "''belirtilmedi''" or a['bitiş']))
	if usul == 'oyuncu' then
		ekle("* Oy vermek için aşağıdaki ''Evet'', ''Hayır'' veya ''Çekimser'' başlıklarından birinin '''değiştir''' bağlantısına tıklayıp yeni bir satıra <code># &#126;&#126;&#126;&#126;</code> yazın. Gerekçe eklemek isteğe bağlıdır.")
	else
		ekle("* Oy vermek için aşağıdaki ''Evet'', ''Hayır'' veya ''Çekimser'' başlıklarından birinin '''değiştir''' bağlantısına tıklayıp yeni bir satıra <code># Ulus adı – &#126;&#126;&#126;&#126;</code> yazın. Gerekçe eklemek isteğe bağlıdır.")
	end
	ekle("* Oylar sayfa kaydedildiğinde '''kendiliğinden sayılır'''. Oyunuzu geri çekmek için satırın üstünü çizin (<code>&lt;s&gt;…&lt;/s&gt;</code>).")

	local toplam = sayilar.evet + sayilar.hayir + sayilar.cekimser
	local parcalar = {}
	for _, s in ipairs(SECENEKLER) do
		table.insert(parcalar, '<span class="sub-oylama-sayi">\'\'\'' .. s.ad .. ':\'\'\' ' .. sayilar[s.kod] .. '</span>')
	end
	local sonuc
	if toplam == 0 then
		sonuc = "''henüz oy yok''"
	elseif cogunlukSaglandi(esik, sayilar.evet, sayilar.hayir) then
		sonuc = "'''Gerekli çoğunluk sağlanıyor'''"
	else
		sonuc = 'Gerekli çoğunluk sağlanamıyor'
	end
	table.insert(parcalar, '<span class="sub-oylama-sayi">\'\'\'Sonuç:\'\'\' ' .. sonuc .. '</span>')
	ekle('<div class="sub-oylama-sayilar">' .. table.concat(parcalar) .. '</div>')

	if usul == 'ulus' then
		local bekleyen = {}
		for _, u in ipairs(veri.uluslar) do
			if not kullananUluslar[u.ad] then
				table.insert(bekleyen, u.ad)
			end
		end
		local metin = #bekleyen == 0 and 'Bütün üye uluslar oy kullandı.'
			or ('Henüz oy kullanmayan uluslar (' .. #bekleyen .. '/' .. uzunluk(veri.uluslar) .. '): ' .. table.concat(bekleyen, ', ') .. '.')
		ekle('<div class="sub-not" style="margin-top:6px;">' .. metin .. '</div>')
	end

	if #gecersiz > 0 then
		ekle('<div class="sub-oylama-gecersiz">\'\'\'Sayılmayan oylar (' .. #gecersiz .. '):\'\'\'')
		for _, g in ipairs(gecersiz) do
			local secenekAdi = ({ evet = 'Evet', hayir = 'Hayır', cekimser = 'Çekimser' })[g.satir.secenek]
			ekle('* ' .. secenekAdi .. ' bölümü: ' .. g.neden .. '.')
		end
		ekle('</div>')
	end
	ekle('</div>')
	return table.concat(out, '\n')
end

return p
