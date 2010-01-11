@import "CKMetric.j"

@implementation CKClassesMetric : CKMetric
{
}

- (void)updateMetricForFile:(id)file line:(CPString)line
{
    [super updateMetricForFile:file line:line];
    
    var index = [metric count] - 1;
    
    // Must begin with @implementation and not be a category
    if (line.indexOf("@implementation") === 0 && line.indexOf(@"(") === -1)
    {
        metric[index]++;
    }
}

@end