Project satellite is a fetcher client based on phantomjs, which visits
the target web site just like real human being.


The project works together with an enhanced nutch version:
https://github.com/galaxyeye/qiwur-nutch


To run the project, 

1. make sure you have a Nutch Server running in Crowdsourcing

2. enter project home directory

3. edit conf/config.json, modify fetchController.nutchServer to your running 
nutch server, in crowdsouring mode

4. windows : start-satellite.bat

   linux : ./bin/satellite start

