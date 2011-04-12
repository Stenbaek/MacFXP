//
//  Connect.h
//  MacFXP
//
//  Created by Rasmus Hummelmose on 4/10/11.
//  Copyright 2011 Århus Universitet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"


@interface FTPConnectionController : NSObject {
@private
    BOOL success;
    AsyncSocket * socket;

}



-(id)initWithHostname:(NSString*)host
                 port:(NSNumber*)port
             username:(NSString*)user
             password:(NSString*)pass
                  SSL:(BOOL)SSL;
- (void) getDirlist;
- (void) sendCommand:(NSString*)command;

@end
