#import <Flutter/Flutter.h>

@interface FlutterOpenAppPlugin : NSObject<FlutterPlugin>

+(instancetype)defaultManager;
-(BOOL)handleOpenURL:(NSURL *)url;

@end
