@import "CKMetric.j"

@implementation CKClassesMetric : CKMetric
{
    CPNumber classes;
}

- (id)initWithName:(CPString)aName
{
    if (self = [super initWithName:aName])
    {
        classes = 0;
    }
    
    return self;
}

- (void)updateMetricForFile:(id)file line:(CPString)line
{
    if ([self isNewFile:file])
    {
        files.push(file);
    }
    
    // Must begin with @implementation and not be a category
    if (line.indexOf("@implementation") === 0 && line.indexOf(@"(") === -1)
    {
        classes++;
    }
}

- (void)reportMetricForFile:(id)file
{
    print(@"%s: %s", file, classes);
}

- (void)reportMetricsForProject
{
    print("Classes:\t" + classes);
}

@end