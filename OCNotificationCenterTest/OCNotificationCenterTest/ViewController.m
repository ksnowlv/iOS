//
//  ViewController.m
//  OCNotificationCenterTest
//
//  Created by ksnowlv on 2024/9/30.
//

#import "ViewController.h"
#import "AClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AClass* a = [AClass new];
    [a test];
}


@end
