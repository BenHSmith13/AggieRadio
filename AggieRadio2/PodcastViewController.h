//
//  PodcastViewController.h
//  AggieRadio2
//
//  Created by Ben Smith on 4/14/15.
//  Copyright (c) 2015 Ben Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "IsPlayingSingle.h"
#import "MWFeedParser.h"

@interface PodcastViewController : UIViewController <MWFeedParserDelegate> {
    
    // Parsing
    MWFeedParser *feedParser;
    NSMutableArray *parsedItems;
    
    // Displaying
    NSArray *itemsToDisplay;
    NSDateFormatter *formatter;
    
}

@property (nonatomic, strong) NSArray *itemsToDisplay;

@end
