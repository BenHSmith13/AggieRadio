//
//  PodcastViewController.m
//  AggieRadio2
//
//  Created by Ben Smith on 4/14/15.
//  Copyright (c) 2015 Ben Smith. All rights reserved.
//
//<div>Icon made by <a href="http://www.freepik.com" title="Freepik">Freepik</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a> is licensed under <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0">CC BY 3.0</a></div>
//

#import "PodcastViewController.h"

@interface PodcastViewController ()

@property (nonatomic, strong) AVAudioPlayer* ARFeed;
//@property (nonatomic, assign) BOOL isFeedPlaying;  //need to make singleton

@end

@implementation PodcastViewController

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //Stuff for tab -----------------------------------------------------------------------------
        self.tabBarItem.title = @"Podcasts";
        UIImage *iconHeadPhone = [UIImage imageNamed:@"microphone110.png"];
        self.tabBarItem.image = iconHeadPhone;
        
        //Header ------------------------------------------------------------------------------------
        UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 50, 200, 50)];
        UIImage *radioLogo = [UIImage imageNamed:@"WebBanner"];
        logoView.image = radioLogo;
        logoView.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:logoView];
        
        UIButton *playButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 100, 300)];
        [playButton setTitle:@"Listen Live" forState:UIControlStateNormal];
        [playButton addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:playButton];
        
        
        
        self.view.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.ARFeed = [AVPlayer playerWithURL:[NSURL URLWithString:@"http://streams.tsc.usu.edu:8888/"]];
    
}


-(void)play:(UIButton*)sender{
    if (![IsPlayingSingle sharedInstance].isPlaying) {
        [self.ARFeed play];
        [IsPlayingSingle sharedInstance].isPlaying = YES;
    }
    else
    {
        [IsPlayingSingle sharedInstance].isPlaying = NO;
        [self.ARFeed pause];  //This needs to be stop, pause pauses it.
    }
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
