//
//  CreamTable.h
//  avtofon
//
//  Created by naceka on 26.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <UIKit/UIKit.h>

@interface CreamTable : UITableViewController

- (void)refresh: (BOOL)hand;
- (void)addPreloadedCreams;
- (BOOL)addCreams: (NSString*) url;

@end
