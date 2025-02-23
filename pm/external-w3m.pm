package external;
sub ham_trustedQSL($) {
#     w3m -dump -T text http://www.arrl.org/tqsl-download >  tqsl-download.txt
#     egrep 'TQSL [0-9.]*' tqsl-download.txt
    my @myCANDIDATE;
    print STDERR __LINE__ . "\n";
    my $pid = open(W3M, "w3m -dump -T text https://www.arrl.org/tqsl-download |");
    while (<W3M>)  {
        if (/TQSL\s*([0-9.]+) / ) { print STDERR $_; my $string = $1; push(@myCANDIDATE, $string);}
    }
    close(W3M);
    print STDERR __LINE__ . ' ham/trustedQSL ' . join (' ', @myCANDIDATE). "\n";
    return ('trustedQSL', @myCANDIDATE);
}
sub cad_kicad($) {
    my @myCANDIDATE;
    print STDERR __LINE__ . "\n";
    my $pid = open(W3M, "w3m -dump -T text https://www.kicad.org/  |");
    while (<W3M>)  {
        if (/Version\s*([0-9.]+)\s*Released/i ) { print STDERR $_; my $string = $1; push(@myCANDIDATE, $string);}
    }
    close(W3M);
    print STDERR __LINE__ . ' cad/kicad ' . join (' ', @myCANDIDATE). "\n";
    return ('kicad', @myCANDIDATE);
}

1;
