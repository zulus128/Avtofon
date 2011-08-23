//
//  Dealer.h
//  avtofon
//
//  Created by вадим on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dealer : NSObject

@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* address;
@property (nonatomic, retain) NSString* code;
@property (nonatomic, retain) NSString* promotion;
@property (assign, readwrite) BOOL recommend;

@end
