// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get form => 'Voici le formulaire';

  @override
  String get consentTitle => 'Avant de commencer';

  @override
  String get consentIntro =>
      'GetShap est là pour t\'aider à prendre goût à l\'exercice régulier et, grâce à lui, à avancer vers tes propres objectifs physiques. Trois choses avant de commencer :';

  @override
  String get consentPoint1 =>
      'Tu t\'entraînes à tes propres risques – comme pour tout exercice physique, des blessures peuvent survenir.';

  @override
  String get consentPoint2 =>
      'L\'app règle la difficulté d\'après tes réponses – c\'est un classement automatique, pas une évaluation professionnelle, et il ne tient pas compte de ton état de santé. Le contenu n\'a pas été préparé par un professionnel de santé.';

  @override
  String get consentPoint3 =>
      'Si tu as un problème de santé, parles-en d\'abord à ton médecin. Et pendant l\'entraînement, écoute ton corps – si quelque chose ne va pas, arrête-toi.';

  @override
  String get consentCheckbox =>
      'J\'ai lu et j\'accepte les Conditions d\'utilisation et l\'Avertissement santé, et je comprends que je m\'entraîne à mes propres risques.';

  @override
  String get consentAccept => 'Accepter et commencer';

  @override
  String get consentUpdatedTitle => 'Nos conditions ont changé';

  @override
  String get consentUpdatedBody =>
      'Les Conditions d\'utilisation et l\'Avertissement santé ont été mis à jour. Lis-les et accepte-les pour continuer.';

  @override
  String get consentTermsLink => 'Conditions d\'utilisation';

  @override
  String get consentHealthLink => 'Avertissement santé';

  @override
  String get consentPrivacyLink => 'Confidentialité';

  @override
  String get contact => 'Contact';

  @override
  String get legal => 'Mentions légales';

  @override
  String get infoIntro =>
      'Créé par Marcell Bodnár.\nN\'hésite pas à m\'écrire pour une question ou un retour :';

  @override
  String get instagramLink => '@bodnar__marcell';

  @override
  String get emailLink => 'marcell@getshap.com';

  @override
  String get wallPush => 'Pompes contre le mur';

  @override
  String get tablePush => 'Pompes sur une table';

  @override
  String get diamondTablePush => 'Pompes diamant sur une table';

  @override
  String get kneePush => 'Pompes sur les genoux';

  @override
  String get pushUp => 'Pompes';

  @override
  String get declinePush => 'Pompes déclinées';

  @override
  String get explosivePush => 'Pompes explosives';

  @override
  String get pseudoPush => 'Pompes pseudo-planche';

  @override
  String get dipPush => 'Dips';

  @override
  String get bagPull => 'Rowing unilatéral avec un sac';

  @override
  String get reverseSnowAngel => 'Anges des neiges inversés';

  @override
  String get bwPull => 'Rowing inversé';

  @override
  String get pullup => 'Tractions';

  @override
  String get squat1 => 'Squats assistés';

  @override
  String get lunge1 => 'Fentes assistées';

  @override
  String get squat2 => 'Squats';

  @override
  String get lunge2 => 'Fentes';

  @override
  String get squat3 => 'Squats avec sac à dos';

  @override
  String get lunge3 => 'Fentes avec sac à dos';

  @override
  String get squat4 => 'Squats sautés';

  @override
  String get lunge4 => 'Fentes bulgares';

  @override
  String get squat5 => 'Squats latéraux';

  @override
  String get lunge5 => 'Fentes bulgares lestées';

  @override
  String get glute1 => 'Kickbacks fessiers';

  @override
  String get glute2 => 'Pont fessier';

  @override
  String get glute3 => 'Pont fessier pieds surélevés';

  @override
  String get glute4 => 'Pont fessier sur une jambe';

  @override
  String get glute5 => 'Hip thrust sur une jambe';

  @override
  String get core1 => 'Relevés de jambes allongé';

  @override
  String get core2 => 'Relevés de jambes inversés';

  @override
  String get workout => 'Entraînement';

  @override
  String get noWorkout => 'Plus d\'entraînement pour aujourd\'hui :)';

  @override
  String get nextWorkoutTitle => 'Prochain entraînement';

  @override
  String get nextWorkoutTomorrow =>
      'Tu pourras t\'entraîner à nouveau demain !';

  @override
  String nextWorkoutDays(int days) {
    return 'Prochain entraînement dans $days jours';
  }

  @override
  String get reps => 'Répétitions';

  @override
  String get seconds => 'Secondes';

  @override
  String get next => 'Suivant';

  @override
  String get goback => 'Retour';

  @override
  String get startWorkout => 'Commencer';

  @override
  String get question => 'Question';

  @override
  String get nextq => 'Question suivante';

  @override
  String get finish => 'Terminer';

  @override
  String get mainGoal => 'Quel est ton objectif principal ?';

  @override
  String get weightLoss => 'Perdre du poids';

  @override
  String get muscleBuild => 'Prendre du muscle';

  @override
  String get genderQuestion => 'Quel est ton sexe ?';

  @override
  String get male => 'Homme';

  @override
  String get female => 'Femme';

  @override
  String get maxKneePush => 'Combien de pompes sur les genoux peux-tu faire ?';

  @override
  String get maxSquats => 'Combien de squats peux-tu faire ?';

  @override
  String get prevExp1 => 'Faisais-tu du sport régulièrement avant ?';

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get prevExp2 => 'As-tu déjà essayé de t\'entraîner ?';

  @override
  String get motivation => 'À quel point as-tu envie de t\'entraîner ?';

  @override
  String get notAtAll => 'Pas du tout';

  @override
  String get somewhat => 'Un peu';

  @override
  String get motivated => 'Beaucoup';

  @override
  String get age => 'Quelle est ta tranche d\'âge ?';

  @override
  String get congrat => 'Félicitations !';

  @override
  String get congratMessage => 'Tu as terminé l\'entraînement du jour !';

  @override
  String get rpe1 => 'Très léger';

  @override
  String get rpe23 => 'Léger';

  @override
  String get rpe46 => 'Modéré';

  @override
  String get rpe78 => 'Intense';

  @override
  String get rpe910 => 'Très intense';

  @override
  String get howWasTheWorkout => 'L\'entraînement était-il difficile ?';

  @override
  String get feedback => 'Ressenti';

  @override
  String get workoutReminderTitle => 'Une petite séance ? 💪';

  @override
  String get workoutReminderBody =>
      'Tu es en train de créer une habitude – continue !';

  @override
  String get welcomeNotiTitle => 'Lance-toi dans ton entraînement';

  @override
  String get welcomeNotiBody => 'Ce ne sera pas difficile 😊';

  @override
  String get streakNotiTitle => 'Série d\'entraînements 🔥';

  @override
  String get streakNotiBody =>
      'N\'oublie pas de prolonger ta série d\'entraînements';

  @override
  String get dontGiveUpNotiTitle => 'N\'abandonne pas !';

  @override
  String get dontGiveUpNotiBody => 'Tu as décidé de changer.';

  @override
  String get notis => 'Notifications';

  @override
  String get notisAreImportant =>
      'Les notifications t\'aident à prendre l\'habitude de t\'entraîner.';

  @override
  String get enableNotis => 'Activer les notifications';

  @override
  String get wallPushDesc =>
      'Place-toi à environ un pas du mur. Pose les mains un peu plus écartées que la largeur des épaules, garde les coudes à environ 30–45 degrés du corps et le corps bien aligné. Rapproche-toi du mur autant que tu peux, puis repousse-toi.';

  @override
  String get tablePushDesc =>
      'Pose les mains sur le bord d\'une table stable, un peu plus écartées que la largeur des épaules.\nGarde les coudes à un angle de 30 à 45 degrés par rapport au corps et le corps bien aligné. Descends aussi bas que tu peux, puis remonte en poussant.\nPlus la surface sur laquelle tu poses les mains est basse, plus l\'exercice est difficile.';

  @override
  String get diamondTablePushDesc =>
      'Pose les mains sur le bord d\'une table stable, rapprochées l\'une de l\'autre, de sorte que tes index et tes pouces forment un triangle, et veille à ce que tes mains ne glissent pas vers l\'avant.\nGarde les coudes près du corps et le corps bien aligné. Descends aussi bas que tu peux, puis remonte en poussant.\nPlus la surface sur laquelle tu poses les mains est basse, plus l\'exercice est difficile.';

  @override
  String get kneePushDesc =>
      'Mets-toi à genoux sur quelque chose de moelleux. Pose les mains un peu plus écartées que la largeur des épaules, garde les coudes à environ 30–45 degrés du corps et le corps bien aligné. Descends aussi bas que tu peux, puis remonte en poussant.';

  @override
  String get pushUpDesc =>
      'Pose les mains un peu plus écartées que la largeur des épaules, garde les coudes à environ 30–45 degrés du corps et le corps bien aligné. Descends aussi bas que tu peux, puis remonte en poussant.';

  @override
  String get declinePushDesc =>
      'Pose les pieds sur une surface surélevée (comme un lit) et les mains un peu plus écartées que la largeur des épaules. Garde les coudes à environ 30–45 degrés du corps et le corps bien aligné. Descends aussi bas que tu peux, puis remonte en poussant.';

  @override
  String get explosivePushDesc =>
      'Pendant la pompe, pousse aussi fort que tu peux pour décoller du sol.';

  @override
  String get pseudoPushDesc =>
      'Place les mains à la largeur des épaules et tourne-les légèrement vers l\'extérieur.\nPenche-toi en avant pour que tes mains se trouvent quelque part entre tes épaules et tes hanches. Abaisse tes épaules autant que possible, de deux façons : pousse-les vers le sol et tire-les vers le bas, en direction de ton buste. Essaie de garder cette position des épaules du mieux que tu peux pendant tout le mouvement. En même temps, contracte tes abdos.\nPlus tu te penches en avant, plus l\'exercice est difficile.';

  @override
  String get dipPushDesc =>
      'Tiens les barres avec le centre de tes paumes posé dessus. Garde les épaules basses et maintiens cette position tout au long du mouvement. Descends jusqu\'à ce que tes coudes soient fléchis à au moins 90 degrés, puis remonte en poussant.';

  @override
  String get bagPullDesc =>
      'Remplis un sac de livres ou de petits poids, au moins 5–10 kg. Appuie-toi sur une main, le buste droit et à peu près à l\'horizontale. Quand tu baisses la main, essaie de garder le sac au-dessus du sol. Pendant la montée, garde les épaules basses – ne les laisse pas remonter vers les oreilles. Plie le bras à environ 90°.\nSi c\'est trop facile :\n• augmente le poids\n• descends plus lentement\n• fais plus de répétitions\nFais-le des deux côtés.';

  @override
  String get reverseSnowAngelDesc =>
      'Allonge-toi sur le ventre. Lève la tête et les mains, et joins les mains au-dessus de ta tête. Ramène les bras sur les côtés jusqu\'aux hanches, puis joins à nouveau les mains au-dessus de ta tête.\nUn aller-retour complet compte pour une répétition.\nGarde les mains décollées du sol pendant tout le mouvement.\nPour rendre l\'exercice plus difficile, tiens un livre dans chaque main.';

  @override
  String get bwPullDesc => '';

  @override
  String get pullupDesc => '';

  @override
  String get squat1Desc =>
      'Tiens-toi à quelque chose de stable avec une main ou les deux. Place les pieds à la largeur des épaules, pointes légèrement tournées vers l\'extérieur. Commence par avancer légèrement les genoux, puis descends de façon contrôlée jusqu\'à environ 90°. Garde le buste droit tout au long du mouvement.';

  @override
  String get lunge1Desc =>
      'Alterne les jambes – compte le total des répétitions, pas par jambe. Tiens-toi à quelque chose de stable avec une main ou les deux. Fais un pas en arrière en gardant le tibia avant vertical. Ta cuisse doit pointer vers l\'avant. Penche-toi légèrement en avant pour que l\'effort porte sur l\'arrière de ta jambe avant.';

  @override
  String get squat2Desc =>
      'Place les pieds à la largeur des épaules, pointes légèrement tournées vers l\'extérieur. Commence par avancer légèrement les genoux, puis descends de façon contrôlée jusqu\'à environ 90°. Garde le buste droit tout au long du mouvement.';

  @override
  String get lunge2Desc =>
      'Alterne les jambes – compte le total des répétitions, pas par jambe. Fais un pas en arrière en gardant le tibia avant vertical. Ta cuisse doit pointer vers l\'avant. Penche-toi légèrement en avant pour que l\'effort porte sur l\'arrière de ta jambe avant.';

  @override
  String get squat3Desc =>
      'Remplis un sac à dos de livres ou d\'autres poids. Place les pieds à la largeur des épaules, pointes légèrement tournées vers l\'extérieur. Commence par avancer légèrement les genoux, puis descends de façon contrôlée jusqu\'à environ 90°. Garde le buste droit tout au long du mouvement.';

  @override
  String get lunge3Desc =>
      'Alterne les jambes – compte le total des répétitions, pas par jambe. Remplis un sac à dos de livres ou d\'autres poids. Fais un pas en arrière en gardant le tibia avant vertical. Ta cuisse doit pointer vers l\'avant. Penche-toi légèrement en avant pour que l\'effort porte sur l\'arrière de ta jambe avant.';

  @override
  String get squat4Desc =>
      'Saute pendant le squat. Place les pieds à la largeur des épaules, pointes légèrement tournées vers l\'extérieur. Commence par avancer légèrement les genoux, puis descends de façon contrôlée jusqu\'à environ 90°. Garde le buste droit tout au long du mouvement. Si tu veux, porte un sac à dos rempli de poids.';

  @override
  String get lunge4Desc =>
      'Pose ta jambe arrière sur une chaise. Ton pied arrière repose sur les orteils, ton pied avant pointe vers l\'avant. Garde les pieds légèrement écartés plutôt qu\'alignés, pour un meilleur équilibre. Garde le tibia avant vertical et la cuisse pointée vers l\'avant. Penche-toi légèrement en avant pour que le poids porte sur l\'arrière de ta jambe avant. Fais-le des deux côtés.';

  @override
  String get squat5Desc =>
      'Écarte les pieds, pointes légèrement tournées vers l\'extérieur. Commence la descente en pliant un genou. Garde le haut du corps aussi droit que possible.';

  @override
  String get lunge5Desc =>
      'Remplis un sac de livres ou d\'autres poids. Pose ta jambe arrière sur une chaise. Ton pied arrière repose sur les orteils, ton pied avant pointe vers l\'avant. Garde les pieds légèrement écartés plutôt qu\'alignés, pour un meilleur équilibre. Garde le tibia avant vertical et la cuisse pointée vers l\'avant. Penche-toi légèrement en avant pour que le poids porte sur l\'arrière de ta jambe avant. Fais-le des deux côtés.';

  @override
  String get glute1Desc =>
      'Tiens-toi à une table, penche-toi légèrement en avant et tends la jambe droit vers l\'arrière.\nN\'oublie pas de le faire avec les deux jambes.';

  @override
  String get glute2Desc =>
      'Allonge-toi sur le dos, genoux pliés. Écarte légèrement les bras sur les côtés pour plus de stabilité.\nMonte les hanches aussi haut que tu peux en contractant les fessiers, puis redescends.';

  @override
  String get glute3Desc =>
      'Allonge-toi sur le dos, genoux pliés, les pieds sur une surface surélevée comme le bord d\'un canapé. Écarte légèrement les bras sur les côtés pour plus de stabilité.\nMonte les hanches aussi haut que tu peux en contractant les fessiers, puis redescends les hanches.';

  @override
  String get glute4Desc =>
      'Allonge-toi sur le dos, genoux pliés, puis tends une jambe en la gardant en l\'air. Écarte légèrement les bras sur les côtés pour plus de stabilité.\nMonte les hanches aussi haut que tu peux en contractant les fessiers, puis redescends les hanches.\nN\'oublie pas de le faire avec les deux jambes.';

  @override
  String get glute5Desc =>
      'Assieds-toi devant un canapé ou un lit, de sorte que le bord soit contre le haut de ton dos. Garde une jambe pliée et tends l\'autre.\nMonte les hanches aussi haut que tu peux avec une seule jambe en contractant les fessiers, en décollant aussi l\'autre pied du sol, puis redescends.\nN\'oublie pas de le faire avec les deux jambes.';

  @override
  String get core1Desc =>
      'Place les mains sous tes hanches et soulève la tête. Contracte les abdos et lève les jambes, mais pas jusqu\'à la verticale. Redescends les jambes de façon contrôlée et ne les pose pas au sol entre les répétitions. Avec les genoux pliés, c\'est plus facile.';

  @override
  String get core2Desc =>
      'Allonge-toi sur le ventre sur une chaise et tiens-toi à ses pieds. Genoux pliés, lève les jambes derrière toi aussi haut que tu peux.';

  @override
  String get lightBagPull => 'Rowing unilatéral avec un sac plus léger';

  @override
  String get runInPlace => 'Course sur place';

  @override
  String get warmupDesc =>
      'Fais l\'exercice de façon contrôlée. Veille à garder une bonne technique.';

  @override
  String get warmup => 'Échauffement';

  @override
  String get understand => 'J\'ai compris';

  @override
  String get important => 'Important';

  @override
  String get finishWarning =>
      'N\'appuie sur le bouton « Terminer » qu\'une fois l\'entraînement vraiment terminé.\n\nC\'est un retour pour l\'app.';

  @override
  String get tip => 'Conseil';

  @override
  String tipWithType(String type) {
    return 'Conseil $type';
  }

  @override
  String get tipTypePrinciples => 'Mental';

  @override
  String get tipTypeWorkout => 'Entraînement';

  @override
  String get tipTypeDiet => 'Nutrition';

  @override
  String get tipLibrary => 'Bibliothèque de conseils';

  @override
  String get noTipsYet => 'Tu n\'as pas encore reçu de conseil de ce type.';

  @override
  String get principles1 =>
      'Objectif principal : ne jamais tout arrêter – c\'est le seul moyen sûr d\'arriver là où tu veux.';

  @override
  String get principles2 =>
      'Un entraînement facile vaut mieux que pas d\'entraînement du tout.';

  @override
  String get principles3 =>
      'Quand l\'entraînement commence à devenir une habitude, tu peux peu à peu en faire plus.';

  @override
  String get principles4 =>
      'Un corps en meilleure forme fait du bien à ta santé mentale comme à ta santé physique.';

  @override
  String get beginnerWorkout1 =>
      'Une très mauvaise technique peut entraîner des blessures – essaie de faire les exercices au moins correctement.';

  @override
  String get beginnerWorkout2 =>
      'Repose-toi entre 30 secondes et 2 minutes entre les exercices – tu récupères ainsi une partie de tes forces, sans que tes entraînements ne durent trop longtemps.';

  @override
  String get beginnerDiet1 =>
      'Si tu veux perdre du poids, prends des sodas zéro sucre et, dès que tu peux, bois-les à la place des boissons sucrées et des autres sucreries – ils calment tes envies de sucre tout en ayant presque 0 calorie.';

  @override
  String get beginnerDiet2 =>
      'Si tu veux perdre du poids, fais le plein de fruits et de légumes que tu aimes vraiment – ils sont peu caloriques mais remplissent bien l\'estomac, donc tu auras moins faim ensuite.';

  @override
  String get advancedWorkout1 =>
      'Quatre grands groupes musculaires : poussée, tirage, tronc et jambes.\n\nLes exercices de poussée, ce sont les variantes de pompes, les dips, le développé couché et les autres exercices où tu éloignes quelque chose de ton corps en poussant. Ils travaillent surtout les pectoraux, les triceps et l\'avant des épaules.\n\nLes exercices de tirage, comme le rowing avec un sac ou les tractions, sont ceux où tu rapproches quelque chose de ton corps. Ils travaillent surtout le dos, les biceps et l\'arrière des épaules. Il en existe deux grands types : le tirage vertical (tractions) et le tirage horizontal (rowing avec un sac).\n\nLes muscles du tronc, ce sont les abdos, le bas du dos et les obliques. Ils travaillent dans la plupart des exercices au poids du corps, comme les pompes et les tractions, mais tu peux aussi faire des exercices spécifiques pour eux.\n\nTes jambes ont 4 grands muscles : quadriceps, ischio-jambiers, fessiers et mollets. Les squats travaillent très bien les quadriceps, et le hip thrust et le pont fessier ciblent surtout les fessiers. Les exercices les plus efficaces pour les ischio-jambiers sont ceux où tu plies la jambe, mais il n\'existe pas d\'alternative avec le matériel qu\'on a à la maison. En revanche, les fentes (présentes dans l\'app) combinées au hip thrust et au pont fessier les travaillent suffisamment bien. Les mollets n\'ont pas d\'exercice dédié dans l\'app, car la course à pied les travaille bien, et les autres exercices un peu aussi.';

  @override
  String get advancedWorkout2 =>
      'L\'échauffement améliore tes performances et réduit le risque de blessure.';

  @override
  String get advancedWorkout3 =>
      'Si perdre du poids compte plus pour toi que prendre du muscle : tu peux remplacer les exercices de jambes par du footing – ou faire les deux. Le footing brûle plus de calories. Mais ne cours pas trop si tu n\'aimes pas ça.';

  @override
  String get advancedWorkout4 =>
      'Pendant l\'échauffement, fais attention à ta technique – profites-en pour exécuter les mouvements le plus parfaitement possible, afin d\'améliorer ta technique.';

  @override
  String get advancedDiet1 =>
      'Essaie de t\'entraîner environ 2 heures après un repas. Après un gros déjeuner, tu peux même attendre plus longtemps – tu auras ainsi de l\'énergie pour l\'entraînement, et ta digestion ne te gênera pas.';

  @override
  String get advancedDiet2 =>
      'Calories entrées, calories dépensées – si tu brûles plus d\'énergie que tu n\'en consommes, tu perds du poids.';

  @override
  String get advancedDiet3 =>
      'Manger plus de protéines aide à la fois à prendre du muscle et à perdre du poids – elles favorisent la croissance musculaire et t\'aident à garder tes muscles pendant une sèche.';

  @override
  String get advancedDiet4 =>
      'N\'en fais pas trop avec le régime – ne t\'impose pas un régime que tu ne te sens pas capable de tenir sur le long terme.';

  @override
  String get advancedDiet5 =>
      'Si tu veux perdre du poids, pèse-toi tous les jours à peu près à la même heure – les repas, l\'hydratation et le passage aux toilettes peuvent faire varier ton poids de quelques kilos en quelques heures, sans que tu aies brûlé la moindre graisse.';

  @override
  String get advancedDiet6 =>
      'Si tu veux perdre du poids, note ton poids quelque part – idéalement dans Excel ou Google Sheets, où tu peux facilement calculer des moyennes hebdomadaires. Si ton poids n\'a pas tendance à baisser depuis quelques semaines, essaie de manger plus de fruits et de légumes, moins de produits sucrés, ou de faire plus de footing.';

  @override
  String get workoutStreak => 'série d\'entraînements';

  @override
  String get streakFreeze => 'Gel de série';

  @override
  String get updateReadyMessage => 'Une mise à jour a été téléchargée.';

  @override
  String get updateRestart => 'Redémarrer';

  @override
  String get updateAvailableTitle => 'Mise à jour disponible';

  @override
  String get updateAvailableMessage =>
      'Une nouvelle version de l\'app est disponible sur l\'App Store.';

  @override
  String get updateNow => 'Mettre à jour';

  @override
  String get updateLater => 'Plus tard';
}
