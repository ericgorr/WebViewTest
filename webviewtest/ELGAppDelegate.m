//
//  ELGAppDelegate.m
//  webviewtest
//
//  Created by Eric Gorr on 2/7/13.
//  Copyright (c) 2013 Eric Gorr. All rights reserved.
//

#import "ELGAppDelegate.h"
#import <WebKit/WebKit.h>
#import <stdlib.h>


@implementation ELGAppDelegate



- (NSString*) obtainHTMLString:(u_int32_t)limit outParagraphs:(NSInteger*)count
{
	NSXMLElement*	node;
		
	NSUInteger			x;
	NSMutableArray*		paragraphs	= [NSMutableArray array];

	*count = arc4random_uniform( limit ) + 1;

	for ( x = 0; x < *count; x++ )
	{
		node = [NSXMLElement elementWithName:@"p" stringValue:[NSString stringWithFormat:@"%lu: %@", x + 1, [NSDate date]]];
		
		[paragraphs addObject:node];
	}
	
	NSXMLNode*	divID = [NSXMLNode attributeWithName:@"id" stringValue:@"foo"];
	
	node = [NSXMLNode elementWithName:@"div" children:paragraphs attributes:@[ divID ]];
		
	NSXMLDocument*	document		= [NSXMLDocument documentWithRootElement:node];
	NSData*			documentData	= [document XMLDataWithOptions:NSXMLDocumentTidyHTML];
	NSString*		htmlString		= [[NSString alloc] initWithData:documentData encoding:NSUTF8StringEncoding];
	
	return htmlString;
}



- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
}



- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
	NSString*	heightOutput	= [sender stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"foo\").scrollHeight;"];
	NSInteger	height			= [heightOutput integerValue];
									
	[[self splitView] setPosition:height + 10 ofDividerAtIndex:0];
}



- (IBAction) actionNewHTMLContent:(id)sender
{
	NSInteger count;
	
	NSString*	htmlString = [self obtainHTMLString:10 outParagraphs:&count];
		
	[self setNParagraphs:[NSNumber numberWithInteger:count]];
	
	[[[self webA] mainFrame] loadHTMLString:htmlString baseURL:nil];
	
	htmlString = [self obtainHTMLString:10000 outParagraphs:&count];
	
	[[[self webB] mainFrame] loadHTMLString:htmlString baseURL:nil];
}



- (IBAction) actionPrintFrame:(id)sender
{
	NSLog( @"%@", NSStringFromRect( [[self webA] frame] ) );
}



@end
