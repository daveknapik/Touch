//
//  NewsViewController.m
//  Touch
//
//  Created by Dave Knapik on 10/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsItemViewController.h"
#import "NewsItem.h"
#import "TouchXML.h"

@implementation NewsViewController
@synthesize newsItems;

-(void) grabRSSFeed:(NSString *)rssFeedURL {
    newsItems = [[NSMutableArray alloc] init];	
	
    NSURL *url = [NSURL URLWithString: rssFeedURL];
	
    CXMLDocument *rssParser = [[[CXMLDocument alloc] initWithContentsOfURL:url options:0 error:nil] autorelease];
	
    // Create a new Array object to be used with the looping of the results from the rssParser
    NSArray *resultNodes = NULL;
	
    // Set the resultNodes Array to contain an object for every instance of an  node in our RSS feed
    resultNodes = [rssParser nodesForXPath:@"//item" error:nil];
	
    // Loop through the resultNodes to access each items actual data
    for (CXMLElement *resultElement in resultNodes) {
		
        // Create a temporary MutableDictionary to store the items fields in, which will eventually end up in blogEntries
        NewsItem *newsItem = [[NewsItem alloc] init];
		
        // Create a counter variable as type "int"
		int counter;
		
        // Loop through the children of the current  node
		for(counter = 0; counter < [resultElement childCount]; counter++) {
			
            // Add each field to the newsItem Dictionary with the node name as key and node value as the value
            //[newsItem setObject:[[resultElement childAtIndex:counter] stringValue] forKey:[[resultElement childAtIndex:counter] name]];
        
			NSString *nodeName = [[resultElement childAtIndex:counter] name];
			
			if ([nodeName isEqualToString:@"title"]) {
				newsItem.title = [[resultElement childAtIndex:counter] stringValue];
			}
			else if ([nodeName isEqualToString:@"description"]) {
				newsItem.description = [[resultElement childAtIndex:counter] stringValue];
			}
			else if ([nodeName isEqualToString:@"link"]) {
				newsItem.link = [[resultElement childAtIndex:counter] stringValue];
			}
			else if ([nodeName isEqualToString:@"pubDate"]) {
				newsItem.pubDate = [[resultElement childAtIndex:counter] stringValue];
			}
		}
		
        // Add the blogItem to the global blogEntries Array so that the view can access it.
        [newsItems addObject:newsItem];
		[newsItem release];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if([newsItems count] == 0) {
        // Create the feed string, in this case I have used dBlog
        NSString *rssFeedURL = @"http://www.touchmusic.org.uk/index.xml ";
		
        // Call the grabRSSFeed function with the above
        // string as a parameter
        [self grabRSSFeed:rssFeedURL];
		
        // Call the reloadData function on the blogTable, this
        // will cause it to refresh itself with our new data
        [self.tableView reloadData];
    }
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
	[newsItems dealloc];
    [super dealloc];
}

#pragma mark -
#pragma mark Table Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [newsItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *NewsItemCellIdentifier = @"NewsItemCellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NewsItemCellIdentifier];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
									   reuseIdentifier:NewsItemCellIdentifier] autorelease];
	}
	
	NSUInteger row = [indexPath row];
	cell.textLabel.text = [[self.newsItems objectAtIndex:row] title];
	cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
    return cell;
}

#pragma mark -
#pragma mark Table Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath { 
    return 40; 
} 

 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row];
	NewsItem *newsItem = [self.newsItems objectAtIndex:row];
	
	NewsItemViewController *newsItemViewController = [[NewsItemViewController alloc] init];
	
	newsItemViewController.newsItem = newsItem;
	
	[self.navigationController pushViewController:newsItemViewController animated:YES];
	[newsItemViewController release];
} 

@end
