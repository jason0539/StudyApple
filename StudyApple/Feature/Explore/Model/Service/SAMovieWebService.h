//
//  SAMovieWebService.h
//  StudyApple
//
//  Created by liuzhenhui on 2019/1/10.
//  Copyright © 2019 liuzhenhui. All rights reserved.
//

#ifndef SAMovieWebService_h
#define SAMovieWebService_h


#endif /* SAMovieWebService_h */
#import <Foundation/Foundation.h>
#import "SAMovie.h"

@interface SAMovieWebService : NSObject
#pragma mark - Movie Data WebService
+ (void)requestMovieDataWithParameters:(id)parameters start:(void (^)(void))start success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure;
@end
