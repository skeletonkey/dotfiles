#!/usr/bin/perl

use strict;
use warnings;

my $diff_cmd = 'diff';
my $home_dir = $ENV{HOME};
my $md5_cmd  = 'md5';
my $some_dir = '.';

opendir(my $dh, $some_dir) || die "can't opendir $some_dir: $!";
my @dots = grep { /^\./ && -f "$some_dir/$_" } readdir($dh);
closedir $dh;

foreach my $file (@dots) {
    my $local_file = "$home_dir/$file";
    if (-e $local_file) {
        my $home_md5 = get_md5($local_file);
        my $git_md5 = get_md5($file);

        if ($home_md5 ne $git_md5) {
            print "$file is out of date\n";
            print "\tUpdate, Diff, or Ignore [u|d|I]: ";
            my $answer = <STDIN>;
            chomp($answer);
            if ($answer =~ /^d/i) {
                diff_files($local_file, $file);
            }
            elsif ($answer =~ /^u/i) {
                update_file($file);
            }
        }
    }
    else {
        print "File not present: $local_file\n";
    }
}

sub get_md5 {
    my $file = shift;
    my $ret = `$md5_cmd $file`;
    my ($md5) = $ret =~ /(\S+)$/;
    return $md5;
}

sub diff_files {
    my ($local_file, $file) = @_;
    my $files = join(' ', $local_file, $file);
    print "< $local_file\n";
    print "> $file\n";
    system("$diff_cmd $files");
    print "\tUpdate Local [y|N]: ";
    my $answer = <STDIN>;
    chomp($answer);
    if ($answer =~ /^y/i) {
        update_file($file);
    }
}

sub update_file {
    my $file_name = shift;
    system("cp $file_name $home_dir/$file_name");
}
