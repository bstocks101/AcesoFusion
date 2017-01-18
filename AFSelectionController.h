//
//  AFSelectionController.h
//  AcesoFusion
//
//  Created by Bradley Stocks on 2017/01/16.
//
//

#import <Cocoa/Cocoa.h>

@interface AFSelectionController : NSWindowController

@property (retain) IBOutlet NSTextField* patientID;
@property (retain) IBOutlet NSPopUpButton* list;
@property (retain) NSString* selectedTitle;

- (void) populateDisplay: (NSArray*) titles;

- (IBAction)cancelPressed:(id)sender;
-(IBAction)selectPressed:(id)sender;

@end
