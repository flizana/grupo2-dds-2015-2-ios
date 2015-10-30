//
//  ProposalsTableViewController.m
//  Constitution
//
//  Created by Fernando Lizana on 10/29/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import "ProposalsTableViewController.h"
#import "Network.h"
#import "Proposal.h"
#import "APIParameters.h"

@interface ProposalsTableViewController ()

@property (strong, nonatomic) NSArray *proposals;

@property (nonatomic) unsigned long selectedProposalId;

@end

@implementation ProposalsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.proposals = nil;
    
    [self downloadProposals];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Network

- (void)downloadProposals
{
    [Network downloadProposalsWithBlock:^(BOOL success, NSError *error, NSArray *proposals){
        if (!error){
            if (success){
                [self parseProposals:proposals];
            } else {
                NSLog(@"Error downloading proposals.");
            }
        } else {
            NSLog(@"Error downloading proposals: [%@]", error);
        }
    }];
}

#pragma mark - Parsing

- (void)parseProposals:(NSArray *)proposals
{
    NSMutableArray *proposalsArray = [NSMutableArray array];
    for (NSDictionary *prop in proposals){
        Proposal *proposal = [[Proposal alloc] init];
        proposal.proposalId = (unsigned long)[(NSNumber *)[prop objectForKey:@"id"] unsignedLongValue];
        proposal.proposalText = (NSString *)[prop objectForKey:@"texto"];
        proposal.userId = (unsigned long)[(NSNumber *)[prop objectForKey:@"user_id"] unsignedLongValue];
        proposal.proposalURL = (NSString *)[prop objectForKey:@"url"];
        [proposalsArray addObject:proposal];
    }
    self.proposals = [NSArray arrayWithArray:proposalsArray];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.proposals){
        return self.proposals.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"proposalCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    Proposal *proposal = self.proposals[indexPath.row];
    cell.textLabel.text = proposal.proposalText;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Proposal *proposal = self.proposals[indexPath.row];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0]};
    CGRect rect = [proposal.proposalText boundingRectWithSize:CGSizeMake(self.tableView.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    if ((rect.size.height + 30) < 44.0){
        return 44.0;
    } else {
        return rect.size.height + 70;
    }
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Proposal *proposal = self.proposals[indexPath.row];
    self.selectedProposalId = proposal.proposalId;
    [self performSegueWithIdentifier:@"proposalSegue" sender:self];
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"proposalSegue"]){
        
    }
}


@end
