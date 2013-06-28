//
//  main.m
//  MovieStreamer
//
//  Created by Michael Kulik on 6/22/12.
//  Copyright 2013 Michael B. Kulik. All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import "Browser.h"
#import "MovieDirectory.h"

#include "mongoose.h"

static int handler(struct mg_connection *conn)
{
    const struct mg_request_info *request_info = mg_get_request_info(conn);
    
    NSString *uri = [[NSString alloc] initWithUTF8String:request_info->uri];
    MovieDirectory *movie_dir = [[MovieDirectory alloc]init];
                
    if([uri isEqualToString:@"/"])
    {
        NSString *ua = [[NSString alloc] initWithUTF8String:mg_get_header(conn, "User-Agent")];
        Browser *browser = [[Browser alloc] initWithString:ua];
        NSFileManager *fm = [NSFileManager defaultManager];
        NSArray *movies = [fm contentsOfDirectoryAtPath:[[movie_dir get_moviedir] path] error:nil];
		
        //HTTP header
        mg_printf(conn,"HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n");
			
        if( [browser isSafari] || [browser isAndroid] || [browser isIE] )
        {
            NSPredicate *fltr = [NSPredicate predicateWithFormat:@"(self ENDSWITH '.mp4') || (self ENDSWITH '.m4v')"];
            NSArray *mp4s = [movies filteredArrayUsingPredicate:fltr];
				
            for(id mp4 in mp4s)
            {
                mg_printf(conn, "<a href=""/%s"">%s</a><br>", [mp4 UTF8String], [[mp4 stringByDeletingPathExtension] UTF8String]);
            }
        }
        else if( [browser isChrome] || [browser isOpera] || [browser isFirefox])
        {
            NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self ENDSWITH '.webm'"];
            NSArray *webms = [movies filteredArrayUsingPredicate:fltr];
			
            for(id webm in webms)
            {
                mg_printf(conn, "<a href=""/%s"">%s</a><br>", [webm UTF8String], [[webm stringByDeletingPathExtension] UTF8String]);
            }
        }
        else
        {
            mg_printf(conn, "Unsupported Browser");
        }
        
        [browser release];
        [ua release];
    }
    
    
    if([[uri pathExtension] isEqualToString:@"mp4"] ||
       [[uri pathExtension] isEqualToString:@"m4v"] ||
       [[uri pathExtension] isEqualToString:@"webm"] )
    {
        NSString *path = [[NSString alloc] initWithFormat:@"%@%@",
                          [[movie_dir get_moviedir] path], uri];
			
        mg_send_file(conn, [path UTF8String]);
            
        [path release];
    }
    
    [uri release];
    [movie_dir release];
    return 1;
}


int main(int argc, char *argv[])
{
	struct mg_context *ctx;
    struct mg_callbacks callbacks;
	
	const char *options[] = {
		"listening_ports", "8080", 
		"extra_mime_types", ".mp4=video/mp4,.m4v=video/mp4,.webm=video/webm",
		NULL
	};
    
    memset(&callbacks, 0, sizeof(callbacks));
    callbacks.begin_request = handler;
	
	ctx = mg_start(&callbacks , NULL, options);
	
    return NSApplicationMain(argc,  (const char **) argv);
}
