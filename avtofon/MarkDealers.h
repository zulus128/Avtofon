//
//  MarkDealers.h
//  avtofon
//
//  Created by naceka on 23.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mark.h"

@interface MarkDealers : UITableViewController {
    
}

-(void) dialNumber:(int)n;

@property (nonatomic, retain) Mark* mark;

@end
