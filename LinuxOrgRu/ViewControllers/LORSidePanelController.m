//
//  LORSidePanelController.m
//  LinuxOrgRu
//
//  Created by Anakros on 6/13/15.
//  Copyright © 2015 Anakros. All rights reserved.
//

#import "LORSidePanelController.h"

@interface LORSidePanelController ()

@end

@implementation LORSidePanelController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];

  if (!self) {
    return nil;
  }

  return self;
}

- (void)awakeFromNib {
  UIViewController *centerViewController =
      [self.storyboard instantiateViewControllerWithIdentifier:@"TrackerNav"];
  UIViewController *leftViewController =
      [self.storyboard instantiateViewControllerWithIdentifier:@"leftViewController"];

  NSAssert(centerViewController != nil, @"Center view controller should be set");
  NSAssert(leftViewController != nil, @"Left view controller should be set");

  self.centerPanel = centerViewController;
  self.leftPanel = leftViewController;
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Style overrides

- (void)styleContainer:(UIView *)container animate:(BOOL)animate duration:(NSTimeInterval)duration {
  [super styleContainer:container animate:animate duration:duration];

  container.layer.shadowRadius = 5.0f;
  container.layer.shadowOpacity = 0.5f;
}

- (void)stylePanel:(UIView *)panel {
  //  [super stylePanel:panel];
}

@end
