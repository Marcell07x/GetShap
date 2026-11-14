import 'dart:io';

import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:path_provider/path_provider.dart';

/// A video on the server never changes (a re-shot one gets a new name), so one
/// that is on the device is never checked again.
///
/// Their folder is kept out of the device backups by
/// android/app/src/main/res/xml/backup_rules.xml, data_extraction_rules.xml
/// and ios/Runner/AppDelegate.swift.
class ExerciseVideos {
    /// The `media` folder has to stay on the server whenever the website
    /// itself is uploaded again.
    static const String _server = 'https://getshap.com/media/videos';

    static const Duration _timeout = Duration(seconds: 30);

    static final Map<String, Future<File?>> _downloads = <String, Future<File?>>{};

    /// Null when the video is not on the device and cannot be downloaded now.
    static Future<File?> get(String name) async {
        try {
            final Directory support = await getApplicationSupportDirectory();
            final File file = File('${support.path}/videos/$name');
            if (await file.exists()) return file;

            Future<File?>? download = _downloads[name];
            if (download == null) {
                download = fetch(Uri.parse('$_server/$name'), file).whenComplete(() {
                    // Not `=>`: whenComplete would wait for the removed
                    // download, which is this very one.
                    _downloads.remove(name);
                });
                _downloads[name] = download;
            }
            return await download;
        } catch (e) {
            return null;
        }
    }

    /// Written as `.part` and renamed only when whole, so a download cut short
    /// never passes for a video.
    @visibleForTesting
    static Future<File?> fetch(Uri url, File file) async {
        final File part = File('${file.path}.part');
        final HttpClient client = HttpClient();
        client.connectionTimeout = const Duration(seconds: 15);
        try {
            final HttpClientRequest request = await client.getUrl(url);
            final HttpClientResponse response = await request.close().timeout(_timeout);
            // An error page can come with status 200 too.
            if (response.statusCode != HttpStatus.ok ||
                response.headers.contentType?.primaryType != 'video') {
                return null;
            }
            await part.parent.create(recursive: true);
            await response.timeout(_timeout).pipe(part.openWrite());
            return await part.rename(file.path);
        } catch (e) {
            return null;
        } finally {
            client.close(force: true);
        }
    }
}
