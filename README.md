# RRD-to-CSV

Simple quick and dirty scripts to convert RRD to CSV. Slightly improved version of [github.com/mscoutermarsh/RRD-to-CSV](https://github.com/mscoutermarsh/RRD-to-CSV).

Example of the CSV file:

```csv
timestamp,value1
1339261200,3.4020448525e+07
1339261500,1.8406509015e+07
1339261800,1.3551101702e+07
1339262100,1.0942669565e+07
1339262400,8.9584420948e+06
1339262700,1.0100165465e+07
...
```
Features:

 - Automatically detects number of datasources;

## Usage

The conversion is done in two steps:

### .rrd -> .xml

First you need to convert .rrd files to .xml. You can either convert one file by rrdtool directly:

```bash
$ rrdtool dump cpu-user.rrd cpu-user.xml
```

or use **rrdToXml.pl** script which converts **all** .rrd files in current directory:

```bash
$ ls -1
rrdToXml.pl
test1.rrd
test2.rrd
$ perl rrdToXml.pl
$ ls -1
rrdToXml.pl
test1.rrd
test1.xml
test2.rrd
test2.xml
```

### .xml -> .csv

To convert 1 file use **convert.pl**:

```bash
$ perl convert.pl cpu-user.xml > test.csv
```

To convert all files in current directory:

```bash
$ perl xml-to-csv.pl
```
