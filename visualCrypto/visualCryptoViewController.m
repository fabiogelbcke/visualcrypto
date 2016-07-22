//
//  visualCryptoViewController.m
//  visualCrypto
//
//  Created by Fábio Gelbcke Work on 9/30/13.
//  Copyright (c) 2013 Fábio Gelbcke Work. All rights reserved.
//

#import "visualCryptoViewController.h"
#include <stdlib.h>

@interface visualCryptoViewController ()

@property (strong, nonatomic )UIImage *target;
@property (strong, nonatomic) IBOutlet UIImageView *imgView1;
@property (strong, nonatomic) IBOutlet UIImageView *imgView2;
@property (strong, nonatomic) IBOutlet UIImageView *imgView3;


@end

@implementation visualCryptoViewController


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


- (IBAction)selectImage {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:imagePicker animated:YES completion:nil];
}


- (IBAction)createImage {
    
    CGContextRef ctx;
    CGImageRef imageRef = [self.target CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = malloc(height * width * 4);
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    unsigned char *pixelMap1 = malloc(height * width * 4);
    unsigned char *pixelMap2 = malloc(height * width * 4);
    int byteIndex = 0;
    for (int ii = 0 ; ii <= width * height ; ++ii){
        int r = arc4random() % 1;
        
        if (r==1){
            pixelMap1[byteIndex+1] = (char)0;
            pixelMap1[byteIndex+1] = (char)0;
            pixelMap1[byteIndex+2] = (char)0;
            pixelMap1[byteIndex+3] = (char)1;
            
        }
        else{
            pixelMap1[byteIndex+1] = (char)1;
            pixelMap1[byteIndex+1] = (char)1;
            pixelMap1[byteIndex+2] = (char)1;
            pixelMap1[byteIndex+3] = (char)1;
            
        }
        
        
            }
    
    byteIndex = 0;
    for (int ii = 0 ; ii <= width * height ; ++ii)
    {
        int outputColor = (rawData[byteIndex] + rawData[byteIndex+1] +
                           rawData[byteIndex+2]) / 3;
        
        rawData[byteIndex] = (char) (outputColor);
        rawData[byteIndex+1] = (char) (outputColor);
        rawData[byteIndex+2] = (char) (outputColor);
        
        byteIndex += 4;
    }
}



@end
