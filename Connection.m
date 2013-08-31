//
//  Connection.m
//  MovieStreamer
//
//  Created by Michael Kulik on 8/30/13.
//
//

#import "Connection.h"
#import "HTTPDataResponse.h"
#import "HTTPLogging.h"
#import "HTTPMessage.h"
#import "Browser.h"

@implementation Connection

- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path
{
	if ([path isEqualToString:@"/"])
	{
        NSMutableString *response = [[NSMutableString alloc] init];
        
        Browser *browser = [[Browser alloc] initWithString:[request headerField:@"user-agent"]];
        
        NSArray *movies = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[config documentRoot] error:nil];
        
        if( [browser isSafari] || [browser isAndroid] || [browser isIE] )
        {
            NSPredicate *fltr = [NSPredicate predicateWithFormat:@"(self ENDSWITH '.mp4') || (self ENDSWITH '.m4v')"];
            NSArray *mp4s = [movies filteredArrayUsingPredicate:fltr];
            
            for(id mp4 in mp4s)
            {
                [response appendFormat:@"<a href=""%@"">%@</a><br>",mp4,[mp4 stringByDeletingPathExtension]];
            }
        }
        else if( [browser isChrome] || [browser isOpera] || [browser isFirefox])
        {
            NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self ENDSWITH '.webm'"];
            NSArray *webms = [movies filteredArrayUsingPredicate:fltr];
			
            for(id webm in webms)
            {
               [response appendFormat:@"<a href=""%@"">%@</a><br>",webm,[webm stringByDeletingPathExtension]];
            }
        }
        else
        {
            [response appendString:@"Unsupported Browser"];
        }
        
        return [[HTTPDataResponse alloc] initWithData:[response dataUsingEncoding:NSUTF8StringEncoding]];
	}
    
    return [super httpResponseForMethod:method URI:path];
}

@end
