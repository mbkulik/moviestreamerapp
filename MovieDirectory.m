//
//  MovieDirectory.m
//  MovieStreamer
//
//  Created by Michael Kulik on 6/28/13.
//
//

#import "MovieDirectory.h"

#define DEFAULT_KEY @"com.moviestreamerapp.MovieStreamer"

@implementation MovieDirectory

-(NSURL*)get_moviedir
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
	
    if([settings objectForKey:DEFAULT_KEY] == nil )
	{
        return [NSURL URLWithString:[NSHomeDirectory() stringByAppendingString:@"/Movies"]];
	}
    else
    {
        return [settings URLForKey:DEFAULT_KEY];
    }
}

-(void)set_moviedir:(NSURL*)dir
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings setURL:dir forKey:DEFAULT_KEY];
    [settings synchronize];
}


@end
