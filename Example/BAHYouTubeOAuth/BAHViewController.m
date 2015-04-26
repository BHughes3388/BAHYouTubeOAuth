//
//  BAHViewController.m
//  BAHYouTubeOAuth
//
//  Created by BHughes on 4/25/15.
//  Copyright (c) 2015 BHughes3388. All rights reserved.
//

#import "BAHViewController.h"

@interface BAHViewController ()

@end

@implementation BAHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [titleLabel setText:@"YouTube OAuth Demo"];
    [titleLabel setTextColor:[UIColor colorWithRed:229.0f/255 green:45.0f/255 blue:39.0f/255 alpha:1.0f]];
    [titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:26.0f]];
    [titleLabel sizeToFit];
    [self.navigationItem setTitleView:titleLabel];
    
    [self.requestButton addTarget:self action:@selector(authorizeWithYouTube) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)authorizeWithYouTube{
        
    static NSString *youTubeClientID =@"26824236956-hdhrfrkf309upo5dp9rrpg51ejfop2qa.apps.googleusercontent.com";
    static NSString *youTubeClientSecret = @"JNGcNW7LyQ4YORYK4PcjqkSU";
    static NSString *redirectURI = @"http://bladerfeed.comyr.com/oauth2callback";
    static NSString *response_type = @"code";
    static NSString *scope = @"https://www.googleapis.com/auth/youtube.readonly";
    static NSString *state = @"BladerFeed";
    static NSString *access_type = @"offline";

    BAHYouTubeOAuth *youTubeOAuth = [[BAHYouTubeOAuth alloc]init];
    
    [youTubeOAuth authenticateWithYouTubeUsingYouTubeClientID:youTubeClientID
                                          youTubeClientSecret:youTubeClientSecret
                                                 responseType:response_type
                                                        scope:scope
                                                        state:state
                                               appURLCallBack:redirectURI
                                                   accessType:access_type
                                               viewController:self
                                                             :^(BOOL success, NSString *youTubeToken, NSString *youTubeRefreshToken) {
                                                                 
                                                                 if (success) {
                                                                     //the token you will use to request right now
                                                                     [[NSUserDefaults standardUserDefaults] setObject:youTubeToken forKey:@"youtube_token"];
                                                                     //token you can use to request a new token on your behalf for requestion later
                                                                     //this only shows when you ask for "offline access"
                                                                     [[NSUserDefaults standardUserDefaults] setObject:youTubeRefreshToken forKey:@"youtube_refresh"];
                                                                     
                                                                     [[NSUserDefaults standardUserDefaults] synchronize];
                                                                     
                                                                     [self performSegueWithIdentifier:@"Videos" sender:self];
                                                                 }

                                                                 
                                                             }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
