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
        
       //    NSLog(@"Model alloc");
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
            case TYPE_CREAM:
                [[Common instance] addMarkWsCream:item];                
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
            if([elementName isEqualToString:COMPLECT_TAG]) {
                
                [model.complectations addObject:complectation];
                // NSLog(@"addComplectation");
                [complectation release];
            }	        
            else
                if([elementName isEqualToString:MODEL_TAG]) {
                    
                    [item.models addObject:model];
                  //  NSLog(@"addModel");
                    [model release];
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
                if([elementName isEqualToString:IMAGE_TAG]) {

                    NSString* nm = [trimedStr lastPathComponent];
                    [[Common instance] saveImage:trimedStr name:nm];
                    switch(currtype) {
                            
                        case EN_MARK:
                            item.image = nm;
                            break;
                        case EN_MODEL:
                            model.image = nm;
                            break;
                    }
                }
                    else
                        if([elementName isEqualToString:ADDRESS_TAG]) 
                            dealer.address = trimedStr;
                            else
                                if([elementName isEqualToString:CODE_TAG]) {
                                    
                                    switch(currtype) {
                                            
                                        case EN_DEALER:
                                            dealer.code = trimedStr;
                                            break;
                                        case EN_COMLECTATION:
                                            complectation.code = trimedStr;
                                            break;
                                    }

                                }
                                    
                                else
                                    if([elementName isEqualToString:PROMOTION_TAG]) 
                                        dealer.promotion = trimedStr;
                                    else
                                        if([elementName isEqualToString:RECOMMEND_TAG]) 
                                            dealer.recommend = [trimedStr boolValue];
                                        else
                                            if([elementName isEqualToString:RECOMMEND_TAG]) 
                                                dealer.recommend = [trimedStr boolValue];
                                            else
                                                if([elementName isEqualToString:YEAR_TAG]) 
                                                    complectation.year = trimedStr;
                                                else
                                                    if([elementName isEqualToString:VOLUME_TAG]) 
                                                        complectation.volume = trimedStr;
                                                    else
                                                        if([elementName isEqualToString:POWER_TAG]) 
                                                            complectation.power = trimedStr;
                                                        else
                                                            if([elementName isEqualToString:FUEL_TAG]) 
                                                                complectation.fuel = trimedStr;
                                                            else
                                                                if([elementName isEqualToString:TRANSMISSION_TAG]) 
                                                                    complectation.transmission = trimedStr;
                                                                else
                                                                    if([elementName isEqualToString:GEARBOX_TAG]) 
                                                                        complectation.gearbox = trimedStr;
                                                                    else
                                                                        if([elementName isEqualToString:PRICE_TAG]) 
                                                                            complectation.price = trimedStr;
                                                                        else
                                                                            if([elementName isEqualToString:PRICESPEC_TAG]) 
                                                                                complectation.pricespec = trimedStr;
                                        
                            
	[currentElementValue release];
	currentElementValue = nil;

}

- (void) dealloc {

	//[item release];
	
	[currentElementValue release];
	[super dealloc];
}

@end
