#!/usr/bin/env perl

$dvi_mode = 0;
$pdf_mode = 1;
$postscript_mode = 0;

add_cus_dep( 'acn', 'acr', 0, 'run_makeglossaries' );
add_cus_dep( 'glo', 'gls', 0, 'run_makeglossaries' );
add_cus_dep( 'ntn', 'not', 0, 'run_makeglossaries' );
add_cus_dep('aux', 'glstex', 0, 'run_bib2gls');

push @generated_exts, 'glo', 'gls', 'glg';
push @generated_exts, 'acn', 'acr', 'alg';
push @generated_exts, 'ntn', 'not', 'nlg';

$clean_ext .= " acr acn alg glo gls glg ist not ntn glstex";

sub run_makeglossaries {
    my $dir = dirname($_[0]);
    my $base_name = basename($_[0]);

    my $return;
    if ( $silent ) {
        $return = system "makeglossaries", "-q", "-d", "$dir", "$base_name";
    }
    else {
        $return = system "makeglossaries", "-d", "$dir", "$base_name";
    };
    return $return;
}


sub run_bib2gls {
  if ( $silent ) {
    system "bib2gls --silent --group '$_[0]'";
  } else {
    system "bib2gls --group '$_[0]'";
  };
}
