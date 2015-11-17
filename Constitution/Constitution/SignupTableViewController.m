//
//  SignupTableViewController.m
//  Constitution
//
//  Created by Fernando Lizana on 10/29/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import "SignupTableViewController.h"
#import "User.h"

#define ALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define NUMERIC @"0123456789"
#define ALPHA_NUMERIC ALPHA NUMERIC

typedef enum textFieldInput{
    FIRST_NAME,
    LAST_NAME,
    EMAIL,
    PASSWORD,
    CONFIRM_PASSWORD,
    GENDER,
    CITY,
    REGION
}textFieldInput;

typedef enum tableViewSection{
    REQUIRED,
    OPTIONAL
}tableViewSection;

@interface SignupTableViewController ()

@property (strong, nonatomic) UITextField *activeField;
@property (strong, nonatomic) NSMutableArray *inputTexts;

@end

@implementation SignupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set delegates
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Add tap gesture recognizer
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnTableView:)];
    [self.tableView addGestureRecognizer:tap];
    
    // Set input texts
    self.inputTexts = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", nil];
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField.textColor isEqual:[UIColor redColor]]){
        textField.textColor = [UIColor blackColor];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeField = textField;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == EMAIL){
        if ([self isValidEmailAddress:textField.text]){
            textField.textColor = [UIColor blackColor];
        }
    }
    
    NSString *text = [NSString stringWithFormat:@"%@%@", textField.text, string];
    [self.inputTexts replaceObjectAtIndex:textField.tag withObject:
     text];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ((textField.tag == EMAIL) && (![self isValidEmailAddress:textField.text]) && ![textField.text isEqualToString:@""]) {
        // Email address input text field wrong
        textField.textColor = [UIColor redColor];
        return NO;
    }
        
    if ((textField.tag == PASSWORD || textField.tag == CONFIRM_PASSWORD) && ((textField.text.length < 6) || ([self passwordContainsInvalidChars:textField.text]))){
        // Password input text field wrong
        [self alertStatus:@"Password Invalid" message:@"Password must be at least 6 characters long and contain only letters and numbers."];
        return NO;
    }
        
    [self.inputTexts replaceObjectAtIndex:textField.tag withObject:textField.text];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeField = nil;
}

