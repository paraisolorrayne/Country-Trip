//
//  ViewController.m
//  Country-Trip
//
//  Created by Lorrayne Paraiso on 25/05/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (strong, nonatomic) CountryPropertyObject *country;
@property (strong, nonatomic) IBOutlet UICollectionView *countryCollectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self connectInternet];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [_countryCollectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark

- (void)searchCountries {
    [[CountryService defaultService]fetchCountries:^(NSArray<CountryPropertyObject*> *countriesCollectionResultsPopular) {
        self.countryCollectionResults = [(self.countryCollectionResults ?: @[]) arrayByAddingObjectsFromArray:countriesCollectionResultsPopular];
         [self.countryCollectionView reloadData];
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

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.countryCollectionResults.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CountryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"country" forIndexPath:indexPath];
    CountryPropertyObject *country = self.countryCollectionResults [indexPath.row];
    cell.countryName.text = [NSString stringWithFormat:@"%@", country.shortname];
    
    //NSString *posterUrlcomplete = [NSString stringWithFormat:@"%@%@", kTMDbPosterPath, movie.poster_path];
    //NSURL *posterUrlComplete = [NSURL URLWithString:posterUrlcomplete];
    //[cell.posterCollection setImageWithURL:posterUrlComplete];
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@" segue para a tela de detalhes do filme");
   /* DetailsViewController *movieDetailView = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Details"];
    MoviePropertyObject *movie = self.movieCollectionResultsPop [indexPath.row];
    movieDetailView.movieDetail = movie;
    [self.navigationController pushViewController:movieDetailView animated:YES];*/
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end
