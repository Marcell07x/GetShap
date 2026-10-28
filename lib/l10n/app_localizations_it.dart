// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get form => 'Ecco il modulo';

  @override
  String get consentTitle => 'Prima di iniziare';

  @override
  String get consentIntro =>
      'GetShap è qui per aiutarti a prendere gusto all\'attività fisica regolare e, attraverso di essa, ad avvicinarti ai tuoi obiettivi fisici. Tre cose prima di cominciare:';

  @override
  String get consentPoint1 =>
      'Ti alleni a tuo rischio – come in ogni attività fisica, possono verificarsi infortuni.';

  @override
  String get consentPoint2 =>
      'L\'app imposta la difficoltà in base alle tue risposte – si tratta di una classificazione automatica, non di una valutazione professionale, e non tiene conto del tuo stato di salute. I contenuti non sono stati preparati da un professionista sanitario.';

  @override
  String get consentPoint3 =>
      'Se hai un problema di salute, parlane prima con il tuo medico. E durante l\'allenamento ascolta il tuo corpo – se qualcosa non ti sembra a posto, fermati.';

  @override
  String get consentCheckbox =>
      'Ho letto e accetto i Termini di utilizzo e l\'Avvertenza sulla salute, e sono consapevole che mi alleno a mio rischio.';

  @override
  String get consentAccept => 'Accetta e inizia';

  @override
  String get consentUpdatedTitle => 'I nostri termini sono cambiati';

  @override
  String get consentUpdatedBody =>
      'I Termini di utilizzo e l\'Avvertenza sulla salute sono stati aggiornati. Leggili e accettali per continuare.';

  @override
  String get consentTermsLink => 'Termini di utilizzo';

  @override
  String get consentHealthLink => 'Avvertenza sulla salute';

  @override
  String get consentPrivacyLink => 'Privacy';

  @override
  String get contact => 'Contatti';

  @override
  String get legal => 'Note legali';

  @override
  String get infoIntro =>
      'Creato da Marcell Bodnár.\nScrivimi pure per domande o feedback:';

  @override
  String get instagramLink => '@bodnar__marcell';

  @override
  String get emailLink => 'marcell@getshap.com';

  @override
  String get wallPush => 'Flessioni al muro';

  @override
  String get tablePush => 'Flessioni sul tavolo';

  @override
  String get diamondTablePush => 'Flessioni a diamante sul tavolo';

  @override
  String get kneePush => 'Flessioni sulle ginocchia';

  @override
  String get pushUp => 'Flessioni';

  @override
  String get declinePush => 'Flessioni declinate';

  @override
  String get explosivePush => 'Flessioni esplosive';

  @override
  String get pseudoPush => 'Flessioni pseudo planche';

  @override
  String get dipPush => 'Dip alle parallele';

  @override
  String get bagPull => 'Rematore a un braccio con borsa';

  @override
  String get reverseSnowAngel => 'Angeli nella neve inversi';

  @override
  String get bwPull => 'Rematore inverso';

  @override
  String get pullup => 'Trazioni';

  @override
  String get squat1 => 'Squat assistiti';

  @override
  String get lunge1 => 'Affondi assistiti';

  @override
  String get squat2 => 'Squat';

  @override
  String get lunge2 => 'Affondi';

  @override
  String get squat3 => 'Squat con zaino';

  @override
  String get lunge3 => 'Affondi con zaino';

  @override
  String get squat4 => 'Squat con salto';

  @override
  String get lunge4 => 'Squat bulgari';

  @override
  String get squat5 => 'Squat laterali';

  @override
  String get lunge5 => 'Squat bulgari con peso';

  @override
  String get glute1 => 'Slanci posteriori';

  @override
  String get glute2 => 'Ponte glutei';

  @override
  String get glute3 => 'Ponte glutei con piedi rialzati';

  @override
  String get glute4 => 'Ponte glutei a una gamba';

  @override
  String get glute5 => 'Hip thrust a una gamba';

  @override
  String get core1 => 'Sollevamento gambe da sdraiato';

  @override
  String get core2 => 'Iperestensioni inverse';

  @override
  String get workout => 'Allenamento';

  @override
  String get noWorkout => 'Per oggi niente più allenamenti :)';

  @override
  String get nextWorkoutTitle => 'Prossimo allenamento';

  @override
  String get nextWorkoutTomorrow => 'Domani puoi allenarti di nuovo!';

  @override
  String nextWorkoutDays(int days) {
    return 'Mancano $days giorni al prossimo allenamento';
  }

  @override
  String get reps => 'Ripetizioni';

  @override
  String get seconds => 'Secondi';

  @override
  String get next => 'Avanti';

  @override
  String get goback => 'Indietro';

  @override
  String get startWorkout => 'Inizia';

  @override
  String get question => 'Domanda';

  @override
  String get nextq => 'Prossima domanda';

  @override
  String get finish => 'Termina';

  @override
  String get mainGoal => 'Qual è il tuo obiettivo principale?';

  @override
  String get weightLoss => 'Perdere peso';

  @override
  String get muscleBuild => 'Aumentare la massa muscolare';

  @override
  String get genderQuestion => 'Qual è il tuo sesso?';

  @override
  String get male => 'Uomo';

  @override
  String get female => 'Donna';

  @override
  String get maxKneePush => 'Quante flessioni sulle ginocchia riesci a fare?';

  @override
  String get maxSquats => 'Quanti squat riesci a fare?';

  @override
  String get prevExp1 => 'In passato facevi sport regolarmente?';

  @override
  String get yes => 'Sì';

  @override
  String get no => 'No';

  @override
  String get prevExp2 => 'Hai già provato a iniziare ad allenarti?';

  @override
  String get motivation => 'Quanta voglia hai di allenarti?';

  @override
  String get notAtAll => 'Nessuna';

  @override
  String get somewhat => 'Un po\'';

  @override
  String get motivated => 'Tanta';

  @override
  String get age => 'Qual è la tua fascia d\'età?';

  @override
  String get congrat => 'Complimenti!';

  @override
  String get congratMessage => 'Hai completato l\'allenamento di oggi!';

  @override
  String get rpe1 => 'Molto leggero';

  @override
  String get rpe23 => 'Leggero';

  @override
  String get rpe46 => 'Moderato';

  @override
  String get rpe78 => 'Intenso';

  @override
  String get rpe910 => 'Molto intenso';

  @override
  String get howWasTheWorkout => 'Quanto è stato faticoso l\'allenamento?';

  @override
  String get feedback => 'Feedback';

  @override
  String get workoutReminderTitle => 'Un allenamento veloce? 💪';

  @override
  String get workoutReminderBody =>
      'Stai costruendo un\'abitudine – continua così!';

  @override
  String get welcomeNotiTitle => 'Inizia il tuo allenamento';

  @override
  String get welcomeNotiBody => 'Non sarà difficile 😊';

  @override
  String get streakNotiTitle => 'Serie di allenamenti 🔥';

  @override
  String get streakNotiBody =>
      'Non dimenticare di allungare la tua serie di allenamenti';

  @override
  String get dontGiveUpNotiTitle => 'Non mollare!';

  @override
  String get dontGiveUpNotiBody => 'Hai deciso di voler cambiare.';

  @override
  String get notis => 'Notifiche';

  @override
  String get notisAreImportant =>
      'Le notifiche ti aiutano a prendere l\'abitudine di allenarti.';

  @override
  String get enableNotis => 'Attiva le notifiche';

  @override
  String get wallPushDesc =>
      'Mettiti a circa un passo dal muro. Appoggia le mani un po\' più larghe delle spalle, tieni i gomiti a circa 30–45 gradi dal corpo e il corpo in linea retta. Avvicinati al muro il più possibile, poi spingiti indietro.';

  @override
  String get tablePushDesc =>
      'Appoggia le mani sul bordo di un tavolo stabile, un po\' più larghe delle spalle.\nTieni i gomiti a un angolo di 30–45 gradi rispetto al corpo e il corpo in linea retta. Scendi il più in basso possibile, poi spingi per risalire.\nPiù è bassa la superficie su cui appoggi le mani, più l\'esercizio è impegnativo.';

  @override
  String get diamondTablePushDesc =>
      'Appoggia le mani sul bordo di un tavolo stabile, vicine tra loro, in modo che indici e pollici formino un triangolo, e fai attenzione che le mani non scivolino in avanti.\nTieni i gomiti vicini al corpo e il corpo in linea retta. Scendi il più in basso possibile, poi spingi per risalire.\nPiù è bassa la superficie su cui appoggi le mani, più l\'esercizio è impegnativo.';

  @override
  String get kneePushDesc =>
      'Inginocchiati su qualcosa di morbido. Appoggia le mani un po\' più larghe delle spalle, tieni i gomiti a circa 30–45 gradi dal corpo e il corpo in linea retta. Scendi il più in basso possibile, poi spingi per risalire.';

  @override
  String get pushUpDesc =>
      'Appoggia le mani un po\' più larghe delle spalle, tieni i gomiti a circa 30–45 gradi dal corpo e il corpo in linea retta. Scendi il più in basso possibile, poi spingi per risalire.';

  @override
  String get declinePushDesc =>
      'Appoggia i piedi su una superficie rialzata (come un letto) e le mani un po\' più larghe delle spalle. Tieni i gomiti a circa 30–45 gradi dal corpo e il corpo in linea retta. Scendi il più in basso possibile, poi spingi per risalire.';

  @override
  String get explosivePushDesc =>
      'Durante la flessione, spingiti via dal pavimento con tutta la forza che hai.';

  @override
  String get pseudoPushDesc =>
      'Appoggia le mani alla larghezza delle spalle e ruotale leggermente verso l\'esterno.\nSporgiti in avanti in modo che le mani si trovino da qualche parte tra le spalle e i fianchi. Abbassa le spalle il più possibile in due modi: spingile verso il pavimento e tirale verso il basso, in direzione del busto. Cerca di mantenere questa posizione delle spalle il meglio possibile per tutto il movimento. Nello stesso tempo, contrai gli addominali.\nPiù ti sporgi in avanti, più l\'esercizio è impegnativo.';

  @override
  String get dipPushDesc =>
      'Afferra le parallele con il centro dei palmi appoggiato sopra. Tieni le spalle basse e mantieni questa posizione per tutto il tempo. Scendi finché i gomiti non sono piegati almeno a 90 gradi, poi spingi per risalire.';

  @override
  String get bagPullDesc =>
      'Riempi una borsa con libri o piccoli pesi, almeno 5–10 kg. Appoggiati con una mano, con il busto dritto e più o meno orizzontale. Quando abbassi la mano, cerca di tenere la borsa sollevata da terra. Durante la tirata, tieni le spalle basse – non lasciarle salire verso le orecchie. Piega il braccio fino a circa 90°.\nSe ti sembra troppo facile:\n• aumenta il peso\n• abbassala più lentamente\n• fai più ripetizioni\nRipeti su entrambi i lati.';

  @override
  String get reverseSnowAngelDesc =>
      'Sdraiati a pancia in giù sul pavimento. Solleva la testa e le mani, unendo le mani sopra la testa. Porta le braccia di lato, verso il basso, fino ai fianchi, poi unisci di nuovo le mani sopra la testa.\nUn giro completo, andata e ritorno, conta come una ripetizione.\nTieni le mani sollevate da terra per tutto il movimento.\nPer renderlo più impegnativo, tieni un libro in ogni mano.';

  @override
  String get bwPullDesc => '';

  @override
  String get pullupDesc => '';

  @override
  String get squat1Desc =>
      'Tieniti a qualcosa di stabile con una o entrambe le mani. Metti i piedi alla larghezza delle spalle, con le punte leggermente rivolte verso l\'esterno. Inizia spingendo leggermente le ginocchia in avanti, poi scendi in modo controllato fino a circa 90°. Tieni il busto dritto per tutto il movimento.';

  @override
  String get lunge1Desc =>
      'Alterna le gambe – conta le ripetizioni totali, non per gamba. Tieniti a qualcosa di stabile con una o entrambe le mani. Fai un passo indietro, mantenendo verticale la tibia della gamba anteriore. La coscia deve puntare in avanti. Inclinati leggermente in avanti, in modo che il lavoro si concentri sulla parte posteriore della gamba anteriore.';

  @override
  String get squat2Desc =>
      'Metti i piedi alla larghezza delle spalle, con le punte leggermente rivolte verso l\'esterno. Inizia spingendo leggermente le ginocchia in avanti, poi scendi in modo controllato fino a circa 90°. Tieni il busto dritto per tutto il movimento.';

  @override
  String get lunge2Desc =>
      'Alterna le gambe – conta le ripetizioni totali, non per gamba. Fai un passo indietro, mantenendo verticale la tibia della gamba anteriore. La coscia deve puntare in avanti. Inclinati leggermente in avanti, in modo che il lavoro si concentri sulla parte posteriore della gamba anteriore.';

  @override
  String get squat3Desc =>
      'Riempi uno zaino con libri o altri pesi. Metti i piedi alla larghezza delle spalle, con le punte leggermente rivolte verso l\'esterno. Inizia spingendo leggermente le ginocchia in avanti, poi scendi in modo controllato fino a circa 90°. Tieni il busto dritto per tutto il movimento.';

  @override
  String get lunge3Desc =>
      'Alterna le gambe – conta le ripetizioni totali, non per gamba. Riempi uno zaino con libri o altri pesi. Fai un passo indietro, mantenendo verticale la tibia della gamba anteriore. La coscia deve puntare in avanti. Inclinati leggermente in avanti, in modo che il lavoro si concentri sulla parte posteriore della gamba anteriore.';

  @override
  String get squat4Desc =>
      'Salta mentre fai lo squat. Metti i piedi alla larghezza delle spalle, con le punte leggermente rivolte verso l\'esterno. Inizia spingendo leggermente le ginocchia in avanti, poi scendi in modo controllato fino a circa 90°. Tieni il busto dritto per tutto il movimento. Se vuoi, indossa uno zaino pieno di pesi.';

  @override
  String get lunge4Desc =>
      'Appoggia la gamba posteriore su una sedia. Il piede posteriore poggia sulle dita, mentre il piede anteriore punta in avanti. Tieni i piedi leggermente distanziati invece che sulla stessa linea, per avere più equilibrio. Tieni verticale la tibia della gamba anteriore e la coscia rivolta in avanti. Inclinati leggermente in avanti, in modo che il peso sia sulla parte posteriore della gamba anteriore. Ripeti su entrambi i lati.';

  @override
  String get squat5Desc =>
      'Allarga i piedi, con le punte leggermente rivolte verso l\'esterno. Inizia la discesa piegando un ginocchio. Tieni la parte superiore del corpo il più dritta possibile.';

  @override
  String get lunge5Desc =>
      'Riempi una borsa con libri o altri pesi. Appoggia la gamba posteriore su una sedia. Il piede posteriore poggia sulle dita, mentre il piede anteriore punta in avanti. Tieni i piedi leggermente distanziati invece che sulla stessa linea, per avere più equilibrio. Tieni verticale la tibia della gamba anteriore e la coscia rivolta in avanti. Inclinati leggermente in avanti, in modo che il peso sia sulla parte posteriore della gamba anteriore. Ripeti su entrambi i lati.';

  @override
  String get glute1Desc =>
      'Tieniti a un tavolo, inclinati leggermente in avanti e porta la gamba tesa indietro.\nRicordati di farlo con entrambe le gambe.';

  @override
  String get glute2Desc =>
      'Sdraiati sulla schiena con le ginocchia piegate. Allarga leggermente le braccia ai lati per avere più stabilità.\nSpingi i fianchi il più in alto possibile contraendo i glutei, poi riabbassali.';

  @override
  String get glute3Desc =>
      'Sdraiati sulla schiena con le ginocchia piegate e i piedi su una superficie rialzata, come il bordo di un divano. Allarga leggermente le braccia ai lati per avere più stabilità.\nSpingi i fianchi il più in alto possibile contraendo i glutei, poi riabbassali.';

  @override
  String get glute4Desc =>
      'Sdraiati sulla schiena con le ginocchia piegate, poi distendi una gamba tenendola sollevata. Allarga leggermente le braccia ai lati per avere più stabilità.\nSpingi i fianchi il più in alto possibile contraendo i glutei, poi riabbassali.\nRicordati di farlo con entrambe le gambe.';

  @override
  String get glute5Desc =>
      'Siediti davanti a un divano o a un letto, in modo che il bordo sia contro la parte alta della schiena. Tieni una gamba piegata e distendi l\'altra.\nSpingi i fianchi il più in alto possibile con una sola gamba contraendo i glutei, sollevando anche l\'altro piede da terra, poi scendi.\nRicordati di farlo con entrambe le gambe.';

  @override
  String get core1Desc =>
      'Metti le mani sotto i fianchi e solleva la testa. Contrai gli addominali e solleva le gambe, ma non fino alla verticale. Abbassa le gambe in modo controllato e non appoggiarle a terra tra una ripetizione e l\'altra. Con le ginocchia piegate è più facile.';

  @override
  String get core2Desc =>
      'Sdraiati a pancia in giù su una sedia e tieniti alle sue gambe. Con le ginocchia piegate, solleva le gambe dietro di te il più in alto possibile.';

  @override
  String get lightBagPull => 'Rematore a un braccio con borsa più leggera';

  @override
  String get runInPlace => 'Corsa sul posto';

  @override
  String get warmupDesc =>
      'Esegui l\'esercizio in modo controllato. Fai attenzione alla tecnica corretta.';

  @override
  String get warmup => 'Riscaldamento';

  @override
  String get understand => 'Ho capito';

  @override
  String get important => 'Importante';

  @override
  String get finishWarning =>
      'Premi il pulsante «Termina» solo quando hai davvero completato l\'allenamento.\n\nServe come feedback per l\'app.';

  @override
  String get tip => 'Consiglio';

  @override
  String tipWithType(String type) {
    return 'Consiglio: $type';
  }

  @override
  String get tipTypePrinciples => 'Mentalità';

  @override
  String get tipTypeWorkout => 'Allenamento';

  @override
  String get tipTypeDiet => 'Alimentazione';

  @override
  String get tipLibrary => 'Raccolta di consigli';

  @override
  String get noTipsYet =>
      'Non hai ancora ricevuto un consiglio di questo tipo.';

  @override
  String get principles1 =>
      'Obiettivo principale: non smettere mai del tutto – è l\'unico modo sicuro per arrivare dove vuoi.';

  @override
  String get principles2 =>
      'Un allenamento leggero è meglio che saltarlo del tutto.';

  @override
  String get principles3 =>
      'Quando allenarti inizia a diventare un\'abitudine, puoi aumentare un po\' alla volta.';

  @override
  String get principles4 =>
      'Un corpo più in forma fa bene sia alla salute mentale sia a quella fisica.';

  @override
  String get beginnerWorkout1 =>
      'Una tecnica pessima negli esercizi può causare infortuni – cerca di eseguirli almeno in modo decente.';

  @override
  String get beginnerWorkout2 =>
      'Riposa da 30 secondi a 2 minuti tra un esercizio e l\'altro – così recuperi parte delle forze, ma i tuoi allenamenti non durano troppo.';

  @override
  String get beginnerDiet1 =>
      'Se vuoi perdere peso, compra bibite zero zuccheri e, quando puoi, bevile al posto delle bevande zuccherate e degli altri dolci – placano la voglia di zucchero e hanno quasi 0 calorie.';

  @override
  String get beginnerDiet2 =>
      'Se vuoi perdere peso, fai scorta di frutta e verdura che ti piacciono davvero – hanno poche calorie ma riempiono parecchio lo stomaco, così dopo avrai meno fame.';

  @override
  String get advancedWorkout1 =>
      'Quattro gruppi muscolari principali: spinta, tirata, core e gambe.\n\nGli esercizi di spinta sono le varianti delle flessioni, i dip, la panca piana e altri esercizi in cui allontani qualcosa dal corpo spingendo. Allenano soprattutto il petto, i tricipiti e la parte anteriore delle spalle.\n\nGli esercizi di tirata, come il rematore con la borsa o le trazioni, sono quelli in cui avvicini qualcosa al corpo. Allenano soprattutto la schiena, i bicipiti e la parte posteriore delle spalle. Ce ne sono due tipi principali: tirata verticale (trazioni) e tirata orizzontale (rematore con la borsa).\n\nI muscoli del core sono gli addominali, la zona lombare e gli obliqui. Lavorano nella maggior parte degli esercizi a corpo libero, come le flessioni e le trazioni, ma puoi anche fare esercizi specifici per loro.\n\nLe gambe hanno 4 muscoli principali: quadricipiti, femorali, glutei e polpacci. Gli squat allenano molto bene i quadricipiti, mentre hip thrust e ponte glutei lavorano soprattutto sui glutei. Gli esercizi più efficaci per i femorali sono quelli in cui pieghi la gamba, ma con l\'attrezzatura di casa non c\'è un\'alternativa. Tuttavia gli affondi (presenti nell\'app) insieme a hip thrust e ponte glutei li allenano abbastanza bene. Per i polpacci non c\'è un esercizio dedicato nell\'app, perché si allenano bene correndo, e un po\' anche negli altri esercizi.';

  @override
  String get advancedWorkout2 =>
      'Il riscaldamento migliora le tue prestazioni e riduce il rischio di infortuni.';

  @override
  String get advancedWorkout3 =>
      'Se perdere peso è più importante per te che aumentare la massa muscolare: puoi sostituire gli esercizi per le gambe con la corsa – o fare entrambe le cose. La corsa brucia più calorie. Ma non correre troppo se non ti piace.';

  @override
  String get advancedWorkout4 =>
      'Durante il riscaldamento fai attenzione alla tecnica – approfittane per eseguire i movimenti nel modo più perfetto possibile, così migliori la tua tecnica.';

  @override
  String get advancedDiet1 =>
      'Cerca di allenarti circa 2 ore dopo un pasto. Dopo un pranzo abbondante, potresti voler aspettare anche di più – così avrai energia per l\'allenamento e la digestione non ti darà fastidio.';

  @override
  String get advancedDiet2 =>
      'Calorie in entrata, calorie in uscita – se bruci più energia di quella che assumi, perdi peso.';

  @override
  String get advancedDiet3 =>
      'Mangiare più proteine aiuta sia ad aumentare i muscoli sia a perdere peso – sostiene la crescita muscolare e ti aiuta a mantenere i muscoli mentre sei a dieta.';

  @override
  String get advancedDiet4 =>
      'Non esagerare con la dieta – non costringerti a seguire una dieta che pensi di non riuscire a mantenere a lungo.';

  @override
  String get advancedDiet5 =>
      'Se vuoi perdere peso, pesati ogni giorno più o meno alla stessa ora – i pasti, l\'idratazione e l\'andare in bagno possono far variare il tuo peso di qualche chilo nel giro di poche ore, senza che tu abbia davvero bruciato grasso.';

  @override
  String get advancedDiet6 =>
      'Se vuoi perdere peso, annota il tuo peso da qualche parte – meglio su Excel o su Fogli Google, dove puoi calcolare facilmente le medie settimanali. Se il tuo peso non è sceso nelle ultime settimane, prova a mangiare più frutta e verdura e meno dolci, o a correre di più.';

  @override
  String get workoutStreak => 'serie di allenamenti';

  @override
  String get streakFreeze => 'Protezione serie';

  @override
  String get updateReadyMessage => 'È stato scaricato un aggiornamento.';

  @override
  String get updateRestart => 'Riavvia';

  @override
  String get updateAvailableTitle => 'Aggiornamento disponibile';

  @override
  String get updateAvailableMessage =>
      'Una nuova versione dell\'app è disponibile sull\'App Store.';

  @override
  String get updateNow => 'Aggiorna';

  @override
  String get updateLater => 'Più tardi';
}
