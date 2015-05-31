//
//  PageContentViewController.m
//  ContiExam
//
//  Created by Ramón García on 5/30/15.
//  Copyright (c) 2015 Oscar & Ramon. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()

@end

@implementation PageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    _lblTopLine.text = _topLine;
    _lblText1.text = _textLine1;
    _lblText2.text = _textLine2;
    //[_btnSkip setTitle:_btnSkipText forState:UIControlStateNormal];
    _imgView.image = [UIImage imageNamed: _imgFile];
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
