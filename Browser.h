//
//  Browser.h
//  MovieStreamer
//
//  Created by Michael Kulik on 12/12/12.
//
//

@interface Browser : NSObject{
    NSString *user_agent;
}

-(id)initWithString:(NSString*)ua;
-(bool)isChrome;
-(bool)isOpera;
-(bool)isFirefox;
-(bool)isSafari;
-(bool)isiOS;
-(bool)isAndroid;
-(bool)isIE;

@end
