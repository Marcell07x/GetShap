// Downloading an exercise video (exercise_videos.dart): a video that arrives
// whole is kept under its own name, and nothing else ever is. Not an error
// page, and not a download that broke off: a file under a video's name is
// kept for good and never checked again, so it has to be the video.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:getshap/workout/exercise_videos.dart';

void main() {
    late Directory directory;
    late HttpServer server;

    /// What the server answers a request with.
    late Future<void> Function(HttpResponse response) answer;

    final List<int> video = List<int>.generate(50000, (int i) => i % 251);

    setUp(() async {
        // flutter_test answers every request itself unless this is cleared.
        HttpOverrides.global = null;
        directory = await Directory.systemTemp.createTemp('exercise_videos_test');
        server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        server.listen((HttpRequest request) => answer(request.response));
    });

    tearDown(() async {
        await server.close(force: true);
        await directory.delete(recursive: true);
    });

    /// Where a video is kept. The folder is not there before the first one.
    File kept(String name) => File('${directory.path}/videos/$name');

    Future<File?> fetch(String name, {int? port}) => ExerciseVideos.fetch(
        Uri.parse('http://127.0.0.1:${port ?? server.port}/videos/$name'),
        kept(name),
    );

    Future<void> wholeVideo(HttpResponse response) async {
        response.headers.contentType = ContentType('video', 'mp4');
        response.add(video);
        await response.close();
    }

    /// A server that promises a whole video, sends a fifth of it, and hangs
    /// up. It closes the connection in good order, the way a download cut
    /// short looks the most like a finished one.
    Future<ServerSocket> cutShort() async {
        final ServerSocket cut = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
        cut.listen((Socket socket) {
            bool answered = false;
            socket.listen(
                (List<int> request) async {
                    if (answered) return;
                    answered = true;
                    socket.write(
                        'HTTP/1.1 200 OK\r\n'
                        'Content-Type: video/mp4\r\n'
                        'Content-Length: ${video.length}\r\n'
                        '\r\n',
                    );
                    socket.add(video.sublist(0, 10000));
                    await socket.flush();
                    await socket.close();
                },
                onError: (Object error) {},
            );
        });
        return cut;
    }

    test('a video that arrives whole is kept under its name', () async {
        answer = wholeVideo;

        final File? downloaded = await fetch('pushUp.mp4');

        expect(downloaded, isNotNull);
        expect(downloaded!.path, kept('pushUp.mp4').path);
        expect(await kept('pushUp.mp4').readAsBytes(), video);
        expect(File('${kept('pushUp.mp4').path}.part').existsSync(), isFalse);
    });

    test('a video the server does not have is not kept', () async {
        answer = (HttpResponse response) async {
            response.statusCode = HttpStatus.notFound;
            response.headers.contentType = ContentType.html;
            response.write('<h1>Not Found</h1>');
            await response.close();
        };

        expect(await fetch('missing.mp4'), isNull);
        expect(kept('missing.mp4').existsSync(), isFalse);
    });

    test('a page sent in a video\'s place is not kept, even with status 200', () async {
        answer = (HttpResponse response) async {
            response.headers.contentType = ContentType.html;
            response.write('<h1>This domain is parked</h1>');
            await response.close();
        };

        expect(await fetch('pushUp.mp4'), isNull);
        expect(kept('pushUp.mp4').existsSync(), isFalse);
    });

    test('a server that cannot be reached gives no video', () async {
        final int port = server.port;
        await server.close(force: true);

        expect(await fetch('pushUp.mp4', port: port), isNull);
        expect(kept('pushUp.mp4').existsSync(), isFalse);
    });

    test('a download that breaks off leaves no video behind', () async {
        final ServerSocket cut = await cutShort();
        addTearDown(cut.close);

        expect(await fetch('pushUp.mp4', port: cut.port), isNull);
        expect(kept('pushUp.mp4').existsSync(), isFalse);
    });

    test('the next try after a broken download brings the whole video', () async {
        final ServerSocket cut = await cutShort();
        addTearDown(cut.close);
        expect(await fetch('pushUp.mp4', port: cut.port), isNull);

        answer = wholeVideo;
        expect(await fetch('pushUp.mp4'), isNotNull);
        expect(await kept('pushUp.mp4').readAsBytes(), video);
    });
}
