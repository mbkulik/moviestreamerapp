//
//  AppController.h
//  MovieStreamer
//
//  Created by Michael Kulik on 6/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class PreferenceController;

@interface AppController : NSObject {
	PreferenceController *preferenceController;
}

-(IBAction)showPreferencePanel:(id)sender;

@end
