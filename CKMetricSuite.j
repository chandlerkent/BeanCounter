@import "Metrics/CKLOCMetric.j"
@import "Metrics/CKClassesMetric.j"
@import "Metrics/CKFilesMetric.j"
@import "Metrics/CKMethodsMetric.j"

@import "CompositeMetrics/CKMethodsPerClassMetric.j"
@import "CompositeMetrics/CKLOCPerClassMetric.j"

var Readline = require("readline").readline;
var FileList = require("jake").FileList;
var File = require("file");
 
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