//
//  NewsItemViewController.m
//  Touch
//
//  Created by Dave Knapik on 13/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NewsItemViewController.h"
#import "NewsItem.h"

@implementation NewsItemViewController

@synthesize webView;
@synthesize newsItem;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewDidLoad {
	[webView loadHTMLString:newsItem.description baseURL:nil];
    [super viewDidLoad];
}

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

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.webView = nil;
}


- (void)dealloc {
	[webView release];
	[newsItem release];
    [super dealloc];
}


@end
