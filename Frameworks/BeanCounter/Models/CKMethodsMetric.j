@import "CKMetric.j"

@implementation CKMethodsMetric : CKMetric
{
}

// Must begin with -, +, or function
- (BOOL)isLineAMethod:(CPString)line
{
    var methodRegEx = new RegExp("(-|[+]|function).*", "i");
    
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
    [super updateMetricForFile:file line:line];
    
    if ([self shouldUpdateMetricForFile:file line:line])
    {
        var index = [metric count] - 1;
        metric[index]++;
    }
}

- (BOOL)shouldUpdateMetricForFile:(id)file line:(CPString)line
{
    if (![self isFileATestFile:file])
    {
        if ([self isLineAMethod:line] && ![self isMethodATestCase:line])
        {
            return YES;
        }
    }
    
    return NO;
}

@end