//
//  BAHYouTubeOAuthViewController.h
//  Pods
//
//  Created by BHughes on 2/11/15.
//
//

#import <UIKit/UIKit.h>
#import "BAHYouTubeOAuth.h"

@interface BAHYouTubeOAuthViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic, strong)id youTubeSender;

@property (nonatomic, strong)UIWebView *oAuthWebView;

@property (nonatomic, strong)NSString *youtubeClientID;

@property (nonatomic, strong)NSString *youtubeClientSecret;

@property (nonatomic, strong)NSString *uriCallBack;

@property (nonatomic, strong)NSString *state;

@end
