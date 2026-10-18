import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:getshap/core/debug_clock.dart';
import 'package:getshap/tips/tip_manager.dart';
import 'package:getshap/tips/tips_data.dart';

//the day number TipManager compares lastTipChangeTime against
int today() => DateTime.now().millisecondsSinceEpoch ~/ (24 * 60 * 60 * 1000);

List<String> ids(Iterable<TipItem> tips) => tips.map((t) => t.id).toList();

final List<String> sectionA =
    ids([...TipsData.principles, ...TipsData.beginnerWorkout, ...TipsData.beginnerDiet]);

Future<List<String>> tipLibraryAfterLaunch(Map<String, Object> values) async {
    SharedPreferences.setMockInitialValues(values);
    await TipManager().initialize();
    return TipManager().tipLibrary;
}

void main() {
    TestWidgetsFlutterBinding.ensureInitialized();

    test('a fresh install starts the tip library with the first tip', () async {
        expect(await tipLibraryAfterLaunch({}), ['principles1']);
    });

    group('rebuilding the tip library of an existing install', () {
        test('mid section A it is everything up to the current tip', () async {
            final List<String> seen = [
                'principles1', 'principles2', 'principles3', 'principles4',
                'beginnerWorkout1', 'beginnerDiet1',
            ];
            final tipLibrary = await tipLibraryAfterLaunch({
                'seenTipsA': seen,
                'lastTipId': 'beginnerDiet1',
                'lastTipChangeTime': today(),
                'nextBeginnerType': 'workout',
            });
            expect(tipLibrary, unorderedEquals(seen));
        });

        test('after a full round it is every section A tip, each once', () async {
            //principles1 is in seenTipsA and in the full list as well;
            //unorderedEquals also compares the lengths
            final tipLibrary = await tipLibraryAfterLaunch({
                'hasCompletedFullCycle': true,
                'seenTipsA': ['principles1'],
                'lastTipId': 'principles1',
                'lastTipChangeTime': today(),
            });
            expect(tipLibrary, unorderedEquals(sectionA));
        });

        test('in section B the diet count fills in a wrapped workout list', () async {
            //five workout tips and four diet tips: the workout index has
            //wrapped back to 1
            final tipLibrary = await tipLibraryAfterLaunch({
                'hasFinishedSectionA': true,
                'advancedWorkoutIndex': 1,
                'advancedDietIndex': 4,
                'nextAdvancedType': 'diet',
                'lastTipId': 'advancedWorkout1',
                'lastTipChangeTime': today(),
            });
            expect(tipLibrary, unorderedEquals([
                ...sectionA,
                ...ids(TipsData.advancedWorkout),
                ...ids(TipsData.advancedDiet.take(4)),
            ]));
        });
    });

    test('a new tip goes into the tip library as soon as it is picked', () async {
        final tipLibrary = await tipLibraryAfterLaunch({
            'tipLibrary': ['principles1'],
            'seenTipsA': ['principles1'],
            'lastTipId': 'principles1',
            'lastTipChangeTime': today() - 3,
        });
        final prefs = await SharedPreferences.getInstance();
        expect(TipManager().currentTipId, 'principles2');
        expect(tipLibrary, ['principles1', 'principles2']);
        expect(prefs.getStringList('tipLibrary'), ['principles1', 'principles2']);
    });

    test('the Advance day(s) debug clock rotates the tip too', () async {
        SharedPreferences.setMockInitialValues({
            'tipLibrary': ['principles1'],
            'seenTipsA': ['principles1'],
            'lastTipId': 'principles1',
            'lastTipChangeTime': today(),
        });
        addTearDown(() async {
            //back to an offset of 0 for the other tests
            SharedPreferences.setMockInitialValues({});
            await DebugClock.load();
        });

        //two days are not enough yet...
        await DebugClock.advance(2);
        await TipManager().initialize();
        expect(TipManager().currentTipId, 'principles1');

        //...one more makes three since the last change
        await DebugClock.advance(1);
        await TipManager().initialize();
        expect(TipManager().currentTipId, 'principles2');
        expect(TipManager().tipLibrary, ['principles1', 'principles2']);
    });

    test('a tip given again in a new round is not added twice', () async {
        final tipLibrary = await tipLibraryAfterLaunch({
            'tipLibrary': sectionA,
            'seenTipsA': sectionA,
            'lastTipId': 'beginnerDiet2',
            'lastTipChangeTime': today() - 3,
        });
        final prefs = await SharedPreferences.getInstance();
        //the rotation started over at principles1, which is already in it
        expect(TipManager().currentTipId, 'principles1');
        expect(prefs.getStringList('seenTipsA'), ['principles1']);
        expect(tipLibrary, unorderedEquals(sectionA));
        expect(prefs.getStringList('tipLibrary'), unorderedEquals(sectionA));
    });
}
