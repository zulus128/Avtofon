//
//  DealerTable.h
//  avtofon
//
//  Created by вадим on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealerTable : UIViewController <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource> {

    UITableView *myTableView;
    NSMutableArray *dataSource; //will be storing all the data
    NSMutableArray *tableData;//will be storing data that will be displayed in table
    NSMutableArray *searchedData;//will be storing data matching with the search string
    UISearchBar *sBar;//search bar
}

@property(nonatomic,retain)NSMutableArray *dataSource;

- (void)refresh: (BOOL)hand;
- (void)addPreloadedDealers;
- (BOOL)addDealers: (NSString*) url;

@end
