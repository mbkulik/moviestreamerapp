//
//  Browser.m
//  MovieStreamer
//
//  Created by Michael Kulik on 12/12/12.
//
//

#import "Browser.h"

@implementation Browser

-(id)initWithString:(NSString*)ua
{
    user_agent = ua;
    
    return self;
}

-(bool)isChrome
{
    return [user_agent rangeOfString:@"Chrome"].location != NSNotFound;
}

-(bool)isOpera
{
    return [user_agent rangeOfString:@"Opera"].location != NSNotFound;
}

-(bool)isFirefox
{
    return [user_agent rangeOfString:@"Firefox"].location != NSNotFound;
}

-(bool)isSafari
{
    return  [user_agent rangeOfString:@"Safari"].location != NSNotFound &&
            [user_agent rangeOfString:@"Chrome"].location == NSNotFound;
}

-(bool)isiOS
{
    return  [user_agent rangeOfString:@"iPhone"].location != NSNotFound &&
            [user_agent rangeOfString:@"iPad"].location != NSNotFound &&
            [user_agent rangeOfString:@"iPod"].location != NSNotFound;
}

-(bool)isAndroid
{
    return [user_agent rangeOfString:@"Android"].location != NSNotFound;
}

-(bool)isIE
{
    return [user_agent rangeOfString:@"MSIE"].location != NSNotFound;
}

@end
