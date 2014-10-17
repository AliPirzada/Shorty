//
//  DOTViewController.h
//  Shorty
//
//  Created by Ali Pirzada on 6/09/2014.
//  Copyright (c) 2014 Dotanimizers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOTViewController : UIViewController <UIWebViewDelegate,
                                                 NSURLConnectionDelegate,
                                                 NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UITextField *urlField;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *shortenButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shortLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *clipBoardButton;

-(IBAction)loadLocation:(id)sender;
-(IBAction)shortenURL:(id)sender;
-(IBAction)clipBoardURL:(id)sender;

@end
