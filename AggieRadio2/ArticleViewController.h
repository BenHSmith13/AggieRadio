//
//  ArticleViewController.h
//  AggieRadio2
//
//  Created by Ben Smith on 4/15/15.
//  Copyright (c) 2015 Ben Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IsPlayingSingle.h"
#import <AVFoundation/AVFoundation.h>
#import "MWFeedParser.h"

@interface ArticleViewController : UIViewController <MWFeedParserDelegate>{
    // Parsing
    MWFeedParser *feedParser;
    NSMutableArray *parsedItems;
    
    // Displaying
    NSArray *itemsToDisplay;
    NSDateFormatter *formatter;
}

@property(nonatomic, strong)NSArray *itemsToDisplay;

@end
