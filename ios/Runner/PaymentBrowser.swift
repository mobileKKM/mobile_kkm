import Flutter
import SafariServices
import UIKit

/// tPay's payment page in an SFSafariViewController (Apple Pay works there).
/// iOS gives no return link for a domain that isn't ours, so the only event
/// is the user closing the view with Done; Dart then asks the server.
final class PaymentBrowser: NSObject, SFSafariViewControllerDelegate {
  private let channel: FlutterMethodChannel
  private weak var presented: SFSafariViewController?

  init(messenger: FlutterBinaryMessenger) {
    channel = FlutterMethodChannel(name: "de.codebucket.mkkm/payment", binaryMessenger: messenger)
    super.init()
    channel.setMethodCallHandler { [weak self] call, result in
      self?.handle(call, result: result)
    }
  }

  private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "open":
      let arguments = call.arguments as? [String: Any]
      guard let text = arguments?["url"] as? String, let url = URL(string: text) else {
        result(FlutterError(code: "bad-url", message: nil, details: nil))
        return
      }
      open(url, tint: (arguments?["tintColor"] as? NSNumber).map { color(argb: $0.uint32Value) })
      result(nil)
    case "close":
      presented?.dismiss(animated: true)
      result(nil)
    case "initialReturn":
      result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func open(_ url: URL, tint: UIColor?) {
    guard let root = Self.topViewController() else { return }
    let safari = SFSafariViewController(url: url)
    safari.delegate = self
    safari.dismissButtonStyle = .done
    safari.preferredControlTintColor = tint
    presented = safari
    root.present(safari, animated: true)
  }

  func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
    channel.invokeMethod("closed", arguments: nil)
  }

  private func color(argb: UInt32) -> UIColor {
    UIColor(
      red: CGFloat((argb >> 16) & 0xFF) / 255,
      green: CGFloat((argb >> 8) & 0xFF) / 255,
      blue: CGFloat(argb & 0xFF) / 255,
      alpha: CGFloat((argb >> 24) & 0xFF) / 255
    )
  }

  /// The view controller on top of the active scene's window.
  private static func topViewController() -> UIViewController? {
    let window = UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .flatMap { $0.windows }
      .first { $0.isKeyWindow }
    var top = window?.rootViewController
    while let next = top?.presentedViewController {
      top = next
    }
    return top
  }
}
