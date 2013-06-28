//
//  PreferenceController.h
//  MovieStreamer
//
//  Created by Michael Kulik on 6/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MovieDirectory.h"


@interface PreferenceController : NSWindowController {
	IBOutlet NSButton *browse_button;
	IBOutlet NSTextField *path;
    MovieDirectory* movie_dir;
}

-(IBAction)changePath:(id)sender;

@end
