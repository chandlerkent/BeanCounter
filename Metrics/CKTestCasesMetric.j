@import "CKMetric.j"

@implementation CKTestCasesMetric : CKMetric
{
    CPArray testCases;
}

- (id)initWithName:(CPString)aName
{
    if (self = [super initWithName:aName])
    {
        testCases = [CPArray array];
    }
    
    return self;
}

- (void)updateMetricForFile:(id)file line:(CPString)line
{
    var testCaseRegEx = new RegExp(".*Test.j", "i");
    
    if (testCaseRegEx.test(file))
    {
        if ([self addFileIfNew:file])
        {
            testCases.push(0);
        }
    }
    
    var index = files.length - 1;
    
    if (line.indexOf("-") === 0 || line.indexOf("+") === 0)
    {
        testCases[index]++;
    }
}

- (void)reportMetricForFile:(id)file
{
    var index = [files indexOfObject:file];

    if (index > -1)
    {
        print(file + " Test Cases: " + testCases[index]);
    }
}

- (void)reportMetricsForProject
{
    print("Test Cases:\t" + [self totalNumberOfTestCases]);
}

- (CPInteger)totalNumberOfTestCases
{
    var totalNumberOfTestCases = 0;
    
    for (var i = 0; i < testCases.length; i++)
    {
        totalNumberOfTestCases += testCases[i];
    }
    
    return totalNumberOfTestCases;
}

@end