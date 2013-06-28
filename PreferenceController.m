//
//  PreferenceController.m
//  MovieStreamer
//
//  Created by Michael Kulik on 6/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PreferenceController.h"

@implementation PreferenceController

-(id)init
{
	if(![super initWithWindowNibName:@"Preferences"])
		return nil;
	
    movie_dir = [[MovieDirectory alloc] init];
    
	return self;
}

-(void)dealloc
{
    [movie_dir release];
    [super dealloc];
}

-(void)windowDidLoad
{	
	[path setStringValue:[[movie_dir get_moviedir] path]];
}

-(IBAction)changePath:(id)sender
{
	NSOpenPanel *dialog = [NSOpenPanel openPanel];
	[dialog setCanChooseFiles:FALSE];
	[dialog setCanChooseDirectories:TRUE];
	[dialog setAllowsMultipleSelection:FALSE];
	
	if( [dialog runModal ] )
	{
        [movie_dir set_moviedir:[dialog URL]];
        
		[path setStringValue:[[movie_dir get_moviedir] path]];
	}
}


@end
