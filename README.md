# BAHYouTubeOAuth

[![CI Status](http://img.shields.io/travis/BHughes3388/BAHYouTubeOAuth.svg?style=flat)](https://travis-ci.org/BHughes3388/BAHYouTubeOAuth)
[![Version](https://img.shields.io/cocoapods/v/BAHYouTubeOAuth.svg?style=flat)](http://cocoadocs.org/docsets/BAHYouTubeOAuth)
[![License](https://img.shields.io/cocoapods/l/BAHYouTubeOAuth.svg?style=flat)](http://cocoadocs.org/docsets/BAHYouTubeOAuth)
[![Platform](https://img.shields.io/cocoapods/p/BAHYouTubeOAuth.svg?style=flat)](http://cocoadocs.org/docsets/BAHYouTubeOAuth)

## Preview

![](http://img.photobucket.com/albums/v235/rx7anator/Mobile%20Applications/342fcd25-dcb1-4c74-80a4-1665d0e97d68_zpsqxklg9jn.png) ![](http://img.photobucket.com/albums/v235/rx7anator/Mobile%20Applications/YouTubeOAuth_zpsjntsroya.gif)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

BAHYouTubeOAuth is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "BAHYouTubeOAuth"

## Setup

Import
```Objective-C
#import "BAHYouTubeOAuth.h"
```

Where ever you would like your user to login to YouTube and retrieve a token 
```Objective-C
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

                                                                //Do whatever you need with the token
                                                                
                                                                }


                                                            }];
```

## Author

BHughes3388, BHughes3388@gmail.com

## License

BAHYouTubeOAuth is available under the MIT license. See the LICENSE file for more info.

