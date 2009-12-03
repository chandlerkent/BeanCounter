BeanCounter is a metrics suite for Cappuccino projects. Currently, BeanCounter has support for calculating the following metrics:

* Lines of Code
* Number of Classes
* Number of Files
* Number of Methods
* Number of Test Cases
* Lines of Code per Class
* Methods per Class
* Test Cases per Method

Contributing
============
It is very easy to add a new type of metric to BeanCounter (it will be much easier in the future, possibly using a plug-in architecture). If you wish to create a base metric (a metric that does not depend on any other metric), subclass CKMetric and override:
    - (void)updateMetricForFile:(id)file line:(CPString)line
You can also override some other default behavior for more fine grained control, like:
    - (id)defaultFileMetric
    - (id)defaultProjectMetric
    - (id)calculateTotalMetricWithStartingMetric:(id)startingMetric andNewMetric:(id)newMetric
    - (id)metricForFile:(id)file
    - (id)metricForProject
See the comments on these methods for descriptions on what they should do. See some of the current metrics in Frameworks/BeanCounter/ for an example.

If you wish to create a composite metric (a metric which depends on one or more metric), subclass CKCompositeMetric and implement:
    - (id)metricForFile:(id)file
    - (id)metricForProject
In many cases, the default behavior (just dividing two metrics) for a composite metric is good enough. In that case, no subclassing is necessary.

To have your new metric be run with the rest of the metrics, add an @import statement to CKMetricSuite.j and add your new metric to the metrics array in that class. See all the examples. (Again, this is an area that is still very experimental. I want this to be much easier so you won't have to do this in the future. But for now, this is how it needs to be done.)

Installation Instructions
=========================
BeanCounter is a [Narwhal](http://github.com/tlrobinson/narwhal) package and will soon be added to the tusk package manager. When that happens, you can simply run:
    tusk update
    sudo tusk install beancounter
Thanks to @hammerdr for helping me set this up.

Usage Instructions
==================
From the top-level directory of your Cappuccino project, run:
    env NARWHAL_ENGINE=jsc beancounter

Dependencies
============
Currently, BeanCounter depends on [Narwhal](http://github.com/tlrobinson/narwhal) and [Cappuccino](http://github.com/280north/cappucino).

Todo
====
There is a lot left to do before BeanCounter is ready for primetime. Here is what is on the list right now:

* "Smarter" code parsing (currently it is line-by-line and naive of where it is in the file/class).
* Tests to "prove" correctness of metrics.
* A plug-in type architecture for easier integration of 3rd-party metrics.
* More metrics (suggestions?).