//
//  MarkWsDealers.h
//  avtofon
//
//  Created by вадим on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mark : NSObject {
    
}

@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* image;
@property (nonatomic, retain) NSMutableArray* dealers;
@property (nonatomic, retain) NSMutableArray* models;

@end
