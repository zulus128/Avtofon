//
//  Model.m
//  avtofon
//
//  Created by naceka on 23.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Model.h"


@implementation Model

@synthesize title, image, complectations;

- (id)init {
    
    self = [super init];
    if (self) {
        // Initialization code here.
        
        self.complectations = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void) dealloc {
    
    self.complectations = nil;
    
 	[super dealloc];
}

@end
