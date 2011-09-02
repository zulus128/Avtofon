//
//  DealerTable.m
//  avtofon
//
//  Created by вадим on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DealerTable.h"
#import "Common.h"
#import "Reachability.h"
#import "XMLParser.h"
#import "Mark.h"
#import "MarkDealers.h"

@implementation DealerTable

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self refresh:NO];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    UIImage *image = [UIImage imageNamed: @"greenbox.png"];
    [self.navigationController.navigationBar setBackgroundImage:image];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[Common instance] getMarkWsDealersCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
        
    // Configure the cell...
    Mark* mark = [[Common instance]getMarkWsDealerAt:indexPath.row];
    cell.textLabel.text = mark.title;
    cell.imageView.image = [[Common instance] getImage:mark.image];

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    MarkDealers *detailViewController = [[MarkDealers alloc] initWithNibName:@"MarkDealers" bundle:nil];
     
    Mark* mrk = [[Common instance]getMarkWsDealerAt:indexPath.row];
    detailViewController.mark = mrk;
    
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
     
}


- (void)refresh: (BOOL)hand {
    
    NSLog(@"refresh dealers");
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
	
    BOOL b = [[Reachability reachabilityWithHostName:MENU_URL_FOR_REACH] currentReachabilityStatus];    
    if (([[Common instance] isOnlyWiFi] && (b != ReachableViaWiFi))
        || (![[Common instance] isOnlyWiFi] && (b == NotReachable))) {
        
		UIAlertView* dialog = [[UIAlertView alloc] init];
		[dialog setTitle:@"Убедитесь в наличии Интернета!"];
		[dialog setMessage:@"Невозможно загрузить список."];
		[dialog addButtonWithTitle:@"OK"];
		[dialog show];
		[dialog release];
        
        [self addPreloadedDealers];
        
/*        Item* item = [[Common instance] getsAt:0];
        self.topcell.title.text = item.title;
        self.topcell.rubric.text = item.rubric;
        self.topcell.image.image = [Common loadImage];
        [Common instance].img = self.topcell.image.image;
  */      
        [self.tableView reloadData];
		
	}else {
        
        [[Common instance] clearMarkWsDealers];
        if(![self addDealers:XMLDEALERS_URL]) {
            
            [self addPreloadedDealers];
            
           /* Item* item = [[Common instance] getNewsAt:0];
            self.topcell.title.text = item.title;
            self.topcell.rubric.text = item.rubric;
            self.topcell.image.image = [Common loadImage];
            [Common instance].img = self.topcell.image.image;
            */
            [self.tableView reloadData];
            hand = NO;
            
        }
        else {
            
            [self.tableView reloadData];
            [[Common instance] saveDealersPreload];
                
            if([[Common instance] getMarkWsDealersCount]) {
                    
              /*      
                Item* item = [[Common instance] getNewsAt:0];
                    self.topcell.title.text = item.title;
                    self.topcell.rubric.text = item.rubric;
                    self.topcell.image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: item.image]]];
                    [Common instance].img = self.topcell.image.image;
                    
                    [Common saveImage:self.topcell.image.image];
               */
            }
        }
    }
        
            
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

- (void) addPreloadedDealers {
    
 //   [[Common instance] clearNews];
 //   [[Common instance] clearQAs];
 //   [[Common instance] clearPodcasts];
    
 //   [[Common instance] loadPreloaded];
}


- (BOOL)addDealers: (NSString*) url {
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:url]];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = nil;//[[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    //        [error release];
    if (responseData == nil) {
        // Check for problems
        if (error != nil) {
            
            UIAlertView* dialog = [[UIAlertView alloc] init];
            [dialog setTitle:@"Ошибка Интернет-подключения"];
            [dialog setMessage:[error localizedDescription]];
            [dialog addButtonWithTitle:@"OK"];
            [dialog show];
            [dialog release];
            return NO;
        }
    }
    NSString *myStr = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];// NSWindowsCP1251StringEncoding];
    //myStr = [myStr stringByReplacingOccurrencesOfString:@"encoding=\"windows-1251\"" withString:@""];
    NSData* aData = [myStr dataUsingEncoding:NSUTF8StringEncoding];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:aData];
    XMLParser* parser = [[XMLParser alloc] initXMLParser:TYPE_DEALER];
    [xmlParser setDelegate:parser];    
    
    for (int i = 0; i < 5; i++) {
        
        BOOL success = [xmlParser parse];	
        
        if(success) {
            
            NSLog(@"No Errors");
            //            [self.tableView reloadData];
            break;
        }
        else {
            
            //NSLog(@"Error! Possibly xml version is not new");
            NSLog(@"Parser error: %@", [[xmlParser parserError] localizedDescription]);
            return NO;
        }
    }
    
    return YES;
}

@end
