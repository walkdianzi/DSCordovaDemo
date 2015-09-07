//
//  ViewController1.m
//  WebDemo
//
//  Created by YMY on 15/8/15.
//  Copyright (c) 2015年 dasheng. All rights reserved.
//

#import "ViewController1.h"
#import "ZipArchive.h"

@implementation ViewController1

-(void)viewDidLoad{
  
    
    NSString *path = [[NSBundle mainBundle] resourcePath];

    //得到zip存储位置
    NSString *sandboxPath = NSHomeDirectory();
    NSString *path2 = [sandboxPath  stringByAppendingPathComponent:@"Library/Caches"];//将Documents
    NSString *zipPath = [path2 stringByAppendingPathComponent:@"www.zip"];
    
    ZipArchive* zip = [[ZipArchive alloc] init];
    if( [zip UnzipOpenFile:zipPath] )  //解压文件成功
    {
        //把解压的文件放入对应的路径中
        BOOL ret = [zip UnzipFileTo:path overWrite:YES];
        if( NO==ret )
        {
            NSLog(@"error");
        }
        [zip UnzipCloseFile];
    }
    
    self.wwwFolderName = @"www";
    self.startPage = @"index.html";

    [super viewDidLoad];
    
    [self DownloadTextFile:@"http://7u2fm4.com1.z0.glb.clouddn.com/c6fe7ea3-4fa5-4dd6-bb41-07513e84ae24.zip" fileName:@"www.zip"];
}

-(void)DownloadTextFile:(NSString*)fileUrl   fileName:(NSString*)_fileName
{
    
    dispatch_queue_t queue = dispatch_get_global_queue(
                                                       DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSURL *url = [NSURL URLWithString:fileUrl];
        NSError *error = nil;
        // 2
        NSData *data = [NSData dataWithContentsOfURL:url options:0 error:&error];
        
        if(!error)
        {
            
            /*得到要保存zip的路径*/
            NSString *sandboxPath = NSHomeDirectory();
            NSString *path = [sandboxPath  stringByAppendingPathComponent:@"Library/Caches"];//将Documents
            NSString *zipPath = [path stringByAppendingPathComponent:_fileName];
            
            
            /*把zip文件放入路径中*/
            [data writeToFile:zipPath options:0 error:&error];
            
            if(!error)
            {
                //解压zip文件
                ZipArchive* zip = [[ZipArchive alloc] init];
                if( [zip UnzipOpenFile:zipPath] )  //解压文件成功
                {
                    //把解压的文件放入对应的路径中
                    BOOL ret = [zip UnzipFileTo:path overWrite:YES];
                    if( NO==ret )
                    {
                        NSLog(@"error");
                    }
                    [zip UnzipCloseFile];
                }
            }
            else
            {
                NSLog(@"Error saving file %@",error);
            }
        }
        else
        {
            NSLog(@"Error downloading zip file: %@", error);
        }
    });
}

//-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    
//    return YES;
//}
@end
