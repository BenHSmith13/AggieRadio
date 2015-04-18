//
//  SingleArticleViewController.h
//  AggieRadio2
//
//  Created by Ben Smith on 4/18/15.
//  Copyright (c) 2015 Ben Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedItem.h"

@interface SingleArticleViewController : UIViewController{
    MWFeedItem *item;
}

-(instancetype) initWithNothing;
@property (nonatomic, strong) MWFeedItem *item;

@end
