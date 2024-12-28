import UIKit
import Flutter
import Firebase
import GoogleMaps
import YandexMapsMobile

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    YMKMapKit.setApiKey("67f55339-3dc0-4273-aff4-cd2df9844757")
//     GMSServices.provideAPIKey("AIzaSyCTKuVMoOo7RsTzILlK4yyn2atBK3v5AM8") // AIzaSyDdtSC-LadLz0dT0YMNLfWpOb_kw705UhU
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
