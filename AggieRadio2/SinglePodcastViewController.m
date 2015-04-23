//
//  SinglePodcastViewController.m
//  AggieRadio2
//
//  Created by Ben Smith on 4/17/15.
//  Copyright (c) 2015 Ben Smith. All rights reserved.
//
// thanks to contributors to http://stackoverflow.com/questions/2654849/uislider-to-control-avaudioplayer
//

#import "SinglePodcastViewController.h"

@interface SinglePodcastViewController () <AVAudioPlayerDelegate>

@property (nonatomic, strong) AVPlayer* cast;
@property (nonatomic, assign) BOOL isPodcastPlaying;
@property (nonatomic, strong) UIButton* playButton;
@property (nonatomic, strong) UISlider* slider;
@property (nonatomic, strong) NSTimer* sliderTimer;

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
    //self.cast = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:[[self.item.enclosures objectAtIndex:0] objectForKey:@"url"]] error:nil];
    
    UILabel *articleTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 75, self.view.bounds.size.width, 50)];
    articleTitle.textAlignment = NSTextAlignmentCenter;
    articleTitle.text = self.item.title;
    articleTitle.numberOfLines = 0;
    articleTitle.lineBreakMode = NSLineBreakByWordWrapping;
    [articleTitle setFont:[UIFont boldSystemFontOfSize:17]];
    [self.view addSubview:articleTitle];
    
    
    self.playButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-100, 115, 200, 100)];
    [self.playButton setTitle:@"Play" forState:UIControlStateNormal];
    [self.playButton addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [self.playButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:self.playButton];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"stampedSurface"]];

    
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
