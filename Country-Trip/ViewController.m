//
//  ViewController.m
//  Country-Trip
//
//  Created by Lorrayne Paraiso on 25/05/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import "ViewController.h"

static NSString *const kUrlImage = @"http://awseb-e-e-awsebloa-c5zq0lwotmwj-832470836.us-east-1.elb.amazonaws.com/world/countries/";
@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (strong, nonatomic) CountryPropertyObject *country;
@property (strong, nonatomic) IBOutlet UICollectionView *countryCollectionView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedContinentControl;
@property (strong, nonatomic) NSString *continentDescription;
@property (strong, nonatomic) NSString *nameContinent;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self connectInternet];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [_countryCollectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Service

- (void)searchCountries {
    [[CountryService defaultService]fetchCountries:^(NSArray<CountryPropertyObject*> *countriesCollectionResultsPopular) {
        _loading.hidden = NO;
        [_loading startAnimating];
        self.countryCollectionResults = [(self.countryCollectionResults ?: @[]) arrayByAddingObjectsFromArray:countriesCollectionResultsPopular];
        [self orderCollection];
        [self.countryCollectionView reloadData];
        [_loading stopAnimating];
        [_loading hidesWhenStopped];
    } error:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Erro");
    } ];
}

- (void)connectInternet {
    NSURL *scriptUrl = [NSURL URLWithString:@"https://www.google.com"];
    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
    if (data) {
        [self searchCountries];
    } else {
        UIAlertController *view = [UIAlertController alertControllerWithTitle:@""
                                                                      message: [NSString stringWithFormat:@"Sem conexão com a Internet!"]
                                                               preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDestructive
                                                   handler:^(UIAlertAction * action) {
                                                       [view dismissViewControllerAnimated:YES completion:^{
                                                           [self.view endEditing:YES];
                                                       }];
                                                   }];
        [view addAction:ok];
        [self presentViewController:view animated:YES completion:nil];
        
    }
}

#pragma mark - Actions

- (void)orderCollection {
    NSArray <CountryPropertyObject *> *sortedArray;
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"shortname" ascending:YES];
    sortedArray=[_countryCollectionResults sortedArrayUsingDescriptors:@[sort]];
    _countryCollectionResults = sortedArray;
    [_countryCollectionView reloadData];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.countryCollectionResults.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CountryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"country" forIndexPath:indexPath];
    CountryPropertyObject *country = self.countryCollectionResults [indexPath.row];
    
    cell.countryName.text = [NSString stringWithFormat:@"%@", country.shortname];
    [cell.posterCollection cancelImageDownloadTask];
    cell.posterCollection.image = [UIImage imageNamed:@"default"];
    NSString *posterStringComplete = [NSString stringWithFormat:@"%@%@/flag", kUrlImage, country.idCountry];
    _country.posterString = posterStringComplete;
    NSURL *posterUrlComplete = [NSURL URLWithString:posterStringComplete];
    country.posterUrl = posterUrlComplete;
    [cell.posterCollection setImageWithURL:posterUrlComplete];
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *countryDetailView = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Details"];
    CountryPropertyObject *country = self.countryCollectionResults [indexPath.row];
    countryDetailView.countryDetail = country;
    [self.navigationController pushViewController: countryDetailView animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end
