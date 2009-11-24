@import "Metrics/CKLOCMetric.j"
@import "Metrics/CKClassesMetric.j"
@import "Metrics/CKFilesMetric.j"
@import "Metrics/CKMethodsMetric.j"
@import "Metrics/CKTestCasesMetric.j"

@import "CompositeMetrics/CKMethodsPerClassMetric.j"
@import "CompositeMetrics/CKLOCPerClassMetric.j"
@import "CompositeMetrics/CKTestCasesPerMethodMetric.j"

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
        
        var classesMetric = [[CKClassesMetric alloc] initWithName:@"Classes"];
        metrics.push(classesMetric);
        
        metrics.push([[CKFilesMetric alloc] initWithName:@"Files"]);
        
        var methodsMetric = [[CKMethodsMetric alloc] initWithName:@"Methods"];
        metrics.push(methodsMetric);
        
        var testCasesMetric = [[CKTestCasesMetric alloc] initWithName:@"Test Cases"];
        metrics.push(testCasesMetric);
        
        /* Composite Metrics */
        var methodsPerClassMetric = [[CKMethodsPerClassMetric alloc] initWithMetrics:[classesMetric, methodsMetric]];
        metrics.push(methodsPerClassMetric);
        
        var locPerClassMetric = [[CKLOCPerClassMetric alloc] initWithMetrics:[classesMetric, locMetric]];
        metrics.push(locPerClassMetric);
        
        var testCasesPerMethodMetric = [[CKTestCasesPerMethodMetric alloc] initWithMetrics:[testCasesMetric, methodsMetric]];
        metrics.push(testCasesPerMethodMetric);
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