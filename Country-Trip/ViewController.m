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
    // Dispose of any resources that can be recreated.
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

- (void)presentPopup {
    self.popup = [ContinentPopupViewController instantiateNewView];
    [self.popup presentInViewController:self completion:nil];
}

- (IBAction)selectSegment:(id)sender {
    switch (self.segmentedContinentControl.selectedSegmentIndex) {
        case 0: //Asia
            _nameContinent = @"Asia";
            _continentDescription = @"This is the largest and most populous continent on earth. Its area is 44.9 million square kilometers, corresponding to 30% of the emerging areas of the globe. The Asian contingent population is 4.1 billion (60% of the world's population). This large continent is divided into 45 countries, with China being the largest (9,596,961 km²) and most inhabited (1.3 billion inhabitants). ";
            self.popup.nameContinent = @"test";
            self.popup.continentDescription = _continentDescription;
            [self presentPopup];
            break;
        case 1: //Africa
            _nameContinent = @"Africa";
            _continentDescription = @"With a territorial extension of 30,198,835 square kilometers, the African continent houses approximately 1.1 billion inhabitants, distributed in 53 countries, with Nigeria being the most populous: 158.2 million people . The African population density is 34 inhabitants per square kilometer; Population growth is the highest in the world: 2.3% a year. The countries of this continent have several socioeconomic problems - AIDS and malaria account for many deaths; More than half of the inhabitants live on less than $ 1.25 a day, that is, below the poverty line; The infant mortality rate is 79 deaths per thousand live births. On the other hand, Africa presents the greatest cultural diversity, besides sheltering beautiful natural landscapes. ";
            _popup.nameContinent = _nameContinent;
            _popup.continentDescription = _continentDescription;
            [self presentPopup];
            break;
        case 2: //America
            _nameContinent = @"America";
            _continentDescription = @"The American continent has an area of ​​over 42 million square kilometers, divided into North America (23.4 million km²), Central America (735.6 thousand km²) and South America (17.8 million km²). Km²). America is made up of 35 countries, with a population of 934.3 million. The United States and Canada (North American countries) have high Human Development Indexes (HDI), however, Mexico and most of the nations of Central and South America have several socioeconomic problems. America: The American continent has an area of ​​over 42 million square kilometers, divided into North America (23.4 million km²), Central America (735.6 thousand km²) and South America (17.8 million km²). Km²). America is made up of 35 countries, with a population of 934.3 million. The United States and Canada (North American countries) have high Human Development Indexes (HDI), however, Mexico and most of the nations of Central and South America have several socioeconomic problems. America: The American continent has an area of ​​over 42 million square kilometers, divided into North America (23.4 million km²), Central America (735.6 thousand km²) and South America (17.8 million km²). Km²). America is made up of 35 countries, with a population of 934.3 million. The United States and Canada (North American countries) have high Human Development Indexes (HDI), however, Mexico and most of the nations of Central and South America have several socioeconomic problems. And its population is 934.3 million. The United States and Canada (North American countries) have high Human Development Indexes (HDI), however, Mexico and most of the nations of Central and South America have several socioeconomic problems. And its population is 934.3 million. The United States and Canada (North American countries) have high Human Development Indexes (HDI), however, Mexico and most of the nations of Central and South America have several socioeconomic problems.";
            _popup.nameContinent = _nameContinent;
            _popup.continentDescription = _continentDescription;
            [self presentPopup];
            break;
        case 3: //Europa
            _nameContinent = @"Europe";
            _continentDescription = @"It has 49 countries spread over an area of ​​10.3 million square kilometers. With 749.6 million inhabitants, Europe has the lowest population growth: 0.1% per year. This continent holds the best socioeconomic indicators on the planet.";
            _popup.nameContinent = _nameContinent;
            _popup.continentDescription = _continentDescription;
            [self presentPopup];
            break;
        case 4: //Oceania
            _nameContinent = @"Oceania";
            _continentDescription = @"The smallest continental portion, with a territorial extension of 8.5 million square kilometers, with 37.1 million inhabitants, distributed in 14 nations. With the exception of Australia and New Zealand, the countries of this continent have several economic problems.";
            _popup.nameContinent = _nameContinent;
            _popup.continentDescription = _continentDescription;
            [self presentPopup];
            break;
        default: ;
            break;
    }
}

#pragma mark Content Filtering


#pragma mark - UISearchDisplayController Delegate Methods




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
