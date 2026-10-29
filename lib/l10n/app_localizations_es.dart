// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get form => 'Aquí está el formulario';

  @override
  String get consentTitle => 'Antes de empezar';

  @override
  String get consentIntro =>
      'GetShap está aquí para ayudarte a disfrutar del ejercicio regular y, a través de él, avanzar hacia tus propias metas físicas. Tres cosas antes de empezar:';

  @override
  String get consentPoint1 =>
      'Entrenas bajo tu propio riesgo – como con cualquier ejercicio, pueden ocurrir lesiones.';

  @override
  String get consentPoint2 =>
      'La app ajusta la dificultad según tus respuestas – es una clasificación automática, no una evaluación profesional, y no tiene en cuenta tu estado de salud. El contenido no fue elaborado por un profesional de la salud.';

  @override
  String get consentPoint3 =>
      'Si tienes algún problema de salud, consulta primero con tu médico. Y durante el entrenamiento, escucha a tu cuerpo – si algo no se siente bien, detente.';

  @override
  String get consentCheckbox =>
      'He leído y acepto los Términos de uso y el Aviso de salud, y entiendo que entreno bajo mi propio riesgo.';

  @override
  String get consentAccept => 'Aceptar y empezar';

  @override
  String get consentUpdatedTitle => 'Nuestros términos cambiaron';

  @override
  String get consentUpdatedBody =>
      'Los Términos de uso y el Aviso de salud se actualizaron. Léelos y acéptalos para continuar.';

  @override
  String get consentTermsLink => 'Términos de uso';

  @override
  String get consentHealthLink => 'Aviso de salud';

  @override
  String get consentPrivacyLink => 'Privacidad';

  @override
  String get contact => 'Contacto';

  @override
  String get legal => 'Información legal';

  @override
  String get infoIntro =>
      'Creado por Marcell Bodnár.\nSi tienes preguntas o comentarios, escríbeme:';

  @override
  String get instagramLink => '@bodnar__marcell';

  @override
  String get emailLink => 'marcell@getshap.com';

  @override
  String get wallPush => 'Flexiones en la pared';

  @override
  String get tablePush => 'Flexiones en la mesa';

  @override
  String get diamondTablePush => 'Flexiones diamante en la mesa';

  @override
  String get kneePush => 'Flexiones de rodillas';

  @override
  String get pushUp => 'Flexiones';

  @override
  String get declinePush => 'Flexiones declinadas';

  @override
  String get explosivePush => 'Flexiones explosivas';

  @override
  String get pseudoPush => 'Flexiones pseudo plancha';

  @override
  String get dipPush => 'Fondos';

  @override
  String get bagPull => 'Remo a una mano con bolsa';

  @override
  String get reverseSnowAngel => 'Ángeles de nieve invertidos';

  @override
  String get chestBwPull => 'Remo invertido a la altura del pecho';

  @override
  String get waistBwPull => 'Remo invertido a la altura de la cintura';

  @override
  String get negPullUp => 'Dominadas negativas';

  @override
  String get pullUp => 'Dominadas';

  @override
  String get squat1 => 'Sentadillas asistidas';

  @override
  String get lunge1 => 'Zancadas asistidas';

  @override
  String get squat2 => 'Sentadillas';

  @override
  String get lunge2 => 'Zancadas';

  @override
  String get squat3 => 'Sentadillas con mochila';

  @override
  String get lunge3 => 'Zancadas con mochila';

  @override
  String get squat4 => 'Sentadillas con salto';

  @override
  String get lunge4 => 'Sentadillas búlgaras';

  @override
  String get squat5 => 'Sentadillas laterales';

  @override
  String get lunge5 => 'Sentadillas búlgaras con peso';

  @override
  String get glute1 => 'Patada de glúteo';

  @override
  String get glute2 => 'Puente de glúteos';

  @override
  String get glute3 => 'Puente de glúteos con pies elevados';

  @override
  String get glute4 => 'Puente de glúteos a una pierna';

  @override
  String get glute5 => 'Hip thrust a una pierna';

  @override
  String get core1 => 'Elevación de piernas acostado';

  @override
  String get core2 => 'Hiperextensiones inversas';

  @override
  String get workout => 'Entrenamiento';

  @override
  String get noWorkout => 'No hay más entrenamientos por hoy :)';

  @override
  String get nextWorkoutTitle => 'Próximo entrenamiento';

  @override
  String get nextWorkoutTomorrow => '¡Mañana puedes volver a entrenar!';

  @override
  String nextWorkoutDays(int days) {
    return 'Faltan $days días para tu próximo entrenamiento';
  }

  @override
  String get reps => 'Repeticiones';

  @override
  String get testRepsHint =>
      'Haz todas las que puedas y luego escribe cuántas hiciste.';

  @override
  String get seconds => 'Segundos';

  @override
  String get next => 'Siguiente';

  @override
  String get save => 'Guardar';

  @override
  String saveConfirm(int reps) {
    String _temp0 = intl.Intl.pluralLogic(
      reps,
      locale: localeName,
      other: '$reps repeticiones',
      one: '$reps repetición',
    );
    return '¿Seguro que hiciste $_temp0?';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get goback => 'Atrás';

  @override
  String get startWorkout => 'Empezar';

  @override
  String get question => 'Pregunta';

  @override
  String get nextq => 'Siguiente pregunta';

  @override
  String get finish => 'Terminar';

  @override
  String get mainGoal => '¿Cuál es tu objetivo principal?';

  @override
  String get weightLoss => 'Bajar de peso';

  @override
  String get muscleBuild => 'Ganar músculo';

  @override
  String get genderQuestion => '¿Cuál es tu sexo?';

  @override
  String get male => 'Hombre';

  @override
  String get female => 'Mujer';

  @override
  String get maxKneePush => '¿Cuántas flexiones de rodillas puedes hacer?';

  @override
  String get maxSquats => '¿Cuántas sentadillas puedes hacer?';

  @override
  String get prevExp1 => '¿Antes hacías deporte con regularidad?';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get prevExp2 => '¿Alguna vez intentaste empezar a entrenar?';

  @override
  String get motivation => '¿Cuántas ganas tienes de entrenar?';

  @override
  String get notAtAll => 'Ninguna';

  @override
  String get somewhat => 'Algunas';

  @override
  String get motivated => 'Muchas';

  @override
  String get age => '¿Cuál es tu grupo de edad?';

  @override
  String get workoutPlaceQuestion =>
      '¿Dónde quieres entrenar a partir de ahora?';

  @override
  String get workoutPlaceNote => 'Puedes cambiarlo más tarde en el menú.';

  @override
  String get atHome => 'En casa';

  @override
  String get inPark => 'En un parque';

  @override
  String get workoutPlace => 'Lugar de entrenamiento';

  @override
  String get congrat => '¡Felicidades!';

  @override
  String get congratMessage => '¡Entrenamiento de hoy completado!';

  @override
  String get rpe1 => 'Muy ligero';

  @override
  String get rpe23 => 'Ligero';

  @override
  String get rpe46 => 'Moderado';

  @override
  String get rpe78 => 'Intenso';

  @override
  String get rpe910 => 'Muy intenso';

  @override
  String get howWasTheWorkout => '¿Cuánto te costó el entrenamiento?';

  @override
  String get feedback => 'Valoración';

  @override
  String get workoutReminderTitle => '¿Un entrenamiento rápido? 💪';

  @override
  String get workoutReminderBody => 'Estás creando un hábito – ¡sigue así!';

  @override
  String get welcomeNotiTitle => 'Empieza tu entrenamiento';

  @override
  String get welcomeNotiBody => 'No va a ser difícil 😊';

  @override
  String get streakNotiTitle => 'Racha de entrenamientos 🔥';

  @override
  String get streakNotiBody => 'No olvides alargar tu racha de entrenamientos';

  @override
  String get dontGiveUpNotiTitle => '¡No te rindas!';

  @override
  String get dontGiveUpNotiBody => 'Decidiste que quieres cambiar.';

  @override
  String get notis => 'Notificaciones';

  @override
  String get notisAreImportant =>
      'Las notificaciones te ayudan a crear el hábito de entrenar.';

  @override
  String get enableNotis => 'Activar notificaciones';

  @override
  String get wallPushDesc =>
      'Colócate a más o menos un paso de la pared. Pon las manos un poco más abiertas que el ancho de los hombros, mantén los codos a unos 30–45 grados del cuerpo y el cuerpo en línea recta. Acércate a la pared todo lo que puedas y luego empújate hacia atrás.';

  @override
  String get tablePushDesc =>
      'Apoya las manos en el borde de una mesa estable, un poco más abiertas que el ancho de los hombros.\nMantén los codos en un ángulo de 30 a 45 grados respecto al cuerpo y el cuerpo en línea recta. Baja todo lo que puedas y luego empuja hacia arriba.\nCuanto más baja sea la superficie donde apoyas las manos, más difícil será el ejercicio.';

  @override
  String get diamondTablePushDesc =>
      'Apoya las manos en el borde de una mesa estable, juntas, de modo que los dedos índice y pulgar formen un triángulo, y asegúrate de que no se deslicen hacia adelante.\nMantén los codos pegados al cuerpo y el cuerpo en línea recta. Baja todo lo que puedas y luego empuja hacia arriba.\nCuanto más baja sea la superficie donde apoyas las manos, más difícil será el ejercicio.';

  @override
  String get kneePushDesc =>
      'Arrodíllate sobre algo blando. Pon las manos un poco más abiertas que el ancho de los hombros, mantén los codos a unos 30–45 grados del cuerpo y el cuerpo en línea recta. Baja todo lo que puedas y luego empuja hacia arriba.';

  @override
  String get pushUpDesc =>
      'Pon las manos un poco más abiertas que el ancho de los hombros, mantén los codos a unos 30–45 grados del cuerpo y el cuerpo en línea recta. Baja todo lo que puedas y luego empuja hacia arriba.';

  @override
  String get declinePushDesc =>
      'Apoya los pies en una superficie elevada (como una cama) y las manos un poco más abiertas que el ancho de los hombros. Mantén los codos a unos 30–45 grados del cuerpo y el cuerpo en línea recta. Baja todo lo que puedas y luego empuja hacia arriba.';

  @override
  String get explosivePushDesc =>
      'Durante la flexión, empújate del suelo con toda la fuerza que puedas.';

  @override
  String get pseudoPushDesc =>
      'Coloca las manos al ancho de los hombros y gíralas un poco hacia afuera.\nInclínate hacia adelante de modo que las manos queden en algún punto entre los hombros y la cadera. Baja los hombros todo lo posible de dos maneras: empújalos hacia el suelo y llévalos hacia abajo, en dirección al torso. Intenta mantener esta posición de los hombros lo mejor que puedas durante todo el movimiento. Al mismo tiempo, aprieta el abdomen.\nCuanto más te inclines hacia adelante, más difícil será el ejercicio.';

  @override
  String get dipPushDesc =>
      'Sujeta las barras con el centro de las palmas apoyado encima. Mantén los hombros bajos y conserva esa posición todo el tiempo. Baja hasta que los codos lleguen al menos a 90 grados y luego empuja hacia arriba.';

  @override
  String get bagPullDesc =>
      'Llena una bolsa con libros o pesas pequeñas, de al menos 5–10 kg (11–22 lb). Apóyate con una mano, con el torso recto y más o menos horizontal. Al bajar la mano, intenta que la bolsa no toque el suelo. Al subir, mantén los hombros bajos – no dejes que suban hacia las orejas. Dobla el brazo hasta unos 90°.\nSi te resulta demasiado fácil:\n• aumenta el peso\n• bájala más despacio\n• haz más repeticiones\nHazlo con ambos lados.';

  @override
  String get reverseSnowAngelDesc =>
      'Acuéstate boca abajo en el suelo. Levanta la cabeza y las manos, y junta las manos por encima de la cabeza. Lleva los brazos por los lados hasta la cadera y luego vuelve a juntar las manos por encima de la cabeza.\nUna ida y vuelta completa cuenta como una repetición.\nMantén las manos sin tocar el suelo durante todo el movimiento.\nPara hacerlo más difícil, sostén un libro en cada mano.';

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
      'Sujétate a algo estable con una mano o con las dos. Coloca los pies al ancho de los hombros, con las puntas un poco hacia afuera. Empieza llevando las rodillas un poco hacia adelante y luego baja de forma controlada hasta unos 90°. Mantén el torso recto todo el tiempo.';

  @override
  String get lunge1Desc =>
      'Alterna las piernas – cuenta las repeticiones totales, no por pierna. Sujétate a algo estable con una mano o con las dos. Da un paso atrás manteniendo vertical la espinilla delantera. El muslo debe apuntar hacia adelante. Inclínate un poco hacia adelante para que el trabajo recaiga en la parte trasera de la pierna delantera.';

  @override
  String get squat2Desc =>
      'Coloca los pies al ancho de los hombros, con las puntas un poco hacia afuera. Empieza llevando las rodillas un poco hacia adelante y luego baja de forma controlada hasta unos 90°. Mantén el torso recto todo el tiempo.';

  @override
  String get lunge2Desc =>
      'Alterna las piernas – cuenta las repeticiones totales, no por pierna. Da un paso atrás manteniendo vertical la espinilla delantera. El muslo debe apuntar hacia adelante. Inclínate un poco hacia adelante para que el trabajo recaiga en la parte trasera de la pierna delantera.';

  @override
  String get squat3Desc =>
      'Llena una mochila con libros u otros pesos. Coloca los pies al ancho de los hombros, con las puntas un poco hacia afuera. Empieza llevando las rodillas un poco hacia adelante y luego baja de forma controlada hasta unos 90°. Mantén el torso recto todo el tiempo.';

  @override
  String get lunge3Desc =>
      'Alterna las piernas – cuenta las repeticiones totales, no por pierna. Llena una mochila con libros u otros pesos. Da un paso atrás manteniendo vertical la espinilla delantera. El muslo debe apuntar hacia adelante. Inclínate un poco hacia adelante para que el trabajo recaiga en la parte trasera de la pierna delantera.';

  @override
  String get squat4Desc =>
      'Salta mientras haces la sentadilla. Coloca los pies al ancho de los hombros, con las puntas un poco hacia afuera. Empieza llevando las rodillas un poco hacia adelante y luego baja de forma controlada hasta unos 90°. Mantén el torso recto todo el tiempo. Si quieres, ponte una mochila con pesos.';

  @override
  String get lunge4Desc =>
      'Apoya la pierna de atrás en una silla. El pie de atrás se apoya sobre los dedos y el pie delantero apunta hacia adelante. Mantén los pies un poco separados en lugar de en línea recta para tener mejor equilibrio. Mantén vertical la espinilla delantera y el muslo apuntando hacia adelante. Inclínate un poco hacia adelante para que el peso recaiga en la parte trasera de la pierna delantera. Hazlo con ambos lados.';

  @override
  String get squat5Desc =>
      'Separa los pies, con las puntas un poco hacia afuera. Empieza a bajar doblando una rodilla. Mantén la parte superior del cuerpo lo más erguida posible.';

  @override
  String get lunge5Desc =>
      'Llena una bolsa con libros u otros pesos. Apoya la pierna de atrás en una silla. El pie de atrás se apoya sobre los dedos y el pie delantero apunta hacia adelante. Mantén los pies un poco separados en lugar de en línea recta para tener mejor equilibrio. Mantén vertical la espinilla delantera y el muslo apuntando hacia adelante. Inclínate un poco hacia adelante para que el peso recaiga en la parte trasera de la pierna delantera. Hazlo con ambos lados.';

  @override
  String get glute1Desc =>
      'Sujétate a una mesa, inclínate un poco hacia adelante y lleva la pierna estirada hacia atrás.\nNo olvides hacerlo con ambas piernas.';

  @override
  String get glute2Desc =>
      'Acuéstate boca arriba con las rodillas dobladas. Separa un poco los brazos hacia los lados para tener más estabilidad.\nSube la cadera todo lo que puedas mientras aprietas los glúteos y luego bájala.';

  @override
  String get glute3Desc =>
      'Acuéstate boca arriba con las rodillas dobladas y los pies sobre una superficie elevada, como el borde de un sofá. Separa un poco los brazos hacia los lados para tener más estabilidad.\nSube la cadera todo lo que puedas mientras aprietas los glúteos y luego bájala.';

  @override
  String get glute4Desc =>
      'Acuéstate boca arriba con las rodillas dobladas y luego estira una pierna, manteniéndola en el aire. Separa un poco los brazos hacia los lados para tener más estabilidad.\nSube la cadera todo lo que puedas mientras aprietas los glúteos y luego bájala.\nNo olvides hacerlo con ambas piernas.';

  @override
  String get glute5Desc =>
      'Siéntate frente a un sofá o una cama, de modo que el borde quede contra la parte alta de tu espalda. Mantén una pierna doblada y estira la otra.\nSube la cadera todo lo que puedas con una sola pierna mientras aprietas los glúteos, levantando también el otro pie del suelo, y luego baja.\nNo olvides hacerlo con ambas piernas.';

  @override
  String get core1Desc =>
      'Coloca las manos debajo de la cadera y levanta la cabeza. Aprieta el abdomen y sube las piernas, pero no hasta la vertical. Baja las piernas de forma controlada y no las apoyes en el suelo entre repeticiones. Con las rodillas dobladas es más fácil.';

  @override
  String get core2Desc =>
      'Acuéstate boca abajo sobre una silla y sujétate a sus patas. Con las rodillas dobladas, levanta las piernas por detrás todo lo que puedas.';

  @override
  String get lightBagPull => 'Remo a una mano con bolsa más ligera';

  @override
  String get runInPlace => 'Correr en el lugar';

  @override
  String get warmupDesc =>
      'Haz el ejercicio de forma controlada. Asegúrate de mantener una buena técnica.';

  @override
  String get warmup => 'Calentamiento';

  @override
  String get understand => 'Entendido';

  @override
  String get important => 'Importante';

  @override
  String get finishWarning =>
      'Toca el botón «Terminar» solo cuando hayas terminado de verdad el entrenamiento.\n\nEsto le sirve a la app como valoración.';

  @override
  String get tip => 'Consejo';

  @override
  String tipWithType(String type) {
    return 'Consejo de $type';
  }

  @override
  String get tipTypePrinciples => 'Mentalidad';

  @override
  String get tipTypeWorkout => 'Entrenamiento';

  @override
  String get tipTypeDiet => 'Alimentación';

  @override
  String get tipLibrary => 'Biblioteca de consejos';

  @override
  String get noTipsYet => 'Aún no tienes consejos de este tipo.';

  @override
  String get principles1 =>
      'Objetivo principal: nunca lo dejes del todo – es la única forma segura de llegar a donde quieres.';

  @override
  String get principles2 =>
      'Un entrenamiento fácil es mejor que saltártelo por completo.';

  @override
  String get principles3 =>
      'Cuando entrenar empiece a sentirse como un hábito, puedes ir aumentando poco a poco.';

  @override
  String get principles4 =>
      'Un cuerpo en mejor forma es bueno tanto para tu salud mental como para tu salud física.';

  @override
  String get beginnerWorkout1 =>
      'Una técnica pésima en los ejercicios puede causar lesiones – intenta hacerlos al menos de forma decente.';

  @override
  String get beginnerWorkout2 =>
      'Descansa entre 30 segundos y 2 minutos entre ejercicios – así recuperas parte de tu fuerza, pero tus entrenamientos no se alargan demasiado.';

  @override
  String get beginnerDiet1 =>
      'Si quieres bajar de peso, compra refrescos sin azúcar y, siempre que puedas, tómalos en lugar de bebidas azucaradas y otros dulces – calman las ganas de dulce y tienen casi 0 calorías.';

  @override
  String get beginnerDiet2 =>
      'Si quieres bajar de peso, ten a mano frutas y verduras que de verdad te gusten – tienen pocas calorías pero llenan mucho el estómago, así que después no tendrás tanta hambre.';

  @override
  String get advancedWorkout1 =>
      'Cuatro grandes grupos musculares: empuje, tracción, core y piernas.\n\nLos ejercicios de empuje son las variantes de flexiones, los fondos, el press de banca y otros ejercicios en los que alejas algo de tu cuerpo empujando. Trabajan sobre todo el pecho, los tríceps y la parte delantera de los hombros.\n\nLos ejercicios de tracción, como el remo con bolsa o las dominadas, son aquellos en los que acercas algo a tu cuerpo. Trabajan sobre todo la espalda, los bíceps y la parte trasera de los hombros. Hay dos tipos principales: la tracción vertical (dominadas) y la tracción horizontal (remo con bolsa).\n\nLos músculos del core son el abdomen, la zona lumbar y los oblicuos. Se trabajan en la mayoría de los ejercicios con el peso corporal, como las flexiones y las dominadas, pero también puedes hacer ejercicios específicos para ellos.\n\nTus piernas tienen 4 músculos principales: cuádriceps, isquiotibiales, glúteos y pantorrillas. Las sentadillas trabajan muy bien los cuádriceps, y el hip thrust y el puente de glúteos se centran sobre todo en los glúteos. Los ejercicios más eficaces para los isquiotibiales son aquellos en los que doblas la pierna, pero no hay alternativa para ellos con el equipamiento de casa. Sin embargo, las zancadas (que aparecen en la app) junto con el hip thrust y el puente de glúteos los trabajan bastante bien. Las pantorrillas no tienen un ejercicio propio en la app, porque se trabajan bien al correr, y también un poco en otros ejercicios.';

  @override
  String get advancedWorkout2 =>
      'Calentar mejora tu rendimiento y reduce el riesgo de lesiones.';

  @override
  String get advancedWorkout3 =>
      'Si bajar de peso te importa más que ganar músculo: puedes cambiar los ejercicios de piernas por salir a correr – o hacer las dos cosas. Correr quema más calorías. Pero no corras demasiado si no te gusta.';

  @override
  String get advancedWorkout4 =>
      'Durante el calentamiento, presta atención a tu técnica – aprovecha para hacer los movimientos lo mejor posible y así mejorar tu técnica.';

  @override
  String get advancedDiet1 =>
      'Intenta entrenar unas 2 horas después de comer. Después de una comida abundante, quizá te convenga esperar aún más – así tendrás energía para el entrenamiento y la digestión no te molestará.';

  @override
  String get advancedDiet2 =>
      'Calorías que entran, calorías que salen – si quemas más energía de la que consumes, bajarás de peso.';

  @override
  String get advancedDiet3 =>
      'Comer más proteína ayuda tanto a ganar músculo como a bajar de peso – favorece el crecimiento muscular y te ayuda a conservar el músculo mientras haces dieta.';

  @override
  String get advancedDiet4 =>
      'No te pases con la dieta – no te obligues a seguir una dieta que creas que no podrías mantener a largo plazo.';

  @override
  String get advancedDiet5 =>
      'Si quieres bajar de peso, pésate todos los días más o menos a la misma hora – comer, la hidratación e ir al baño pueden hacer variar tu peso unos kilos (o libras) en pocas horas, sin que hayas quemado nada de grasa.';

  @override
  String get advancedDiet6 =>
      'Si quieres bajar de peso, anota tu peso en algún lugar – idealmente en Excel o en Hojas de cálculo de Google, donde puedes calcular fácilmente promedios semanales. Si tu peso no ha ido bajando en las últimas semanas, intenta comer más frutas y verduras, menos cosas dulces, o sal a correr más.';

  @override
  String get workoutStreak => 'racha de entrenamientos';

  @override
  String get streakFreeze => 'Protector de racha';

  @override
  String get updateReadyMessage => 'Se descargó una actualización.';

  @override
  String get updateRestart => 'Reiniciar';

  @override
  String get updateAvailableTitle => 'Actualización disponible';

  @override
  String get updateAvailableMessage =>
      'Hay una nueva versión de la app disponible en el App Store.';

  @override
  String get updateNow => 'Actualizar';

  @override
  String get updateLater => 'Más tarde';
}
