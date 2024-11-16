//
//  AClass.m
//  NotificationCenterTest
//
//  Created by ksnowlv on 2024/9/30.
//

#import "AClass.h"

@implementation AClass

static NSString * const AClassNotificationName = @"AClassNotification";

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotifation:) name:AClassNotificationName object:nil];
        __weak typeof(self) weakSelf = self;
        [[NSNotificationCenter defaultCenter] addObserverForName:AClassNotificationName object:nil queue:nil usingBlock:^(NSNotification * _Nonnull notification) {
            typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf) {
                [strongSelf handleNotifation:notification];
            }
        }];
       
        
    }
    return self;
}

- (void)dealloc {
    NSLog(@"---AClass %@",NSStringFromSelector(_cmd));
}

- (void)handleNotifation:(NSNotification* )notification {
    
    if (notification.object) {
        NSLog(@"---AClass %@,%@",NSStringFromSelector(_cmd), notification.object);
    }
}

- (void)test {
    [[NSNotificationCenter defaultCenter] postNotificationName:AClassNotificationName object:@"oc notification"];
}

@end
