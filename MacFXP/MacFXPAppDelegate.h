//
//  MacFXPAppDelegate.h
//  MacFXP
//
//  Created by Rasmus Hummelmose on 4/8/11.
//  Copyright 2011 Århus Universitet. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FTPConnectionController.h"

@interface MacFXPAppDelegate : NSObject <NSApplicationDelegate> {
    
@private
    NSWindow *window;
    NSMutableString * socketOutput;
    IBOutlet NSTextField *hostField;
    IBOutlet NSTextField *portField;
    IBOutlet NSTextField *userField;
    IBOutlet NSSecureTextField *passField;
    IBOutlet NSTextView *logField;
    BOOL SSL;
    IBOutlet NSButton *SSLField;
    FTPConnectionController * ftpConnect;
    IBOutlet NSTextField *commandField;
}
- (IBAction)connect:(id)sender;
- (IBAction)sendCommand:(id)sender;


@property (assign) IBOutlet NSWindow *window;

@end
