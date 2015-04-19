//
//  EventObject.h
//  AggieRadio2
//
//  Created by Ben Smith on 4/19/15.
//  Copyright (c) 2015 Ben Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventObject : NSObject
{
    NSString* title;
    NSString* date;
    NSString* time;
}

-(void)setTitle:(NSString*)str;
-(NSString*) title;

-(void)setDate:(NSString*)str;
-(NSString*)date;

-(void)setTime:(NSString*)str;
-(NSString*)time;

@end
