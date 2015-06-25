//
//  LORLeftMenuViewController.m
//  LinuxOrgRu
//
//  Created by Alexey on 6/16/15.
//  Copyright (c) 2015 Anakros. All rights reserved.
//

#import "LORLeftMenuViewController.h"

@interface LORLeftMenuViewController ()

@end

@implementation LORLeftMenuViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)deselectTable {
  NSAssert(_tableViewController != nil, @"table view controller should be set");

  [_tableViewController.tableView
      deselectRowAtIndexPath:[_tableViewController.tableView indexPathForSelectedRow]
                    animated:NO];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"embedLeftMenuTable"]) {
    self.tableViewController = segue.destinationViewController;
  }
}

#pragma mark - Actions

- (IBAction)settingsTouched:(id)sender {
  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
  [self deselectTable];

  self.sidePanelController.centerPanel =
      [storyboard instantiateViewControllerWithIdentifier:@"SettingsNav"];
}

@end
