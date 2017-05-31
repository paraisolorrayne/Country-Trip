//
//  ProfileViewController.m
//  Country-Trip
//
//  Created by Lorrayne Paraiso on 27/05/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *profilePicture;
@property (strong, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

@property (weak, nonatomic) IBOutlet UILabel *lblLoginStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loading;

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
        _loading.hidden = NO;
        [_loading startAnimating];
        
        
        if ([FBSDKAccessToken currentAccessToken]) {
            
            FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                          initWithGraphPath:@"me"
                                          parameters: data
                                          HTTPMethod:@"GET"];
            [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                  id result,
                                                  NSError *error) {
                if (!error){
                    NSDictionary *dictionary = (NSDictionary *)result;
                    NSDictionary *data = [(NSDictionary *)result objectForKey:@"picture"];
                    NSDictionary *pic = [(NSDictionary *)data objectForKey:@"data"];
                    NSDictionary *photo = (NSDictionary *)[pic objectForKey:@"url"];
                    NSString *url = [NSString stringWithFormat:@"%@", photo];
                    ;
                    NSString *userName = [dictionary objectForKey:@"name"];
                    _lblUsername.text = userName;
                    NSString *userEmail = [dictionary objectForKey:@"email"];
                    _lblEmail.text = userEmail;
                    _profilePicture.image = [UIImage imageNamed:@"user-default"];
                    [_profilePicture cancelImageDownloadTask];
                    if (!url) {
                        
                    } else {
                        NSURL *posterUrlComplete = [NSURL URLWithString:url];
                        [_profilePicture setImageWithURL:posterUrlComplete];
                    }
                    
                    _loading.hidesWhenStopped = YES;
                    [_loading stopAnimating];
                }
                else {
                    NSLog(@"result: %@",[error description]);
                }}];
        }
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self toggleHiddenState:NO];
    self.loginButton.readPermissions =
    @[@"public_profile", @"email", @"user_friends"];
    _lblUsername.text = @"";
    _lblEmail.text = @"";
    
    [self toggleHiddenState:NO];
    self.lblLoginStatus.text = @"";
    self.loginButton.readPermissions =
    @[@"public_profile", @"email", @"user_friends"];
}

- (void) viewWillAppear:(BOOL)animated {
    [self profileUserInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
