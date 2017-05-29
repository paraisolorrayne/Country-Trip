//
//  DetailViewController.m
//  Country-Trip
//
//  Created by Zup Beta on 26/05/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import "DetailViewController.h"

static NSString *const kUrlImage = @"http://awseb-e-e-awsebloa-c5zq0lwotmwj-832470836.us-east-1.elb.amazonaws.com/world/countries/";

@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *countryImageView;
@property (strong, nonatomic) IBOutlet UILabel *longNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *callingCodeLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateVisitedLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated {
    _longNameLabel.text = _countryDetail.longname;
    NSString *callingCode = [@"Calling Code: " stringByAppendingString:_countryDetail.callingCode];
    _callingCodeLabel.text = callingCode;
    [_countryImageView cancelImageDownloadTask];
    self.countryImageView.image = [UIImage imageNamed:@"default"];
    if (_countryDetail.posterUrl) {
        [_countryImageView setImageWithURL:_countryDetail.posterUrl];
    }
    _dateVisitedLabel.text = [NSString stringWithFormat:@"%@", _dateTravel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveCountryInCoreData {
    AppDelegate *appDelegate = (AppDelegate *) UIApplication.sharedApplication.delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    _countryData = [NSEntityDescription insertNewObjectForEntityForName:@"Country" inManagedObjectContext:context];
    _countryData.shortname = _countryDetail.shortname;
    _countryData.longname = _countryDetail.longname;
    _countryData.callingCode = _countryDetail.callingCode;
    NSLog(@"shortname: %@\nlongname: %@\n callingCode: %@\n\n", _countryData.shortname, _countryData.longname, _countryData.callingCode);
    //_countryData.idCountry = _countryDetail.idCountry;
    NSError *error = nil;
    [context save:&error];
    if (error) {
        NSLog(@"%@", error);
    }
}

-(void)clearStackView {
    NSArray *viewControllersFromStack = [self.navigationController viewControllers];
    for(UIViewController *currentVC in [viewControllersFromStack reverseObjectEnumerator]) {
        [currentVC.navigationController popViewControllerAnimated:NO];
    }
}

#pragma mark - Action

- (IBAction)markVisited:(id)sender {
    [self saveCountryInCoreData];
    UIAlertController *view = [UIAlertController alertControllerWithTitle:@"País registrado com sucesso!"
                                                                  message: [NSString stringWithFormat:@"Deseja permancer na tela"]
                                                           preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"Yes"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action) {
                                                    [view dismissViewControllerAnimated:YES completion:^{
                                                        [self.view endEditing:YES];
                                                    }];
                                                }];
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"No"
                                                 style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                                                     [view dismissViewControllerAnimated:YES completion:^{
                                                         
                                                     }];
                                                     [self clearStackView];
                                                 }];
    
    [view addAction:yes];
    [view addAction: no];
    [self presentViewController:view animated:YES completion:nil];
}

- (IBAction)editVisit:(id)sender {
    DateVisitedViewController *popup = [DateVisitedViewController instantiateNewView];
    [popup presentInRootViewControllerOfViewController:self completion:nil];
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
