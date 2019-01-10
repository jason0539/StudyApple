//
//  SAMovie.h
//  StudyApple
//
//  Created by liuzhenhui on 2019/1/10.
//  Copyright © 2019 liuzhenhui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAMovie : NSObject

@property (assign, nonatomic) int64_t rowid;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *year;
@property (copy, nonatomic) NSString *genres;
@property (copy, nonatomic) NSString *thumbnailImageURLString;

@end
