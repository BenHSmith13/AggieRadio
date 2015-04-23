//
//  EventsViewController.m
//  AggieRadio2
//
//  Created by Ben Smith on 4/15/15.
//  Copyright (c) 2015 Ben Smith. All rights reserved.
//
//<div>Icon made by <a href="http://appzgear.com" title="Appzgear">Appzgear</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a> is licensed under <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0">CC BY 3.0</a></div>
//

#import "EventsViewController.h"

@interface EventsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NSDictionary* json;
@property (nonatomic, strong)NSArray* events;
@property (nonatomic, strong)UITableView* eventTableView;

@end

@implementation EventsViewController

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //Stuff for tab ----------------------------------------------------------------------
        self.tabBarItem.title = @"Events";
        UIImage *iconCalendar = [UIImage imageNamed:@"day7.png"];
        self.tabBarItem.image = iconCalendar;
        
        self.title = @"Events";
        
        //Header ------------------------------------------------------------------------------------
        UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-100, 30, 200, 50)];
        UIImage *radioLogo = [UIImage imageNamed:@"WebBanner"];
        logoView.image = radioLogo;
        logoView.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:logoView];
        
        UIButton *playButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-50, 80, 100, 100)];
        [playButton setTitle:@"Listen Live" forState:UIControlStateNormal];
        [playButton addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
        [playButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.view addSubview:playButton];
        
        //Table -----------------------------------------------------------------------------------------
        UIImageView *tableHeaderImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 175, self.view.bounds.size.width, 50)];
        UIImage *tableHeaderImg = [UIImage imageNamed:@"Events5"];
        tableHeaderImgView.image = tableHeaderImg;
        tableHeaderImgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:tableHeaderImgView];
        
        self.eventTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 225, self.view.bounds.size.width, self.view.bounds.size.height - 225)];
        self.eventTableView.delegate = self;
        self.eventTableView.dataSource = self;
        [self.view addSubview:self.eventTableView];
        
        //JSON Junk ---------------------------------------------------------------------------------------
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://calendarapi.spingo.com/v1/events?auth_token=8c50d4747a3766dc6ef343474263f19162e711a78ba5a550b969c1b665f04e4f"]
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                    [self parseJSON:json];
                                                    NSLog(@"JSON: %@", json);
                                                }];
        [dataTask resume];
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"metal3.png"]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.ARFeed = [AVPlayer playerWithURL:[NSURL URLWithString:@"http://streams.tsc.usu.edu:8888/"]];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

-(void)play:(UIButton*)sender{
    if (![IsPlayingSingle sharedInstance].isPlaying) {
        [[IsPlayingSingle sharedInstance] startFeed];
        [[IsPlayingSingle sharedInstance].ARFeed play];
        [IsPlayingSingle sharedInstance].isPlaying = YES;
    }
    else
    {
        [IsPlayingSingle sharedInstance].isPlaying = NO;
        [[IsPlayingSingle sharedInstance].ARFeed pause];  //This needs to be stop, pause pauses it.
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.events.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    //configure the cell
    EventObject* object = [self.events objectAtIndex:indexPath.row];
    if(object){
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
        cell.textLabel.text = object.title;
        NSMutableString* subtitle = [NSMutableString string];
        [subtitle appendString:object.date];
        //[subtitle appendString:object.time];
        cell.detailTextLabel.text = subtitle;
    }
    return cell;
}

-(void)parseJSON:(NSDictionary*)json{
    NSArray *events = [json objectForKey:@"events"];
    
    NSMutableArray *eventData = [NSMutableArray new];
    for (NSDictionary *individualEvent in events) {
        EventObject* thisEvent = [EventObject new];
        [thisEvent setTitle:[individualEvent objectForKey:@"title"]];
        [thisEvent setDate:[individualEvent objectForKey:@"date"]];
        [thisEvent setTime:[individualEvent objectForKey:@"time"]];
        [eventData addObject:thisEvent];
    }
    self.events = eventData;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.eventTableView reloadData];
    });
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
