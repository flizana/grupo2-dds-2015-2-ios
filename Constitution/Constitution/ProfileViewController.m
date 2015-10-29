//
//  ProfileViewController.m
//  Constitution
//
//  Created by Fernando Lizana on 10/29/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"

@interface ProfileViewController ()

@property (strong, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    User *currentUser = [User currentUser];
    self.fullNameLabel.text = [NSString stringWithFormat:@"%@ %@", [currentUser getFirstName], [currentUser getLastName]];
    self.emailLabel.text = [currentUser getEmail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
