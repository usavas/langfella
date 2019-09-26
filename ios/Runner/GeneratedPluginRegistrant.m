//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <background_fetch/BackgroundFetchPlugin.h>
#import <path_provider/PathProviderPlugin.h>
#import <share/SharePlugin.h>
#import <sqflite/SqflitePlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [BackgroundFetchPlugin registerWithRegistrar:[registry registrarForPlugin:@"BackgroundFetchPlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
  [FLTSharePlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharePlugin"]];
  [SqflitePlugin registerWithRegistrar:[registry registrarForPlugin:@"SqflitePlugin"]];
}

@end
