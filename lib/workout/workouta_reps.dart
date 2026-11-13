import 'package:getshap/core/level.dart';

class WorkoutAReps{
    var _Reps = [];
    late int _levelR;

    Future<void> SetRepsA(List<Map<String, String>> workoutParts) async {
        WorkoutLevel workoutLevel = WorkoutLevel();
        await workoutLevel.getLevel(); 
        _levelR = workoutLevel.level; 

        if (_levelR < 5) {
            // pushex
            _Reps = [10];
        } else if (_levelR < 10) {
            // pushex
            _Reps = [11];
        } else if (_levelR < 15) {
            // pushex
            _Reps = [12];
        } else if (_levelR < 20) {
            // pushex
            _Reps = [13];
        } else if (_levelR < 25) {
            // pushex
            _Reps = [14];
        } else if (_levelR < 30) {
            // pushex
            _Reps = [15];
        } else if (_levelR < 35) {
            // pushex, pushex
            _Reps = [15, 5];
        } else if (_levelR < 40) {
            // pushex, pushex
            _Reps = [15, 6];
        } else if (_levelR < 45) {
            // pushex, pushex
            _Reps = [15, 7];
        } else if (_levelR < 50) {
            // pushex, pushex
            _Reps = [15, 8];
        } else if (_levelR < 55) {
            // pushex, pushex
            _Reps = [15, 9];
        } else if (_levelR < 60) {
            // pushex, pushex
            _Reps = [15, 10];
        } else if (_levelR < 65) {
            // pushex, pullex, pushex
            _Reps = [15, 7, 10];
        } else if (_levelR < 70) {
            // pushex, pullex, pushex
            _Reps = [15, 10, 10];
        } else if (_levelR < 75) {
            // pushex, pullex, pushex
            _Reps = [15, 10, 11];
        } else if (_levelR < 80) {
            // pushex, pullex, pushex
            _Reps = [15, 15, 11];
        } else if (_levelR < 85) {
            // pushex, pullex, pushex
            _Reps = [15, 15, 12];
        } else if (_levelR < 90) {
            // pushex, pullex, pushex, pullex
            _Reps = [15, 15, 12, 7];
        // 90+: the push sets that used to climb to 16-20 now run on the harder
        // variation instead, ramping evenly from 10 to 15 by level 150.
        } else if (_levelR < 95) {
            // pushexp, pullex, pushex, pullex
            _Reps = [10, 15, 13, 10];
        } else if (_levelR < 100) {
            // pushexp, pullex, pushexp, pullex
            _Reps = [10, 15, 7, 10];
        } else if (_levelR < 105) {
            // pushexp, pullex, pushexp, pullex
            _Reps = [11, 15, 7, 12];
        } else if (_levelR < 110) {
            // pushexp, pullex, pushexp, pullex
            _Reps = [11, '10-15', 8, '10-15'];
        } else if (_levelR < 115) {
            // pushexp, pullex, pushexp, pullex, pushex
            _Reps = [12, '10-15', 8, '10-15', 7];
        } else if (_levelR < 120) {
            // pushexp, pullex, pushexp, pullex, pushex, pullex
            _Reps = [12, '10-15', 9, '10-15', 8, 5];
        } else if (_levelR < 125) {
            // pushexp, pullex, pushexp, pullex, pushex, pullex
            _Reps = [13, '10-15', 9, '10-15', 12, 5];
        } else if (_levelR < 130) {
            // pushexp, pullex, pushexp, pullex, pushexp, pullex
            _Reps = [13, '10-15', 10, '10-15', 7, 6];
        } else if (_levelR < 135) {
            // pushexp, pullex, pushexp, pullex, pushexp, pullex
            _Reps = [14, '10-15', 10, '10-15', 8, 6];
        } else if (_levelR < 140) {
            // pushexp, pullex, legsex, pushexp, pullex, legsex, pushexp, pullex, legsex
            _Reps = [14, '10-15', 5, 11, '10-15', 5, 8, 6, 5];
        } else if (_levelR < 145) {
            // pushexp, pullex, legsex, pushexp, pullex, legsex, pushexp, pullex, legsex
            _Reps = [15, '10-15', 7, 12, '10-15', 7, 8, 6, 7];
        } else if (_levelR < 150) {
            // pushexp, pullex, legsex, pushexp, pullex, legsex, pushexp, pullex, legsex
            _Reps = [15, '10-15', 10, 12, '10-15', 10, 9, 6, 5];
        }
        
        for (int i = 0; i < _Reps.length; i++) {
            workoutParts[i]['reps'] = _Reps[i].toString();
        }
    }
}