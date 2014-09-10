//
//  TipViewController.m
//  tipcalc
//
//  Created by Rajkumar Vijayan on 9/6/14.
//  Copyright (c) 2014 Appovator. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"
#define CURRENCY_SYMBOL [[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol]

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
- (IBAction)onTap:(id)sender;
- (void)updateDefaultValues;
- (void)updateValues;
- (void) updateDefaultAmt;
- (void) saveBillAmount;
- (NSString *)localeFormat:(float) Amount;
- (IBAction)onSegSelect:(id)sender;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tip Calc";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.tipControl.selectedSegmentIndex=-1;
  //  [self updateDefaultValues];
    [self updateDefaultAmt];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self saveBillAmount];
    [self.view endEditing:YES];
    [self updateDefaultValues];
}

- (void)updateValues {
    
    float billAmount = [self.billTextField.text floatValue];
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue] ;
    
    float totalAmount = billAmount + tipAmount;
    NSString *currencyStringTip = [self localeFormat:tipAmount];
    self.tipLabel.text = [NSString stringWithFormat:@"%@", currencyStringTip];
    //    self.tipLabel.text = [NSString stringWithFormat:@"%@ %.2f",CURRENCY_SYMBOL,tipAmount];
    
 //   NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
  //  [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
  //  [formatter setLocale:[NSLocale currentLocale]];
  //  NSString *currencyString = [formatter stringFromNumber: [NSNumber numberWithFloat: totalAmount] ];
    NSString *currencyStringTotal = [self localeFormat:totalAmount];
   // self.totalLabel.text = [NSString stringWithFormat:@"%@ %@",CURRENCY_SYMBOL, currencyString];
     self.totalLabel.text = [NSString stringWithFormat:@"%@", currencyStringTotal];
}

- (IBAction)onSegSelect:(id)sender {
    [self updateValues];
    [self saveBillAmount];
}


- (void)updateDefaultValues {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    float floatValue = [defaults floatForKey:@"Def_Tip_Perc"];
    
    //    int intValue = [defaults integerForKey:@"another_key_that_you_choose"];
    //self.tipControl.selectedSegmentIndex=-1;
//    float floatValue = 0.5f;
    float billAmount = [self.billTextField.text floatValue];
    float tipAmount = billAmount * (floatValue/100) ;
    
    float totalAmount = billAmount + tipAmount;
    
    NSString *currencyStringTip = [self localeFormat:tipAmount];
    self.tipLabel.text = [NSString stringWithFormat:@"%@", currencyStringTip];
    //self.tipLabel.text = [NSString stringWithFormat:@"%@ %.2f",CURRENCY_SYMBOL, tipAmount];
    
    NSString *currencyStringTotal = [self localeFormat:totalAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"%@", currencyStringTotal];
  //  self.totalLabel.text = [NSString stringWithFormat:@"%@ %.2f",CURRENCY_SYMBOL, totalAmount];
}

- (void) updateDefaultAmt {
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    float defAmtValue = [defaults floatForKey:@"Last_Bill_Amt"];
    
    NSDate *prevDate = (NSDate *)[defaults objectForKey:@"Last_DateTime"];

   // NSString *prevDate = [defaults objectForKey:@"Last_DateTime"];
   // NSDateFormatter *prevdateFormat = [[NSDateFormatter alloc] init];
   // [prevdateFormat setDateFormat:@"yyyy-MM-dd HH:MM:SS"];
   // NSDate *prevTime = [prevdateFormat dateFromString:prevDate];
    
    NSDate *currTime = [NSDate date];
//    NSDate *currentTime = [prevdateFormat dateFromString:currTime];
    NSTimeInterval distanceBetweenDates = [currTime timeIntervalSinceDate:prevDate];
    double secsInAMin = 60;
    int minutesBetweenDates = distanceBetweenDates / secsInAMin;
    
    if (minutesBetweenDates <= 10) {
        self.billTextField.text = [NSString stringWithFormat:@"%0.2f", defAmtValue];
        [self updateDefaultValues];
    } else {
        [self updateDefaultValues];
    }
        
    
  //  self.billTextField.text = [NSString stringWithFormat:@"%0.2f", defAmtValue];
  //  [self updateDefaultValues];
}

- (void) saveBillAmount {
    float billAmount = [self.billTextField.text floatValue];
    NSDate *currentTime = [NSDate date];
    NSUserDefaults *billAmt = [NSUserDefaults standardUserDefaults];
    
    [billAmt setFloat:billAmount forKey:@"Last_Bill_Amt"];
    [billAmt setObject:currentTime forKey:@"Last_DateTime"];
    [billAmt synchronize];
}

- (NSString *)localeFormat:(float) Amount {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setLocale:[NSLocale currentLocale]];
    NSString *currencyString = [formatter stringFromNumber: [NSNumber numberWithFloat: Amount] ];
    return currencyString;
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}


@end
