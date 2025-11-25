//
//  ISVLionCustomRewardedVideo.m
//  ISVLionCustomAdapter
//
//  Created by zhoubf on 2025/10/22.
//

#import "ISVLionCustomRewardedVideo.h"
#import <MentaMediationGlobal/MentaMediationGlobal-umbrella.h>

@interface ISVLionCustomRewardedVideo () <MentaMediationRewardVideoDelegate>

@property (nonatomic, strong) MentaMediationRewardVideo *rewardedVideo;
@property (nonatomic, weak) id<ISRewardedVideoAdDelegate> delegate;

@end


@implementation ISVLionCustomRewardedVideo

- (void)loadAdWithAdData:(nonnull ISAdData *)adData
                delegate:(nonnull id<ISRewardedVideoAdDelegate>)delegate {
    self.delegate = delegate;
    
    NSString *slotId = [adData getString:@"slot_id"];
    if (!slotId || !slotId.length) {
        NSLog(@"slot_id is nil");
        return;
    }
    
    self.rewardedVideo = [[MentaMediationRewardVideo alloc] initWithPlacementID:slotId];
    self.rewardedVideo.delegate = self;
    [self.rewardedVideo loadAd];
}

- (BOOL)isAdAvailableWithAdData:(nonnull ISAdData *)adData {
    return self.rewardedVideo && self.rewardedVideo.isAdReady;
}

- (void)showAdWithViewController:(UIViewController *)viewController
                          adData:(ISAdData *)adData
                        delegate:(id<ISRewardedVideoAdDelegate>)delegate {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.rewardedVideo showAdFromRootViewController:viewController];
    });
}

#pragma mark - MentaMediationRewardVideoDelegate

// 广告素材加载成功
- (void)menta_rewardVideoDidLoad:(MentaMediationRewardVideo *)rewardVideo {
    NSLog(@"%s", __func__);
}

// 广告素材加载失败
- (void)menta_rewardVideoLoadFailedWithError:(NSError *)error rewardVideo:(MentaMediationRewardVideo *)rewardVideo {
    NSLog(@"%s", __func__);
    
    [self.delegate adDidFailToLoadWithErrorType:ISAdapterErrorTypeNoFill
                                      errorCode:error ? error.code : 0
                                   errorMessage:error ? error.localizedDescription : nil];
}

// 广告素材渲染成功
// 此时可以获取 ecpm
- (void)menta_rewardVideoRenderSuccess:(MentaMediationRewardVideo *)rewardVideo {
    NSLog(@"%s", __func__);
    
    [self.delegate adDidLoad];
}

// 广告素材渲染失败
- (void)menta_rewardVideoRenderFailureWithError:(NSError *)error rewardVideo:(MentaMediationRewardVideo *)rewardVideo {
    NSLog(@"%s", __func__);
    
    [self.delegate adDidFailToLoadWithErrorType:ISAdapterErrorTypeInternal
                                      errorCode:error ? error.code : 0
                                   errorMessage:error ? error.localizedDescription : nil];
}

// 激励视频广告即将展示
- (void)menta_rewardVideoWillPresent:(MentaMediationRewardVideo *)rewardVide {
    NSLog(@"%s", __func__);
}

// 激励视频广告展示失败
- (void)menta_rewardVideoShowFailWithError:(NSError *)error rewardVideo:(MentaMediationRewardVideo *)rewardVideo {
    NSLog(@"%s", __func__);
    
    [self.delegate adDidFailToShowWithErrorCode:error ? error.code : 0
                                   errorMessage:error ? error.localizedDescription : nil];
}

// 激励视频广告曝光
- (void)menta_rewardVideoExposed:(MentaMediationRewardVideo *)rewardVideo {
    NSLog(@"%s", __func__);
    
    [self.delegate adDidOpen];
}

// 激励视频广告点击
- (void)menta_rewardVideoClicked:(MentaMediationRewardVideo *)rewardVideo {
    NSLog(@"%s", __func__);
    
    [self.delegate adDidClick];
}

// 激励视频广告跳过
- (void)menta_rewardVideoSkiped:(MentaMediationRewardVideo *)rewardVideo {
    NSLog(@"%s", __func__);
}

// 激励视频达到奖励节点
- (void)menta_rewardVideoDidEarnReward:(MentaMediationRewardVideo *)rewardVideo {
    NSLog(@"%s", __func__);
    
    [self.delegate adRewarded];
}

// 激励视频播放完成
- (void)menta_rewardVideoPlayCompleted:(MentaMediationRewardVideo *)rewardVideo {
    NSLog(@"%s", __func__);
    
    [self.delegate adDidEnd];
}

// 激励视频广告关闭
-(void)menta_rewardVideoClosed:(MentaMediationRewardVideo *)rewardVideo {
    NSLog(@"%s", __func__);
    
    [self.delegate adDidClose];
}

@end
