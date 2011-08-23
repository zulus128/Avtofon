//
//  XMLParser.m
//  XMLpars
//
//  Created by вадим on 2/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XMLParser.h"
#import "Common.h"

@implementation XMLParser

@synthesize item, dealer;

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
        
        NSLog(@"Item alloc type = %i", itype);
	}
	
    if([elementName isEqualToString:DEALER_TAG]) {
        
		dealer = [[Dealer alloc] init];
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
                //[[Common instance] addQA:item];                
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
            dealer = nil;
        }	        
        else
            
        if([elementName isEqualToString:TITLE_TAG]) {
            
            if(dealer)
                dealer.title = trimedStr;
            else
                item.title = trimedStr;
        }
            else
                if([elementName isEqualToString:IMAGE_TAG]) 
                    item.image = trimedStr;
                    else
                        //if([elementName isEqualToString:IMAGE_TAG]) 
                            
	[currentElementValue release];
	currentElementValue = nil;

}

- (void) dealloc {

	[item release];
	
	[currentElementValue release];
	[super dealloc];
}

@end
