//
//  BAHYouTubeOAuthViewController.m
//  Pods
//
//  Created by BHughes on 2/11/15.
//
//

#import "BAHYouTubeOAuthViewController.h"

@interface BAHYouTubeOAuthViewController ()

@end

@implementation BAHYouTubeOAuthViewController

static NSString *youTubeTokenURL = @"https://accounts.google.com/o/oauth2/token";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:229.0f/255 green:45.0f/255 blue:39.0f/255 alpha:1.0f]];
    
    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 80)];
    [logo setTintColor:[UIColor whiteColor]];
    [logo setContentMode:UIViewContentModeScaleAspectFit];
    [logo setImage:[[UIImage imageNamed:@"YouTube.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    [self.navigationItem setTitleView:logo];
        
    self.oAuthWebView = [[UIWebView alloc]initWithFrame:self.view.frame];
    [self.oAuthWebView setDelegate:self];
    
    [self.view addSubview:self.oAuthWebView];

    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *URLString = [[request URL] absoluteString];
    
    NSString *callBackString = [NSString stringWithFormat:@"%@?", self.uriCallBack];
    
    if ([URLString rangeOfString:callBackString].location != NSNotFound) {
        
        NSArray *codeArray = [URLString componentsSeparatedByString:@"code="];
        
        NSString *code = [codeArray lastObject];
        
        NSString *post = [NSString stringWithFormat:@"code=%@&client_id=%@&client_secret=%@&redirect_uri=%@&grant_type=authorization_code", code, self.youtubeClientID, self.youtubeClientSecret, self.uriCallBack];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[post length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:youTubeTokenURL]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody:postData];
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
            
            NSString *token = [json objectForKey:@"access_token"];
            NSString *refreshToken = [json objectForKey:@"refresh_token"];
            if (token && refreshToken) {
                
                BAHYouTubeOAuth *youTubeOAuth = (BAHYouTubeOAuth*)self.youTubeSender;
                youTubeOAuth.completelion(YES, token, refreshToken);
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }else{
                //TODO: Handle Error
            }
            
        }];
        
        return NO;
    }
    
    return YES;
    
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
