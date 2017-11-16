# USAGE: perl xml-to-csv.pl
# Uses convert.pl to convert each XML file in the current directory to .csv

my @files = <*>;
foreach my $file (@files) {
    if ($file =~ m/\.xml/) {
        my @filename = split('\.', $file);
        my $name = $filename[0];
        print "Converting $file...\n";
        `perl convert.pl $file > $name.csv`;
    }
}
print "\nDone!";
