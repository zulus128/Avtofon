//
//  Common.m
//
//  Created by вадим on 6/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Common.h"

@implementation UINavigationBar (UINavigationBarCategory)

-(void)setBackgroundImage:(UIImage*)image{
    
    if(image == NULL){ 

        [[Common instance].aTabBarBackground removeFromSuperview];
        return;
    }

    [Common instance].aTabBarBackground.frame = CGRectMake(0,0,self.frame.size.width,self.frame.size.height);
    [self addSubview:[Common instance].aTabBarBackground];
    [self sendSubviewToBack:[Common instance].aTabBarBackground];

}

@end

@implementation Common

@synthesize dealerFilePath = _dealerFilePath;
@synthesize priceFilePath = _priceFilePath;
@synthesize creamFilePath = _creamFilePath;
@synthesize aTabBarBackground = _aTabBarBackground;

+ (Common*) instance  {
	
	static Common* instance;
	
	@synchronized(self) {
		
		if(!instance) {
			
			instance = [[Common alloc] init];
		}
	}
	return instance;
}

- (id) init{	
	
	self = [super init];
	if(self !=nil) {

        self.aTabBarBackground = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"greenbox.png"]];
        
        dealers = [[NSMutableArray alloc] init];
        prices = [[NSMutableArray alloc] init];
        creams = [[NSMutableArray alloc] init];
        
 		NSArray* sp = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString* docpath = [sp objectAtIndex: 0];
        self.dealerFilePath = [docpath stringByAppendingPathComponent:@"dealers.plist"];
		BOOL fe = [[NSFileManager defaultManager] fileExistsAtPath:self.dealerFilePath];
		if(!fe) {
            
            NSLog(@"NO dealers.plist FILE !!! Creating...");
            NSString *appFile = [[NSBundle mainBundle] pathForResource:@"dealers" ofType:@"plist"];
			NSError *error;
			NSFileManager *fileManager = [NSFileManager defaultManager];
			[fileManager copyItemAtPath:appFile toPath:self.dealerFilePath error:&error];
			
		}
        dealer_file = [[NSMutableDictionary alloc] initWithContentsOfFile:self.dealerFilePath];

        self.priceFilePath = [docpath stringByAppendingPathComponent:@"prices.plist"];		
        fe = [[NSFileManager defaultManager] fileExistsAtPath:self.priceFilePath];
		if(!fe) {
            
            NSLog(@"NO prices.plist FILE !!! Creating...");
            NSString *appFile = [[NSBundle mainBundle] pathForResource:@"prices" ofType:@"plist"];
			NSError *error;
			NSFileManager *fileManager = [NSFileManager defaultManager];
			[fileManager copyItemAtPath:appFile toPath:self.priceFilePath error:&error];
			
		}
        price_file = [[NSMutableDictionary alloc] initWithContentsOfFile:self.priceFilePath];

        self.creamFilePath = [docpath stringByAppendingPathComponent:@"creams.plist"];		
        fe = [[NSFileManager defaultManager] fileExistsAtPath:self.creamFilePath];
		if(!fe) {
            
            NSLog(@"NO creams.plist FILE !!! Creating...");
            NSString *appFile = [[NSBundle mainBundle] pathForResource:@"creams" ofType:@"plist"];
			NSError *error;
			NSFileManager *fileManager = [NSFileManager defaultManager];
			[fileManager copyItemAtPath:appFile toPath:self.creamFilePath error:&error];
			
		}
        cream_file = [[NSMutableDictionary alloc] initWithContentsOfFile:self.creamFilePath];

	}
	return self;	
}

- (void) dealloc {
    
	[dealers release];
    [prices release];
    [creams release];
    
    [_dealerFilePath release];
    [_priceFilePath release];
    [_creamFilePath release];
    [_aTabBarBackground release];
    
	[super dealloc];
}

- (void)clearMarkWsDealers {
    
    [dealers removeAllObjects];
}

- (void)addMarkWsDealer: (Mark*)item {
   
    [dealers addObject:item];
    NSLog(@"Dealer added, title: %@", item.title);
}

- (int) getMarkWsDealersCount {

    return [dealers count];
}

- (Mark*) getMarkWsDealerAt: (int)num {
    
    return [dealers objectAtIndex:num];
}

- (void)clearMarkWsPrices {
    
    [prices removeAllObjects];
}

- (void)addMarkWsPrice: (Mark*)item {
    
    [prices addObject:item];
    NSLog(@"Price added, title: %@", item.title);
}

- (int) getMarkWsPricesCount {
    
    return [prices count];
}

- (Mark*) getMarkWsPriceAt: (int)num {
    
    return [prices objectAtIndex:num];
}

- (void)clearMarkWsCreams {
    
    [creams removeAllObjects];
}

- (void)addMarkWsCream: (Mark*)item {
    
    [creams addObject:item];
    NSLog(@"Cream added, title: %@", item.title);
}

- (int) getMarkWsCreamsCount {
    
    return [creams count];
}

- (Mark*) getMarkWsCreamAt: (int)num {
    
    return [creams objectAtIndex:num];
}

- (BOOL) isOnlyWiFi {
    
	return [[NSUserDefaults standardUserDefaults] boolForKey:@"onlyWiFi"];
}

- (void) setOnlyWiFi: (BOOL)b {
	
	[[NSUserDefaults standardUserDefaults] setBool:b forKey:@"onlyWiFi"];
    
}

- (void) saveDealersPreload {
    
}

- (void) savePricesPreload {
    
}

- (void) saveCreamsPreload {
    
}

@end
