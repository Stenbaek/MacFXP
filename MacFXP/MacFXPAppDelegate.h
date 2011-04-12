//
//  MacFXPAppDelegate.h
//  MacFXP
//
//  Created by Rasmus Hummelmose on 4/12/11.
//  Copyright 2011 Århus Universitet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MacFXPAppDelegate : NSObject <NSApplicationDelegate> {
@private
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
