CVE-2014-0094 / CVE -2014-0114 Struts Tester
============================================

This PoC gives a list of payloads that can be used to modify data in the context of a Struts web application that is vulnerable to CVE-2014-0094 or CVE-2014-0114. The results depend on the container that executes the application. Is a customized version for the PoC posted by "neobyte" at http://sec.baidu.com/index.php?research/detail/id/18

This version contains some modifications that have been util for me during the vulnerability analysis. For example:
+ Prints the FQDN of the classes that can be modified according to the results
+ Prints the methods of an Object that can be reached by getters navigation

Additional materials
--------------------

Two vulnerable applications containing the Struts Tester: 
+ A Struts 2 sample application adapted from [apache examples] (CVE-2014-0094)
+ A Struts 1 sample application adapted from [dzone example] (CVE-2014-0114). In this case there's a second version with the [pwntester] / [rgielen] filter applied (more info about the filter at https://github.com/rgielen/struts1filter) 

[apache examples]: https://github.com/apache/struts-examples.git
[dzone example]: http://www.dzone.com/tutorials/java/struts/struts-example/struts-login-page-example-1.html
[pwntester]: https://github.com/pwntester
[rgielen]: https://github.com/rgielen

And the execution results for the below containers:
+ Tomcat 6 / 7 / 8
+ Glassfish 4.1
+ JBOSS 7.1 / 7.4
+ WAS 8.5.5 (developer version)
+ Weblogic 10.3 / 12.1

