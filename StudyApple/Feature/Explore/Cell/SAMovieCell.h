//
//  MovieCell.h
//  StudyApple
//
//  Created by liuzhenhui on 2019/1/21.
//  Copyright © 2019 liuzhenhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SAMovie.h"

@interface SAMovieCell : UITableViewCell

@property(nonatomic,strong) IBOutlet UIImageView *movieImageView;
@property(nonatomic,strong) IBOutlet UILabel *nameLabel;
@property(nonatomic,strong) IBOutlet UILabel *yearLabel;

-(void)config:(SAMovie *)model;

@end
