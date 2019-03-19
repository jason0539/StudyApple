//
//  SATabBarOneViewController.m
//  StudyApple
//
//  Created by liuzhenhui on 2019/3/19.
//  Copyright © 2019 liuzhenhui. All rights reserved.
//

#import "SATabBarOneViewController.h"

#define kStateComponent 0
#define kZipComponent   1

@interface SATabBarOneViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) NSDictionary *stateZips;
@property (strong, nonatomic) NSArray *states;
@property (strong, nonatomic) NSArray *zips;

@end

@implementation SATabBarOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSBundle *bundle = [NSBundle mainBundle];
    
    NSURL *statedictionaryPlistURL = [bundle URLForResource:@"statedictionary" withExtension:@"plist"];
    //数据集（洲、邮编）
    self.stateZips = [NSDictionary dictionaryWithContentsOfURL:statedictionaryPlistURL];
    //所有州
    NSArray *allStates = [self.stateZips allKeys];
    NSArray *sortedStates = [allStates sortedArrayUsingSelector:@selector(compare:)];
    self.states = sortedStates;
    //当前选中的州的所有邮编
    NSString *selectedState = self.states[0];
    self.zips = self.stateZips[selectedState];
    
}
- (IBAction)buttonPressed:(UIButton *)sender {
    NSInteger stateRow = [self.pickerView
                          selectedRowInComponent:kStateComponent];
    NSInteger zipRow = [self.pickerView
                        selectedRowInComponent:kZipComponent];
    
    NSString *state = self.states[stateRow];
    NSString *zip = self.zips[zipRow];
    
    NSString *title = [[NSString alloc] initWithFormat:
                       @"You selected zip code %@.", zip];
    NSString *message = [[NSString alloc] initWithFormat:
                         @"%@ is in %@", zip, state];
    
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:title
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault handler:nil];
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
    return 2;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == kStateComponent) {
        return self.states.count;
    }else{
        return self.zips.count;
    }
}

#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == kStateComponent) {
        return self.states[row];
    }else{
        return self.zips[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == kStateComponent) {
        NSString *selectedState = self.states[row];
        self.zips = self.stateZips[selectedState];
        [self.pickerView reloadComponent:kZipComponent];
        [self.pickerView selectRow:0
                        inComponent:kZipComponent
                               animated:YES];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    CGFloat pickerWidth = pickerView.bounds.size.width;
    if (component == kZipComponent) {
        return pickerWidth/3;
    } else {
        return 2 * pickerWidth/3;
    }
}

@end
