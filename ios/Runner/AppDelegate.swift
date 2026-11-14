import Flutter
import UIKit
import flutter_local_notifications

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    excludeVideosFromBackup()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // The exercise videos are downloaded into Application Support/videos
  // (lib/workout/exercise_videos.dart) and can be downloaded again, so they
  // stay out of the iCloud backup. The mark is on the folder, which covers
  // everything in it, and is set again on every launch.
  private func excludeVideosFromBackup() {
    guard let support = FileManager.default.urls(
      for: .applicationSupportDirectory, in: .userDomainMask).first else { return }
    var videos = support.appendingPathComponent("videos", isDirectory: true)
    try? FileManager.default.createDirectory(at: videos, withIntermediateDirectories: true)
    var values = URLResourceValues()
    values.isExcludedFromBackup = true
    try? videos.setResourceValues(values)
  }

  // With the UIScene lifecycle the Flutter engine is created when the scene
  // connects, after launch, so plugins are registered here instead of above.
  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
      GeneratedPluginRegistrant.register(with: registry)
    }
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
