//
//  BAHTableViewController.m
//  BAHYouTubeOAuth
//
//  Created by BHughes on 4/16/15.
//  Copyright (c) 2015 BHughes3388. All rights reserved.
//

#import "BAHTableViewController.h"

@interface BAHTableViewController (){
    
    NSMutableArray *videoArray;
}

@end

@implementation BAHTableViewController

static NSString *youTubeClientID =@"26824236956-hdhrfrkf309upo5dp9rrpg51ejfop2qa.apps.googleusercontent.com";
static NSString *youTubeClientSecret = @"JNGcNW7LyQ4YORYK4PcjqkSU";
static NSString *redirectURI = @"http://bladerfeed.comyr.com/oauth2callback";
static NSString *response_type = @"code";
static NSString *scope = @"https://www.googleapis.com/auth/youtube.readonly";
static NSString *state = @"BladerFeed";
static NSString *access_type = @"offline";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    videoArray = [[NSMutableArray alloc]init];

    [self performSelector:@selector(authorizeWithYouTube) withObject:nil afterDelay:2.0f];

}
- (void)authorizeWithYouTube{
    
    NSLog(@"inside authorizeYouTube");
    
    BAHYouTubeOAuth *youTubeOAuth = [[BAHYouTubeOAuth alloc]init];
    
    [youTubeOAuth authenticateWithYouTubeUsingYouTubeClientID:youTubeClientID
                                          youTubeClientSecret:youTubeClientSecret
                                                 responseType:response_type
                                                        scope:scope
                                                        state:state
                                               appURLCallBack:redirectURI
                                                   accessType:access_type
                                                       sender:self
                                                             :^(BOOL success, NSString *youTubeToken, NSString *youTubeRefreshToken) {
                                                                 
                                                                 if (success) {
                                                                     //the token you will use to request right now
                                                                     [[NSUserDefaults standardUserDefaults] setObject:youTubeToken forKey:@"youtube_token"];
                                                                     //token you can use to request a new token on your behalf for requestion later
                                                                     //this only shows when you ask for "offline access"
                                                                     [[NSUserDefaults standardUserDefaults] setObject:youTubeRefreshToken forKey:@"youtube_refresh"];
                                                                     
                                                                     [[NSUserDefaults standardUserDefaults] synchronize];
                                                                     
                                                                    [self requestVideosFromYouTube];
                                                                     
                                                                 }

                                                                 
                                                                 
                                                                 
                                                                 
                                                                 
                                                                 
                                                             }];
}

- (void)requestVideosFromYouTube{
    
    NSString *tokenString = [[NSUserDefaults standardUserDefaults] objectForKey:@"youtube_token"];
    
    NSString *newURL = [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/channels?part=contentDetails&mine=true&access_token=%@", tokenString];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:newURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        
        
        NSArray *videoData = [responseObject objectForKey:@"items"];
        NSDictionary *videoData2 = [videoData[0] objectForKey:@"contentDetails"];
        NSDictionary *videoData3 = [videoData2 objectForKey:@"relatedPlaylists"];
        NSString *playlistId = [videoData3 objectForKey:@"uploads"];
        
        [self requestYouTubePlayListWith:playlistId];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
    
}

- (void)requestYouTubePlayListWith:(NSString*)youTubePlayListID{
    
    NSString *tokenString = [[NSUserDefaults standardUserDefaults] objectForKey:@"youtube_token"];
    
    NSString *newURL = [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=%@&access_token=%@", youTubePlayListID, tokenString];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:newURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *playListArray = [responseObject objectForKey:@"items"];
        for (NSDictionary *video in playListArray) {
            /*
            NSMutableDictionary *videoInfo = [[NSMutableDictionary alloc]init];
            
            [videoInfo setValue:[[[video objectForKey:@"snippet"] objectForKey:@"resourceId"] objectForKey:@"videoId"] forKey:@"link"];
            [videoInfo setValue:[[video objectForKey:@"snippet"] objectForKey:@"title"] forKey:@"title"];
            [videoInfo setValue:[video objectForKey:@"description"] forKey:@"description"];
            [videoInfo setValue:[[[[video objectForKey:@"snippet"] objectForKey:@"thumbnails"] objectForKey:@"default"] objectForKey:@"url"] forKey:@"pictures"];
            */
            [videoArray addObject:[[video objectForKey:@"snippet"] objectForKey:@"title"]];
    
            
        }
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return videoArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    [cell.textLabel setText:videoArray[indexPath.row]];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
