//
//  AppController.m
//  MovieStreamer
//
//  Created by Michael Kulik on 6/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"
#import "PreferenceController.h"

@implementation AppController

-(IBAction) showPreferencePanel:(id)sender
{
		if( !preferenceController)
		{
			preferenceController =[[PreferenceController alloc] init];
		}
			 
		[preferenceController showWindow:self];
}

@end
