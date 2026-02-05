import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    let controller = window?.rootViewController as! FlutterViewController
    let lineChannel = FlutterMethodChannel(
      name: "app.shelfie.shelfie/line_share",
      binaryMessenger: controller.binaryMessenger
    )

    lineChannel.setMethodCallHandler { [weak self] (call, result) in
      switch call.method {
      case "isAvailable":
        result(self?.isLineAvailable() ?? false)
      case "shareImage":
        guard let args = call.arguments as? [String: Any],
              let filePath = args["filePath"] as? String else {
          result(false)
          return
        }
        self?.shareImageToLine(filePath: filePath, result: result)
      default:
        result(FlutterMethodNotImplemented)
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func isLineAvailable() -> Bool {
    guard let url = URL(string: "line://") else { return false }
    return UIApplication.shared.canOpenURL(url)
  }

  private func shareImageToLine(filePath: String, result: @escaping FlutterResult) {
    guard let image = UIImage(contentsOfFile: filePath) else {
      result(false)
      return
    }

    UIPasteboard.general.image = image

    let pasteboardName = UIPasteboard.general.name.rawValue
    guard let url = URL(string: "line://msg/image/\(pasteboardName)") else {
      result(false)
      return
    }

    UIApplication.shared.open(url, options: [:]) { success in
      result(success)
    }
  }
}
