//
//  SATabBarOneViewController.m
//  StudyApple
//
//  Created by liuzhenhui on 2019/3/19.
//  Copyright © 2019 liuzhenhui. All rights reserved.
//

#import "SATabBarOneViewController.h"

@interface SATabBarOneViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong,nonatomic) NSArray *characterName;

@end

@implementation SATabBarOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.characterName = @[@"Luke", @"Leia", @"Han", @"Chewbacca",
                            @"Artoo", @"Threepio", @"Lando"];
}
- (IBAction)buttonPressed:(UIButton *)sender {
    NSInteger row = [self.pickerView selectedRowInComponent:0];
    NSString *selected = self.characterName[row];
    NSString *title = [[NSString alloc]initWithFormat:@"You selected %@",selected];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Choosed" message:title preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -
#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.characterName count];
}

#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.characterName[row];
}

@end
