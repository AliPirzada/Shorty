//
//  DOTViewController.m
//  Shorty
//
//  Created by Ali Pirzada on 6/09/2014.
//  Copyright (c) 2014 Dotanimizers. All rights reserved.
//

#import "DOTViewController.h"

@interface DOTViewController ()
{
    NSURLConnection *shortenURLConnection;
    NSMutableData *shortURLData;
}

@end

#define kGoDaddyAccountKey @"0123456789abcdef0123456789abcdef"

@implementation DOTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadLocation:(id)sender
{
    // created a string of url
    NSString *urlText = self.urlField.text;
  /*
    if (![urlText hasPrefix:@"http:"]&&![urlText hasPrefix:@"https:"]) {
        if (![urlText hasPrefix:@"//"]) {
            urlText = [@"//" stringByAppendingString:urlText];
            urlText = [@"http:" stringByAppendingString:urlText];
        } */
        // converted the string into an URL object
        NSURL *url = [NSURL URLWithString:urlText];
        // Request a webpage to be loaded in webview
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    //}
}


-(void)webViewDidStartLoad:(UIWebView *)webView
{
    self.shortenButton.enabled = NO;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.shortenButton.enabled = YES;
    self.urlField.text = webView.request.URL.absoluteString;
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSString *message = [NSString stringWithFormat:@"A problem occured trying to load this page: %@",
                         error.localizedDescription];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could notload URL" message:message delegate:nil cancelButtonTitle:@"That's Sad" otherButtonTitles:nil];
    [alert show];
}


-(IBAction)shortenURL:(id)sender
{
    //create a stringof URL
    NSString *urlToShorten = self.webView.request.URL.absoluteString;
    
    //constructs a string by appending the url and goDaddy accoutn for URL shortening.
    NSString *urlString = [NSString stringWithFormat:@"http://api.x.co/Squeeze.svc/text/%@?url=%@",kGoDaddyAccountKey,
                           [urlToShorten stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //sets the instance variable to new empty object
    shortURLData = [NSMutableData new];
    
    //turns the requested string into a URL object,, use it to ceate a request object and then start a
    //NSURL Connection using that request.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    shortenURLConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    self.shortenButton.enabled = NO;
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.shortLabel.title = @"failed";
    self.clipBoardButton.enabled = NO;
    self.shortenButton.enabled = YES;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [shortURLData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSURL *shortURLString = [[NSString alloc]initWithData:shortURLData encoding:NSUTF8StringEncoding];
    self.shortLabel.title = shortURLString;
    self.clipBoardButton.enabled = YES;
}

-(IBAction)clipBoardURL:(id)sender
{
    
    NSString *shortURLString = self.shortLabel.title;
    NSURL *shortURL = [NSURL URLWithString:shortURLString];
    //firstly it returns the system side pasteboard used for general data and you send the setURL message passing it the URL object.
    [[UIPasteboard generalPasteboard] setURL:shortURL];
    
}

@end
