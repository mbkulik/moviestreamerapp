//
//  MovieDirectory.h
//  MovieStreamer
//
//  Created by Michael Kulik on 6/28/13.
//
//

#import <Foundation/Foundation.h>

@interface MovieDirectory : NSObject

-(NSURL*)get_moviedir;
-(void)set_moviedir:(NSURL*)dir;

@end
