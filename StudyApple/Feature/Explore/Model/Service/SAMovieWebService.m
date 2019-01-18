//
//  SAMovieWebService.m
//  StudyApple
//
//  Created by liuzhenhui on 2019/1/10.
//  Copyright © 2019 liuzhenhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SAMovieWebService.h"
#import <AFNetworking/AFNetworking.h>

static NSString * const SARequestMovieDataURL = @"http://api.douban.com/v2/movie/in_theaters?count=%@&start=%@";

@implementation SAMovieWebService

#pragma mark -Movie data webservice
+ (void)requestMovieDataWithParameters:(id)parameters start:(void (^)(void))start success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    start();
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *pageLimit = [NSString stringWithFormat:@"%d",(int32_t)[parameters[@"pageLimit"] intValue]];
    NSString *pageNum = [NSString stringWithFormat:@"%d",(int32_t)[parameters[@"pageNum"] intValue]];
    NSString *URLString = [NSString stringWithFormat:SARequestMovieDataURL,pageLimit,pageNum];
    NSURL *URL = [NSURL URLWithString:URLString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if(error){
            NSLog(@"Error:%@",error);
            failure(error);
        }else{
            NSMutableArray *movieList = [SAMovieWebService parseMovieListFromData:responseObject];
            NSDictionary * result = @{@"movieList":movieList};
            success(result);
        }
    }];
    [dataTask resume];
}

#pragma mark - Utility
+(NSMutableArray *) parseMovieListFromData:(NSDictionary *)data{
    if (!data) {
        return nil;
    }
    
    NSMutableArray *movieList = [[NSMutableArray alloc] init];
    NSArray *movieDataList = [data objectForKey:@"subjects"];
    NSLog(@"parseMovieListFromData: %d",movieDataList.count);
    for (int32_t i = 0; i < movieDataList.count; i ++) {
        SAMovie *movie = [[SAMovie alloc] init];
        
        NSDictionary *movieData = movieDataList[i];
        movie.name = [movieData objectForKey:@"title"];
        movie.year = [movieData objectForKey:@"year"];
        movie.genres = [movieData objectForKey:@"genres"];
        NSDictionary *imagesData = [movieData objectForKey:@"images"];
        if (imagesData) {
            movie.thumbnailImageURLString = [imagesData objectForKey:@"large"];
        } else {
            movie.thumbnailImageURLString = nil;
        }
        
        [movieList addObject:movie];
    }
    return [movieList mutableCopy];
}

@end
