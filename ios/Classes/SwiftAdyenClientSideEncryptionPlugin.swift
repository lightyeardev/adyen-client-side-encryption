import Flutter
import UIKit
import Adyen


public class SwiftAdyenClientSideEncryptionPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "adyen_client_side_encryption", binaryMessenger: registrar.messenger())
    let instance = SwiftAdyenClientSideEncryptionPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let args = call.arguments as! Dictionary<String, String?>
    let number = args["number"]!;
    let expiryMonth = args["expiryMonth"]!;
    let expiryYear = args["expiryYear"]!;
    let cvc = args["cvc"]!;
    let cardHolderName = args["cardHolderName"]!;
    let publicKey = args["publicKey"]!;
    do {
      let card = Card(number: number, securityCode: cvc, expiryMonth: expiryMonth, expiryYear: expiryYear, holder: cardHolderName)
      let encryptedCard = try CardEncryptor.encrypt(card: card, with: publicKey!)
        
        result([
            "number": encryptedCard.number,
            "expiryMonth": encryptedCard.expiryMonth,
            "expiryYear": encryptedCard.expiryYear,
            "cvc": encryptedCard.securityCode,
        ])
    } catch let error {
      result(FlutterError(code: "EXCEPTION", message: error.localizedDescription, details: nil))
    }
  }
}
