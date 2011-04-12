//
//  Connect.m
//  MacFXP
//
//  Created by Rasmus Hummelmose on 4/10/11.
//  Copyright 2011 Århus Universitet. All rights reserved.
//

#import "FTPConnectionController.h"
#import "AsyncSocket.h"



@implementation FTPConnectionController

//
//  Initialiserer klassen og forbinder.......
//

- (id)initWithHostname:(NSString *)host port:(NSNumber*)port username:(NSString *)user password:(NSString *)pass SSL:(BOOL)SSL
{
    self = [super init];
    if (self) {
        
        socket = [[AsyncSocket alloc] initWithDelegate:[NSApp delegate]];

        
        
        [socket connectToHost:host onPort:[port intValue] error:nil];
        [socket readDataWithTimeout:5000 tag:1];
        
        if (SSL) {
            [socket writeData:[@"AUTH TLS\n" dataUsingEncoding:NSASCIIStringEncoding] withTimeout:5000 tag:1];        
            [socket readDataWithTimeout:5000 tag:1];
            
            
            NSMutableDictionary * tlsSettings = [NSMutableDictionary dictionaryWithCapacity:3];
            [tlsSettings setObject:[NSNumber numberWithBool:NO] forKey:(NSString *)kCFStreamSSLValidatesCertificateChain];
            [socket startTLS:tlsSettings];
            [socket readDataWithTimeout:5000 tag:1];
        }
        
        [socket writeData:[[NSString stringWithFormat:@"USER %@\n", user] dataUsingEncoding:NSASCIIStringEncoding] withTimeout:5000 tag:1];
        [socket readDataWithTimeout:5000 tag:1];
        

        [socket writeData:[[NSString stringWithFormat:@"PASS %@\n", pass] dataUsingEncoding:NSASCIIStringEncoding] withTimeout:5000 tag:1];
        [socket readDataWithTimeout:5000 tag:1];


        [socket writeData:[@"PBSZ 0\n" dataUsingEncoding:NSASCIIStringEncoding] withTimeout:5000 tag:2];
        [socket readDataWithTimeout:5000 tag:1];
        [socket writeData:[@"SITE XDUPE 3\n" dataUsingEncoding:NSASCIIStringEncoding] withTimeout:5000 tag:2];
        [socket readDataWithTimeout:5000 tag:1];
        [socket writeData:[@"TYPE I\n" dataUsingEncoding:NSASCIIStringEncoding] withTimeout:5000 tag:2];
        [socket readDataWithTimeout:5000 tag:1];
        [socket writeData:[@"PWD\n" dataUsingEncoding:NSASCIIStringEncoding] withTimeout:5000 tag:1];
        [socket readDataWithTimeout:5000 tag:1];
        
    }
    
    return self;
}

//
//  Andre metoder
//

- (void) getDirlist {
    [socket writeData:[@"STAT -la\n" dataUsingEncoding:NSASCIIStringEncoding] withTimeout:5000 tag:1];
    [socket readDataWithTimeout:5000 tag:11];
}

- (void) sendCommand:(NSString*)command {
    [socket writeData:[[NSString stringWithFormat:@"%@\n", command] dataUsingEncoding:NSASCIIStringEncoding] withTimeout:5000 tag:1];
    [socket readDataWithTimeout:5000 tag:1];
}


//
//  Memory management
//

- (void)dealloc
{
    [socket release];
    [super dealloc];
}


@end