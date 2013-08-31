//
//  PreferenceController.h
//  MovieStreamer
//
//  Created by Michael Kulik on 6/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PreferenceController : NSWindowController {
	IBOutlet NSButton *browse_button;
	IBOutlet NSTextField *path;
}

-(IBAction)changePath:(id)sender;

@end
