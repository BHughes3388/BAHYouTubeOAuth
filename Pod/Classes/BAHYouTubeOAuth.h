//
//  BAHYouTubeOAuth.h
//  Pods
//
//  Created by BHughes on 2/11/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BAHYouTubeOAuthViewController.h"

typedef void (^YouTubeCompletelion)(BOOL success, NSString *youTubeToken, NSString *youTubeRefreshToken);


@interface BAHYouTubeOAuth : NSObject

@property(copy, nonatomic)YouTubeCompletelion completelion;


- (void)authenticateWithYouTubeUsingYouTubeClientID:(NSString*)youTubeClientID
                                youTubeClientSecret:(NSString*)youTubeClientSecret
                                       responseType:(NSString*)youTubeResponseType
                                              scope:(NSString*)scope
                                              state:(NSString*)state
                                     appURLCallBack:(NSString*)appURLCallBack
                                         accessType:(NSString*)youTubeAccessType
                                     viewController:(id)viewController
                                                   :(void (^)(BOOL success, NSString *youTubeToken, NSString *youTubeRefreshToken))completelion;


@end
