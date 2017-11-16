# RRD-to-CSV

Simple quick and dirty scripts to convert RRD to CSV. Slightly improved version of [github.com/mscoutermarsh/RRD-to-CSV](https://github.com/mscoutermarsh/RRD-to-CSV).

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

# Troubleshooting

Before converting XMLs to CSVs, check out the number of datasource you're using:

```xml
$ grep -m 1 '<row>' test.xml
                        <!-- 2017-11-15 08:01:20 EST / 1510750880 --> <row><v>9.0000000000e-02</v></row>
```

If you have more than one `v` element you will need to change the last if statement in **convert.pl** script by capturing all those elements and printing them to the file. So if you have 2 `v` elements the if statement will look following way:

```perl
if ($line =~ m/<v>([\de\+\-\.]*)<\/v><v>([\de\+\-\.]*)<\/v>/) {
  print "$date,$1,$2\n";
}
```