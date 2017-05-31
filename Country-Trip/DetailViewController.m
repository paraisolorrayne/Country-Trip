//
//  DetailViewController.m
//  Country-Trip
//
//  Created by Lorrayne Paraiso on 26/05/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import "DetailViewController.h"

static NSString *const kUrlImage = @"http://awseb-e-e-awsebloa-c5zq0lwotmwj-832470836.us-east-1.elb.amazonaws.com/world/countries/";

@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *countryImageView;
@property (strong, nonatomic) IBOutlet UILabel *longNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *callingCodeLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateVisitedLabel;
@property (strong, nonatomic) DateVisitedViewController *popup;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _popup = [DateVisitedViewController instantiateNewView];
    _dateVisitedLabel.text = @"";
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if (_countryDetail) {
        _longNameLabel.text = _countryDetail.longname;
        NSString *callingCode = [@"Calling Code: " stringByAppendingString:_countryDetail.callingCode ?: @""];
        _callingCodeLabel.text = callingCode;
        [_countryImageView cancelImageDownloadTask];
        self.countryImageView.image = [UIImage imageNamed:@"default"];
        if (_countryDetail.posterUrl) {
            [_countryImageView setImageWithURL:_countryDetail.posterUrl];
        }
    } else if (_countryData) {
        _longNameLabel.text = _countryData.longname;
        NSString *callingCode = [@"Calling Code: " stringByAppendingString:_countryData.callingCode ?: @""];
        _callingCodeLabel.text = callingCode;
        [_countryImageView cancelImageDownloadTask];
        self.countryImageView.image = [UIImage imageNamed:@"default"];
        NSURL *posterUrl;
        posterUrl = [NSURL URLWithString:_countryData.posterString];
        if (posterUrl) {
            [_countryImageView setImageWithURL:posterUrl];
        }
    }
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
    _countryData.posterString = [NSString stringWithFormat:@"%@", _countryDetail.posterUrl];
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
    [self.popup presentInRootViewControllerOfViewController:self completion:nil];
    _dateVisitedLabel.text = _popup.stringFromDate;
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
