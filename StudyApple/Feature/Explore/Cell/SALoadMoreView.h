//
//  SALoadMoreView.h
//  StudyApple
//
//  Created by liuzhenhui on 2019/1/16.
//  Copyright © 2019 liuzhenhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SALoadMoreView : UICollectionReusableView

@property (nonatomic,retain) UIActivityIndicatorView *ActivityView;
@property (nonatomic,retain) UILabel *tipsLabel;

- (void)startAnimation;
- (void)stopAnimation;
- (BOOL)isAnimating;
- (void)noMoreData;
- (void)restartLoadData;

@end
