# USAGE: perl rrd-to-xml.pl
# Running rrdtool dump for all .rrd files in directory

my @files = <*>;
foreach my $file (@files) {
    if ($file =~ m/\.rrd/) {
        my @filename = split('\.', $file);
        my $name = $filename[0];
        print "dumping $file...\n";
        `rrdtool dump $file > $name.xml`;
    }
}
print "done :)";
