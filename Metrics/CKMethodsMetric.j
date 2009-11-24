@import "CKMetric.j"

@implementation CKMethodsMetric : CKMetric
{
    CPArray methods;
}

- (id)initWithName:(CPString)aName
{
    if (self = [super initWithName:aName])
    {
        methods = [CPArray array];
    }
    
    return self;
}

// Must begin with - or +
- (BOOL)isLineAMethod:(CPString)line
{
    var methodRegEx = new RegExp("(-|[+]).*", "i");
    
    return methodRegEx.test(line);
}

- (BOOL)isMethodATestCase:(CPString)method
{
    var testCaseRegEx = new RegExp("^.*test.*$", "i");
    
    return testCaseRegEx.test(method);
}

- (BOOL)isFileATestFile:(CPString)file
{
    var testFileRegEx = new RegExp(".*test.j", "i");
    
    return testFileRegEx.test(file);
}

- (void)updateMetricForFile:(id)file line:(CPString)line
{
    if (![self isFileATestFile:file])
    {
        if ([self addFileIfNew:file])
        {
            methods.push(0);
        }
        
        var index = methods.length - 1;

        if ([self isLineAMethod:line] && ![self isMethodATestCase:line])
        {
            methods[index]++;
        }
    }
}

- (void)reportMetricForFile:(id)file
{
    var index = [files indexOfObject:file];
    
    if (index > -1)
    {
        print(file + " " + [self name].toLowerCase() + ": " + methods[index]);
    }
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
    print([self name] + ":\t" + [self totalNumberOfMethods]);
}

@end