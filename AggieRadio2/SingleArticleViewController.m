//
//  SingleArticleViewController.m
//  AggieRadio2
//
//  Created by Ben Smith on 4/18/15.
//  Copyright (c) 2015 Ben Smith. All rights reserved.
//

#import "SingleArticleViewController.h"

@interface SingleArticleViewController () <UIWebViewDelegate>

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
    [articleTitle setTextColor:[UIColor colorWithRed:18.0/255.0 green:6.0/255.0 blue:80.0/255.0 alpha:1]];
    [self.view addSubview:articleTitle];
    
    UILabel *authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 115, self.view.bounds.size.width, 50)];
    authorLabel.textAlignment = NSTextAlignmentCenter;
    authorLabel.text = self.item.author;
    [authorLabel setTextColor:[UIColor colorWithRed:18.0/255.0 green:6.0/255.0 blue:80.0/255.0 alpha:1]];
    [self.view addSubview:authorLabel];
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 165, self.view.bounds.size.width, self.view.bounds.size.height - 200)];
    
    NSRange range = [self.item.content rangeOfString:self.item.content];
    
    if(range.location != NSNotFound) {
        // Adjust style for mobile
        float inset = 16;
        NSString *style = [NSString stringWithFormat:@"<style>img {max-width: %fpx;}</style>", self.view.bounds.size.width - inset];
        self.item.content = [NSString stringWithFormat:@"%@%@%@", [self.item.content substringToIndex:range.location], style, [self.item.content substringFromIndex:range.location]];
        NSString *style2 = [NSString stringWithFormat:@"<style>iframe {max-width: %fpx;}</style>", self.view.bounds.size.width - inset];
        self.item.content = [NSString stringWithFormat:@"%@%@%@", [self.item.content substringToIndex:range.location], style2, [self.item.content substringFromIndex:range.location]];

    }
    
    [webView loadHTMLString:self.item.content baseURL:nil];
    //webView.delegate = self;
    [self.view addSubview:webView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"metal3.png"]];

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
