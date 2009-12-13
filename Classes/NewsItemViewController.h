//
//  NewsItemViewController.h
//  Touch
//
//  Created by Dave Knapik on 13/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsItem;

@interface NewsItemViewController : UIViewController {
	UIWebView *webView;
	NewsItem *newsItem;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) NewsItem *newsItem;

@end
