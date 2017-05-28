//
//  ViewController.m
//  Country-Trip
//
//  Created by Lorrayne Paraiso on 25/05/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import "ViewController.h"
#import "ContinentPopupViewController.h"
static NSString *const kUrlImage = @"http://awseb-e-e-awsebloa-c5zq0lwotmwj-832470836.us-east-1.elb.amazonaws.com/world/countries/";
@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (strong, nonatomic) CountryPropertyObject *country;
@property (strong, nonatomic) IBOutlet UICollectionView *countryCollectionView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedContinentControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self connectInternet];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [_countryCollectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark

- (void)searchCountries {
    [[CountryService defaultService]fetchCountries:^(NSArray<CountryPropertyObject*> *countriesCollectionResultsPopular) {
        _loading.hidden = NO;
        [_loading startAnimating];
        self.countryCollectionResults = [(self.countryCollectionResults ?: @[]) arrayByAddingObjectsFromArray:countriesCollectionResultsPopular];
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

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSMutableArray *filtroStrings;
    NSMutableArray *totalStrings;
    filtroStrings = [[NSMutableArray alloc]init];
    for (NSString *str in totalStrings) {
        NSRange stringRange=[str rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (stringRange.location != NSNotFound) {
            [filtroStrings addObject:str];
        }
    [self.countryCollectionView reloadData];
    }
    
}


#pragma mark - Actions

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [_countryCollectionView reloadData];
    [self searchBar:_searchBar textDidChange:_searchBar.text];
    [self becomeFirstResponder];
    [self.loading startAnimating];
    [_countryCollectionView reloadData];
    [self.loading stopAnimating];
}

- (IBAction)selectSegment:(id)sender {
    switch (self.segmentedContinentControl.selectedSegmentIndex) {
        case 0: //Asia
            ContinentPopupViewController *popup = [ContinentPopupViewController instantiateNewView];
            [popup presentInRootViewControllerOfViewController:self completion:nil];
            break;
        case 1: //Africa
            ContinentPopupViewController *popup = [ContinentPopupViewController instantiateNewView];
            [popup presentInRootViewControllerOfViewController:self completion:nil];
            break;
        case 2: //America
            ContinentPopupViewController *popup = [ContinentPopupViewController instantiateNewView];
            [popup presentInRootViewControllerOfViewController:self completion:nil];
            break;
        case 3: //Europa
            ContinentPopupViewController *popup = [ContinentPopupViewController instantiateNewView];
            [popup presentInRootViewControllerOfViewController:self completion:nil];
            break;
            case 4: //Oceania
                ContinentPopupViewController *popup = [ContinentPopupViewController instantiateNewView];
            [popup presentInRootViewControllerOfViewController:self completion:nil];
             break;
        default: ;
            break;
    }
}


#pragma mark - <UISearchBarDelegate>

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if ([_searchBar isFirstResponder] && [touch view] != _searchBar) {
        [_searchBar resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
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
    NSString *posterStringComplete = [NSString stringWithFormat:@"%@%@/flag", kUrlImage, country.idCountry];
    NSURL *posterUrlComplete = [NSURL URLWithString:posterStringComplete];
    country.posterUrl = posterUrlComplete;
    [cell.posterCollection setImageWithURL:posterUrlComplete];
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@" segue para a tela de detalhes do filme");
    DetailViewController *countryDetailView = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Details"];
    CountryPropertyObject *country = self.countryCollectionResults [indexPath.row];
    countryDetailView.countryDetail = country;
    [self.navigationController pushViewController: countryDetailView animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end
