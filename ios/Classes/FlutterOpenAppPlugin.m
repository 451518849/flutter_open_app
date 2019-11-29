#import "FlutterOpenAppPlugin.h"

@interface FlutterOpenAppPlugin()
@property (nonatomic, copy) FlutterResult completedBlock;
@end

@implementation FlutterOpenAppPlugin

+(instancetype)defaultManager{
    static dispatch_once_t onceToken;
    static FlutterOpenAppPlugin *instance;
    dispatch_once(&onceToken, ^{
        instance = [[FlutterOpenAppPlugin alloc] init];
    });
    return instance;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_open_app"
            binaryMessenger:[registrar messenger]];
  FlutterOpenAppPlugin* instance = [[FlutterOpenAppPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}


- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
 
  if([@"openUrl" isEqualToString:call.method]){
      NSString *openUrl = call.arguments[@"openUrl"];
      [self openUrl:openUrl completed:result];
  }
  else {
    result(FlutterMethodNotImplemented);
  }
}

-(void)openUrl:(NSString *)openUrl completed:(FlutterResult)completedBlock{
    if(completedBlock){
        
        //这里不能使用self.completedBlock，因为调用当前方法的对象由系统创建，并不是单例
        [FlutterOpenAppPlugin defaultManager].completedBlock = [completedBlock copy];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl]];
}

-(BOOL)handleOpenURL:(NSURL *)url{

    //这个方法有我们自己控制，因此可以保证是单例，可以使用self.completedBlock
    if(self.completedBlock) {
        NSLog(@"completedBlock");
        self.completedBlock(url.absoluteURL.absoluteString);
        return YES;
    }

    return NO;
}

@end
