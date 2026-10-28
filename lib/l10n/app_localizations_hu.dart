// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get form => 'kérdőív';

  @override
  String get consentTitle => 'Mielőtt belevágsz';

  @override
  String get consentIntro =>
      'A GetShap célja, hogy megszeresd a rendszeres mozgást, és ezen keresztül haladj a saját testi céljaid felé. Három dolog, mielőtt belevágsz:';

  @override
  String get consentPoint1 =>
      'Az edzéseket saját felelősségedre végzed – mint minden mozgásnál, itt is előfordulhat sérülés.';

  @override
  String get consentPoint2 =>
      'A nehézséget a válaszaid alapján állítja be az app – ez automatikus besorolás, nem szakmai állapotfelmérés, és nem veszi figyelembe az egészségi állapotodat. A tartalmat nem egészségügyi szakember állította össze.';

  @override
  String get consentPoint3 =>
      'Ha egészségügyi problémád van, előbb beszélj az orvosoddal. Edzés közben pedig figyelj magadra – ha valami nem érződik jónak, hagyd abba.';

  @override
  String get consentCheckbox =>
      'Elolvastam és elfogadom a Felhasználási feltételeket és az Egészségügyi tájékoztatót, és tudomásul veszem, hogy az edzéseket saját felelősségemre végzem.';

  @override
  String get consentAccept => 'Elfogadom, kezdjük';

  @override
  String get consentUpdatedTitle => 'Frissültek a feltételek';

  @override
  String get consentUpdatedBody =>
      'Módosultak a Felhasználási feltételek és az Egészségügyi tájékoztató. Kérjük, olvasd el és fogadd el őket a folytatáshoz.';

  @override
  String get consentTermsLink => 'Felhasználási feltételek';

  @override
  String get consentHealthLink => 'Egészségügyi tájékoztató';

  @override
  String get consentPrivacyLink => 'Adatvédelem';

  @override
  String get contact => 'Kapcsolat';

  @override
  String get legal => 'Jogi tudnivalók';

  @override
  String get infoIntro =>
      'Készítette: Bodnár Marcell. \nKérdésekkel, visszajelzéssel keress bátran:';

  @override
  String get instagramLink => '@bodnar__marcell';

  @override
  String get emailLink => 'marcell@getshap.com';

  @override
  String get wallPush => 'Fal Fekvőtámasz';

  @override
  String get tablePush => 'Asztal Fekvőtámasz';

  @override
  String get diamondTablePush => 'Gyémánt Fekvőtámasz Asztalon';

  @override
  String get kneePush => 'Térdelő Fekvőtámasz';

  @override
  String get pushUp => 'Fekvőtámasz';

  @override
  String get declinePush => 'Feltett Lábas Fekvőtámasz';

  @override
  String get explosivePush => 'Robbanékony Fekvőtámasz';

  @override
  String get pseudoPush => 'Pszeudo Fekvőtámasz';

  @override
  String get dipPush => 'Tolódzkodás';

  @override
  String get bagPull => 'Táskás/Súlyzós Evezés';

  @override
  String get reverseSnowAngel => 'Fordított Hóangyal';

  @override
  String get bwPull => 'Alacsony Rudas Evezés';

  @override
  String get pullup => 'Húzódzkodás';

  @override
  String get squat1 => 'Kapaszkodással Guggolás';

  @override
  String get lunge1 => 'Kapaszkodással Kitörés';

  @override
  String get squat2 => 'Guggolás';

  @override
  String get lunge2 => 'Kitörés';

  @override
  String get squat3 => 'Táskás Guggolás';

  @override
  String get lunge3 => 'Táskás Kitörés';

  @override
  String get squat4 => 'Guggolásból Ugrás';

  @override
  String get lunge4 => 'Bolgár Guggolás';

  @override
  String get squat5 => 'Oldalas Guggolás';

  @override
  String get lunge5 => 'Bolgár Guggolás Táskával';

  @override
  String get glute1 => 'Hátsó lábemelés';

  @override
  String get glute2 => 'Csípőemelés';

  @override
  String get glute3 => 'Emelt Lábas Csípőemelés';

  @override
  String get glute4 => 'Féllábas Csípőemelés';

  @override
  String get glute5 => 'Féllábas Csípőemelés Padon';

  @override
  String get core1 => 'Fekvő Lábemelések';

  @override
  String get core2 => 'Hátsó Lábemelések';

  @override
  String get workout => 'Edzés';

  @override
  String get noWorkout => 'Mára nincs több edzés :)';

  @override
  String get nextWorkoutTitle => 'Következő edzés';

  @override
  String get nextWorkoutTomorrow => 'Holnap már edzhetsz!';

  @override
  String nextWorkoutDays(int days) {
    return '$days nap múlva lesz edzés';
  }

  @override
  String get reps => 'Ismétlés';

  @override
  String get seconds => 'Másodperc';

  @override
  String get next => 'Következő';

  @override
  String get goback => 'Előző';

  @override
  String get startWorkout => 'Edzés Kezdése';

  @override
  String get question => 'Kérdés';

  @override
  String get nextq => 'Következő kérdés';

  @override
  String get finish => 'Befejezés';

  @override
  String get mainGoal => 'Mi a fő célod?';

  @override
  String get weightLoss => 'Fogyás';

  @override
  String get muscleBuild => 'Izmosodás';

  @override
  String get genderQuestion => 'Mi a nemed?';

  @override
  String get male => 'Férfi';

  @override
  String get female => 'Nő';

  @override
  String get maxKneePush => 'Hány térdelő fekvőtámaszt tudsz?';

  @override
  String get maxSquats => 'Hány guggolást tudsz?';

  @override
  String get prevExp1 => 'Sportoltál-e régebben rendszeresen?';

  @override
  String get yes => 'Igen';

  @override
  String get no => 'Nem';

  @override
  String get prevExp2 => 'Próbáltál már elkezdeni edzeni?';

  @override
  String get motivation => 'Mennyire van kedved edzeni?';

  @override
  String get notAtAll => 'Nincsen';

  @override
  String get somewhat => 'Valamennyire talán';

  @override
  String get motivated => 'Motivált vagyok';

  @override
  String get age => 'Mi a korosztályod?';

  @override
  String get congrat => 'Gratulálok!';

  @override
  String get congratMessage => 'Megcsináltad a mai edzésed!';

  @override
  String get rpe1 => 'Nagyon Könnyű';

  @override
  String get rpe23 => 'Könnyű';

  @override
  String get rpe46 => 'Kicsit Megerőltető';

  @override
  String get rpe78 => 'Megerőltető';

  @override
  String get rpe910 => 'Nagyon Megerőltető';

  @override
  String get howWasTheWorkout => 'Milyen nehéz volt az edzés?';

  @override
  String get feedback => 'Visszajelzés';

  @override
  String get workoutReminderTitle => 'Egy kis edzés? 💪';

  @override
  String get workoutReminderBody => 'Épp egy új szokást építesz ki - nyomjad!';

  @override
  String get welcomeNotiTitle => 'Vágj bele az edzésbe';

  @override
  String get welcomeNotiBody => 'nem lesz nehéz 😊';

  @override
  String get streakNotiTitle => 'Edzés streak 🔥';

  @override
  String get streakNotiBody =>
      'Ne felejtsd el meghosszabbítani az edzés streak-edet';

  @override
  String get dontGiveUpNotiTitle => 'Ne add fel!';

  @override
  String get dontGiveUpNotiBody => 'Úgy döntöttél, hogy változtatni szeretnél.';

  @override
  String get notis => 'Értesítések';

  @override
  String get notisAreImportant =>
      'Az emlékeztető értesítések segítenek rászokni az edzésre.';

  @override
  String get enableNotis => 'Értesítések engedélyezése';

  @override
  String get wallPushDesc =>
      'Állj egy lépésre a faltól. Helyezd a kezeidet vállszélességnél kicsivel szélesebbre, a könyökeidet tartsd a testedtől nagyjából 30-45 fokra, a testedet pedig tartsd egy egyenes vonalban. Engedd magad olyan közel a falhoz, amennyire csak tudod, majd told ki magad.';

  @override
  String get tablePushDesc =>
      'Helyezd a kezeidet egy stabil asztal szélére, vállszélességnél kicsivel szélesebbre.\nA könyökeidet tartsd a testedtől nagyjából 30-45 fokra, a testedet pedig tartsd egy egyenes vonalban. Engedd le magad olyan mélyre, amennyire csak tudod, majd nyomd ki magad.\nMinél alacsonyabb helyre teszed a kezed, annál nehezebb a gyakorlat.';

  @override
  String get diamondTablePushDesc =>
      'Helyezd a kezeidet egy stabil asztal szélére, egymáshoz közel, úgy, hogy a mutató- és hüvelykujjaid nagyjából egy háromszöget rajzoljanak ki, és a kezeid ne csússzanak előre.\nA könyökeidet tartsd közel a testedhez, a testedet pedig tartsd egy egyenes vonalban. Engedd le magad olyan mélyre, amennyire csak tudod, majd nyomd ki magad.\nMinél alacsonyabb helyre teszed a kezed, annál nehezebb a gyakorlat.';

  @override
  String get kneePushDesc =>
      'Térdelj le valami puha dologra. Helyezd a kezeidet vállszélességnél kicsivel szélesebbre, a könyökeidet tartsd a testedtől nagyjából 30-45 fokra, a testedet pedig tartsd egy egyenes vonalban. Engedd le magad olyan mélyre, amennyire csak tudod, majd nyomd ki magad.';

  @override
  String get pushUpDesc =>
      'Helyezd a kezeidet vállszélességnél kicsivel szélesebbre, a könyökeidet tartsd a testedtől nagyjából 30-45 fokra, a testedet pedig tartsd egy egyenes vonalban. Engedd le magad olyan mélyre, amennyire csak tudod, majd nyomd ki magad.';

  @override
  String get declinePushDesc =>
      'Helyezd a lábaidat valami magasabb dologra (mondjuk kanapéra), a kezeidet a földre, vállszélességnél kicsivel szélesebbre, a könyökeidet tartsd a testedtől nagyjából 30-45 fokra, a testedet pedig tartsd egy egyenes vonalban. Engedd le magad olyan mélyre, amennyire csak tudod, majd nyomd ki magad.';

  @override
  String get explosivePushDesc =>
      'Fekvőtámasz közben told el magad a földtől, amilyen erősen csak tudod.';

  @override
  String get pseudoPushDesc =>
      'Tedd a kezeidet vállszélesre, és kicsit fordítsd kifelé.\nDőlj előre úgy, hogy a kezeid valahol a vállaid és a csípőd között legyenek. Feszítsd a vállaidat lefelé, amennyire csak tudod, kétféleképpen is, egyrészt a föld felé, másrészt meg lefele a törzsed felé. Ezt a vállpozíciót próbáld tartani végig, amennyire tudod. Közben szorítsd össze a hasad.\nMinél jobban előredőlsz, annál nehezebb a gyakorlat.';

  @override
  String get dipPushDesc =>
      'Fogd meg a rudakat úgy, hogy a tenyered közepe legyen fölöttük. Szorítsd le a vállad, tartsd is úgy egész végig. Ereszkedj le, legalább amíg 90 fokba be nem hajlott a könyököd, majd nyomd ki magad.';

  @override
  String get bagPullDesc =>
      'Pakolj tele egy táskát könyvekkel, kis súlyzókkal, érzésre legalább 5-10 kg legyen a táska. \nEgyik kézzel támaszkodj, a törzsed legyen egyenes és nagyjából vízszintes. Ha leengeded a kezed, a táska lehetőleg a levegőben legyen. Felhúzásnál a válladat szorítsd le, ne menjen föl a füledhez. A karod kb. 90°-ig hajlítsd be. \nHa túl könnyű:\n• növeld a súlyt\n• engedd le lassabban\n• vagy csinálj belőle többet\nCsináld meg mindkét oldalra.';

  @override
  String get reverseSnowAngelDesc =>
      'Feküdj hassal a földre. Emeld meg a fejed és a kezeid úgy, hogy a két kezed a fejed fölött összeér. Vidd el oldalt a kezeid a csípődig, majd érintsd újra össze a kezeid a fejed fölött.\nEgy oda-vissza számít egy ismétlésnek.\nVégig tartsd a levegőben a kezeid.\nNehezítésképpen fogj meg egy-egy könyvet a két kezedben.';

  @override
  String get bwPullDesc => '';

  @override
  String get pullupDesc => '';

  @override
  String get squat1Desc =>
      'Támaszkodj/kapaszkodj valami stabil dologba az egyik vagy mindkét oldaladon. Vállszéles terpeszben a lábfejeid kicsit kifele nézzenek. Kezdd kicsit előrevinni a térdeidet, majd kontrollált tempóban ereszkedj le nagyjából 90° mélységébe. Tartsd a törzsed egyenesen.';

  @override
  String get lunge1Desc =>
      'A két lábra összesen számold az ismétléseket, ne lábanként külön. Támaszkodj/kapaszkodj valami stabil dologba az egyik vagy mindkét oldaladon. Lépj hátra, miközben az elülső sípcsontod függőlegesen marad. A combod mutasson előre. Kicsit dőlj előre, hogy az elülső lábad hátsó részén legyen a hangsúly.';

  @override
  String get squat2Desc =>
      'Vállszéles terpeszben a lábfejeid kicsit kifele nézzenek. Kezdd kicsit előrevinni a térdeidet, majd kontrollált tempóban ereszkedj le nagyjából 90° mélységébe. Tartsd a törzsed egyenesen.';

  @override
  String get lunge2Desc =>
      'A két lábra összesen számold az ismétléseket, ne lábanként külön. Lépj hátra, miközben az elülső sípcsontod függőlegesen marad. A combod mutasson előre. Kicsit dőlj előre, hogy az elülső lábad hátsó részén legyen a hangsúly.';

  @override
  String get squat3Desc =>
      'Tölts meg egy táskát könyvekkel vagy más súlyokkal. Vállszéles terpeszben a lábfejeid kicsit kifele nézzenek. Kezdd kicsit előrevinni a térdeidet, majd kontrollált tempóban ereszkedj le nagyjából 90° mélységébe. Tartsd a törzsed egyenesen.';

  @override
  String get lunge3Desc =>
      'A két lábra összesen számold az ismétléseket, ne lábanként külön. Tölts meg egy táskát könyvekkel vagy más súlyokkal. Lépj hátra, miközben az elülső sípcsontod függőlegesen marad. A combod mutasson előre. Kicsit dőlj előre, hogy az elülső lábad hátsó részén legyen a hangsúly.';

  @override
  String get squat4Desc =>
      'Guggolás közben ugorj egyet. Vállszéles terpeszben a lábfejeid kicsit kifele nézzenek. Kezdd kicsit előrevinni a térdeidet, majd kontrollált tempóban ereszkedj le nagyjából 90° mélységébe. Tartsd a törzsed egyenesen. Ha gondolod, vegyél fel egy súlyokkal megpakolt hátizsákot.';

  @override
  String get lunge4Desc =>
      'A hátsó lábad tedd fel mondjuk egy székre. A hátsó lábfejed lábujjadon támaszkodjon, az első nézzen előre. A két lábujj ne egy vonalban legyen, hogy stabilabban állj. Tartsd az elülső sípcsontod függőlegesen. A combod mutasson előre. Kicsit dőlj előre, hogy az elülső lábad hátsó részén legyen a hangsúly. Mindkét lábaddal elől csináld meg.';

  @override
  String get squat5Desc =>
      'Állj terpeszben, kicsit nézzenek kifelé a lábfejeid. Kezdd a leereszkedést az egyik térded behajlításával. Tartsd a felsőtested függőlegesen, amennyire tudod.';

  @override
  String get lunge5Desc =>
      'Vegyél fel egy könyvekkel telepakolt táskát. A hátsó lábad tedd fel mondjuk egy székre. A hátsó lábfejed lábujjadon támaszkodjon, az első nézzen előre. A két lábujj ne egy vonalban legyen, hogy stabilabban állj. Tartsd az elülső sípcsontod függőlegesen. A combod mutasson előre. Kicsit dőlj előre, hogy az elülső lábad hátsó részén legyen a hangsúly. Mindkét lábaddal elől csináld meg.';

  @override
  String get glute1Desc =>
      'Kapaszkodj meg egy asztalban, kicsit hajolj előre, és emeld hátra a lábad.\nNe felejtsd el mindkét lábra megcsinálni.';

  @override
  String get glute2Desc =>
      'Feküdj hátra hajlított térddel. Kicsit rakd ki oldalra a kezeid, hogy stabilabb legyél.\nVidd fel a csípődet olyan magasra, amilyenre csak tudod, miközben feszíted a farizmod, majd engedd vissza a csípőd.';

  @override
  String get glute3Desc =>
      'Feküdj hátra hajlított térddel úgy, hogy a lábaid valami magaslaton, mondjuk egy kanapé szélén legyenek. Kicsit rakd ki oldalra a kezeid, hogy stabilabb legyél.\nVidd fel a csípődet olyan magasra, amilyenre csak tudod, miközben feszíted a farizmod, majd engedd vissza a csípőd.';

  @override
  String get glute4Desc =>
      'Feküdj hátra hajlított térddel, majd nyújtsd ki az egyik lábad, miközben a levegőben tartod. Kicsit rakd ki oldalra a kezeid, hogy stabilabb legyél.\nVidd fel a csípődet olyan magasra, amilyenre csak tudod, miközben feszíted a farizmod, majd engedd vissza a csípőd.\nNe felejtsd el mindkét lábra megcsinálni.';

  @override
  String get glute5Desc =>
      'Ülj egy kanapé vagy ágy elé, úgy, hogy az ágy széle a hátadnál legyen. Egyik lábad legyen behajlítva, a másik pedig nyújtva.\nAz egyik lábaddal told ki a csípődet, amennyire csak tudod, miközben feszíted a farizmodat, és a másik lábadat is elemeled a földről, majd ereszkedj le.\nNe felejtsd el mindkét lábra megcsinálni.';

  @override
  String get core1Desc =>
      'Tedd be a kezeid a feneked alá. Emeld fel a fejed. Feszítsd a hasad, és emeld fel a lábaid, de ne teljesen függőlegesig. Kontrolláltan engedd le a lábaid, és ismétlések között ne pihentesd lent a földön. Térdhajlítással könnyebb.';

  @override
  String get core2Desc =>
      'Feküdj hassal egy székre, és kapaszkodj a lábaiba. Hajlított térddel emeld fel hátul a lábaid, amennyire tudod.';

  @override
  String get lightBagPull => 'Táskás/Súlyzós Evezés kisebb súllyal';

  @override
  String get runInPlace => 'Helyben Futás';

  @override
  String get warmupDesc =>
      'Végezd a gyakorlatot kontrolláltan. Figyelj, hogy helyes technikával csináld.';

  @override
  String get warmup => 'Bemelegítés';

  @override
  String get understand => 'Értem';

  @override
  String get important => 'Fontos';

  @override
  String get finishWarning =>
      'Az appban edzésnél csak akkor nyomd meg a „Befejezés” gombot, ha tényleg befejezted az edzést. \n\nEz egy visszajelzés az appnak.';

  @override
  String get tip => 'Tipp';

  @override
  String tipWithType(String type) {
    return '$type tipp';
  }

  @override
  String get tipTypePrinciples => 'Mindset';

  @override
  String get tipTypeWorkout => 'Edzés';

  @override
  String get tipTypeDiet => 'Diéta';

  @override
  String get tipLibrary => 'Tippkönyvtár';

  @override
  String get noTipsYet => 'Még nem kaptál ilyen tippet.';

  @override
  String get principles1 =>
      'Legfőbb cél: soha ne hagyd teljesen abba - akkor biztosan eléred, amit szeretnél.';

  @override
  String get principles2 =>
      'Inkább legyen az edzés nagyon könnyű, mint hogy ne eddz rendszeresen.';

  @override
  String get principles3 =>
      'Ha az edzés kezd a szokásoddá válni, akkor finoman tovább lehet nehezíteni.';

  @override
  String get principles4 =>
      'Egy sportosabb test jót tesz a mentális és a fizikai egészségnek is.';

  @override
  String get beginnerWorkout1 =>
      'Gyakorlatoknál a borzalmas forma sérüléshez vezethet - csináld legalább tűrhető formában.';

  @override
  String get beginnerWorkout2 =>
      'Tarts 30mp és 2 perc közötti szünetet két gyakorlat között - így visszanyered az erőd egy részét, de a pihenés mégsem húzza el túlságosan az edzést.';

  @override
  String get beginnerDiet1 =>
      'Ha fogyni szeretnél, vásárolj édesítőszeres üdítőket, és amennyire csak tudod, ezeket idd a cukros italok és más édességek helyett - csillapítják az édesség utáni vágyadat, miközben szinte nulla kalóriát tartalmaznak.';

  @override
  String get beginnerDiet2 =>
      'Ha fogyni szeretnél, vásárolj több gyümölcsöt, zöldséget, amiket szeretsz - kevés kalóriát tartalmaznak, de sok helyet foglalnak a gyomrodban, így csillapítják az éhségedet, anélkül, hogy sok kalóriát vinnél be.';

  @override
  String get advancedWorkout1 =>
      'Négy fő izomcsoport: toló-, húzó-, törzs- és lábizmok.\n\nTológyakorlat minden olyan gyakorlat, ahol valamit eltolsz a testedtől, például a fekvőtámasz különböző változatai, a tolódzkodás vagy a fekvenyomás. Ezek főleg a mellizmodat, a tricepszedet és a vállad elülső részét edzik.\n\nHúzógyakorlat minden olyan gyakorlat, ahol valamit közelebb húzol a testedhez, például a táskás evezés vagy a húzódzkodás. Ezek főleg a hátadat, a bicepszedet és a vállad hátsó részét edzik. Két fő típusuk a függőleges (húzódzkodás) és a vízszintes (táskás evezés) húzás.\n\nA törzsizmok a hasizom, az alsó hát és az oldalsó törzsizmok. A legtöbb saját testsúlyos gyakorlat (például a fekvőtámasz és a húzódzkodás) edzi őket, de külön gyakorlatokat is csinálhatsz rájuk.\n\nA lábadnak 4 fő izma van: az elülső combizom, a hátsó combizom, a farizom és a vádli. A guggolás nagyon jól edzi az elülső combizmot, a csípőemelés pedig főleg a farizmot dolgoztatja. A hátsó combizomra azok a gyakorlatok a leghatékonyabbak, ahol behajlítod a lábad, de otthoni eszközökkel ezekre nincs igazán alternatíva. A kitörés (ahogyan benne van az appban) és a csípőemelés viszont együtt elég jól edzik. A vádlira nincs külön gyakorlat az appban, mert a futás jól edzi, és valamennyire a többi gyakorlat is.';

  @override
  String get advancedWorkout2 =>
      'A bemelegítés növeli a teljesítményedet, és csökkenti a sérülés veszélyét.';

  @override
  String get advancedWorkout3 =>
      'Ha a fogyás fontosabb az izomépítésnél: kocogással is helyettesítheted a lábgyakorlatokat, vagy mindkettőt is csinálhatod. A kocogás több kalóriát éget el. De ne tölts túl sok időt kocogással, ha nem szereted.';

  @override
  String get advancedWorkout4 =>
      'Bemelegítésnél figyelj a gyakorlatok technikájára - ilyenkor próbáld a lehető legtökéletesebb formában végrehajtani őket, hogy fejlődjön a technikád.';

  @override
  String get advancedDiet1 =>
      'Egyik étkezésed után nagyjából 2 órával érdemes edzeni. Ha egy nagy ebéd után edzenél, ez lehet több idő is - így lesz energiád az edzéshez, és az emésztésed sem fog zavarni.';

  @override
  String get advancedDiet2 =>
      'Kalóriák be, kalóriák ki - ha több energiát égetsz el, mint amennyit beviszel, fogyni fogsz.';

  @override
  String get advancedDiet3 =>
      'Több fehérje fogyasztása izomépítésnél és fogyásnál: segít, hogy több izmot építs, és fogyásnál ne veszíts az izomzatodból.';

  @override
  String get advancedDiet4 =>
      'Ne vidd túlzásba a diétázást - ne kényszeríts magadra olyan diétát, amit szerinted nem tudnál hosszú távon tartani.';

  @override
  String get advancedDiet5 =>
      'Ha fogyni szeretnél, mérd minden nap nagyjából ugyanabban az időben a súlyod - evés, hidratáltság, nagydolog intézése mind hozzájárul, hogy akár pár órán belül kilókat változzon a súlyod, anélkül, hogy égetnél zsírt.';

  @override
  String get advancedDiet6 =>
      'Ha fogyni szeretnél, a megmért tömegedet jegyezd le valahova, lehetőleg Excelbe vagy Google Táblázatokba, ahol könnyen tudsz heti átlagot számolni. Ha a súlyod az utóbbi hetekben nem haladt lefelé, figyelj, hogy több gyümölcsöt, zöldséget és kevesebb cukros dolgot egyél, vagy kocogj többet.';

  @override
  String get workoutStreak => 'edzés streak';

  @override
  String get streakFreeze => 'Streak freeze';

  @override
  String get updateReadyMessage => 'Egy frissítés letöltődött.';

  @override
  String get updateRestart => 'Újraindítás';

  @override
  String get updateAvailableTitle => 'Frissítés elérhető';

  @override
  String get updateAvailableMessage =>
      'Az alkalmazás új verziója elérhető az App Store-ban.';

  @override
  String get updateNow => 'Frissítés';

  @override
  String get updateLater => 'Később';
}
