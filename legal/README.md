# GetShap – jogi dokumentumok

Ez a mappa tartalmazza az app jogi szövegeit. **Nem ügyvéd írta** – gyakorlati,
az app tényleges működésére szabott szövegek, amelyek a szokásos fitneszapp-
gyakorlatot követik. Ha az app komolyra fordul (fizetős lesz, sok felhasználó,
külföldi terjesztés), érdemes ügyvéddel átnézetni.

```
legal/
├── hu/
│   ├── felhasznalasi-feltetelek.md      ÁSZF / EULA
│   ├── egeszsegugyi-tajekoztato.md      ← ez a fontos: sérülés, saját felelősség
│   └── adatvedelmi-tajekoztato.md       GDPR (kötelező a store-okhoz)
├── en/
│   ├── terms-of-use.md
│   ├── health-disclaimer.md
│   └── privacy-policy.md
├── de/ es/ fr/ it/ pt/ ru/ tr/          fordítások, az angol fájlnevekkel
├── build_site.dart                      ebből lesznek a weboldal jogi oldalai (legal/site/)
└── consent-screen-copy.md               az appban megjelenő rövid szöveg + ARB kulcsok
```

## 1. Kitöltendő adatok

Nincs kitöltendő placeholder. A szolgáltató azonosítása név + e-mail +
weboldal, postacím nélkül.

**Mikor lesz mégis szükség postacímre:**

- ha az app fizetőssé válik, vagy bármilyen bevételt termel (ekkor már
  üzletszerű gazdasági tevékenység, és az Elker. tv. 4. §-a szerinti
  szolgáltatói adatok kötelezők);
- ha az App Store Connectben **„trader" (kereskedő) státuszt** kell
  bejelentened az EU digitális szolgáltatási rendelete miatt – ebben az esetben
  az Apple a nevet, címet, telefonszámot és e-mailt nyilvánosan kiírja az app
  letöltőoldalára. Ezt az App Store Connect → Business → Trader Status
  szekcióban tudod megnézni és beállítani; ingyenes, hobbi célú appnál
  jellemzően a nem-kereskedő státusz az irányadó, de érdemes ellenőrizni, mert
  a besorolás befolyásolja az EU-s terjeszthetőséget;
- ha céget alapítasz – ekkor a „Szolgáltató"/„Adatkezelő" blokkba cégnév,
  székhely, cégjegyzékszám és adószám kerül.

Ha nem akarsz lakcímet közzétenni, a szokásos megoldás postafiók vagy virtuális
iroda címe.

## 2. A weboldal (getshap.com)

A jogi oldalakat a `build_site.dart` generálja ezekből a markdown fájlokból, mind
a 9 nyelven. Az angol és a magyar címek a régiek maradtak, mert ezekre linkelnek
a régebbi appverziók és a store-ok. A többi nyelv a saját kódja alatt van, angol
útvonallal:

```
getshap.com/terms          getshap.com/hu/feltetelek      getshap.com/de/terms
getshap.com/health         getshap.com/hu/egeszseg        getshap.com/de/health
getshap.com/privacy        getshap.com/hu/adatvedelem     getshap.com/de/privacy
                                                          (ugyanígy: es, fr, it, pt, ru, tr)
```

A fejlécben lenyíló nyelvmenü van, amely ugyanazt a dokumentumot nyitja meg a
többi nyelven. A nyitóoldalakat (`/`, `/hu/`, `/de/` …) semmi nem generálja:
kézzel készülnek, csak a weboldal mappában vannak, és ugyanilyen nyelvmenüjük
van.

**Frissítés:** `dart run legal/build_site.dart`, majd a `legal/site/` tartalmát
másold be a weboldal mappába, és töltsd fel. A nyitóoldalakat a bemásolás nem
írja felül.

**Egy forrás.** Az app ugyanezeket a markdown fájlokat viszi magával assetként,
és offline mutatja őket az elfogadó oldalon
(`lib/onboarding/legal_document_page.dart`). Ha egy dokumentum változik, a
weboldalt újra kell generálni, az app pedig a következő buildben kapja meg az új
szöveget. A kettő csak akkor térhet el, ha az egyiket elfelejted frissíteni.

