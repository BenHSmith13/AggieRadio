//
//  ArticleViewController.m
//  AggieRadio2
//
//  Created by Ben Smith on 4/15/15.
//  Copyright (c) 2015 Ben Smith. All rights reserved.
//
//<div>Icon made by <a href="http://www.freepik.com" title="Freepik">Freepik</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a> is licensed under <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0">CC BY 3.0</a></div>
//

#import "ArticleViewController.h"
#import "MWFeedParser.h"
#import "NSString+HTML.h"
#import "SingleArticleViewController.h"

@interface ArticleViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* articleTableView;

@end

@implementation ArticleViewController

@synthesize itemsToDisplay;

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //Stuff for tab ---------------------------------------------------------------------------
        self.tabBarItem.title = @"Articles";
        UIImage *iconNewspaper = [UIImage imageNamed:@"newspaper20.png"];
        self.tabBarItem.image = iconNewspaper;
        
        //Header ------------------------------------------------------------------------------------
        UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-100, 50, 200, 50)];
        UIImage *radioLogo = [UIImage imageNamed:@"WebBanner"];
        logoView.image = radioLogo;
        logoView.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:logoView];
        
        UIButton *playButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-50, 100, 100, 100)];
        [playButton setTitle:@"Listen Live" forState:UIControlStateNormal];
        [playButton addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:playButton];
        
        //Table -----------------------------------------------------------------------------------------
        UIImageView *tableHeaderImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 50)];
        UIImage *tableHeaderImg = [UIImage imageNamed:@"articles"];
        tableHeaderImgView.image = tableHeaderImg;
        tableHeaderImgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:tableHeaderImgView];
        
        self.articleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 250, self.view.bounds.size.width, self.view.bounds.size.height - 250)];
        self.articleTableView.delegate = self;
        self.articleTableView.dataSource = self;
        [self.view addSubview:self.articleTableView];
        
        
        self.view.backgroundColor = [UIColor magentaColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Setup for MWFeed Parser ---------------------------------------------------------------------
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    parsedItems = [[NSMutableArray alloc] init];
    self.itemsToDisplay = [NSArray array];
    
    //RSS Feed --------------------------------------------------------------------------------------
    NSURL *podbeanRSSFeed = [NSURL URLWithString:@"http://www.usu.edu/radio/index.php/feed/"];
    feedParser = [[MWFeedParser alloc] initWithFeedURL:podbeanRSSFeed];
    feedParser.delegate = self;
    feedParser.feedParseType = ParseTypeFull;
    feedParser.connectionType = ConnectionTypeAsynchronously;
    [feedParser parse];
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

- (void)updateTableWithParsedItems {
    self.itemsToDisplay = [parsedItems sortedArrayUsingDescriptors:
                           [NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"date"
                                                                                ascending:NO]]];
    self.articleTableView.userInteractionEnabled = YES;
    self.articleTableView.alpha = 1;
    
    dispatch_async(dispatch_get_main_queue(), ^{  //I don't know if this is neccisary
        [self.articleTableView reloadData];
    });
}

#pragma mark -
#pragma mark MWFeedParserDelegate

- (void)feedParserDidStart:(MWFeedParser *)parser {
    NSLog(@"Started Parsing: %@", parser.url);
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
    NSLog(@"Parsed Feed Info: “%@”", info.title);
    self.title = info.title;
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
    NSLog(@"Parsed Feed Item: “%@”", item.title);
    if (item) [parsedItems addObject:item];
}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
    NSLog(@"Finished Parsing%@", (parser.stopped ? @" (Stopped)" : @""));
    [self updateTableWithParsedItems];
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
    NSLog(@"Finished Parsing With Error: %@", error);
    if (parsedItems.count == 0) {
        self.title = @"Failed"; // Show failed message in title
    } else {
        // Failed but some items parsed, so show and inform of error
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Parsing Incomplete"
                                                        message:@"There was an error during the parsing of this feed. Not all of the feed items could parsed."
                                                       delegate:nil
                                              cancelButtonTitle:@"Dismiss"
                                              otherButtonTitles:nil];
        [alert show];
    }
    [self updateTableWithParsedItems];
}


#pragma mark -
#pragma mark Table view data source

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return itemsToDisplay.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Configure the cell.
    MWFeedItem *item = [itemsToDisplay objectAtIndex:indexPath.row];
    if (item) {
        
        // Process
        NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
        NSString *itemSummary = item.summary ? [item.summary stringByConvertingHTMLToPlainText] : @"";
        
        // Set
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
        cell.textLabel.text = itemTitle;
        NSMutableString *subtitle = [NSMutableString string];
        if (item.date) [subtitle appendFormat:@"%@: ", [formatter stringFromDate:item.date]];
        [subtitle appendString:itemSummary];
        cell.detailTextLabel.text = subtitle;
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SingleArticleViewController *singleArt = [[SingleArticleViewController alloc] initWithNothing];
    singleArt.item = (MWFeedItem *)[itemsToDisplay objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:singleArt animated:YES];
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
