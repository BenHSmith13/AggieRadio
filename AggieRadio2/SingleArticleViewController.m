//
//  SingleArticleViewController.m
//  AggieRadio2
//
//  Created by Ben Smith on 4/18/15.
//  Copyright (c) 2015 Ben Smith. All rights reserved.
//

#import "SingleArticleViewController.h"

@interface SingleArticleViewController ()

@end

@implementation SingleArticleViewController

@synthesize item;

-(instancetype)initWithNothing
{
    self = [super init];
    if(self){}
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    self.title = self.item.title;
    
    UITextView* content = [[UITextView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, self.view.bounds.size.height - 200)];
    content.text = item.content;
    [self.view addSubview:content];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor redColor]];
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
