https://stackoverflow.com/questions/4203235/how-to-test-if-your-linux-support-sse2
mayastore requires sse4_2
cat /proc/cpuinfo | grep sse4_2 
each core will have a flags tag that will contain sse4_2 if it has it.