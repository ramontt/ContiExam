//
//  IntroPageViewController.m
//  ContiExam
//
//  Created by Ramón García on 5/31/15.
//  Copyright (c) 2015 Oscar & Ramon. All rights reserved.
//

#import "IntroPageViewController.h"
#import "PageContentViewController.h"

@interface IntroPageViewController ()

@end

@implementation IntroPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Initialize page titles
    _pageTopTexts = @[@"EXAMEN", @"NOMBRES", @"SUERTE!"];
    _pageTexts1 = @[@"31/May/2015", @"Oscar Camacho", @"What a good night,"];
    _pageTexts2 = @[@"", @"Ramon Garcia", @"to have a curse ..."];
    _pageImageNames = @[@"continental_logo.png", @"", @""];
    _pageBtnSkipTexts = @[@"Skip", @"Skip", @"OK!"];
    
    // Set data source
    [self setDataSource: self];
    
    // Set first visible view
    PageContentViewController* startingVC = [self viewControllerAtIndex:0];
    NSArray* viewControllers = @[startingVC];
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if( ([_pageTopTexts count] == 0) || (index >= [_pageTopTexts count]) )
    {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.topLine = _pageTopTexts[index];
    pageContentViewController.textLine1 = _pageTexts1[index];
    pageContentViewController.textLine2 = _pageTexts2[index];
    pageContentViewController.imgFile = _pageImageNames[index];
    pageContentViewController.btnSkipText = _pageBtnSkipTexts[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Page View Controller Data Source

- (UIViewController*)
pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if( (index == 0) || (index == NSNotFound) )
    {
        return nil;
    }
    
    index --;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController*) pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if( index == NSNotFound )
    {
        return nil;
    }
    
    index ++;
    
    if( index == [_pageTopTexts count] )
    {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

- (NSInteger) presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [_pageTopTexts count];
}

- (NSInteger) presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
