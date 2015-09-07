//
//  ViewController.m
//  WebDemo
//
//  Created by YMY on 15/8/15.
//  Copyright (c) 2015年 dasheng. All rights reserved.
//

#import "ViewController.h"
#import "ZipArchive.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CDVViewController *cdvViewController = [CDVViewController new];
    cdvViewController.wwwFolderName = @"www";
    cdvViewController.startPage = @"index.html";
    //cdvViewController.useSplashScreen = YES;
    //cdvViewController.view.frame = self.view.frame;
    [self.view addSubview:cdvViewController.view];
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSString*)DownloadTextFile:(NSString*)fileUrl   fileName:(NSString*)_fileName
{
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask,YES);//使用C函数NSSearchPathForDirectoriesInDomains来获得沙盒中目录的全路径。
    NSString *ourDocumentPath =[documentPaths objectAtIndex:0];
    
    NSString *sandboxPath = NSHomeDirectory();
    NSString *documentPath = [sandboxPath  stringByAppendingPathComponent:@"WebDemo.app"];//将Documents添加到sandbox路径上//TestDownImgZip.app
    NSString *FileName=[documentPath stringByAppendingPathComponent:_fileName];//fileName就是保存文件的文件名
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // Copy the database sql file from the resourcepath to the documentpath
    if ([fileManager fileExistsAtPath:FileName])
    {
        return FileName;
    }else
    {
        NSURL *url = [NSURL URLWithString:fileUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        [data writeToFile:FileName atomically:YES];//将NSData类型对象data写入文件，文件名为FileName
    }
    return FileName;
}

- (void)OpenZip:(NSString*)zipPath  unzipto:(NSString*)_unzipto
{
    ZipArchive* zip = [[ZipArchive alloc] init];
    if( [zip UnzipOpenFile:zipPath] )
    {
        BOOL ret = [zip UnzipFileTo:_unzipto overWrite:YES];
        if( NO==ret )
        {
            NSLog(@"error");
        }
        [zip UnzipCloseFile];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
