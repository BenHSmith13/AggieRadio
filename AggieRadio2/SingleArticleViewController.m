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

    UILabel *articleTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 75, self.view.bounds.size.width, 50)];
    articleTitle.textAlignment = NSTextAlignmentCenter;
    articleTitle.text = self.item.title;
    articleTitle.numberOfLines = 0;
    articleTitle.lineBreakMode = NSLineBreakByWordWrapping;
    [articleTitle setFont:[UIFont boldSystemFontOfSize:17]];
    [articleTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:articleTitle];
    
    UILabel *authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 115, self.view.bounds.size.width, 50)];
    authorLabel.textAlignment = NSTextAlignmentCenter;
    authorLabel.text = self.item.author;
    [authorLabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview:authorLabel];
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 165, self.view.bounds.size.width, self.view.bounds.size.height - 200)];
    [webView loadHTMLString:self.item.content baseURL:nil];
    [self.view addSubview:webView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor blueColor]];
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
