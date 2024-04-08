//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<agora_chat_sdk/ImFlutterSdkPlugin.h>)
#import <agora_chat_sdk/ImFlutterSdkPlugin.h>
#else
@import agora_chat_sdk;
#endif

#if __has_include(<agora_rtc_engine/AgoraRtcNgPlugin.h>)
#import <agora_rtc_engine/AgoraRtcNgPlugin.h>
#else
@import agora_rtc_engine;
#endif

#if __has_include(<firebase_auth/FLTFirebaseAuthPlugin.h>)
#import <firebase_auth/FLTFirebaseAuthPlugin.h>
#else
@import firebase_auth;
#endif

#if __has_include(<firebase_core/FLTFirebaseCorePlugin.h>)
#import <firebase_core/FLTFirebaseCorePlugin.h>
#else
@import firebase_core;
#endif

#if __has_include(<google_sign_in_ios/FLTGoogleSignInPlugin.h>)
#import <google_sign_in_ios/FLTGoogleSignInPlugin.h>
#else
@import google_sign_in_ios;
#endif

#if __has_include(<iris_method_channel/IrisMethodChannelPlugin.h>)
#import <iris_method_channel/IrisMethodChannelPlugin.h>
#else
@import iris_method_channel;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [ImFlutterSdkPlugin registerWithRegistrar:[registry registrarForPlugin:@"ImFlutterSdkPlugin"]];
  [AgoraRtcNgPlugin registerWithRegistrar:[registry registrarForPlugin:@"AgoraRtcNgPlugin"]];
  [FLTFirebaseAuthPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseAuthPlugin"]];
  [FLTFirebaseCorePlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseCorePlugin"]];
  [FLTGoogleSignInPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTGoogleSignInPlugin"]];
  [IrisMethodChannelPlugin registerWithRegistrar:[registry registrarForPlugin:@"IrisMethodChannelPlugin"]];
}

@end
