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

@interface XMLParser : NSObject <NSXMLParserDelegate> {

	NSMutableString* currentElementValue;
    int itype;
    BOOL isDealer;
}

- (XMLParser *) initXMLParser: (int) type;

@property (nonatomic, retain) Mark* item;
@property (nonatomic, retain) Dealer* dealer;

@end
