// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get form => 'Hier ist das Formular';

  @override
  String get consentTitle => 'Bevor du loslegst';

  @override
  String get consentIntro =>
      'GetShap soll dir helfen, Freude an regelmäßiger Bewegung zu finden und so deinen eigenen körperlichen Zielen näherzukommen. Drei Dinge, bevor du anfängst:';

  @override
  String get consentPoint1 =>
      'Du trainierst auf eigenes Risiko – wie bei jedem Sport kann es zu Verletzungen kommen.';

  @override
  String get consentPoint2 =>
      'Die App legt den Schwierigkeitsgrad anhand deiner Antworten fest – das ist eine automatische Einstufung, keine fachliche Beurteilung, und sie berücksichtigt deinen Gesundheitszustand nicht. Die Inhalte wurden nicht von medizinischem Fachpersonal erstellt.';

  @override
  String get consentPoint3 =>
      'Wenn du gesundheitliche Probleme hast, sprich zuerst mit einer Ärztin oder einem Arzt. Und hör während des Trainings auf deinen Körper – wenn sich etwas nicht richtig anfühlt, hör auf.';

  @override
  String get consentCheckbox =>
      'Ich habe die Nutzungsbedingungen und den Gesundheitshinweis gelesen und akzeptiere sie. Mir ist bewusst, dass ich auf eigenes Risiko trainiere.';

  @override
  String get consentAccept => 'Akzeptieren und starten';

  @override
  String get consentUpdatedTitle => 'Neue Bedingungen';

  @override
  String get consentUpdatedBody =>
      'Die Nutzungsbedingungen und der Gesundheitshinweis wurden aktualisiert. Bitte lies sie und akzeptiere sie, um fortzufahren.';

  @override
  String get consentTermsLink => 'Nutzungsbedingungen';

  @override
  String get consentHealthLink => 'Gesundheitshinweis';

  @override
  String get consentPrivacyLink => 'Datenschutz';

  @override
  String get contact => 'Kontakt';

  @override
  String get legal => 'Rechtliches';

  @override
  String get infoIntro =>
      'Entwickelt von Marcell Bodnár.\nSchreib mir gern, wenn du Fragen oder Feedback hast:';

  @override
  String get instagramLink => '@bodnar__marcell';

  @override
  String get emailLink => 'marcell@getshap.com';

  @override
  String get wallPush => 'Wandliegestütze';

  @override
  String get tablePush => 'Liegestütze am Tisch';

  @override
  String get diamondTablePush => 'Diamant-Liegestütze am Tisch';

  @override
  String get kneePush => 'Knieliegestütze';

  @override
  String get pushUp => 'Liegestütze';

  @override
  String get declinePush => 'Liegestütze mit erhöhten Füßen';

  @override
  String get explosivePush => 'Explosive Liegestütze';

  @override
  String get pseudoPush => 'Pseudo-Planche-Liegestütze';

  @override
  String get dipPush => 'Dips';

  @override
  String get bagPull => 'Einarmiges Rudern mit Tasche';

  @override
  String get reverseSnowAngel => 'Reverse Snow Angels';

  @override
  String get chestBwPull => 'Rudern an brusthoher Stange';

  @override
  String get waistBwPull => 'Rudern an hüfthoher Stange';

  @override
  String get negPullUp => 'Negative Klimmzüge';

  @override
  String get pullUp => 'Klimmzüge';

  @override
  String get squat1 => 'Kniebeugen mit Festhalten';

  @override
  String get lunge1 => 'Ausfallschritte mit Festhalten';

  @override
  String get squat2 => 'Kniebeugen';

  @override
  String get lunge2 => 'Ausfallschritte';

  @override
  String get squat3 => 'Kniebeugen mit Rucksack';

  @override
  String get lunge3 => 'Ausfallschritte mit Rucksack';

  @override
  String get squat4 => 'Sprungkniebeugen';

  @override
  String get lunge4 => 'Bulgarische Kniebeugen';

  @override
  String get squat5 => 'Seitliche Kniebeugen';

  @override
  String get lunge5 => 'Bulgarische Kniebeugen mit Gewicht';

  @override
  String get glute1 => 'Beinheben nach hinten';

  @override
  String get glute2 => 'Beckenheben';

  @override
  String get glute3 => 'Beckenheben mit erhöhten Füßen';

  @override
  String get glute4 => 'Einbeiniges Beckenheben';

  @override
  String get glute5 => 'Einbeiniger Hip Thrust';

  @override
  String get core1 => 'Beinheben im Liegen';

  @override
  String get core2 => 'Beinheben in Bauchlage';

  @override
  String get workout => 'Training';

  @override
  String get noWorkout => 'Für heute keine Trainings mehr :)';

  @override
  String get nextWorkoutTitle => 'Nächstes Training';

  @override
  String get nextWorkoutTomorrow => 'Morgen kannst du wieder trainieren!';

  @override
  String nextWorkoutDays(int days) {
    return 'Noch $days Tage bis zum nächsten Training';
  }

  @override
  String get reps => 'Wiederholungen';

  @override
  String get testRepsHint =>
      'Mach so viele, wie du schaffst, und trag dann ein, wie viele es waren.';

  @override
  String get seconds => 'Sekunden';

  @override
  String get next => 'Weiter';

  @override
  String get save => 'Speichern';

  @override
  String saveConfirm(int reps) {
    String _temp0 = intl.Intl.pluralLogic(
      reps,
      locale: localeName,
      other: '$reps Wiederholungen',
      one: '$reps Wiederholung',
    );
    return 'Hast du wirklich $_temp0 geschafft?';
  }

  @override
  String get cancel => 'Abbrechen';

  @override
  String get goback => 'Zurück';

  @override
  String get startWorkout => 'Training starten';

  @override
  String get question => 'Frage';

  @override
  String get nextq => 'Nächste Frage';

  @override
  String get finish => 'Fertig';

  @override
  String get mainGoal => 'Was ist dein Hauptziel?';

  @override
  String get weightLoss => 'Abnehmen';

  @override
  String get muscleBuild => 'Muskelaufbau';

  @override
  String get genderQuestion => 'Was ist dein Geschlecht?';

  @override
  String get male => 'Männlich';

  @override
  String get female => 'Weiblich';

  @override
  String get maxKneePush => 'Wie viele Knieliegestütze schaffst du?';

  @override
  String get maxSquats => 'Wie viele Kniebeugen schaffst du?';

  @override
  String get prevExp1 => 'Hast du früher regelmäßig Sport gemacht?';

  @override
  String get yes => 'Ja';

  @override
  String get no => 'Nein';

  @override
  String get prevExp2 =>
      'Hast du schon einmal versucht, mit dem Training anzufangen?';

  @override
  String get motivation => 'Wie motiviert bist du zu trainieren?';

  @override
  String get notAtAll => 'Gar nicht';

  @override
  String get somewhat => 'Ein bisschen';

  @override
  String get motivated => 'Ich bin motiviert';

  @override
  String get age => 'Zu welcher Altersgruppe gehörst du?';

  @override
  String get workoutPlaceQuestion => 'Wo möchtest du ab jetzt trainieren?';

  @override
  String get workoutPlaceNote => 'Du kannst das später im Menü ändern.';

  @override
  String get atHome => 'Zu Hause';

  @override
  String get inPark => 'Im Park';

  @override
  String get workoutPlace => 'Trainingsort';

  @override
  String get congrat => 'Glückwunsch!';

  @override
  String get congratMessage => 'Du hast das heutige Training geschafft!';

  @override
  String get rpe1 => 'Sehr leicht';

  @override
  String get rpe23 => 'Leicht';

  @override
  String get rpe46 => 'Etwas anstrengend';

  @override
  String get rpe78 => 'Anstrengend';

  @override
  String get rpe910 => 'Sehr anstrengend';

  @override
  String get howWasTheWorkout => 'Wie anstrengend war das Training?';

  @override
  String get feedback => 'Feedback';

  @override
  String get workoutReminderTitle => 'Kurzes Training? 💪';

  @override
  String get workoutReminderBody =>
      'Du baust gerade eine Gewohnheit auf – bleib dran!';

  @override
  String get welcomeNotiTitle => 'Starte in dein Training';

  @override
  String get welcomeNotiBody => 'Es wird nicht schwer 😊';

  @override
  String get streakNotiTitle => 'Trainingsserie 🔥';

  @override
  String get streakNotiBody =>
      'Vergiss nicht, deine Trainingsserie zu verlängern';

  @override
  String get dontGiveUpNotiTitle => 'Gib nicht auf!';

  @override
  String get dontGiveUpNotiBody =>
      'Du hast dich entschieden, etwas zu verändern.';

  @override
  String get notis => 'Benachrichtigungen';

  @override
  String get notisAreImportant =>
      'Benachrichtigungen helfen dir, das Training zur Gewohnheit zu machen.';

  @override
  String get enableNotis => 'Erinnerungen aktivieren';

  @override
  String get wallPushDesc =>
      'Stell dich etwa einen Schritt von der Wand entfernt hin. Setz die Hände etwas breiter als schulterbreit auf, halte die Ellbogen etwa 30–45 Grad vom Körper entfernt und den Körper in einer geraden Linie. Geh so nah an die Wand, wie du kannst, und drück dich dann wieder weg.';

  @override
  String get tablePushDesc =>
      'Stütz die Hände etwas breiter als schulterbreit auf die Kante eines stabilen Tisches.\nHalte die Ellbogen in einem Winkel von 30–45 Grad zum Körper und den Körper in einer geraden Linie. Senk dich so tief ab, wie du kannst, und drück dich dann wieder hoch.\nJe niedriger die Fläche, auf die du die Hände stützt, desto schwerer wird die Übung.';

  @override
  String get diamondTablePushDesc =>
      'Stütz die Hände eng nebeneinander auf die Kante eines stabilen Tisches, sodass Zeigefinger und Daumen ein Dreieck bilden, und achte darauf, dass die Hände nicht nach vorne rutschen.\nHalte die Ellbogen nah am Körper und den Körper in einer geraden Linie. Senk dich so tief ab, wie du kannst, und drück dich dann wieder hoch.\nJe niedriger die Fläche, auf die du die Hände stützt, desto schwerer wird die Übung.';

  @override
  String get kneePushDesc =>
      'Knie dich auf etwas Weiches. Setz die Hände etwas breiter als schulterbreit auf, halte die Ellbogen etwa 30–45 Grad vom Körper entfernt und den Körper in einer geraden Linie. Geh so tief, wie du kannst, und drück dich dann wieder hoch.';

  @override
  String get pushUpDesc =>
      'Setz die Hände etwas breiter als schulterbreit auf, halte die Ellbogen etwa 30–45 Grad vom Körper entfernt und den Körper in einer geraden Linie. Geh so tief, wie du kannst, und drück dich dann wieder hoch.';

  @override
  String get declinePushDesc =>
      'Leg die Füße auf eine erhöhte Fläche (zum Beispiel ein Bett) und setz die Hände etwas breiter als schulterbreit auf. Halte die Ellbogen etwa 30–45 Grad vom Körper entfernt und den Körper in einer geraden Linie. Geh so tief, wie du kannst, und drück dich dann wieder hoch.';

  @override
  String get explosivePushDesc =>
      'Drück dich beim Liegestütz so kraftvoll vom Boden ab, wie du kannst.';

  @override
  String get pseudoPushDesc =>
      'Setz die Hände schulterbreit auf und dreh sie leicht nach außen.\nLehn dich nach vorne, sodass deine Hände irgendwo zwischen Schultern und Hüfte liegen. Drück die Schultern so weit wie möglich nach unten, und zwar auf zwei Arten: Drück sie zum Boden hin und zieh sie in Richtung Oberkörper nach unten. Versuch, diese Schulterposition während der ganzen Bewegung so gut wie möglich zu halten. Spann gleichzeitig den Bauch an.\nJe weiter du dich nach vorne lehnst, desto schwerer wird die Übung.';

  @override
  String get dipPushDesc =>
      'Greif die Holme so, dass die Mitte deiner Handflächen oben aufliegt. Drück die Schultern nach unten und halte sie die ganze Zeit so. Senk dich ab, bis deine Ellbogen mindestens 90 Grad gebeugt sind, und drück dich dann wieder hoch.';

  @override
  String get bagPullDesc =>
      'Füll eine Tasche mit Büchern oder kleinen Gewichten, mindestens 5–10 kg. Stütz dich mit einer Hand ab, den Oberkörper gerade und ungefähr waagerecht. Wenn du die Hand absenkst, sollte die Tasche möglichst nicht den Boden berühren. Halte beim Hochziehen die Schultern unten – lass sie nicht zu den Ohren hochwandern. Beug den Arm bis etwa 90°.\nWenn es dir zu leicht ist:\n• erhöhe das Gewicht\n• senk langsamer ab\n• mach mehr Wiederholungen\nMach die Übung auf beiden Seiten.';

  @override
  String get reverseSnowAngelDesc =>
      'Leg dich auf den Bauch. Heb Kopf und Hände an und bring die Hände über dem Kopf zusammen. Führ die Arme seitlich nach unten bis zur Hüfte und bring die Hände dann wieder über dem Kopf zusammen.\nEinmal hin und zurück zählt als eine Wiederholung.\nHalte die Hände während der ganzen Bewegung über dem Boden.\nUm es schwerer zu machen, nimm in jede Hand ein Buch.';

  @override
  String get chestBwPullDesc => '';

  @override
  String get waistBwPullDesc => '';

  @override
  String get negPullUpDesc => '';

  @override
  String get pullUpDesc => '';

  @override
  String get squat1Desc =>
      'Halte dich mit einer oder beiden Händen an etwas Stabilem fest. Stell dich schulterbreit hin, die Zehen leicht nach außen gedreht. Schieb zuerst die Knie leicht nach vorne und senk dich dann kontrolliert bis etwa 90° ab. Halte den Oberkörper dabei die ganze Zeit gerade.';

  @override
  String get lunge1Desc =>
      'Wechsle die Beine ab – zähl die Wiederholungen insgesamt, nicht pro Bein. Halte dich mit einer oder beiden Händen an etwas Stabilem fest. Mach einen Schritt nach hinten; dein vorderes Schienbein bleibt senkrecht. Dein Oberschenkel zeigt nach vorne. Lehn dich leicht nach vorne, damit die Belastung auf der Rückseite deines vorderen Beins liegt.';

  @override
  String get squat2Desc =>
      'Stell dich schulterbreit hin, die Zehen leicht nach außen gedreht. Schieb zuerst die Knie leicht nach vorne und senk dich dann kontrolliert bis etwa 90° ab. Halte den Oberkörper dabei die ganze Zeit gerade.';

  @override
  String get lunge2Desc =>
      'Wechsle die Beine ab – zähl die Wiederholungen insgesamt, nicht pro Bein. Mach einen Schritt nach hinten; dein vorderes Schienbein bleibt senkrecht. Dein Oberschenkel zeigt nach vorne. Lehn dich leicht nach vorne, damit die Belastung auf der Rückseite deines vorderen Beins liegt.';

  @override
  String get squat3Desc =>
      'Füll einen Rucksack mit Büchern oder anderen Gewichten. Stell dich schulterbreit hin, die Zehen leicht nach außen gedreht. Schieb zuerst die Knie leicht nach vorne und senk dich dann kontrolliert bis etwa 90° ab. Halte den Oberkörper dabei die ganze Zeit gerade.';

  @override
  String get lunge3Desc =>
      'Wechsle die Beine ab – zähl die Wiederholungen insgesamt, nicht pro Bein. Füll einen Rucksack mit Büchern oder anderen Gewichten. Mach einen Schritt nach hinten; dein vorderes Schienbein bleibt senkrecht. Dein Oberschenkel zeigt nach vorne. Lehn dich leicht nach vorne, damit die Belastung auf der Rückseite deines vorderen Beins liegt.';

  @override
  String get squat4Desc =>
      'Spring aus der Kniebeuge hoch. Stell dich schulterbreit hin, die Zehen leicht nach außen gedreht. Schieb zuerst die Knie leicht nach vorne und senk dich dann kontrolliert bis etwa 90° ab. Halte den Oberkörper dabei die ganze Zeit gerade. Wenn du willst, trag dabei einen Rucksack mit Gewichten.';

  @override
  String get lunge4Desc =>
      'Leg dein hinteres Bein auf einen Stuhl. Der hintere Fuß stützt sich auf den Zehen ab, der vordere zeigt nach vorne. Stell die Füße leicht versetzt statt auf eine Linie, so hältst du besser das Gleichgewicht. Halte das vordere Schienbein senkrecht, der Oberschenkel zeigt nach vorne. Lehn dich leicht nach vorne, damit das Gewicht auf der Rückseite deines vorderen Beins liegt. Mach die Übung auf beiden Seiten.';

  @override
  String get squat5Desc =>
      'Stell dich breitbeinig hin, die Zehen leicht nach außen gedreht. Beginn die Abwärtsbewegung, indem du ein Knie beugst. Halte den Oberkörper so aufrecht wie möglich.';

  @override
  String get lunge5Desc =>
      'Füll eine Tasche mit Büchern oder anderen Gewichten. Leg dein hinteres Bein auf einen Stuhl. Der hintere Fuß stützt sich auf den Zehen ab, der vordere zeigt nach vorne. Stell die Füße leicht versetzt statt auf eine Linie, so hältst du besser das Gleichgewicht. Halte das vordere Schienbein senkrecht, der Oberschenkel zeigt nach vorne. Lehn dich leicht nach vorne, damit das Gewicht auf der Rückseite deines vorderen Beins liegt. Mach die Übung auf beiden Seiten.';

  @override
  String get glute1Desc =>
      'Halte dich an einem Tisch fest, lehn dich leicht nach vorne und streck das Bein gerade nach hinten.\nDenk daran, es mit beiden Beinen zu machen.';

  @override
  String get glute2Desc =>
      'Leg dich mit angewinkelten Knien auf den Rücken. Leg die Arme etwas seitlich ab, das gibt dir mehr Stabilität.\nDrück die Hüfte so hoch, wie du kannst, spann dabei den Po an und senk sie dann wieder ab.';

  @override
  String get glute3Desc =>
      'Leg dich mit angewinkelten Knien auf den Rücken und stell die Füße auf eine erhöhte Fläche, zum Beispiel die Kante eines Sofas. Leg die Arme etwas seitlich ab, das gibt dir mehr Stabilität.\nDrück die Hüfte so hoch, wie du kannst, spann dabei den Po an und senk die Hüfte dann wieder ab.';

  @override
  String get glute4Desc =>
      'Leg dich mit angewinkelten Knien auf den Rücken und streck dann ein Bein aus, sodass es in der Luft bleibt. Leg die Arme etwas seitlich ab, das gibt dir mehr Stabilität.\nDrück die Hüfte so hoch, wie du kannst, spann dabei den Po an und senk die Hüfte dann wieder ab.\nDenk daran, es mit beiden Beinen zu machen.';

  @override
  String get glute5Desc =>
      'Setz dich so vor ein Sofa oder Bett, dass die Kante an deinem oberen Rücken anliegt. Ein Bein bleibt angewinkelt, das andere streckst du aus.\nDrück die Hüfte mit einem Bein so hoch, wie du kannst, spann dabei den Po an und heb auch den anderen Fuß vom Boden ab. Senk dich dann wieder ab.\nDenk daran, es mit beiden Beinen zu machen.';

  @override
  String get core1Desc =>
      'Leg die Hände unter deine Hüfte und heb den Kopf an. Spann den Bauch an und heb die Beine, aber nicht ganz bis zur Senkrechten. Senk die Beine kontrolliert ab und leg sie zwischen den Wiederholungen nicht auf dem Boden ab. Mit gebeugten Knien ist es leichter.';

  @override
  String get core2Desc =>
      'Leg dich mit dem Bauch auf einen Stuhl und halte dich an seinen Beinen fest. Heb die Beine mit gebeugten Knien hinter dir so hoch, wie du kannst.';

  @override
  String get lightBagPull => 'Einarmiges Rudern mit leichterer Tasche';

  @override
  String get runInPlace => 'Laufen auf der Stelle';

  @override
  String get warmupDesc =>
      'Führ die Übung kontrolliert aus. Achte auf eine saubere Technik.';

  @override
  String get warmup => 'Aufwärmen';

  @override
  String get understand => 'Verstanden';

  @override
  String get important => 'Wichtig';

  @override
  String get finishWarning =>
      'Drück erst auf „Fertig“, wenn du das Training wirklich abgeschlossen hast.\n\nDas ist eine Rückmeldung für die App.';

  @override
  String get tip => 'Tipp';

  @override
  String tipWithType(String type) {
    return 'Tipp: $type';
  }

  @override
  String get tipTypePrinciples => 'Mindset';

  @override
  String get tipTypeWorkout => 'Training';

  @override
  String get tipTypeDiet => 'Ernährung';

  @override
  String get tipLibrary => 'Tippsammlung';

  @override
  String get noTipsYet => 'Einen solchen Tipp hast du noch nicht bekommen.';

  @override
  String get principles1 =>
      'Das wichtigste Ziel: Hör nie ganz auf – das ist der einzige sichere Weg, dorthin zu kommen, wo du hinwillst.';

  @override
  String get principles2 =>
      'Ein leichtes Training ist besser, als es ganz ausfallen zu lassen.';

  @override
  String get principles3 =>
      'Wenn sich das Training wie eine Gewohnheit anfühlt, kannst du langsam darauf aufbauen.';

  @override
  String get principles4 =>
      'Ein fitterer Körper tut deiner mentalen und deiner körperlichen Gesundheit gut.';

  @override
  String get beginnerWorkout1 =>
      'Eine miserable Technik kann zu Verletzungen führen – versuch, die Übungen zumindest ordentlich auszuführen.';

  @override
  String get beginnerWorkout2 =>
      'Mach zwischen den Übungen 30 Sekunden bis 2 Minuten Pause – so kommt ein Teil deiner Kraft zurück, und das Training dauert trotzdem nicht zu lange.';

  @override
  String get beginnerDiet1 =>
      'Wenn du abnehmen willst, kauf dir zuckerfreie Limonaden und trink sie, wann immer es geht, statt zuckerhaltiger Getränke und anderer Süßigkeiten – sie stillen die Lust auf Süßes und haben fast 0 Kalorien.';

  @override
  String get beginnerDiet2 =>
      'Wenn du abnehmen willst, deck dich mit Obst und Gemüse ein, das du wirklich magst – es hat wenige Kalorien, füllt aber gut den Magen, sodass du danach weniger Hunger hast.';

  @override
  String get advancedWorkout1 =>
      'Vier große Muskelgruppen: Drücken, Ziehen, Rumpf und Beine.\n\nDrückübungen sind Liegestütz-Varianten, Dips, Bankdrücken und andere Übungen, bei denen du etwas von deinem Körper wegdrückst. Sie trainieren vor allem die Brust, den Trizeps und die vordere Schulter.\n\nZugübungen wie Rudern mit Tasche oder Klimmzüge sind die, bei denen du etwas zu deinem Körper heranziehst. Sie trainieren vor allem den Rücken, den Bizeps und die hintere Schulter. Es gibt zwei Hauptarten: vertikales Ziehen (Klimmzüge) und horizontales Ziehen (Rudern mit Tasche).\n\nZu deiner Rumpfmuskulatur gehören Bauch, unterer Rücken und seitliche Bauchmuskeln. Sie werden bei den meisten Körpergewichtsübungen mittrainiert, etwa bei Liegestützen und Klimmzügen, du kannst aber auch gezielte Übungen für sie machen.\n\nDeine Beine haben 4 große Muskeln: Quadrizeps, Beinbizeps, Gesäßmuskeln und Waden. Kniebeugen trainieren den Quadrizeps sehr gut, Hip Thrusts und Beckenheben vor allem die Gesäßmuskeln. Am wirksamsten für den Beinbizeps sind Übungen, bei denen du das Bein beugst, aber dafür gibt es mit Mitteln für zu Hause keine Alternative. Ausfallschritte (wie in der App) und Hip Thrusts bzw. Beckenheben zusammen trainieren ihn aber ausreichend gut. Für die Waden gibt es in der App keine eigene Übung, weil sie beim Laufen gut trainiert werden und bei den anderen Übungen ein wenig mit.';

  @override
  String get advancedWorkout2 =>
      'Aufwärmen steigert deine Leistung und senkt das Verletzungsrisiko.';

  @override
  String get advancedWorkout3 =>
      'Wenn dir Abnehmen wichtiger ist als Muskelaufbau: Du kannst die Beinübungen durch Joggen ersetzen – oder beides machen. Joggen verbrennt mehr Kalorien. Aber jogg nicht zu viel, wenn es dir keinen Spaß macht.';

  @override
  String get advancedWorkout4 =>
      'Achte beim Aufwärmen auf deine Technik – nutz die Zeit, um die Bewegungen so sauber wie möglich auszuführen, damit sich deine Technik verbessert.';

  @override
  String get advancedDiet1 =>
      'Trainier am besten etwa 2 Stunden nach einer Mahlzeit. Nach einem großen Mittagessen wartest du besser noch länger – so hast du Energie für das Training, und deine Verdauung stört dich nicht.';

  @override
  String get advancedDiet2 =>
      'Kalorien rein, Kalorien raus – wenn du mehr Energie verbrennst, als du aufnimmst, nimmst du ab.';

  @override
  String get advancedDiet3 =>
      'Mehr Eiweiß hilft beim Muskelaufbau und beim Abnehmen – es unterstützt das Muskelwachstum und hilft dir, in einer Diät deine Muskeln zu halten.';

  @override
  String get advancedDiet4 =>
      'Übertreib es nicht mit der Diät – zwing dich nicht zu einer Diät, von der du glaubst, dass du sie nicht langfristig durchhalten kannst.';

  @override
  String get advancedDiet5 =>
      'Wenn du abnehmen willst, wieg dich jeden Tag ungefähr zur gleichen Zeit – Essen, Trinken und der Gang zur Toilette können dein Gewicht innerhalb weniger Stunden um ein paar Kilo verändern, ohne dass du tatsächlich Fett verbrannt hast.';

  @override
  String get advancedDiet6 =>
      'Wenn du abnehmen willst, notier dein Gewicht irgendwo – am besten in Excel oder Google Tabellen, wo du leicht Wochendurchschnitte berechnen kannst. Wenn dein Gewicht in den letzten Wochen nicht gesunken ist, versuch, mehr Obst und Gemüse und weniger Süßes zu essen oder mehr zu joggen.';

  @override
  String get workoutStreak => 'Trainingsserie';

  @override
  String get streakFreeze => 'Serienschutz';

  @override
  String get updateReadyMessage => 'Ein Update wurde heruntergeladen.';

  @override
  String get updateRestart => 'Neu starten';

  @override
  String get updateAvailableTitle => 'Update verfügbar';

  @override
  String get updateAvailableMessage =>
      'Im App Store ist eine neue Version der App verfügbar.';

  @override
  String get updateNow => 'Aktualisieren';

  @override
  String get updateLater => 'Später';
}
