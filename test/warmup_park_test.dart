// The warm-up of a park workout (warmup_park.dart): the row that takes the
// place of the home warm-up's pull, and when the warm-up has no pull at all.
//
// The levels where the row changes and its reps are left to warmup_park.dart,
// so that they can be tuned there. These tests hold the rules.

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:getshap/warmup/warmup.dart';
import 'package:getshap/warmup/warmup_park.dart';

void main() {
    const String chest = 'chestBwPull';
    const String waist = 'waistBwPull';
    const String monkey = 'monkeyBarRows';

    /// From the easiest on.
    const List<String> rows = <String>[chest, waist, monkey];

    /// Park levels all along the ladder, and well past its last stage.
    final List<int> parkLevels = <int>[for (int level = 0; level <= 800; level += 5) level];

    const Map<String, Object> onLadder = <String, Object>{
        'placeSwitch': 1,
        'pullTestDone': true,
    };

    /// The warm-up as it is built at [level], for [prefs].
    Future<List<Map<String, String>>> warmup(
        int level, [
        Map<String, Object> prefs = const <String, Object>{},
    ]) async {
        SharedPreferences.setMockInitialValues(<String, Object>{
            'level': level,
            'pushe': 2,
            'pulle': 1,
            'legse': 1,
            'switch': 1,
            'age': 1,
            ...prefs,
        });
        final Warmup warmup = Warmup();
        await warmup.setWarmup();
        return warmup.warmup_parts;
    }

    group('on the park ladder', () {
        test('only the pull changes, to the row and the reps of the park level', () async {
            // The home pull is the lighter bag row at 150, the bag row at 300.
            for (final int level in <int>[150, 300]) {
                final List<Map<String, String>> home = await warmup(level);
                expect(rows, isNot(contains(home[1]['nameKey'])));

                for (final int parkLevel in parkLevels) {
                    final List<Map<String, String>> park =
                        await warmup(level, <String, Object>{...onLadder, 'parkLevel': parkLevel});
                    final String where = 'level $level, park level $parkLevel';

                    expect(park, hasLength(home.length), reason: where);
                    expect(park[0], home[0], reason: where);
                    expect(park[2], home[2], reason: where);
                    expect(park[1]['nameKey'], WarmupPark.pull(parkLevel), reason: where);
                    expect(park[1]['reps'], WarmupPark.reps(parkLevel), reason: where);
                    expect(park[1]['videoPath'], isNotEmpty, reason: where);
                }
            }
        });

        test('the pull is always a row, and never an easier one further on', () {
            expect(WarmupPark.pull(0), chest);
            expect(WarmupPark.pull(parkLevels.last), monkey);

            int before = 0;
            for (final int parkLevel in parkLevels) {
                final int now = rows.indexOf(WarmupPark.pull(parkLevel));
                expect(now, greaterThanOrEqualTo(before), reason: 'park level $parkLevel');
                before = now;
            }
        });

        test('it starts on fewer chest-high rows than it has later', () {
            final int lastChest =
                parkLevels.lastWhere((int level) => WarmupPark.pull(level) == chest);
            expect(
                int.parse(WarmupPark.reps(0)),
                lessThan(int.parse(WarmupPark.reps(lastChest))),
            );
        });

        test('at home it is the home warm-up, whatever the park level', () async {
            for (final int level in <int>[150, 300]) {
                final List<Map<String, String>> home = await warmup(level);
                final List<Map<String, String>> backHome = await warmup(
                    level,
                    <String, Object>{...onLadder, 'placeSwitch': 0, 'parkLevel': 300},
                );
                expect(backHome, home, reason: 'level $level');
            }
        });
    });

    group('while the pull test is on', () {
        test('no pull until the waist-high rows are passed', () async {
            final List<Map<String, String>> home = await warmup(150);

            // Nothing entered yet, the chest-high rows failed, and passed.
            const List<Map<String, Object>> states = <Map<String, Object>>[
                <String, Object>{},
                <String, Object>{'pullLvl': 1},
                <String, Object>{'pullLvl': 2},
            ];
            for (final Map<String, Object> state in states) {
                final List<Map<String, String>> testing =
                    await warmup(150, <String, Object>{'placeSwitch': 1, ...state});
                expect(
                    testing,
                    <Map<String, String>>[home[0], home[2]],
                    reason: '$state',
                );
            }
        });

        test('waist-high rows once they are passed', () async {
            final List<Map<String, String>> home = await warmup(150);

            for (final int pullLvl in <int>[3, 4]) {
                final List<Map<String, String>> testing =
                    await warmup(150, <String, Object>{'placeSwitch': 1, 'pullLvl': pullLvl});
                final String where = 'pull level $pullLvl';

                expect(testing, hasLength(home.length), reason: where);
                expect(testing[0], home[0], reason: where);
                expect(testing[2], home[2], reason: where);
                expect(testing[1]['nameKey'], waist, reason: where);
                expect(testing[1]['reps'], isNotEmpty, reason: where);
            }
        });
    });

    test('every part has its reps, at home and in a park', () async {
        const List<Map<String, Object>> parkStates = <Map<String, Object>>[
            <String, Object>{...onLadder, 'parkLevel': 0},
            <String, Object>{'placeSwitch': 1},
            <String, Object>{'placeSwitch': 1, 'pullLvl': 3},
        ];

        // Where the warm-up starts, the first level of workout B, and where
        // its third exercise and its home pull change.
        for (final int level in <int>[130, 150, 270, 300]) {
            final List<Map<String, Object>> states = <Map<String, Object>>[
                <String, Object>{},
                // Park workouts start at 150.
                if (level >= 150) ...parkStates,
            ];
            for (final Map<String, Object> state in states) {
                final List<Map<String, String>> parts = await warmup(level, state);
                expect(parts, isNotEmpty, reason: 'level $level, $state');
                for (final Map<String, String> part in parts) {
                    expect(
                        part['reps'],
                        isNotEmpty,
                        reason: 'level $level, $state, ${part['nameKey']}',
                    );
                }
            }
        }
    });
}
