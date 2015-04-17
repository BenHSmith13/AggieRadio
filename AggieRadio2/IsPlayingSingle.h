//
//  IsPlayingSingle.h
//  AggieRadio2
//
//  Created by Ben Smith on 4/16/15.
//  Copyright (c) 2015 Ben Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@interface IsPlayingSingle : NSObject

+(IsPlayingSingle*)sharedInstance;
-(void) startFeed;


@property(nonatomic, assign) BOOL isPlaying;
@property(nonatomic, strong) AVAudioPlayer* ARFeed;

@end
