//
//  SettingsViewController.m
//  SettingsTest
//
//  Created by Nikolay Berlioz on 13.12.15.
//  Copyright © 2015 Nikolay Berlioz. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

static NSString *kSettingLogin        = @"login";
static NSString *kSettingPassword     = @"password";
static NSString *kSettingLevel        = @"level";
static NSString *kSettingShadows      = @"shadows";
static NSString *kSettingDetalization = @"detalization";
static NSString *kSettingSound        = @"sound";
static NSString *kSettingMusic        = @"music";

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadSettings];
    
    
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    
    [notification addObserver:self selector:@selector(notificationKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [notification addObserver:self selector:@selector(notificationKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - Notification

- (void) notificationKeyboardWillShow:(NSNotification*)notification
{
    NSLog(@"notificationKeyboardWillShow:\n%@", notification.userInfo);
}

- (void) notificationKeyboardWillHide:(NSNotification*)notification
{
    NSLog(@"notificationKeyboardWillHide:\n%@", notification.userInfo);
}

UIKIT_EXTERN NSString *const UIKeyboardFrameBeginUserInfoKey        NS_AVAILABLE_IOS(3_2); // NSValue of CGRect
UIKIT_EXTERN NSString *const UIKeyboardFrameEndUserInfoKey          NS_AVAILABLE_IOS(3_2); // NSValue of CGRect
UIKIT_EXTERN NSString *const UIKeyboardAnimationDurationUserInfoKey NS_AVAILABLE_IOS(3_0); // NSNumber of double
UIKIT_EXTERN NSString *const UIKeyboardAnimationCurveUserInfoKey    NS_AVAILABLE_IOS(3_0); // NSNumber of NSUInteger (UIViewAnimationCurve)
UIKIT_EXTERN NSString *const UIKeyboardIsLocalUserInfoKey           NS_AVAILABLE_IOS(9_0); // NSNumber of BOOL

#pragma mark - Save and Load

- (void) saveSettings
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    [userDefaults setObject:self.loginField.text forKey:kSettingLogin];
    [userDefaults setObject:self.passwordField.text forKey:kSettingPassword];
    [userDefaults setInteger:self.levelControl.selectedSegmentIndex forKey:kSettingLevel];
    [userDefaults setBool:self.shadowsSeitch.isOn forKey:kSettingShadows];
    [userDefaults setInteger:self.detalizationControl.selectedSegmentIndex forKey:kSettingDetalization];
    [userDefaults setDouble:self.soundSlider.value forKey:kSettingSound];
    [userDefaults setDouble:self.musicSlider.value forKey:kSettingMusic];

    [userDefaults synchronize];
}

- (void) loadSettings
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.loginField.text = [userDefaults objectForKey:kSettingLogin];
    self.passwordField.text = [userDefaults objectForKey:kSettingPassword];
    self.levelControl.selectedSegmentIndex = [userDefaults integerForKey:kSettingLevel];
    self.shadowsSeitch.on = [userDefaults boolForKey:kSettingShadows];
    self.detalizationControl.selectedSegmentIndex = [userDefaults integerForKey:kSettingDetalization];
    self.soundSlider.value = [userDefaults doubleForKey:kSettingSound];
    self.musicSlider.value = [userDefaults doubleForKey:kSettingMusic];
}

#pragma mark - Actions

- (IBAction)actionTextChanged:(UITextField *)sender
{
    [self saveSettings];
}

- (IBAction)actionValueChanged:(id)sender
{
    [self saveSettings];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.loginField])
    {
        [self.passwordField becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    
    return NO;
}




@end































