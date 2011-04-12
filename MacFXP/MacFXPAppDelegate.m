//
//  MacFXPAppDelegate.m
//  MacFXP
//
//  Created by Rasmus Hummelmose on 4/8/11.
//  Copyright 2011 Århus Universitet. All rights reserved.
//

#import "MacFXPAppDelegate.h"
#import "FTPConnectionController.h"

#define TAG_CONNECTED 1
#define TAG_COMMAND 11


@implementation MacFXPAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [logField setFont:[NSFont fontWithName:@"Courier New" size:11]];
}

- (IBAction)connect:(id)sender{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterNoStyle];
    NSNumber * portNumber = [f numberFromString:[portField stringValue]];
    [f release];
    if ([SSLField state] == NSOnState) {
        SSL = YES;
    } else {
        SSL = NO;
    }
    ftpConnect = [[FTPConnectionController alloc] initWithHostname:[hostField stringValue]
                                                              port:portNumber
                                                          username:[userField stringValue]
                                                          password:[passField stringValue]
                                                               SSL:SSL];
    [ftpConnect getDirlist];
    socketOutput = [[NSMutableString alloc] init];
}

- (IBAction)sendCommand:(id)sender {
    [ftpConnect sendCommand:[commandField stringValue]];
}


//
//  Metoder der udskriver output og/eller errors fra socket.
//

- (void)onSocket:(AsyncSocket *)sender didReadData:(NSData *)data withTag:(long)tag
{
    if (tag == TAG_COMMAND) {
        [socketOutput appendString:[NSString stringWithFormat:@"\n%i: THIS WAS A COMMAND RESPONSE\n", tagTesting++]];
    } else {
        NSString * response = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        [socketOutput appendString:[NSString stringWithFormat:@"%li : %@", tag, response]];
        [response release];
    }
    
    [logField setString:socketOutput];
    
    NSRange range = NSMakeRange ([[logField string] length], 0);
    [logField scrollRangeToVisible:range];
}
- (void)onSocketDidSecure:(AsyncSocket *)sock
{
	NSLog(@"onSocketDidSecure:%p", sock);
}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
	NSLog(@"onSocket:%p willDisconnectWithError:%@", sock, err);
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
	NSLog(@"onSocketDidDisconnect:%p", sock);
}


@end
