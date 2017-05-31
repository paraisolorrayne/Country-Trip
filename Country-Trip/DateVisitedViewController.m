//
//  DateVisitedViewController.m
//  Country-Trip
//
//  Created by Lorrayne Paraiso on 28/05/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import "DateVisitedViewController.h"

@interface DateVisitedViewController ()
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) NSDate *selectedDate;

@end

@implementation DateVisitedViewController

+(instancetype) instantiateNewView {
    UIStoryboard *sb = [UIStoryboard storyboardWithName: @"Date" bundle: nil];
    DateVisitedViewController *ctrl = [sb instantiateViewControllerWithIdentifier: @"Date"];
    return ctrl;
}

-(void)actionDismissPopup {
    [self dismissPopup:^{
        if ([self.delegate respondsToSelector:@selector(didClickOkOnSuccess:)]) {
            [self.delegate didClickOkOnSuccess:self];
        }
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

-(IBAction)datePickerValueChanged: (id)sender {
    _selectedDate = [sender date];
}

- (IBAction)selectDate:(id)send {
    DetailViewController *detail = [[DetailViewController alloc]init];
    detail.dateTravel = (NSDate *)_selectedDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-mm-yyyy"];
    _stringFromDate = [formatter stringFromDate:_selectedDate];
    [self actionDismissPopup];
}
- (IBAction)cancelDate:(id)sender {
    [self actionDismissPopup];
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
