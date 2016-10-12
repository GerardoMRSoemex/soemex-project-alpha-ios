//
//  LoginViewController.m
//  ProjectAlpha
//
//  Created by Gerardo Martinez on 10/8/16.
//  Copyright © 2016 Soemex. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

//--------------------------------------------------------------------------------------------------
#pragma mark - UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

//--------------------------------------------------------------------------------------------------
#pragma mark - Action Methods

- (IBAction)onLogin:(id)sender {
}

- (IBAction)onRegister:(id)sender {
}


@end
