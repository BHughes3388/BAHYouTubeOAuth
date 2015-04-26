//
//  BAHYouTubeOAuth.m
//  Pods
//
//  Created by BHughes on 2/11/15.
//
//

#import "BAHYouTubeOAuth.h"

@implementation BAHYouTubeOAuth

static NSString *youTubeAuthorizationURL = @"https://accounts.google.com/o/oauth2/auth";


-(void)authenticateWithYouTubeUsingYouTubeClientID:(NSString *)youTubeClientID youTubeClientSecret:(NSString *)youTubeClientSecret responseType:(NSString *)youTubeResponseType scope:(NSString *)scope state:(NSString *)state appURLCallBack:(NSString *)appURLCallBack accessType:(NSString *)youTubeAccessType viewController:(id)viewController :(void (^)(BOOL, NSString *, NSString *))completelion{
    
    
    NSString *authenticateURLString = [NSString stringWithFormat:@"%@?client_id=%@&response_type=code&state=%@&scope=%@&redirect_uri=%@&access_type=%@&approval_prompt=force", youTubeAuthorizationURL, youTubeClientID, state, scope, appURLCallBack, youTubeAccessType];
    
    BAHYouTubeOAuthViewController *OAuthController = [[BAHYouTubeOAuthViewController alloc]init];
    
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:OAuthController];
    
    [viewController presentViewController:navController animated:YES completion:^{
        OAuthController.uriCallBack = appURLCallBack;
        OAuthController.state = state;
        OAuthController.youtubeClientID = youTubeClientID;
        OAuthController.youtubeClientSecret = youTubeClientSecret;
        OAuthController.youTubeSender = self;
        [OAuthController.oAuthWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:authenticateURLString]]];
        
    }];

    self.completelion = completelion;
    
}

@end
