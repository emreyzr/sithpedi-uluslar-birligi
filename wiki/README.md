# Portal:Sithpedi Uluslar Birliği — wiki pages

Wikitext for the **Sithpedi Uluslar Birliği** (League of Nations) portal on
[sithpedi.com](https://sithpedi.com). The portal works as a forum: member-nation
delegates open **amendment proposals** (değişiklik önerisi), **polls** (oylama)
and **discussions** (tartışma). Each request is its own wiki page, and the portal
lists open and closed requests automatically.

There's no JavaScript and no Lua modules. Everything is wikitext, ParserFunctions
and extensions that sithpedi.com already runs (checked against
`Special:Version` on 7 Oct 2026):

| Extension | Used for |
|---|---|
| ParserFunctions | `#switch` / `#if` / `#ifexpr` logic in the templates |
| InputBox | "Yeni talep aç" boxes that create a request page with a preloaded form |
| DynamicPageList3 | Open/closed request tables and the amendment history |
| TemplateStyles | Shared stylesheet `Şablon:SUB Portal/stil.css` |

## How to install

Create each page below **in this order**: templates first, then portal pages,
then categories. Open `https://sithpedi.com/<page title>`, click **Oluştur**,
paste the whole file and save.

The [`manifest.tsv`](manifest.tsv) file holds the same mapping in machine-readable form.

| # | File | Wiki page |
|---|---|---|
| 1 | `sayfalar/01-sablon-sub-stil.css` | `Şablon:SUB Portal/stil.css` |
| 2 | `sayfalar/02-sablon-sub-uye-ulus.wiki` | `Şablon:SUB Üye ulus` |
| 3 | `sayfalar/03-sablon-sub-durum.wiki` | `Şablon:SUB Durum` |
| 4 | `sayfalar/04-sablon-sub-durum-anahtar.wiki` | `Şablon:SUB Durum/anahtar` |
| 5 | `sayfalar/05-sablon-sub-tur.wiki` | `Şablon:SUB Tür` |
| 6 | `sayfalar/06-sablon-sub-komite.wiki` | `Şablon:SUB Komite` |
| 7 | `sayfalar/07-sablon-sub-talep.wiki` | `Şablon:SUB Talep` |
| 8 | `sayfalar/08-sablon-sub-talep-satir.wiki` | `Şablon:SUB Talep/satır` |
| 9 | `sayfalar/09-sablon-sub-oylama.wiki` | `Şablon:SUB Oylama` |
| 10 | `sayfalar/10-onyukleme-degisiklik.wiki` | `Şablon:SUB Talep/önyükleme/Değişiklik önerisi` |
| 11 | `sayfalar/11-onyukleme-oylama.wiki` | `Şablon:SUB Talep/önyükleme/Oylama` |
| 12 | `sayfalar/12-onyukleme-tartisma.wiki` | `Şablon:SUB Talep/önyükleme/Tartışma` |
| 13 | `sayfalar/13-portal-kurulus-bildirgesi.wiki` | `Portal:Sithpedi Uluslar Birliği/Kuruluş Bildirgesi` |
| 14 | `sayfalar/14-portal-delegeler.wiki` | `Portal:Sithpedi Uluslar Birliği/Delegeler` |
| 15 | `sayfalar/15-portal-talep-yonergesi.wiki` | `Portal:Sithpedi Uluslar Birliği/Talep yönergesi` |
| 16 | `sayfalar/16-portal-duzenleme-notu.wiki` | `Portal:Sithpedi Uluslar Birliği/Talep yönergesi/Düzenleme notu` |
| 17 | `sayfalar/17-portal-ana-sayfa.wiki` | `Portal:Sithpedi Uluslar Birliği` |
| 18 | `sayfalar/18-kategori-sub.wiki` | `Kategori:Sithpedi Uluslar Birliği` |
| 19 | `sayfalar/19-kategori-talepler.wiki` | `Kategori:Sithpedi Uluslar Birliği talepleri` |
| 20 | `sayfalar/20-kategori-acik.wiki` | `Kategori:Sithpedi Uluslar Birliği açık talepleri` |
| 21 | `sayfalar/21-kategori-kapali.wiki` | `Kategori:Sithpedi Uluslar Birliği kapalı talepleri` |
| 22 | `sayfalar/22-kategori-kabul.wiki` | `Kategori:Sithpedi Uluslar Birliği kabul edilen talepleri` |
| 23 | `sayfalar/23-kategori-degisiklik.wiki` | `Kategori:Sithpedi Uluslar Birliği değişiklik önerileri` |
| 24 | `sayfalar/24-kategori-oylama.wiki` | `Kategori:Sithpedi Uluslar Birliği oylamaları` |
| 25 | `sayfalar/25-kategori-tartisma.wiki` | `Kategori:Sithpedi Uluslar Birliği tartışmaları` |
| 26 | `sayfalar/26-kategori-belirsiz.wiki` | `Kategori:Sithpedi Uluslar Birliği durumu belirsiz talepleri` |
| 27 | `sayfalar/27-kategori-sablonlar.wiki` | `Kategori:Sithpedi Uluslar Birliği şablonları` |

Things to watch when pasting:

- **Paste the files exactly as they are.** The preload templates (10–12)
  contain things like `~~<noinclude></noinclude>~`. That stops MediaWiki from
  turning the signature placeholders into *your* signature when you save the
  template. When a delegate creates a request, they become `~~~` / `~~~~~` and
  turn into the delegate's own signature and date.
- `Şablon:SUB Portal/stil.css` gets the "sanitized CSS" content model
  automatically because the title ends in `.css`.
- If a list on the portal looks stale, purge the page (`?action=purge`).
  DPL3 doesn't cache its results by default, so this should rarely be needed.

### Optional: images

`dosyalar/` holds the flag and banners taken from the founding declaration
PDF. Upload them with **exactly these file names** (Special:Upload) and they
appear on the portal and the declaration page. If they aren't uploaded, the
pages just leave them out, so there are no red links.

| File | Shown on |
|---|---|
| `Sithpedi Uluslar Birliği bayrağı.png` | Portal banner, declaration header |
| `Kan ve Demir İmparatorluğu sancağı.png` | Declaration › Kurucu devletler |
| `Antik Roma İmparatorluğu sancağı.png` | Declaration › Kurucu devletler |
| `SUB kurucu sancak 3.png` | Declaration › Kurucu devletler (third banner; which nation it belongs to wasn't clear from the PDF, so rename it and its caption in page 13 once known) |

### Optional: protection

Consider protecting `Portal:Sithpedi Uluslar Birliği/Kuruluş Bildirgesi`
and the `Şablon:SUB …` templates so only trusted editors can change them.
Request pages must stay open for editing so members can comment and vote.

## How it works

```
Portal:Sithpedi Uluslar Birliği                         ← the portal (forum front page)
 ├─ /Kuruluş Bildirgesi                                  ← founding declaration + amendment history (DPL)
 ├─ /Delegeler                                           ← delegate list (transcluded into the portal)
 ├─ /Talep yönergesi                                     ← rules for opening, voting, closing
 │   └─ /Düzenleme notu                                  ← short note shown above the edit box (editintro)
 └─ /Talepler/<başlık>                                   ← one page per request, created via InputBox
```

1. A delegate types a title into one of the three **Yeni talep aç** boxes.
   InputBox opens `Portal:Sithpedi Uluslar Birliği/Talepler/<title>` with the
   matching preload template already in the edit box.
2. The page starts with `{{SUB Talep|tür=…|durum=…|ulus=…|komite=…}}`. That
   header shows the type and status badges, the delegate, the nation and the
   committee. It sorts the page into the type and open/closed categories, and
   adds `__NEWSECTIONLINK__` so the page gets an "add topic" tab. DiscussionTools,
   which is installed on sithpedi.com, adds reply links to signed comments.
3. Votes go under the **Evet / Hayır / Çekimser** headings as numbered lines,
   so each option's count shows automatically. `{{SUB Oylama}}` displays the
   voting rules, which are configurable per request:
   - `oylama = ulus | oyuncu`: one vote per nation, or one vote per player
   - `eşik = salt | üçte iki | oybirliği`: the majority needed
   When the closer fills in `evet/hayır/çekimser`, it calculates whether that
   majority was reached.
4. A delegate closes the request by setting `durum` to `kabul`, `ret`,
   `kapandı` or `geri çekildi` and filling in `kapatan`, `kapanış` and
   `sonuç`. The page then moves from the open list to the closed list. Accepted
   amendments also appear in the declaration's *Değişiklik geçmişi*.

"Only delegates may open/close requests" is an **honour rule**. A wiki can't
enforce it without extra code. The header warns when the `ulus` field isn't a
member nation, and any delegate can close a non-delegate request as
`geri çekildi`.

### Maintenance

- **New member nation:** add it to `Şablon:SUB Üye ulus`, the
  `/Delegeler` table and the *Üye uluslar* box on the portal. Also update the
  "6" member count in the portal's statistics row.
- **Delegate changes:** edit `/Delegeler`. The delegates fill in the
  *Viki kullanıcı adı* column there themselves.

## Testing

Everything was tested on a local MediaWiki 1.43.1 (the same version as
sithpedi.com) with ParserFunctions, InputBox, TemplateStyles, CategoryTree and
DynamicPageList3 3.5.2 (the same version as sithpedi.com). The tests covered:

- importing every page (all of them save cleanly and re-save without changes)
- creating requests through each InputBox, including the preload and edit note
- signature and date substitution
- every status and type combination, and the categories each one gets
- the DPL tables, the vote calculation for each majority rule
- desktop, mobile and night-mode layouts in Vector 2022
