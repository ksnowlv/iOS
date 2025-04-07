//
//  ViewController.m
//  OCCurlTest
//
//  Created by ksnowlv on 2025/3/7.
//

#import "ViewController.h"
#import <curl/curl.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    curl_global_init(CURL_GLOBAL_ALL);
    CURL* curl = curl_easy_init();
    
    curl_version_info_data *info = curl_version_info(CURLVERSION_NOW);
    if(info->features & CURL_VERSION_HTTP2)
        printf("HTTP/2 support is present\n");

    if(info->features & CURL_VERSION_HTTP3)
        printf("HTTP/3 support is present\n");

    if(info->features & CURL_VERSION_ALTSVC)
        printf("Alt-svc support is present\n");
    
    
    printf("ssl version:%s",info->ssl_version);
    
   
    NSMutableArray<NSString *> *protocols = [NSMutableArray new];
    for (size_t i = 0; i < sizeof(info->protocols); i++)
    {
        [protocols addObject:[NSString stringWithCString:info->protocols[i] encoding:NSUTF8StringEncoding]];
    }

    NSMutableArray<NSString *> *features = [NSMutableArray new];
    for (size_t i = 0; i < sizeof(info->feature_names); i++)
    {
        [features addObject:[NSString stringWithCString:info->feature_names[i] encoding:NSUTF8StringEncoding]];
    }

    NSString* res =  [NSString stringWithFormat:@"libcurl %s using %s and libz %s on %s (supported protocols: %@), (supported features: %@)",
            info->version,
            info->ssl_version,
            info->libz_version,
            info->host,
            [protocols componentsJoinedByString:@", "],
            [features componentsJoinedByString:@", "]
    ];
    
    NSLog(@"curl info:%@", res);
    
}


@end
