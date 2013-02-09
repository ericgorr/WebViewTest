//
//  ELGAppDelegate.h
//  webviewtest
//
//  Created by Eric Gorr on 2/7/13.
//  Copyright (c) 2013 Eric Gorr. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class WebView;

@interface ELGAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow*		window;
@property (assign) IBOutlet WebView*		webA;
@property (assign) IBOutlet WebView*		webB;
@property (assign) IBOutlet NSSplitView*	splitView;

@property (strong)	NSNumber*	nParagraphs;


- (IBAction) actionNewHTMLContent:(id)sender;
- (IBAction) actionPrintFrame:(id)sender;

@end
