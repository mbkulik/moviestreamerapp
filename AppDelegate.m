//
//  AppDelegate.m
//  MovieStreamer
//
//  Created by Michael Kulik on 8/30/13.
//
//

#import "AppDelegate.h"
#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "Connection.h"
#import "defaults.h"

extern HTTPServer *httpServer;

// Log levels: off, error, warn, info, verbose
static const int ddLogLevel = LOG_LEVEL_VERBOSE;


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    
	// Configure our logging framework.
	// To keep things simple and fast, we're just going to log to the Xcode console.
	[DDLog addLogger:[DDTTYLogger sharedInstance]];
    
	// Initalize our http server
	httpServer = [[HTTPServer alloc] init];
    
    [httpServer setConnectionClass:[Connection class]];
    
	// Normally there's no need to run our server on any specific port.
	// Technologies like Bonjour allow clients to dynamically discover the server's port at runtime.
	// However, for easy testing you may want force a certain port so you can just hit the refresh button.
    [httpServer setPort:8080];
        
	[httpServer setDocumentRoot:[settings stringForKey:DEFAULT_KEY]];
    
	NSError *error = nil;
	if(![httpServer start:&error])
	{
		DDLogError(@"Error starting HTTP Server: %@", error);
	}
}

@end
