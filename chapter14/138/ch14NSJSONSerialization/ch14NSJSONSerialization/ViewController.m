//
//  ViewController.m
//  ch14NSJSONSerialization
//
//  Created by HU QIAO on 2013/12/11.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

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

- (IBAction)jsonParse:(id)sender {
    
    // 送信するリクエストを生成する。
    NSString* path  = @"http://maps.googleapis.com/maps/api/geocode/json?address=tokyo&sensor=false";
    NSURL* url = [NSURL URLWithString:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];

    //WebApiからNSData形式でJSONデータを取得
    NSData* jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

    // Google Geocoding API
    // https://developers.google.com/maps/documentation/geocoding/?hl=ja#JSON
    
    // ジオコーディング レスポンス（JSONデータ）：
    //    {
    //        "results" : [
    //                     {
    //                         "address_components" : [
    //                                                 {
    //                                                     "long_name" : "東京都",
    //                                                     "short_name" : "東京都",
    //                                                     "types" : [ "administrative_area_level_1", "political" ]
    //                                                 },
    //                                                 {
    //                                                     "long_name" : "日本",
    //                                                     "short_name" : "JP",
    //                                                     "types" : [ "country", "political" ]
    //                                                 }
    //                                                 ],
    //                         "formatted_address" : "日本, 東京都",
    //                         "geometry" : {
    //                             "bounds" : {
    //                                 "northeast" : {
    //                                     "lat" : 35.8986441,
    //                                     "lng" : 153.9875216
    //                                 },
    //                                 "southwest" : {
    //                                     "lat" : 24.2242343,
    //                                     "lng" : 138.9427579
    //                                 }
    //                             },
    //                             "location" : {
    //                                 "lat" : 35.6894875,
    //                                 "lng" : 139.6917064
    //                             },
    //                             "location_type" : "APPROXIMATE",
    //                             "viewport" : {
    //                                 "northeast" : {
    //                                     "lat" : 35.817813,
    //                                     "lng" : 139.910202
    //                                 },
    //                                 "southwest" : {
    //                                     "lat" : 35.528873,
    //                                     "lng" : 139.510574
    //                                 }
    //                             }
    //                         },
    //                         "types" : [ "administrative_area_level_1", "political" ]
    //                     }
    //                     ],
    //        "status" : "OK"
    //    }

    
    

    if (jsonData) {
        
        NSError* jsonParsingError = nil;
        //JSONからNSDictionaryまたはNSArrayに変換
        //JSONによって、配列ならばNSArrayになり、そうでなければNSDictionaryとなります。
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingAllowFragments
                                                              error:&jsonParsingError];
        
        //NSDictionaryを利用して、必要なデータを取得します。
        NSString* status = [dic objectForKey:@"status"];
        NSLog(@"status: %@",status);
        
        NSArray* arrayResult =[dic objectForKey:@"results"];
        NSDictionary* resultDic = [arrayResult objectAtIndex:0];
        NSDictionary* geometryDic = [resultDic objectForKey:@"geometry"];
        NSLog(@"geometryDic: %@",geometryDic);
        
        NSDictionary* locationDic = [geometryDic objectForKey:@"location"];
        NSNumber* lat = [locationDic objectForKey:@"lat"];
        NSNumber* lng = [locationDic objectForKey:@"lng"];
        NSLog(@"location lat = %@, lng = %@",lat,lng);
        
    } else {
        
        NSLog(@"the connection could not be created or if the download fails.");

    }
    
}
@end
