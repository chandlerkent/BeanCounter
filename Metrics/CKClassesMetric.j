@import "CKMetric.j"

@implementation CKClassesMetric : CKMetric
{
    CPArray classes;
}

- (id)initWithName:(CPString)aName
{
    if (self = [super initWithName:aName])
    {
        classes = [];
    }
    
    return self;
}

- (void)updateMetricForFile:(id)file line:(CPString)line
{
    if ([self addFileIfNew:file])
    {
        classes.push(0)
    }
    
    var index = classes.length - 1;
    
    // Must begin with @implementation and not be a category
    if (line.indexOf("@implementation") === 0 && line.indexOf(@"(") === -1)
    {
        classes[index]++;
    }
}

- (void)reportMetricForFile:(id)file
{
    var index = [files indexOfObject:file];
    print(file + " classes: " + classes[index]);
}

- (CPInteger)totalNumberOfClasses
{
    var totalClasses = 0;
    
    for (var i = 0; i < classes.length; i++)
    {
        totalClasses += classes[i];
    }
    
    return totalClasses;
}

- (void)reportMetricsForProject
{
    print("Classes:\t" + [self totalNumberOfClasses]);
}

@end