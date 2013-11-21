//
//  SafetyViewController.m
//  Syft
//
//  Created by Joe Newbry on 11/19/13.
//  Copyright (c) 2013 Joe Newbry. All rights reserved.
//

#import "SafetyViewController.h"

@interface SafetyViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *safetTipsScrollView;
@property (strong, nonatomic) IBOutlet UIScrollView *meetingOfflineScrollView;

@end

@implementation SafetyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) setupViews
{
    self.safetTipsScrollView.hidden = false;
    self.meetingOfflineScrollView.hidden = true;
//
//    NSString *safetyText = @"Safety Tips ,asdflasdkjfl;askdjf;laksdjf;laksjdf;lkajsd;flkja;sdlfjk;alskdjf;lajksdf;lkajdsf;lkjas;ldkfja;lskdjf;alksjdf;lkajsd;flkjasd;lfkj";
//
//    CGRect stringSize = [safetyText boundingRectWithSize:CGSizeMake(self.safetTipsScrollView.bounds.size.width, 50000) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:nil context:nil];
//
//    UITextView *safetyTipsView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.safetTipsScrollView.bounds.size.width, stringSize.size.height)];
//    safetyTipsView.textColor = [UIColor redColor];
//    [safetyTipsView setFont:[UIFont fontWithName:@"ArialMT" size:20.0]];
//    safetyTipsView.backgroundColor = [UIColor greenColor];
//
//
//
//
//    safetyTipsView.text = @"Safety Tips";
//
//    [self.safetTipsScrollView addSubview:safetyTipsView];
}

//-(CGFloat) GetHeightFoText:(NSString *)str  FoWidth:(int)width ForFontSize: (int)fntSize
//{
//    CGSize maximumLabelSize = CGSizeMake(width,9999);
//    CGSize expectedLabelSize = [str boundingRectWithSize:<#(CGSize)#> options:<#(NSStringDrawingOptions)#> attributes:<#(NSDictionary *)#> context:<#(NSStringDrawingContext *)#>
//
//                                sizeWithFont:[UIFont systemFontOfSize:fntSize]
//                                constrainedToSize:maximumLabelSize
//                                    lineBreakMode:UILineBreakModeWordWrap];
//    return expectedLabelSize.height;
//}

- (IBAction)changePlainSegmentView:(id)sender {
    if (self.safetTipsScrollView.isHidden){
        self.safetTipsScrollView.hidden = false;
        self.meetingOfflineScrollView.hidden = true;
    } else {
        self.safetTipsScrollView.hidden = true;
        self.meetingOfflineScrollView.hidden = false;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setupViews];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
