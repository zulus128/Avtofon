//
//  XMLParser.m
//  XMLpars
//
//  Created by вадим on 2/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XMLParser.h"
#import "Common.h"

enum type {

    EN_MARK,
    EN_DEALER,
    EN_MODEL,
    EN_COMLECTATION
    
};

@implementation XMLParser

@synthesize item, dealer, model, complectation;

- (XMLParser *) initXMLParser: (int) type {
	
	[super init];
    
    itype = type;
    
	return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
	attributes:(NSDictionary *)attributeDict {
	
  //  NSLog(@"Start Element");
    
	if([elementName isEqualToString:ITEM_TAG]) {

		item = [[Mark alloc] init];
        //item.type = itype;
        //isDealer = NO;
        currtype = EN_MARK;
        
        NSLog(@"Item alloc type = %i", itype);
	}
	
    if([elementName isEqualToString:DEALER_TAG]) {
        
		dealer = [[Dealer alloc] init];
        //isDealer = YES;
        currtype = EN_DEALER;
	}	

    if([elementName isEqualToString:MODEL_TAG]) {
        
		model = [[Model alloc] init];
        currtype = EN_MODEL;
	}	

    if([elementName isEqualToString:COMPLECT_TAG]) {
        
		complectation = [[Complectation alloc] init];
        currtype = EN_COMLECTATION;
	}	

//   if ([elementName isEqualToString:IMAGE_TAG])
 //       item.image = [attributeDict objectForKey:@"url"];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	
	if(!currentElementValue)
		currentElementValue = [[NSMutableString alloc] initWithString:string];
	else
		[currentElementValue appendString:string];
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
		
	NSString* trimedStr;
	if(currentElementValue)
		trimedStr = [currentElementValue stringByTrimmingCharactersInSet:
						   [NSCharacterSet whitespaceAndNewlineCharacterSet]];


    if([elementName isEqualToString:ITEM_TAG]) {
			
        switch (itype) {
            case TYPE_DEALER:
                [[Common instance] addMarkWsDealer:item];                
                break;
            case TYPE_COMPLECTATION:
                [[Common instance] addMarkWsPrice:item];                
                break;
            default:
                break;
        }
        [item release];
    }
    else
        if([elementName isEqualToString:DEALER_TAG]) {
            
            [item.dealers addObject:dealer];
            [dealer release];
        }	        
        else
            if([elementName isEqualToString:TITLE_TAG]) {
            
                switch(currtype) {
                        
                    case EN_MARK:
                        item.title = trimedStr;
                        break;
                    case EN_DEALER:
                        dealer.title = trimedStr;
                        break;
                    case EN_MODEL:
                        model.title = trimedStr;
                        break;
                    case EN_COMLECTATION:
                        complectation.title = trimedStr;
                        break;
                }
            }
            else
                if([elementName isEqualToString:IMAGE_TAG]) 
                    item.image = trimedStr;
                    else
                        if([elementName isEqualToString:ADDRESS_TAG]) 
                            dealer.address = trimedStr;
                            else
                                if([elementName isEqualToString:CODE_TAG]) 
                                    dealer.code = trimedStr;
                                else
                                    if([elementName isEqualToString:PROMOTION_TAG]) 
                                        dealer.promotion = trimedStr;
                                    else
                                        if([elementName isEqualToString:RECOMMEND_TAG]) 
                                            dealer.recommend = [trimedStr boolValue];
                                        
                            
	[currentElementValue release];
	currentElementValue = nil;

}

- (void) dealloc {

	//[item release];
	
	[currentElementValue release];
	[super dealloc];
}

@end
