//
//  ISVlionCustomBanner.m
//  ISVlionCustomAdapter
//
//  Created by zhoubf on 2025/10/22.
//

#import "ISVlionCustomBanner.h"
#import <MentaMediationGlobal/MentaMediationGlobal-umbrella.h>

@interface ISVlionCustomBanner () <MentaMediationBannerDelegate>

@property (nonatomic, strong) MentaMediationBanner *bannerAd;
@property (nonatomic, strong) ISBannerSize *size;
@property (nonatomic, weak) id<ISBannerAdDelegate> delegate;

@end


@implementation ISVlionCustomBanner

- (void)loadAdWithAdData:(nonnull ISAdData *)adData
          viewController:(UIViewController *)viewController
                    size:(ISBannerSize *)size
                delegate:(nonnull id<ISBannerAdDelegate>)delegate {
    self.size = size;
    self.delegate = delegate;
    
    [self destroyAd];
    
    NSString *slotId = [adData getString:@"slot_id"];
    if (!slotId || !slotId.length) {
        NSLog(@"slot_id is nil");
        return;
    }
    
    self.bannerAd = [[MentaMediationBanner alloc] initWithPlacementID:slotId];
    self.bannerAd.delegate = self;
    [self.bannerAd loadAd];
}

- (void)destroyAdWithAdData:(ISAdData *)adData {
    [self destroyAd];
}

- (void)destroyAd {
    if (self.bannerAd) {
        self.bannerAd.delegate = nil;
        self.bannerAd = nil;
    }
}

#pragma mark - MentaMediationBannerDelegate

// 广告素材加载成功
- (void)menta_bannerAdDidLoad:(MentaMediationBanner *)banner {
    NSLog(@"%s", __func__);
    
    // [self.delegate adDidLoad];
}

// 广告素材加载失败
- (void)menta_bannerAdLoadFailedWithError:(NSError *)error banner:(MentaMediationBanner *)banner {
    NSLog(@"%s", __func__);
    
    [self.delegate adDidFailToLoadWithErrorType:ISAdapterErrorTypeNoFill
                                      errorCode:error ? error.code : 0
                                   errorMessage:error ? error.localizedDescription : nil];
}

// 广告素材渲染成功
// 此时可以获取 ecpm
- (void)menta_bannerAdRenderSuccess:(MentaMediationBanner *)banner bannerAdView:(UIView *)bannerAdView {
    NSLog(@"%s", __func__);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        bannerAdView.frame = CGRectMake(0, 0, self.size.width, self.size.height);
        [self.delegate adDidLoadWithView:bannerAdView];
    });
}

// 广告素材渲染失败
- (void)menta_bannerAdRenderFailureWithError:(NSError *)error banner:(MentaMediationBanner *)banner {
    NSLog(@"%s", __func__);
    
    [self.delegate adDidFailToLoadWithErrorType:ISAdapterErrorTypeInternal
                                      errorCode:error ? error.code : 0
                                   errorMessage:error ? error.localizedDescription : nil];
}

// 广告曝光
- (void)menta_bannerAdExposed:(MentaMediationBanner *)banner {
    NSLog(@"%s", __func__);
    
    [self.delegate adDidOpen];
}

// 广告点击
- (void)menta_bannerAdClicked:(MentaMediationBanner *)banner {
    NSLog(@"%s", __func__);
    
    [self.delegate adDidClick];
}

// 广告关闭
-(void)menta_bannerAdClosed:(MentaMediationBanner *)banner {
    NSLog(@"%s", __func__);
    
    [self.delegate adDidDismissScreen];
}

@end
