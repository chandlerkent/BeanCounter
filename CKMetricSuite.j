#!/usr/bin/env objj
 
@import <Foundation/Foundation.j>

@import "CKLOCMetric.j"
@import "CKClassesMetric.j"
@import "CKFilesMetric.j"
@import "CKMethodsMetric.j"

@import "CKMethodsPerClassMetric.j"
@import "CKLOCPerClassMetric.j"
 
CPLogRegister(CPLogPrint);
 
@implementation CKMetricSuite : CPObject
{
    CPArray metrics;
}
 
- (id)init
{
    if (self = [super init])
    {
        metrics = [];
        
        var locMetric = [[CKLOCMetric alloc] initWithName:@"Lines of Code"];
        metrics.push(locMetric);
        
        var classesMetric = [[CKClassesMetric alloc] initWithName:@"Number of Classes in Project"];
        metrics.push(classesMetric);
        
        metrics.push([[CKFilesMetric alloc] initWithName:@"Number of Files in Project"]);
        
        var methodsMetric = [[CKMethodsMetric alloc] initWithName:@"Number of Methods in Project"];
        metrics.push(methodsMetric);
        
        var methodsPerClassMetric = [[CKMethodsPerClassMetric alloc] initWithMetrics:[classesMetric, methodsMetric]];
        metrics.push(methodsPerClassMetric);
        
        var locPerClassMetric = [[CKLOCPerClassMetric alloc] initWithMetrics:[classesMetric, locMetric]];
        metrics.push(locPerClassMetric);
    }
    
    return self;
}
 
- (void)startWithArguments:(CPArray)args
{
    print("Ignoring arguments...\n");
    
    var files = new FileList("**/*.j").items();
    
    for (var i = 0; i < files.length; i++)
    {
        var file = files[i];
        if (file.indexOf("Frameworks") == -1 && file.indexOf("Build") == -1 && file.indexOf("Resources") == -1)
        {
            print("\n" + file);
            var lines = File.read(file).split("\n");
            for (var j = 0; j < lines.length; j++)
            {
                var line = lines[j];
                for (var k = 0; k < metrics.length; k++)
                {
                    var metric = metrics[k];
                    if ([metric isKindOfClass:[CKMetric class]])
                    {
                        [metric updateMetricForFile:file line:line];
                    }
                }
            }
            for (var k = 0; k < metrics.length; k++)
            {
                var metric = metrics[k];
                if ([metric isKindOfClass:[CKMetric class]])
                {
                    [metric reportMetricForFile:file];
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

var metricSuite = [[CKMetricSuite alloc] init];
[metricSuite startWithArguments:args];