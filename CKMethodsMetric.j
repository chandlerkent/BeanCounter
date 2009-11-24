@import "CKMetric.j"

@implementation CKMethodsMetric : CKMetric
{
    CPArray methods;
}

- (id)initWithName:(CPString)aName
{
    if (self = [super initWithName:aName])
    {
        methods = [];
    }
    
    return self;
}

- (void)updateMetricForFile:(id)file line:(CPString)line
{
    if ([self addFileIfNew:file])
    {
        methods.push(0);
    }
    
    var index = files.length - 1;
    
    // Must begin with - or +
    if (line.indexOf("-") === 0 || line.indexOf(@"+") === 0)
    {
        methods[index]++;
    }
}

- (void)reportMetricForFile:(id)file
{
    var index = [files indexOfObject:file];
    
    print(file + " methods: " + methods[index]);
}

- (CPInteger)totalNumberOfMethods
{
    var totalMethods = 0;
    
    for (var i = 0; i < methods.length; i++)
    {
        totalMethods += methods[i];
    }
    
    return totalMethods;
}

- (void)reportMetricsForProject
{

    
    print("Methods:\t" + [self totalNumberOfMethods]);
}

@end