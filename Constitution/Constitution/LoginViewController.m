//
//  LoginViewController.m
//  Constitution
//
//  Created by Fernando Lizana on 10/28/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *signupButton;

@property (strong, nonatomic) UITextField *activeField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeField = nil;
}

- (void)dismissKeyboard
{
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

#pragma mark - UIAlert

- (void)alertStatus:(NSString *)title message:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UI Actions

- (IBAction)loginButtonTapped:(id)sender
{
    if (![self.emailTextField.text isEqualToString:@""]){
        if (![self.passwordTextField.text isEqualToString:@""]){
            [User logInWithEmail:self.emailTextField.text password:self.passwordTextField.text block:^(BOOL success, NSError *error){
                if (!error){
                    if (success){
                        // Login successful
                        [self performSegueWithIdentifier:@"loginSegue" sender:self];
                    } else {
                        NSLog(@"Error logging in...");
                    }
                } else {
                    NSLog(@"Error logging in: [%@]", error);
                }
            }];
        } else {
            [self alertStatus:@"Password blank" message:@"Please provide a valid password"];
        }
    } else {
        [self alertStatus:@"Email blank" message:@"Please provide a valid email address"];
    }
}

- (IBAction)signupButtonTapped:(id)sender
{
    [self performSegueWithIdentifier:@"signupSegue" sender:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
