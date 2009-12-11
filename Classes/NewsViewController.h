//
//  NewsViewController.h
//  Touch
//
//  Created by Dave Knapik on 10/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewsViewController : UITableViewController {
	NSMutableArray *newsItems;
}

@property (nonatomic, retain) NSMutableArray *newsItems;

@end
