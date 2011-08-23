//
//  MarkWsDealers.m
//  avtofon
//
//  Created by вадим on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Mark.h"

@implementation Mark

@synthesize title, image, dealers, models;

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.dealers = [[NSMutableArray alloc] init];
        self.models = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void) dealloc {
    
//	[dealers release];
//    [models release];
    self.dealers = nil;
    self.models = nil;
    
 	[super dealloc];
}

@end
