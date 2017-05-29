//
//  CountryVisitedTableViewController.m
//  Country-Trip
//
//  Created by Lorrayne Paraiso on 28/05/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import "CountryVisitedTableViewController.h"

@interface CountryVisitedTableViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSArray <CountryMO *> *countries;
@property (strong, nonatomic) IBOutlet UITableView *countryTableView;
@property (strong, nonatomic) IBOutlet UILabel *textLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation CountryVisitedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = (AppDelegate *) UIApplication.sharedApplication.delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSError *error = nil;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Country"];
    self.countries = [context executeFetchRequest:fetchRequest error:&error];
    
    if (!self.countries) {
        NSLog(@"Error fetching Country objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    [self.countryTableView reloadData];
}

- (void) viewWillAppear:(BOOL)animated {
    [_countryTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.countries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"celldetail"];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    CountryMO *countryMO = self.countries [indexPath.row];
    //cell.detailTextLabel.text = countryMO.shortname;
    cell.textLabel.text = countryMO.longname;
    //[cell.imageView cancelImageDownloadTask];
   // cell.imageView.image = [UIImage imageNamed:@"default"];
    //if (countryMO.posterString) {
   //     [cell.imageView setImageWithURL:[NSURL URLWithString:countryMO.posterString]];
   // }
    [_countryTableView reloadData];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray *coutries = [self.countries mutableCopy];
        CountryMO *countryMO = coutries[indexPath.row];
        [coutries removeObject:countryMO];
        self.countries = coutries;
        
        AppDelegate *appDelegate = (AppDelegate *) UIApplication.sharedApplication.delegate;
        NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
        [context deleteObject:countryMO];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        NSLog(@"No delete");
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Segue para detalhes do filme salvo");
    DetailViewController *listDetailView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Details"];
    CountryMO *country = self.countries [indexPath.row];
    
    listDetailView.countryData = country;
    [self.navigationController pushViewController:listDetailView animated:YES];
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
