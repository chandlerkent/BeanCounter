@import "CKMetric.j"

@implementation CKLOCMetric : CKMetric
{
    CPArray linesOfCode;
}

- (id)initWithName:(CPString)aName
{
    if (self = [super initWithName:aName])
    {
        linesOfCode = [];
    }
    
    return self;
}

- (void)updateMetricForFile:(id)file line:(CPString)line
{
    if ([self isNewFile:file])
    {
        files.push(file);
        linesOfCode.push(0);
    }
    
    var index = files.length - 1;
    
    if (line !== nil && line !== "" && line[0] !== "/")
    {
        linesOfCode[index]++;
    }
}

- (void)reportMetricForFile:(id)file
{
    var index = [files indexOfObject:file];

    print(@"%s: %s", file, linesOfCode[index]);
}

- (void)reportMetricsForProject
{    
    var totalLOC = 0;
    for (var i = 0; i < files.length; i++)
    {
        totalLOC += linesOfCode[i];
    }
    
    print("Lines of Code:\t" + totalLOC);
}

@end