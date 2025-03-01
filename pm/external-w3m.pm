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
sub ham_fldigi($) {
    my @myCANDIDATE;
    print STDERR __LINE__ . "\n";
    my $pid = open(W3M, "w3m -dump -T text https://www.w1hkj.org/files/fldigi/ |");
    while (<W3M>)  {
        if (/fldigi-([0-9.]*).tar.gz/){ print STDERR $_; my $string = $1; push(@myCANDIDATE, $string);}
    }
    close(W3M);
    print STDERR __LINE__ . ' ham/fldigi ' . join (' ', @myCANDIDATE). "\n";
    return ('fldigi', @myCANDIDATE);
}
sub ham_cwtext($) {
    my @myCANDIDATE;
    print STDERR __LINE__ . "\n";
    my $pid = open(W3M, "w3m -dump -T text https://sourceforge.net/projects/cwtext/files/cwtext/|");
    while (<W3M>)  {
        if (/cwtext\s*([0-9.]*)\s*/){ print STDERR $_; my $string = $1; push(@myCANDIDATE, $string);}
    }
    close(W3M);
    print STDERR __LINE__ . ' ham/cwtext' . join (' ', @myCANDIDATE). "\n";
    return ('cwtext', @myCANDIDATE);
}
sub ham_chirp($) {
    my @myCANDIDATE;
#    print STDERR __LINE__ . "\n";
    my $pid = open(W3M, "w3m -dump -T text https://archive.chirpmyradio.com/chirp_next/|");
    while (<W3M>)  {
        if (m,next-*([0-9.]*)/,){ 		   my $string = $1; push(@myCANDIDATE, $string);}
    }
    close(W3M);
#    print STDERR __LINE__ . ' ham/chirp' . join (' ', @myCANDIDATE). "\n";
    return ('chirp', @myCANDIDATE);
}

