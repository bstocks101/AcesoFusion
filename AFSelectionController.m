//
//  AFSelectionController.m
//  AcesoFusion
//
//  Created by Bradley Stocks on 2017/01/16.
//
//

#import "AFSelectionController.h"

@interface AFSelectionController ()

@end

@implementation AFSelectionController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    //[self showWindow:nil];
}

-(void) populateDisplay:(NSArray *)titles{
    [self.list removeAllItems];
    [self.list addItemsWithTitles:titles];
    [self.patientID setStringValue:@"Test me"];
}

-(IBAction)selectPressed:(id)sender{
    self.selectedTitle = [self.list titleOfSelectedItem];
    NSLog(@"%@", self.selectedTitle);
    [self.window orderOut:sender];
    [self release];
}


-(IBAction)cancelPressed:(id)sender{
    [self.window orderOut:sender];
    [self release];
}




@end
