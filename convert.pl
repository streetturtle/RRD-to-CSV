# USAGE: perl convert.pl testinput.xml > output.csv
# Grabs all data in the XML file, converts it to CSV.

my $inputFile = "<" . $ARGV[0];

print "timestamp,value\n";

my $inAverage = 0;

# open xml file... read Line by Line
open(MYINPUTFILE, $inputFile);

while (<MYINPUTFILE>) {
    my ($line) = $_;
    chomp($line);

    if ($line =~ m/AVERAGE/) {
        $inAverage = 1;
    }
    elsif ($line =~ m/MAX/) {
        $inAverage = 0;
    }

    if ($inAverage) {
        if ($line =~ m/\s[A-Z]{3}\s\/\s(\d{10})\s/) {
            my $date = $1;
            # if you have more than one datasource, capture them here
            if ($line =~ m/<v>([\de\+\-\.]*)<\/v>/) {
                print "$date,$1\n";
            }
        }
    }
}
