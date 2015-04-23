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

@property (nonatomic, strong) AVAudioPlayer* cast;
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
    [self.playButton addTarget:self action:@selector(playButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.playButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:self.playButton];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 200, self.view.bounds.size.width - 32, self.view.bounds.size.height -216)];
    UIImage *roundLogo = [UIImage imageNamed:@"AggieEmblem"];
    imageView.image = roundLogo;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    
    self.slider = [[UISlider alloc] initWithFrame:CGRectMake(16, 200, self.view.bounds.size.width - 32, 50)];
    [self.view addSubview:self.slider];
    
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

- (IBAction)playButtonClicked:(id)sender {
    // Read the file from resource folder and set it in the avAudioPlayer
    //NSURL *fileUrl = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"musicFile" ofType:@"caf"]];
    //avAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:nil];
    [self.cast setDelegate:self];
    [self.cast setVolume:1.0];
    
    // Set a timer which keep getting the current music time and update the UISlider in 1 sec interval
    self.sliderTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateSlider) userInfo:nil repeats:YES];
    // Set the maximum value of the UISlider
    self.slider.maximumValue = self.cast.duration;
    // Set the valueChanged target
    [self.slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    
    // Play the audio
    [self.cast prepareToPlay];
    [self.cast play];
}

- (void)updateSlider {
    // Update the slider about the music time
    self.slider.value = self.cast.currentTime;
}

- (IBAction)sliderChanged:(UISlider *)sender {
    // Fast skip the music when user scroll the UISlider
    [self.cast stop];
    [self.cast setCurrentTime:self.slider.value];
    [self.cast prepareToPlay];
    [self.cast play];
}

// Stop the timer when the music is finished (Need to implement the AVAudioPlayerDelegate in the Controller header)
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    // Music completed
    if (flag) {
        [self.sliderTimer invalidate];
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