sub cad_cascade($) {
    my @myCANDIDATE;
    print STDERR __LINE__ . "\n";
    my $pid = open(W3M, "w3m -dump -T text https://sourceforge.net/projects/rfcascade/files/cascade/ |");
    while (<W3M>)  {
        if (/cascade-([0-9.]+)\s+[0-9\-]+\s/){ print STDERR $_; my $string = $1; push(@myCANDIDATE, $string);}
    }
    close(W3M);
    print STDERR __LINE__ . ' cad/cascade ' . join (' ', @myCANDIDATE). "\n";
    return ('cascade', @myCANDIDATE);
}    
sub cad_iverilog($) {
    my @myCANDIDATE;
    print STDERR __LINE__ . "\n";
    my $pid = open(W3M, "w3m -dump -T text https://github.com/steveicarus/iverilog -o accept_encoding='identity;q=0' |");
    # gunzip: unknown compression format
    while (<W3M>)  {
        if (/Stable version ([0-9.]+)\S/i){ print STDERR $_; my $string = $1; push(@myCANDIDATE, $string);}
    }
    close(W3M);
    print STDERR __LINE__ . ' cad/iverilog ' . join (' ', @myCANDIDATE). "\n";
    return ('iverilog', @myCANDIDATE);
}
sub cad_covered($) {
#    print STDERR __LINE__ . "\n";
    my @myCANDIDATE;
    my $pid = open(W3M, "w3m -dump -T text https://sourceforge.net/projects/covered/files/covered-stable/|");
    while (<W3M>)  {
        if (/covered-([0-9.]+)\S/i){ 		      my $string = $1; push(@myCANDIDATE, $string);}
    }
    close(W3M);
    print STDERR __LINE__ . ' cad/covered ' . join (' ', @myCANDIDATE). "\n";
    return ('covered', @myCANDIDATE);
}
sub cad_atlc($) {
    my @myCANDIDATE;
    my $pid = open(W3M, "w3m -dump -T text https://sourceforge.net/projects/atlc/files/atlc/|");
    while (<W3M>)  {
        if (/atlc-([0-9.]+)\S/i){ 		   my $string = $1; push(@myCANDIDATE, $string);}
    }
    close(W3M);
#   print STDERR __LINE__ . ' cad/atlc ' . join (' ', @myCANDIDATE). "\n";
    return ('atlc', @myCANDIDATE);
}
sub cad_adms($) {
    my @myCANDIDATE;
    my $pid = open(W3M, "w3m -dump -T text https://sourceforge.net/projects/mot-adms/files/adms-source/2.3/|");
    while (<W3M>)  {
        if (/adms-([0-9.]+)\S/i){ 		   my $string = $1; push(@myCANDIDATE, $string);}
    }
    close(W3M);
#    print STDERR __LINE__ . ' cad/adms ' . join (' ', @myCANDIDATE). "\n";
    return ('adms', @myCANDIDATE);
}
sub cad_dinotrace($) {
    my @myCANDIDATE;
    my $pid = open(W3M, "w3m -dump -T text https://github.com/veripool/dinotrace/tags/ -o accept_encoding='identity;q=0'|");
    while (<W3M>)  {
        if (/v([0-9.]+[a-z])/i){ print STDERR $_; my $string = $1; push(@myCANDIDATE, $string);}
    }
    close(W3M);
#    print STDERR __LINE__ . ' cad/adms ' . join (' ', @myCANDIDATE). "\n";
    return ('dinotrace', @myCANDIDATE);
}
sub cad_gtk1_wcalc($) {
    my @myCANDIDATE;
    my $pid = open(W3M, "w3m -dump -T text https://wcalc.sourceforge.net/|");
    while (<W3M>)  {
        if (/wcalc-([0-9.]*) Released/){ print STDERR $_; my $string = $1; push(@myCANDIDATE, $string);}
    }
    close(W3M);
#    print STDERR __LINE__ . ' cad/adms ' . join (' ', @myCANDIDATE). "\n";
    return ('wcalc', @myCANDIDATE);
}
sub cad_ng_spice($) {
    my @myCANDIDATE;
    my $pid = open(W3M, "w3m -dump -T text https://sourceforge.net/projects/ngspice/files/ng-spice-rework/|");
    while (<W3M>)  {
        if (/([0-9.]*)\s*[\d]{4}-[\d]{2}-[\d]{2}\s*\d/){ print STDERR $_; my $string = $1; push(@myCANDIDATE, $string);}
    }
    close(W3M);
#    print STDERR __LINE__ . ' cad-ng-spice ' . join (' ', @myCANDIDATE). "\n";
    return ('ng-spice', @myCANDIDATE);
}
sub cad_verilator($) {
    my @myCANDIDATE;
    my $pid = open(W3M, "w3m -dump -T text https://verilator.org/guide/latest/install.html -o accept_encoding='identity;q=0'|");
    while (<W3M>)  {
        if (/Devel ([0-9.]+)/){ print STDERR $_; my $string = $1; push(@myCANDIDATE, $string);}
    }
    close(W3M);
#    print STDERR __LINE__ . ' cad-verilator ' . join (' ', @myCANDIDATE). "\n";
    return ('verilator', @myCANDIDATE);
}
sub cad_gerbv($) {
    my @myCANDIDATE;
    my $pid = open(W3M, "w3m -dump -T text https://sourceforge.net/projects/gerbv/files/gerbv/|");
    while (<W3M>)  {
#	print STDERR __LINE__ . $_;
        if (/gerbv-([0-9.]+)/){ print STDERR $_; my $string = $1; push(@myCANDIDATE, $string);}
#gerbv-2.7.0 	2019-01-28
    }
    close(W3M);
#    print STDERR __LINE__ . ' cad-verilator ' . join (' ', @myCANDIDATE). "\n";
    return ('gerbv', @myCANDIDATE);
}
sub math_cgal($) {
    my @myCANDIDATE;
    my $pid = open(W3M, "w3m -dump -T text https://github.com/CGAL/cgal/releases -o accept_encoding='identity;q=0'|");
    #gunzip: unknown compression format
#   print STDERR __LINE__ . $_;
    while (<W3M>)  {
        if (/CGAL-([0-9.]+).*release/i ){ print STDERR $_; my $string = $1; push(@myCANDIDATE, $string);}
    }
    close(W3M);
    return ('cgal', @myCANDIDATE);
}
sub cad_gnucap($) {
    my @myCANDIDATE;
    my $pid = open(W3M, "w3m -dump -T text http://git.savannah.gnu.org/cgit/gnucap.git |");
    #gunzip: unknown compression format
#   print STDERR __LINE__ . $_;
    while (<W3M>)  {
        if (/gnucap-([0-9.]+)\.tar\.gz/ ){ print STDERR $_; my $string = $1; push(@myCANDIDATE, $string);}
    }
    close(W3M);
    return ('gnucap', @myCANDIDATE);
}
sub cad_mcalc($) {
    my @myCANDIDATE;
    my $pid = open(W3M, "w3m -dump -T text https://sourceforge.net/projects/mcalc/files/mcalc/|");
    #gunzip: unknown compression format
#   print STDERR __LINE__ . $_;
    while (<W3M>)  {
        if (/mcalc-([0-9.]+)/ ){ print STDERR $_; my $string = $1; push(@myCANDIDATE, $string);}
    }
    close(W3M);
    return ('mcalc', @myCANDIDATE);
}




1;
