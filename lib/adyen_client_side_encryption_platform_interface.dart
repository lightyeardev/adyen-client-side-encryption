import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'adyen_client_side_encryption_method_channel.dart';

abstract class AdyenClientSideEncryptionPlatform extends PlatformInterface {
  /// Constructs a AdyenClientSideEncryptionPlatform.
  AdyenClientSideEncryptionPlatform() : super(token: _token);

  static final Object _token = Object();

  static AdyenClientSideEncryptionPlatform _instance = MethodChannelAdyenClientSideEncryption();

  /// The default instance of [AdyenClientSideEncryptionPlatform] to use.
  ///
  /// Defaults to [MethodChannelAdyenClientSideEncryption].
  static AdyenClientSideEncryptionPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AdyenClientSideEncryptionPlatform] when
  /// they register themselves.
  static set instance(AdyenClientSideEncryptionPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Map<String, String?>> encryptCard(Map<String, String?> cardDetails) {
    throw UnimplementedError('encryptCard() has not been implemented.');
  }
}
