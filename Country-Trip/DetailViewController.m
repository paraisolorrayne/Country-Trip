//
//  DetailViewController.m
//  Country-Trip
//
//  Created by Zup Beta on 26/05/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *countryImageView;
@property (strong, nonatomic) IBOutlet UILabel *longNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *callingCodeLabel;

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveCountryInCoreData {
    
}

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
                                                         [self.view endEditing:YES];
                                                     }];
                                                 }];
    
    [view addAction:yes];
    [view addAction: no];
    [self presentViewController:view animated:YES completion:nil];
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
