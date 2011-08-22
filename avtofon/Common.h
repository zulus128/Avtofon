//
//  Common.h_
//  Created by вадим on 6/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

#define TITLE_TAG @"title"
#define IMAGE_TAG @"img"

enum item_types {
    
    TYPE_DEALER,
    TYPE_COMPLECTATION
};

@interface UINavigationBar (UINavigationBarCategory)
-(void) setBackgroundImage:(UIImage*)image;
@end

@interface Common : NSObject {
 
    NSMutableArray* dealers;
    NSMutableArray* prices;
}

@property (nonatomic, retain) NSString* dealerFilePath;
@property (nonatomic, retain) NSString* priceFilePath;
@property (nonatomic, retain) UIImageView *aTabBarBackground;

+ (Common*)instance;

- (void)clearDealers;
- (void)addDealer: (Item*)item;
- (int) getDealersCount;
- (Item*) getDealerAt: (int)num;

- (BOOL) isOnlyWiFi;
- (void) setOnlyWiFi: (BOOL)b;


@end
