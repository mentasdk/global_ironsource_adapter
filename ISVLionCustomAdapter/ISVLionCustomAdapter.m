//
//  ISVLionCustomAdapter.m
//  ISVLionCustomAdapter
//
//  Created by zhoubf on 2025/10/22.
//

#import "ISVLionCustomAdapter.h"
#import <MentaMediationGlobal/MentaMediationGlobal-umbrella.h>

@implementation ISVLionCustomAdapter

-(void)init:(ISAdData *)adData delegate:(id<ISNetworkInitializationDelegate>)delegate {
    MentaAdSDK *instance = MentaAdSDK.shared;
    if (instance.isInitialized) {
        return;
    }
    
    NSLog(@"%s", __func__);
    
    NSString *appId = [adData getString:@"app_id"];
    NSString *appKey = [adData getString:@"app_key"];
    if (!appId || !appKey) {
        [delegate onInitDidFailWithErrorCode:ISAdapterErrorMissingParams
                                errorMessage:@"app_id or app_key is nil"];
        return;
    }
    
    [instance startWithAppID:appId
                      appKey:appKey
                 finishBlock:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            NSLog(@"menta sdk init success");
            [delegate onInitDidSucceed];
        } else {
            NSLog(@"menta sdk init failure. %@", error);
            [delegate onInitDidFailWithErrorCode:ISAdapterErrorInternal
                                    errorMessage:error ? error.localizedDescription : nil];
        }
    }];
}

- (NSString *) networkSDKVersion {
    return MentaAdSDK.shared.sdkVersion;
}

- (NSString *) adapterVersion {
   return @"1.0.01";
}

@end
