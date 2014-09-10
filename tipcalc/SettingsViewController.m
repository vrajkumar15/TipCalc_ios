//
//  SettingsViewController.m
//  tipcalc
//
//  Created by Rajkumar Vijayan on 9/7/14.
//  Copyright (c) 2014 Appovator. All rights reserved.
//

#import "SettingsViewController.h"
#import "TipViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISlider *defTipSlider;
@property (weak, nonatomic) IBOutlet UILabel *defTipLabel;

- (IBAction)sliderValueChanged:(id)sender;
- (void)updateDefValues;

@end

@implementation SettingsViewController

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
    [self updateDefValues];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderValueChanged:(id)sender {
        float defTipPerc = [[NSString stringWithFormat:@"%f", self.defTipSlider.value] floatValue];
    self.defTipLabel.text = [NSString stringWithFormat:@"%0.2f", defTipPerc];
   // defTipPerc = defTipPerc/100;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:defTipPerc forKey:@"Def_Tip_Perc"];
    [defaults synchronize];
}

- (void)updateDefValues {
    
    NSUserDefaults *defaultsset = [NSUserDefaults standardUserDefaults];
      float floatValue = [defaultsset floatForKey:@"Def_Tip_Perc"];
    self.defTipLabel.text = [NSString stringWithFormat:@"%0.2f", floatValue];
    self.defTipSlider.value = floatValue;
    //  int intValue = [defaults integerForKey:@"another_key_that_you_choose"];
}


@end
