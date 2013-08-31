//
//  PreferenceController.m
//  MovieStreamer
//
//  Created by Michael Kulik on 6/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PreferenceController.h"
#import "HTTPServer.h"
#import "defaults.h"
#import "DDLog.h"

extern HTTPServer *httpServer;
static const int ddLogLevel = LOG_LEVEL_VERBOSE;


@implementation PreferenceController

-(id)init
{
	if(![super initWithWindowNibName:@"Preferences"])
		return nil;
    
	return self;
}


-(void)windowDidLoad
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
	
    if([settings objectForKey:DEFAULT_KEY] == nil )
	{
        [settings setValue:[NSHomeDirectory() stringByAppendingString:@"/Movies"] forKey:DEFAULT_KEY];
        [settings synchronize];
	}
    
    [path setStringValue:[settings stringForKey:DEFAULT_KEY]];
}

-(IBAction)changePath:(id)sender
{
	NSOpenPanel *dialog = [NSOpenPanel openPanel];
	[dialog setCanChooseFiles:FALSE];
	[dialog setCanChooseDirectories:TRUE];
	[dialog setAllowsMultipleSelection:FALSE];
	
	if( [dialog runModal ] )
	{
        NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
         
        [settings setValue:[[dialog URL] path] forKey:DEFAULT_KEY];
        [settings synchronize];
        
        [httpServer stop];
        [httpServer setDocumentRoot:[settings stringForKey:DEFAULT_KEY]];
        
        NSError *error = nil;
        if(![httpServer start:&error])
        {
            DDLogError(@"Error starting HTTP Server: %@", error);
        }
        
		[path setStringValue:[settings stringForKey:DEFAULT_KEY]];
	}
}


@end
