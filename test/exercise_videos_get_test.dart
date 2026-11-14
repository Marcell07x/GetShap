// ExerciseVideos.get and the download ahead of the next workout, the way the
// app calls them, with a real download from a local server.

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:getshap/workout/exercise_videos.dart';
import 'package:getshap/workout/next_workout_videos.dart';

/// Sends the app's requests to the local server instead of the real one.
class _ToLocalServer extends HttpOverrides {
    _ToLocalServer(this.port);

    final int port;

    @override
    HttpClient createHttpClient(SecurityContext? context) =>
        _LocalClient(super.createHttpClient(context), port);
}

class _LocalClient implements HttpClient {
    _LocalClient(this._client, this._port);

    final HttpClient _client;
    final int _port;

    @override
    set connectionTimeout(Duration? timeout) => _client.connectionTimeout = timeout;

    @override
    Future<HttpClientRequest> getUrl(Uri url) =>
        _client.getUrl(Uri.parse('http://127.0.0.1:$_port${url.path}'));

    @override
    void close({bool force = false}) => _client.close(force: force);

    @override
    dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
    TestWidgetsFlutterBinding.ensureInitialized();

    const MethodChannel pathProvider = MethodChannel('plugins.flutter.io/path_provider');

    late Directory directory;
    late HttpServer server;
    late List<String> requested;
    late bool serverHasVideos;

    final List<int> video = List<int>.generate(50000, (int i) => i % 251);

    setUp(() async {
        directory = await Directory.systemTemp.createTemp('exercise_videos_get_test');
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(pathProvider, (MethodCall call) async => directory.path);

        requested = <String>[];
        serverHasVideos = true;
        server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        server.listen((HttpRequest request) async {
            requested.add(request.uri.path);
            if (serverHasVideos) {
                request.response.headers.contentType = ContentType('video', 'mp4');
                request.response.add(video);
            } else {
                request.response.statusCode = HttpStatus.notFound;
            }
            await request.response.close();
        });
        HttpOverrides.global = _ToLocalServer(server.port);
    });

    tearDown(() async {
        HttpOverrides.global = null;
        await server.close(force: true);
        await directory.delete(recursive: true);
    });

    File kept(String name) => File('${directory.path}/videos/$name');

    // The timeout turns a request that never gets its answer into a failure.
    Future<File?> get(String name) =>
        ExerciseVideos.get(name).timeout(const Duration(seconds: 10));

    test('a video that has to be downloaded is handed over', () async {
        final File? file = await get('pushUp.mp4');

        expect(file!.path, kept('pushUp.mp4').path);
        expect(await file.readAsBytes(), video);
        expect(requested, <String>['/media/videos/pushUp.mp4']);
    });

    test('a video asked for twice at once is downloaded once', () async {
        final List<File?> files = await Future.wait(<Future<File?>>[
            get('pushUp.mp4'),
            get('pushUp.mp4'),
        ]);

        expect(files[0], isNotNull);
        expect(files[1], isNotNull);
        expect(requested.length, 1);
    });

    test('a video on the device is not asked from the server', () async {
        await get('pushUp.mp4');
        requested.clear();

        expect(await get('pushUp.mp4'), isNotNull);
        expect(requested, isEmpty);
    });

    test('after a failed download the next try brings the video', () async {
        serverHasVideos = false;
        expect(await get('pushUp.mp4'), isNull);

        serverHasVideos = true;
        expect(await get('pushUp.mp4'), isNotNull);
    });

    test('every video of the next workout is downloaded, not only the first', () async {
        SharedPreferences.setMockInitialValues(<String, Object>{
            'level': 140,
            'pushe': 2,
            'pulle': 1,
            'legse': 1,
            'switch': 1,
            'coreSwitch': 1,
            'age': 1,
        });
        final Set<String> videos = await nextWorkoutVideos();
        expect(videos.length, greaterThan(1));

        await downloadNextWorkoutVideos().timeout(const Duration(seconds: 10));

        for (final String name in videos) {
            expect(kept(name).existsSync(), isTrue, reason: name);
        }
    });
}
