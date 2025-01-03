import Flutter
import UIKit
import Firebase
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    FirebaseApp.configure()
    GMSServices.provideAPIKey("AIzaSyDdtSC-LadLz0dT0YMNLfWpOb_kw705UhU")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
