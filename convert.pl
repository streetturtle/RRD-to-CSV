# USAGE: perl convert.pl testinput.xml > output.csv
# Grabs all data in the XML file, converts it to CSV.

my $inputFile = "<" . $ARGV[0];

my $inAverage = 0;

my $isFirstLine = 1;

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
            # add header with column names
            if ($isFirstLine) {
                print 'timestamp';
                my @numOfDs = $line =~ m/<v>/g;
                for (my $i=0; $i < @numOfDs; $i++) {
                    print ",value", $i+1;
                }
                print "\n";
                $isFirstLine = 0;
            }

            my $timestamp = $1;
            if ($line =~ m/<row>(.*)<\/row>/) {
                print $timestamp;
                my @values = split /(?<=>)(?=<)/, $1;
                foreach my $val (@values) {
                    my @m = $val =~ m/<v>([\de\+\-\.]*)<\/v>/;
                    print ",@m";
                }
                print "\n";
            }
        }
    }
}
