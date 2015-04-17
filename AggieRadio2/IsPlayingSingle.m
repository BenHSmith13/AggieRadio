//
//  IsPlayingSingle.m
//  AggieRadio2
//
//  Created by Ben Smith on 4/16/15.
//  Copyright (c) 2015 Ben Smith. All rights reserved.
//

#import "IsPlayingSingle.h"

@implementation IsPlayingSingle


+(IsPlayingSingle*)sharedInstance
{
    static IsPlayingSingle *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
        instance.isPlaying = NO;
        instance.ARFeed = [AVPlayer playerWithURL:[NSURL URLWithString:@"http://streams.tsc.usu.edu:8888/"]];
        
    });
    return instance;
}


@end
