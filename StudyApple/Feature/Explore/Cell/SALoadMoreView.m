//
//  SALoadMoreView.m
//  StudyApple
//
//  Created by liuzhenhui on 2019/1/16.
//  Copyright © 2019 liuzhenhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SALoadMoreView.h"

@implementation SALoadMoreView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _ActivityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _ActivityView.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        [self addSubview:_ActivityView];
        
        _tipsLabel = [[UILabel alloc]initWithFrame:frame];
        _tipsLabel.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        _tipsLabel.text = @"没有更多数据";
        _tipsLabel.hidden = YES;
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.textColor = [UIColor lightGrayColor];
        _tipsLabel.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:_tipsLabel];
    }
    return self;
}

- (void)startAnimation{
    _ActivityView.hidden = NO;
    [_ActivityView startAnimating];
    _tipsLabel.hidden = YES;
}

- (void)stopAnimation{
    if (_ActivityView.isAnimating == NO) {
        return;
    }
    _ActivityView.hidden = YES;
    [_ActivityView stopAnimating];
}

- (BOOL)isAnimating{
    return _ActivityView.isAnimating;
}

- (void)noMoreData{
    _tipsLabel.hidden = NO;
}

- (void)restartLoadData{
    _tipsLabel.hidden = YES;
}

@end
