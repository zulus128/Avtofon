//
//  Common.h_
//  Created by вадим on 6/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mark.h"

#define ITEM_TAG @"mark"
#define TITLE_TAG @"title"
#define IMAGE_TAG @"img"
#define DEALER_TAG @"dealer"
#define ADDRESS_TAG @"adress"
#define CODE_TAG @"cod"
#define PROMOTION_TAG @"promotion"
#define RECOMMEND_TAG @"recommend"


#define MENU_URL_FOR_REACH @"www.avtofon.com"
#define XMLDEALERS_URL @"http://avtofon.com/sheet/xmldealer"

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
    
    NSMutableDictionary* dealer_file;
    NSMutableDictionary* price_file;
}

@property (nonatomic, retain) NSString* dealerFilePath;
@property (nonatomic, retain) NSString* priceFilePath;
@property (nonatomic, retain) UIImageView *aTabBarBackground;

+ (Common*)instance;

- (void)clearMarkWsDealers;
- (void)addMarkWsDealer: (Mark*)item;
- (int) getMarkWsDealersCount;
- (Mark*) getMarkWsDealerAt: (int)num;

- (BOOL) isOnlyWiFi;
- (void) setOnlyWiFi: (BOOL)b;

- (void) saveDealersPreload;

@end
