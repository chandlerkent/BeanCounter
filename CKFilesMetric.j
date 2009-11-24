@import "CKMetric.j"

@implementation CKFilesMetric : CKMetric
{
}

- (void)updateMetricForFile:(id)file line:(CPString)line
{
    if ([self isNewFile:file])
    {
        files.push(file);
    }
    
    return;
}

- (void)reportMetricForFile:(id)file
{
    return;
}

- (void)reportMetricsForProject
{    
    print("Files:\t\t" + files.length);
}

@end