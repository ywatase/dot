#!/usr/bin/env perl
use utf8;
use strict;
use warnings;
use v5.16;
use GD;
use Carp;
use Pod::Usage;
use JSON::XS ();
use Getopt::Long qw(:config posix_default no_ignore_case gnu_compat bundling auto_version);

our $VERSION = "0.01";
my %args;

my $palette = {
        black   => { rgb => [ 0,   0,   0 ],   index => 0, },
        red     => { rgb => [ 255, 0,   0 ],   index => 1, },
        green   => { rgb => [ 0,   255, 0 ],   index => 2, },
        yellow  => { rgb => [ 255, 255, 0 ],   index => 3, },
        blue    => { rgb => [ 0,   0,   127 ],   index => 4, },
        magenta => { rgb => [ 255, 0,   255 ],   index => 5, },
        cyan    => { rgb => [ 0,   255, 255 ],   index => 6, },
        white   => { rgb => [ 255, 255, 255 ],   index => 7, },
};

main();

sub main {
    init();
    foreach my $file (@ARGV) {
        png2ansi($file);
    }
}

sub png2ansi {
    my ($file) = @_;
    Carp::croak "$file is not found" unless -e $file;
    my $im = GD::Image->new($file);
    my $pal = mk_palette();
    my ( $width, $height ) = $im->getBounds();
    for ( my $y = 0; $y < $height; $y++ ) {
        my @row;
        for ( my $x = 0; $x < $width; $x++ ) {
            my $color = $pal->colorClosest( $im->rgb( $im->getPixel( $x, $y ) ) );
            push @row, $color;
        }
        print join q{}, @row, "\n";
    }
}

sub mk_palette {
    my $pal = GD::Image->new(1,1);
    foreach my $color (sort {$a->{index} <=> $b->{index} } values %{$args{palette_table}}){ 
        $pal->colorAllocate(@{$color->{rgb}});
    }
    return $pal;
}

    

sub init {
    my @args_pattern = ('palette|p=s', 'help|h', 'manual', 'verbose' );
    if ( not GetOptions( \%args, @args_pattern ) ) { pod2usage(2) }
    if ( exists $args{help} ) { pod2usage(0) }
    elsif ( exists $args{manual} ) { pod2usage( -exitstatus => 0, -verbose => 2 ) }
    if (exists $args{palette} and -e $args{palette} ) {
        my $json_text;
        { local $/ = undef; local *FILE; open FILE, '<', $args{palette}; $json_text = <FILE>; close FILE }
        $args{palette_table} = JSON::XS::decode_json($json_text);
    }
    $args{palette_table} ||= $palette;

    return \%args;
}

1;

__END__

=pod

=head1 NAME

png2ansi.pl - PNG to ANSI

=head1 SYNOPSIS

  png2ansi.pl [options] file[, file2, ..., fileN]

convert png file to ansi dat

=head1 OPTIONS

=over 8

=item B<--palette|-p> pallet.json

set color pallet

=item B<--help|?>

show help

=item B<--verbose>

verbose mode

=item B<--manual>

show manual

=item B<--version>

show version

=back

=head1 DESCRIPTION

This is skelton of perl script.

=head1 PREREQUISITES

This script requires the C<Getopt::Long>, C<Pod::Usage>

=head1 Author

 Yusuke Wtase <ywatase@gmail.com>
  
=cut
