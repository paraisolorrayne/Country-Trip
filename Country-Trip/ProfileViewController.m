//
//  ProfileViewController.m
//  Country-Trip
//
//  Created by Zup Beta on 27/05/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *profilePicture;
@property (strong, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

@property (weak, nonatomic) IBOutlet UILabel *lblLoginStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
-(void)toggleHiddenState:(BOOL)shouldHide;
@end

@implementation ProfileViewController


-(void)toggleHiddenState:(BOOL)shouldHide{
    self.lblUsername.hidden = shouldHide;
    self.lblEmail.hidden = shouldHide;
    self.profilePicture.hidden = shouldHide;
}

- (void)profileUserInfo {
    NSDictionary *data = @{ @"fields": @"id,name,email, picture"};
    
    if ([FBSDKAccessToken currentAccessToken]) {
        FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                      initWithGraphPath:@"me"
                                      parameters: data
                                      HTTPMethod:@"GET"];
        [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                              id result,
                                              NSError *error) {
            if (!error){
                NSLog(@"result: %@",result);
                NSDictionary *dictionary = (NSDictionary *)result;
                NSString *photoUrl = (NSString *)[dictionary objectForKey:@"picture"];
                ;
               /*
                _profilePicture.image = [UIImage imageNamed:@"user-default"];
                [_profilePicture cancelImageDownloadTask];
                if (!photoUrl) {
                    
                } else {
                    NSURL *posterUrlComplete = [NSURL URLWithString:photoUrl];
                    [_profilePicture setImageWithURL:posterUrlComplete];
                }
                */
            }
            else {
                NSLog(@"result: %@",[error description]);
            }}];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self toggleHiddenState:YES];
    self.lblLoginStatus.text = @"";
    self.loginButton.readPermissions =
    @[@"public_profile", @"email", @"user_friends"];
    [self profileUserInfo];
    
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
