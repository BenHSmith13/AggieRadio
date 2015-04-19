//
//  EventObject.m
//  AggieRadio2
//
//  Created by Ben Smith on 4/19/15.
//  Copyright (c) 2015 Ben Smith. All rights reserved.
//

#import "EventObject.h"

@implementation EventObject

-(void)setTitle:(NSString *)str
{
    title = str;
}
-(void)setDate:(NSString *)str
{
    date = str;
}
-(void)setTime:(NSString *)str
{
    time = str;
}

-(NSString*)title
{
    return title;
}
-(NSString*)date
{
    return date;
}
-(NSString*)time
{
    return time;
}



@end
