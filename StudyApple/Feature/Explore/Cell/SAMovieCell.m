//
//  SAMovieCell.m
//  StudyApple
//
//  Created by liuzhenhui on 2019/1/21.
//  Copyright © 2019 liuzhenhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SAMovieCell.h"
#import "SAMovie.h"
#import "SACommonUtil.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation SAMovieCell


- (void)config:(SAMovie *)model{
    [self.movieImageView sd_setImageWithURL:[NSURL URLWithString:model.thumbnailImageURLString]
                 placeholderImage:[UIImage imageNamed:@"apress_logo"]];
    self.nameLabel.text = model.name;
    self.yearLabel.text = model.year;
}

@end
