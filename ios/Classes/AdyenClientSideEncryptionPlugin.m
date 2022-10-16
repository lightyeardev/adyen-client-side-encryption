#import "AdyenClientSideEncryptionPlugin.h"
#if __has_include(<adyen_client_side_encryption/adyen_client_side_encryption-Swift.h>)
#import <adyen_client_side_encryption/adyen_client_side_encryption-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "adyen_client_side_encryption-Swift.h"
#endif

@implementation AdyenClientSideEncryptionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAdyenClientSideEncryptionPlugin registerWithRegistrar:registrar];
}
@end