**A weboldalnak fent kell maradnia.** Az Elker. tv. (2001. évi CVIII.) 5. §-a
szerint a szolgáltatónak úgy kell elérhetővé tennie a szerződési feltételeket,
hogy azokat a felhasználó **tárolni és előhívni** tudja. Egy weboldal ennek
megfelel (menthető, nyomtatható, később visszakereshető); egy csak az appban
felvillanó, bezárás után eltűnő szövegablak önmagában nem. Az app az elfogadás
előtt mutatja a teljes szöveget, a menthető, bármikor előhívható változat pedig
a weboldal.

## 3. Mi kerül a store-okba

| Hely | Mit adj meg |
|---|---|
| App Store Connect → App Privacy | Adatvédelmi URL. Adatgyűjtés: **„Data Not Collected"** – az app nem gyűjt adatot, ez igaz és ellenőrizhető |
| App Store Connect → App Information | License Agreement: maradhat az Apple sztenderd EULA-ja, vagy feltöltheted a saját feltételeidet |
| App Store → korhatár | Az Apple korhatár-besorolása tartalom alapján megy, ez nem ugyanaz, mint a dokumentumokban szereplő 13 éves alsó korhatár. A besoroló kérdőívnél jelöld, hogy egészséggel/fitnesszel kapcsolatos tartalom van benne |
| Play Console → Célközönség és tartalom | A 13+ beállítással a Families Policy jellemzően nem kapcsol be. Ha bejelölöd a 13 év alatti korcsoportot, jóval szigorúbb szabályrendszerbe kerülsz – ezt a 13-as alsó korhatárral kerülöd el |
| Google Play → Adatbiztonság szekció | Ugyanaz: nincs adatgyűjtés, nincs adatmegosztás. Az adatvédelmi URL itt kötelező |
| Play → Egészség appok nyilatkozat | Ha kéri: nem egészségügyi, nem orvosi célú alkalmazás |
| **App Store / Play leírás** | Az Apple 1.4.1 irányelve elvárja, hogy az egészséggel kapcsolatos app a **leírásában** is emlékeztessen az orvosi konzultációra – lásd a lenti szöveget |

**Az alkalmazásleírás végére (kötelező elem, nem opcionális):**

> A GetShap általános edzéstartalmat kínál, és nem minősül orvosi vagy
> egészségügyi tanácsadásnak. Az edzéseket saját felelősségedre végzed. Ha
> egészségügyi problémád van, kérdezd meg orvosodat, mielőtt elkezded.

> GetShap offers general exercise content and is not medical or healthcare
> advice. You train at your own risk. If you have any health condition, consult
> your doctor before you start.

**Fontos:** ha a store-leírásban vagy bárhol edzőként hivatkoznál magadra, az
egész védelem meggyengül. A leírásban maradj annál, hogy az app „segít
elkezdeni és szokássá tenni a mozgást".

## 4. Verziózás

Minden dokumentum fejlécében van dátum és verziószám. Ha lényegesen módosítasz
rajtuk, emeld a verziót – az app ekkor újra elfogadást kér, és a `terms_version`
alapján tudni fogod, ki mit fogadott el. Ez a bizonyíték, ha valaha kérdés lenne.

## 5. Hogyan működik az appban

| Fájl | Szerep |
|---|---|
| `lib/core/legal.dart` | A `gaveConsent` kulcs olvasása/írása és a dokumentumok asset-útvonalai (az app nyelve szerint) |
| `lib/onboarding/consent_page.dart` | Maga a képernyő: összefoglaló, linkek, checkbox, gomb |
| `lib/onboarding/legal_document_page.dart` | Egy dokumentum az appban, offline – a három link ezt nyitja meg |
| `lib/main.dart` | A kapu: kinek és mikor jelenik meg |

**A kapu logikája:**

