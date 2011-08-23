//
//  XMLParser.h
//  XMLpars
//
//  Created by вадим on 2/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mark.h"
#import "Dealer.h"
#import "Model.h"
#import "Complectation.h"

@interface XMLParser : NSObject <NSXMLParserDelegate> {

	NSMutableString* currentElementValue;
    int itype;
//    BOOL isDealer;
    int currtype;
}

- (XMLParser *) initXMLParser: (int) type;

@property (nonatomic, retain) Mark* item;
@property (nonatomic, retain) Dealer* dealer;
@property (nonatomic, retain) Model* model;
@property (nonatomic, retain) Complectation* complectation;

@end
