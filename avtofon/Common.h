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
#define MODEL_TAG @"model"
#define COMPLECT_TAG @"complect"
#define YEAR_TAG @"year"
#define VOLUME_TAG @"volume"
#define POWER_TAG @"power"
#define FUEL_TAG @"fuel"
#define TRANSMISSION_TAG @"transmision"
#define GEARBOX_TAG @"gearbox"
#define PRICE_TAG @"price"
#define PRICESPEC_TAG @"pricespec"

#define MENU_URL_FOR_REACH @"www.avtofon.com"
#define XMLDEALERS_URL @"http://avtofon.com/sheet/xmldealer"
#define XMLPRICES_URL @"http://avtofon.com/sheet/xmlprice"
#define XMLCREAMS_URL @"http://avtofon.com/sheet/xmlcream"

enum item_types {
    
    TYPE_DEALER,
    TYPE_COMPLECTATION,
    TYPE_CREAM
};

@interface UINavigationBar (UINavigationBarCategory)
-(void) setBackgroundImage:(UIImage*)image;
@end

@interface Common : NSObject {
 
    NSMutableArray* dealers;
    NSMutableArray* prices;
    NSMutableArray* creams;
    
    NSMutableDictionary* dealer_file;
    NSMutableDictionary* price_file;
    NSMutableDictionary* cream_file;
    
}

@property (nonatomic, retain) NSString* dealerFilePath;
@property (nonatomic, retain) NSString* priceFilePath;
@property (nonatomic, retain) NSString* creamFilePath;
@property (nonatomic, retain) UIImageView *aTabBarBackground;
@property (nonatomic, retain) NSString* docpath;

+ (Common*)instance;

- (void) saveImage: (UIImage*)img name:(NSString*)name;
- (UIImage*) getImage: (NSString*)name;

- (void)clearMarkWsDealers;
- (void)addMarkWsDealer: (Mark*)item;
- (int) getMarkWsDealersCount;
- (Mark*) getMarkWsDealerAt: (int)num;

- (void)clearMarkWsPrices;
- (void)addMarkWsPrice: (Mark*)item;
- (int) getMarkWsPricesCount;
- (Mark*) getMarkWsPriceAt: (int)num;

- (void)clearMarkWsCreams;
- (void)addMarkWsCream: (Mark*)item;
- (int) getMarkWsCreamsCount;
- (Mark*) getMarkWsCreamAt: (int)num;

- (BOOL) isOnlyWiFi;
- (void) setOnlyWiFi: (BOOL)b;

- (void) saveDealersPreload;
- (void) savePricesPreload;
- (void) saveCreamsPreload;

@end
