import UIKit
import Flutter
import Adyen

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let batteryChannel = FlutterMethodChannel(name: "golightyear.com/adyen-cse",
                                                binaryMessenger: controller.binaryMessenger)
        batteryChannel.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            guard call.method == "encryptCard" else {
              result(FlutterMethodNotImplemented)
              return
            }
            self.encryptCard(call: call, result: result)
        })

          
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func encryptCard(call: FlutterMethodCall, result: FlutterResult) {
        let args = call.arguments as! Dictionary<String, String>
        let number = args["number"]!;
        let expiryMonth = args["expiryMonth"]!;
        let expiryYear = args["expiryYear"]!;
        let cvc = args["cvc"]!;
        let cardHolderName = args["cardHolderName"]!;
        let publicKey = args["publicKey"]!;
        do {
            let card = Card(number: number, securityCode: cvc, expiryMonth: expiryMonth, expiryYear: expiryYear, holder: cardHolderName)
            let encryptedCard = try CardEncryptor.encryptToken(from: card, with: publicKey)
            result(encryptedCard)
        } catch let error {
            result(FlutterError(code: "EXCEPTION", message: error.localizedDescription, details: nil))
        }
    }

}
