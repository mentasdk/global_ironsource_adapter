//
//  ISVLionCustomInterstitial.m
//  ISVLionCustomAdapter
//
//  Created by zhoubf on 2025/10/22.
//

#import "ISVLionCustomInterstitial.h"
#import <MentaMediationGlobal/MentaMediationGlobal-umbrella.h>

@interface ISVLionCustomInterstitial () <MentaMediationInterstitialDelegate>

@property (nonatomic, strong) MentaMediationInterstitial *interstitialAd;
@property (nonatomic, weak) id<ISInterstitialAdDelegate> delegate;

@end


@implementation ISVLionCustomInterstitial

- (void)loadAdWithAdData:(nonnull ISAdData *)adData
                delegate:(nonnull id<ISInterstitialAdDelegate>)delegate {
    self.delegate = delegate;
    
    NSString *slotId = [adData getString:@"slot_id"];
    if (!slotId || !slotId.length) {
        NSLog(@"slot_id is nil");
        return;
    }
    
    self.interstitialAd = [[MentaMediationInterstitial alloc] initWithPlacementID:slotId];
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAd];
}

- (BOOL)isAdAvailableWithAdData:(nonnull ISAdData *)adData {
    return self.interstitialAd && self.interstitialAd.isAdReady;
}

- (void)showAdWithViewController:(nonnull UIViewController *)viewController
                          adData:(nonnull ISAdData *)adData
                        delegate:(nonnull id<ISInterstitialAdDelegate>)delegate {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.interstitialAd showAdFromRootViewController:viewController];
    });
}

#pragma mark - MentaMediationInterstitialDelegate

// 广告素材加载成功
- (void)menta_interstitialDidLoad:(MentaMediationInterstitial *)interstitial {
    NSLog(@"%s", __func__);
}

// 广告素材加载失败
- (void)menta_interstitialLoadFailedWithError:(NSError *)error interstitial:(MentaMediationInterstitial *)interstitial {
    NSLog(@"%s", __func__);
    
    [self.delegate adDidFailToLoadWithErrorType:ISAdapterErrorTypeNoFill
                                      errorCode:error ? error.code : 0
                                   errorMessage:error ? error.localizedDescription : nil];
}

// 广告素材渲染成功
// 此时可以获取 ecpm
- (void)menta_interstitialRenderSuccess:(MentaMediationInterstitial *)interstitial {
    NSLog(@"%s", __func__);
    
    [self.delegate adDidLoad];
}

// 广告素材渲染失败
- (void)menta_interstitialRenderFailureWithError:(NSError *)error interstitial:(MentaMediationInterstitial *)interstitial {
    NSLog(@"%s", __func__);
    
    [self.delegate adDidFailToLoadWithErrorType:ISAdapterErrorTypeInternal
                                      errorCode:error ? error.code : 0
                                   errorMessage:error ? error.localizedDescription : nil];
}

// 广告即将展示
- (void)menta_interstitialWillPresent:(MentaMediationInterstitial *)interstitial {
    NSLog(@"%s", __func__);
}

// 广告展示失败
- (void)menta_interstitialShowFailWithError:(NSError *)error interstitial:(MentaMediationInterstitial *)interstitial {
    NSLog(@"%s", __func__);
    
    [self.delegate adDidFailToShowWithErrorCode:error ? error.code : 0
                                   errorMessage:error ? error.localizedDescription : nil];
}

// 广告曝光
- (void)menta_interstitialExposed:(MentaMediationInterstitial *)interstitial {
    NSLog(@"%s", __func__);
    
    [self.delegate adDidOpen];
}

// 广告点击
- (void)menta_interstitialClicked:(MentaMediationInterstitial *)interstitial {
    NSLog(@"%s", __func__);
    
    [self.delegate adDidClick];
}

// 视频播放完成
- (void)menta_interstitialPlayCompleted:(MentaMediationInterstitial *)interstitial {
    NSLog(@"%s", __func__);
}

// 广告关闭
-(void)menta_interstitialClosed:(MentaMediationInterstitial *)interstitial {
    NSLog(@"%s", __func__);
    
    [self.delegate adDidClose];
}

@end
