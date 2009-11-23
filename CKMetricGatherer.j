#!/usr/bin/env objj
 
@import <Foundation/Foundation.j>

@import "CKLOCMetric.j"
@import "CKClassesMetric.j"
@import "CKFilesMetric.j"
 
CPLogRegister(CPLogPrint);
 
@implementation CKMetricGatherer : CPObject
{
    CPArray metrics;
}
 
- (id)init
{
    if (self = [super init])
    {
        metrics = [];
        metrics.push([[CKLOCMetric alloc] initWithName:@"Lines of Code"]);
        metrics.push([[CKClassesMetric alloc] initWithName:@"Number of Classes In Project"]);
        metrics.push([[CKFilesMetric alloc] initWithName:@"Number of Files In Project"]);
    }
    
    return self;
}
 
- (void)startWithArguments:(CPArray)args
{
    var files = new FileList("**/*.j").items();
    
    for (var i = 0; i < files.length; i++)
    {
        var file = files[i];
        if (file.indexOf("Frameworks") == -1 && file.indexOf("Build") == -1 && file.indexOf("Resources") == -1)
        {
            print(file);
            var lines = File.read(file).split("\n");
            for (var j = 0; j < lines.length; j++)
            {
                var line = lines[j];
                for (var k = 0; k < metrics.length; k++)
                {
                    var metric = metrics[k];
                    [metric updateMetricForFile:file line:line];
                }
            }
        }   
    }
    
    print("\n\n");
    for (var k = 0; k < metrics.length; k++)
    {
        var metric = metrics[k];
        [metric reportMetricsForProject];
    }
    print("\n");
}
 
@end
 
var Readline = require("readline").readline;
var FileList = require("jake").FileList;
var File = require("file");

gatherer = [[CKMetricGatherer alloc] init];
[gatherer startWithArguments:args];