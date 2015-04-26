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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    videoArray = [[NSMutableArray alloc]init];

    [self requestVideosFromYouTube];

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

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"YouTube Videos";
}

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
