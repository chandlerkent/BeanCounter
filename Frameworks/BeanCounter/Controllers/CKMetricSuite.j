@import "../Models/CKLOCMetric.j"
@import "../Models/CKClassesMetric.j"
@import "../Models/CKFilesMetric.j"
@import "../Models/CKMethodsMetric.j"
@import "../Models/CKTestCasesMetric.j"

@import "../Models/CKCompositeMetric.j"

@import "../Views/CKCommandLineView.j"

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
        var methodsPerClassMetric = [[CKCompositeMetric alloc] initWithName:@"Methods/Class" metrics:[methodsMetric, classesMetric]];
        metrics.push(methodsPerClassMetric);
        
        var locPerClassMetric = [[CKCompositeMetric alloc] initWithName:@"LOC/Class" metrics:[locMetric, classesMetric]];
        metrics.push(locPerClassMetric);
        
        var testCasesPerMethodMetric = [[CKCompositeMetric alloc] initWithName:@"Tests/Method" metrics:[testCasesMetric, methodsMetric]];
        metrics.push(testCasesPerMethodMetric);
        
        var locPerMethodMetric = [[CKCompositeMetric alloc] initWithName:@"LOC/Method" metrics:[locMetric, methodsMetric]];
        metrics.push(locPerMethodMetric);
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

    var commandLineView = [[CKCommandLineView alloc] initWithMetrics:metrics];
    [commandLineView reportMetrics];
}
 
@end