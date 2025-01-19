package external;
sub ham_trustedQSL($) {
#     w3m -dump -T text http://www.arrl.org/tqsl-download >  tqsl-download.txt
#     egrep 'TQSL [0-9.]*' tqsl-download.txt

    my $pid = open(W3M, "w3m -dump -T text http://www.arrl.org/tqsl-download |");
    while (<W3M>)  {
        if (/TQSL ([0-9.]*)/ ) { my $string = $1; push(@CANDIDATE, $string);}
    }
    close(W3M);
    return @CANDIDATE;
}
1;
