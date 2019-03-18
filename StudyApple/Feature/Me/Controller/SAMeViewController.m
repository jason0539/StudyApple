//
//  SAMeViewController.m
//  StudyApple
//
//  Created by liuzhenhui on 2019/1/10.
//  Copyright © 2019 liuzhenhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SAMeViewController.h"
#import <Masonry/Masonry.h>

@interface SAMeViewController()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;

@end

@implementation SAMeViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    //Setup
    [self setupUI];
}

- (void)setupUI{

    
}

- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender{
    [self.nameField resignFirstResponder];
    [self.numberField resignFirstResponder];
}

@end
