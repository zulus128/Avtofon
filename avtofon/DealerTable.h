//
//  DealerTable.h
//  avtofon
//
//  Created by вадим on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealerTable : UITableViewController

- (void)refresh: (BOOL)hand;
- (void)addPreloadedDealers;
- (BOOL)addDealers: (NSString*) url;

@end
