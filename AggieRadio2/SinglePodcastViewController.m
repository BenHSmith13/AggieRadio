//
//  SinglePodcastViewController.m
//  AggieRadio2
//
//  Created by Ben Smith on 4/17/15.
//  Copyright (c) 2015 Ben Smith. All rights reserved.
//

#import "SinglePodcastViewController.h"

@interface SinglePodcastViewController ()

@property (nonatomic, assign)BOOL isPodcastPlaying;
@property (nonatomic, strong)UIButton* playButton;

@end

@implementation SinglePodcastViewController

@synthesize item;

-(instancetype)initWithNothing
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated  //Do all my crap in here
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    self.title = self.item.title;
    self.cast = [AVPlayer playerWithURL:[NSURL URLWithString:[[self.item.enclosures objectAtIndex:0] objectForKey:@"url"]]];
    
    self.playButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-100, 100, 200, 100)];
    [self.playButton setTitle:@"Play" forState:UIControlStateNormal];
    [self.playButton addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.playButton];
    
}

-(void)play:(UIButton*)sender
{
    if (!self.isPodcastPlaying) {
        [self.playButton setTitle:@"Pause" forState:UIControlStateNormal];
        [self.cast play];
        self.isPodcastPlaying = YES;
    }
    else
    {
        [self.playButton setTitle:@"Play" forState:UIControlStateNormal];
        [self.cast pause];
        self.isPodcastPlaying = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isPodcastPlaying = NO;
    [self.view setBackgroundColor:[UIColor cyanColor]];
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