- (BOOL)isValidEmailAddress:(NSString *)email
{
    BOOL filter = YES;
    NSString *filterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = filter ? filterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (BOOL)passwordContainsInvalidChars:(NSString *)password
{
    BOOL aux = NO;
    for (NSInteger i = 0; i < password.length; i++){
        unichar character = [password characterAtIndex:i];
        int charVal = (int)character;
        if ((charVal < 48) || (charVal > 122)){
            aux = YES;
        } else if ((charVal > 57) && (charVal < 65)){
            aux = YES;
        } else if ((charVal > 90) && (charVal < 97)){
            aux = YES;
        }
    }
    return aux;
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

#pragma mark - Gesture Recognizer

- (void)didTapOnTableView:(UIGestureRecognizer *)recognizer
{
    CGPoint tapLocation = [recognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:tapLocation];
    
    if (indexPath){
        recognizer.cancelsTouchesInView = NO;
    } else {
        if (self.activeField){
            [self.activeField resignFirstResponder];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case REQUIRED:
            return 5;
            break;
            
        case OPTIONAL:
            return 3;
            break;
            
        default:
            return 0;
            break;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case REQUIRED:
            return @"REQUIRED";
            break;
            
        case OPTIONAL:
            return @"OPTIONAL";
            break;
            
        default:
            return nil;
            break;
    }
}


#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.activeField){
        [self.activeField resignFirstResponder];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"signUpCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    switch (indexPath.section) {
        case REQUIRED:{
            CGRect frame = CGRectMake(CGRectGetWidth(cell.frame) * 0.25, CGRectGetMinY(cell.frame), CGRectGetWidth(cell.frame) * 0.60, CGRectGetHeight(cell.frame));
            UITextField *inputTextField = [[UITextField alloc] initWithFrame:frame];
            inputTextField.delegate = self;
            inputTextField.tag = indexPath.row;
            inputTextField.borderStyle = UITextBorderStyleNone;
            inputTextField.spellCheckingType = UITextSpellCheckingTypeNo;
            inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
            inputTextField.text = self.inputTexts[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            switch (indexPath.row) {
                case FIRST_NAME:{
                    cell.textLabel.text = @"First Name:";
                    inputTextField.secureTextEntry = NO;
                    inputTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
                    inputTextField.keyboardType = UIKeyboardTypeDefault;
                    break;
                }
                case LAST_NAME:{
                    cell.textLabel.text = @"Last Name:";
                    inputTextField.secureTextEntry = NO;
                    inputTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
                    inputTextField.keyboardType = UIKeyboardTypeDefault;
                    break;
                }
                case EMAIL:{
                    cell.textLabel.text = @"Email:";
                    inputTextField.secureTextEntry = NO;
                    inputTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
                    inputTextField.keyboardType = UIKeyboardTypeEmailAddress;
                    break;
                }
                case PASSWORD:{
                    cell.textLabel.text = @"Password:";
                    inputTextField.secureTextEntry = YES;
                    inputTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
                    inputTextField.keyboardType = UIKeyboardTypeDefault;
                    break;
                }
                case CONFIRM_PASSWORD:{
                    cell.textLabel.text = @"Confirm Password:";
                    cell.textLabel.numberOfLines = 2;
                    inputTextField.secureTextEntry = YES;
                    inputTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
                    inputTextField.keyboardType = UIKeyboardTypeDefault;
                    break;
                }
                    
                default:
                    break;
            }
            
            cell.accessoryView = inputTextField;
            break;
        }
        case OPTIONAL:{
            CGRect frame = CGRectMake(CGRectGetWidth(cell.frame) * 0.25, CGRectGetMinY(cell.frame), CGRectGetWidth(cell.frame) * 0.60, CGRectGetHeight(cell.frame));
            UITextField *inputTextField = [[UITextField alloc] initWithFrame:frame];
            inputTextField.delegate = self;
            inputTextField.tag = indexPath.row + 5;
            inputTextField.borderStyle = UITextBorderStyleNone;
            inputTextField.spellCheckingType = UITextSpellCheckingTypeNo;
            inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
            inputTextField.text = self.inputTexts[indexPath.row + 5];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            switch (indexPath.row) {
                case 0:{
                    cell.textLabel.text = @"Gender:";
                    inputTextField.secureTextEntry = NO;
                    inputTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
                    inputTextField.keyboardType = UIKeyboardTypeDefault;
                    break;
                }
                case 1:{
                    cell.textLabel.text = @"City:";
                    inputTextField.secureTextEntry = NO;
                    inputTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
                    inputTextField.keyboardType = UIKeyboardTypeDefault;
                    break;
                }
                case 2:{
                    cell.textLabel.text = @"Region:";
                    inputTextField.secureTextEntry = NO;
                    inputTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
                    inputTextField.keyboardType = UIKeyboardTypeDefault;
                    break;
                }
                    
                default:
                    break;
            }
            
            cell.accessoryView = inputTextField;
            break;
        }
        default:
            break;
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - UI Actions

- (IBAction)doneBarButtonTapped:(id)sender
{
    NSString *firstName = self.inputTexts[FIRST_NAME];
    NSString *lastName = self.inputTexts[LAST_NAME];
    NSString *email = self.inputTexts[EMAIL];
    NSString *password = self.inputTexts[PASSWORD];
    NSString *confirmPassword = self.inputTexts[CONFIRM_PASSWORD];
    NSString *gender = self.inputTexts[GENDER];
    NSString *city = self.inputTexts[CITY];
    NSString *region = self.inputTexts[REGION];
    
    // Check if all required fields are set
    if (firstName && ![firstName isEqualToString:@""] && lastName && ![lastName isEqualToString:@""] && email && ![email isEqualToString:@""] && password && ![password isEqualToString:@""] && confirmPassword && ![confirmPassword isEqualToString:@""]){
        // Check if password and confirmPassword match
        if ([password isEqualToString:confirmPassword]){
            // Create new user
            User *newUser = [[User alloc] init];
            [newUser syncFirstName:firstName];
            [newUser syncLastName:lastName];
            [newUser syncEmail:email];
            [newUser syncPassword:password];
            
            // Set gender, city and region if they are not blank
            if (gender && ![gender isEqualToString:@""]){
                [newUser syncGender:gender];
            } else {
                [newUser syncGender:@""];
            }
            if (city && ![city isEqualToString:@""]){
                [newUser syncCity:city];
            } else {
                [newUser syncCity:@""];
            }
            if (region && ![region isEqualToString:@""]){
                [newUser syncRegion:region];
            } else {
                [newUser syncRegion:@""];
            }
            
            // Sign up user
            [newUser signUp:^(BOOL success, NSError *error){
                if (!error){
                    if (success){
                        [self performSegueWithIdentifier:@"signupSuccessSegue" sender:self];
                    } else {
                        NSLog(@"Error signing up user.");
                    }
                } else {
                    NSLog(@"Error signing up user: [%@]", error);
                }
            }];
        } else {
            [self alertStatus:@"Passwords Invalid" message:@"Passwords do not match. Please try again."];
        }
    } else {
        [self alertStatus:@"Field Blank" message:@"Please fill in all required fields"];
    }
}

- (IBAction)cancelBarButtonTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Settings

- (void)registerForPushNotifications
{
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]){
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge)];
    }
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (self.activeField.isFirstResponder){
        [self.activeField resignFirstResponder];
        self.activeField = nil;
    }
}

@end