- **Új felhasználó:** splash → elfogadó képernyő → kérdőív → a szokásos
  folytatás.
- **Meglévő felhasználó** (`hasData == true`, `gaveConsent` hiányzik): splash →
  elfogadó képernyő → főképernyő. Addig nem éri el a főképernyőt, amíg el nem
  fogadja.
- **Aki már elfogadta:** semmi változás.

**Miért a kérdőív *előtt*?** A Ptk. 6:78. § szerint az ÁSZF akkor válik a
szerződés részévé, ha a másik fél a tartalmát a **szerződéskötést megelőzően**
megismerhette és elfogadta; a lényegesen eltérő kikötésekhez (kockázatvállalás,
felelősségkorlátozás) külön figyelemfelhívás és kifejezett elfogadás kell.
Ingyenes appnál a szerződéskötés a használat megkezdése, és a kérdőív már
használat. Ráadásul a kérdőív azt kérdezi, hány térdelő fekvőtámaszt és
guggolást tud a felhasználó – egy részük ki is próbálja, hogy válaszolni tudjon,
vagyis terhelést végez. A figyelmeztetésnek ez elé kell kerülnie.

A `gaveConsent` kulcs hiányában `false` az érték, ezért kapja meg minden
korábbi telepítés. Az elfogadáskor a flag mellé bekerül a `consentAcceptedAt`
(időbélyeg) és a `consentVersion` is – ez utóbbi a `Legal.documentVersion`
konstansból jön.

## 6. Ha módosítod a dokumentumokat

A `Legal.status()` összeveti a mentett `consentVersion`-t a jelenlegi
`Legal.documentVersion`-nel, és háromféle választ ad:

| Státusz | Mikor | Mi történik |
|---|---|---|
| `none` | Soha nem fogadott el semmit | Elfogadó képernyő, első használatra szabott szöveggel |
| `outdated` | Korábbi verziót fogadott el | Ugyanaz a képernyő, „Frissültek a feltételek" fejléccel és egy magyarázó dobozzal |
| `current` | A mostani verziót fogadta el | Semmi, megy tovább |

**A `documentVersion` az érdemi változás jelzője.** Csak akkor emeld, ha a
módosítás tényleg érdemi – ilyenkor minden korábbi felhasználót újra megkérdez
az app a következő indításkor:

- új vagy tágabb felelősségkorlátozás;
- új kötelezettség vagy tiltás a felhasználó oldalán;
- fizetős funkció bevezetése;
- az adatkezelés érdemi változása;
- új egészségügyi kockázat vagy figyelmeztetés;
- joghatóság vagy alkalmazandó jog változása;
- **a szerződő fél változása** (pl. ha a GetShap cég alá kerül) – ez a
  legkönnyebben elfelejthető eset, pedig ilyenkor mindenkivel újra el kell
  fogadtatni.

**Ne emeld** elgépelés javításánál, érthetőbb fogalmazásnál, tagolásnál vagy egy
javított linknél. Ezek nem változtatják meg, amihez a felhasználó hozzájárult, és
ha minden apróságért újrakérdezel, a felhasználók megtanulják gépiesen elfogadni
– pont akkor lesz értéktelen a képernyő, amikor egyszer tényleg számítana.

Ilyen esetben a dokumentum fejlécében a dátumot frissítsd, a verziószámot ne, és
elég a weboldalt újragenerálni (`dart run legal/build_site.dart`) és feltölteni;
az app a következő buildben kapja meg az új szöveget.

**Bármilyen módosítás mind a 9 nyelvre vonatkozik:** amit az angol vagy a magyar
szövegen változtatsz, azt a 7 fordításban (de, es, fr, it, pt, ru, tr) is át kell
vezetni. A `test/legal_documents_test.dart` jelez, ha egy fordításból kimarad egy
fejezet, egy felsorolás vagy egy link.

## 7. Ami még hátravan

- Egészségügyi szűrő kérdés a kérdőívbe (lásd `consent-screen-copy.md` vége).
  Ez átszámozza a kérdőívet 7-ről 8 kérdésre.
