#!/usr/bin/perl
use strict;

=begin 사용법
```bash
    gitup some_dir "Hello, there."
    gitup some_dir Hello
    gitup some_dir
    gitup
```
=cut

# 첫 번쨰 매개변수는 명령을 실행할 디렉토리이다. 매개변수가 없으면 현재 디렉토리에서 수행된다.
my $folder = shift;
unless (-e -d $folder) {
    $folder = `pwd`;
    chomp $folder;
}

# 두 번쨰 매개변수는 커밋 메시지이다. 매개변수가 없으면 현재시간을 커밋 메시지로 사용한다.
my $msg = shift;
if (!$msg) {
    $msg = &ymdhms;
}

chdir($folder) or die $!;

print "Running GIT ADD on $folder\n";
system "git add -A";
print "Running GIT COMMIT with a $msg\n";
system "git commit -a -m \"$msg\"";
print "Running GIT PUSH\n";
system "git push";
print "Done.\n";

# 현재 시간
sub ymdhms{
    # 시간을 매개변수로 전달 받거나 현재 시간을 사용한다.
    my $time = (defined $_[0]) ? $_[0] : time();
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($time);
    $mon += 1;
    $year += 1900;
    sprintf ("%04d-%02d-%02d %02d:%02d:%02d", $year, $mon, $mday, $hour, $min, $sec);
}

