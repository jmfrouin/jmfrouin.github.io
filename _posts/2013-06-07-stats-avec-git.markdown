---
layout: post
status: publish
published: true
title: Stats avec git
author: Jean-Michel Frouin
author_login: jmfrouin
author_email: jm@frouin.me
author_url: http://frouin.me
date: '2013-06-07 08:09:05 +0200'
date_gmt: '2013-06-07 07:09:05 +0200'
categories:
- git
tags: []
comments: []
---
<p>Devant sortir des statistiques d'utilisation sur git, une recherche sur le net et un petit mémo ici !</p>
<!--more-->
<pre class="brush:shell">git blame ficher | grep Auteur | wc -l</pre>
<pre class="brush:shell">git shortlog master --numbered --summary</pre>
<p>Un script bash authorship.sh:</p>
<pre class="brush:shell">
#!/bin/sh
declare -A map
while read line; do
    if grep "^[a-zA-Z]" <<< "$line" > /dev/null; then
        current="$line"
        if [ -z "${map[$current]}" ]; then 
            map[$current]=0
        fi
    elif grep "^[0-9]" <<<"$line" >/dev/null; then
        for i in $(cut -f 1,2 <<< "$line"); do
            map[$current]=$((map[$current] + $i))
        done
    fi
done <<< "$(git log --numstat --pretty="%aN")"

for i in "${!map[@]}"; do
    echo -e "$i:${map[$i]}"
done | sort -nr -t ":" -k 2 | column -t -s ":"
</pre>
<p>Retourne des stats de la forme : </p>
<p>jmfrouin@xps:~/dev (master)$ ./authorship.sh<br />
Auteur1  2106426<br />
Auteur2  1432790<br />
Auteur3  968647<br />
Auteur4  112595<br />
Auteur5  84290</p>
<p>Un script perl author.pl :</p>
<pre class="brush:shell">
#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

my $dir = shift;

die "Please provide a directory name to check\n"
    unless $dir;

chdir $dir
    or die "Failed to enter the specified directory '$dir': $!\n";

if ( ! open(GIT_LS,'-|','git ls-files') ) {
    die "Failed to process 'git ls-files': $!\n";
}
my %stats;
while (my $file = <GIT_LS>) {
    chomp $file;
    if ( ! open(GIT_LOG,'-|',"git log --numstat $file") ) {
        die "Failed to process 'git log --numstat $file': $!\n";
    }
    my $author;
    while (my $log_line = <GIT_LOG>) {
        if ( $log_line =~ m{^Author:\s*([^<]*?)\s*<([^>]*)>} ) {
            $author = lc($1);
        }
        elsif ( $log_line =~ m{^(\d+)\s+(\d+)\s+(.*)} ) {
            my $added = $1;
            my $removed = $2;
            my $file = $3;
            $stats{total}{by_author}{$author}{added}        += $added;
            $stats{total}{by_author}{$author}{removed}      += $removed;
            $stats{total}{by_author}{total}{added}          += $added;
            $stats{total}{by_author}{total}{removed}        += $removed;

            $stats{total}{by_file}{$file}{$author}{added}   += $added;
            $stats{total}{by_file}{$file}{$author}{removed} += $removed;
            $stats{total}{by_file}{$file}{total}{added}     += $added;
            $stats{total}{by_file}{$file}{total}{removed}   += $removed;
        }
    }
    close GIT_LOG;

    if ( ! open(GIT_BLAME,'-|',"git blame -w $file") ) {
        die "Failed to process 'git blame -w $file': $!\n";
    }
    while (my $log_line = <GIT_BLAME>) {
        if ( $log_line =~ m{\((.*?)\s+\d{4}} ) {
            my $author = $1;
            $stats{final}{by_author}{$author}     ++;
            $stats{final}{by_file}{$file}{$author}++;

            $stats{final}{by_author}{total}       ++;
            $stats{final}{by_file}{$file}{total}  ++;
            $stats{final}{by_file}{$file}{total}  ++;
        }
    }
    close GIT_BLAME;
}
close GIT_LS;

print "Total lines committed by author by file\n";
printf "%25s %25s %8s %8s %9s\n",'file','author','added','removed','pct add';
foreach my $file (sort keys %{$stats{total}{by_file}}) {
    printf "%25s %4.0f%%\n",$file
            ,100*$stats{total}{by_file}{$file}{total}{added}/$stats{total}{by_author}{total}{added};
    foreach my $author (sort keys %{$stats{total}{by_file}{$file}}) {
        next if $author eq 'total';
        printf "%25s %25s %8d %8d %8.0f%%\n",'', $author,@{$stats{total}{by_file}{$file}{$author}}{qw{added removed}}
            ,100*$stats{total}{by_file}{$file}{$author}{added}/$stats{total}{by_file}{$file}{total}{added};
    }
}
print "\n";

print "Total lines in the final project by author by file\n";
printf "%25s %25s %8s %9s %9s\n",'file','author','final','percent', '% of all';
foreach my $file (sort keys %{$stats{final}{by_file}}) {
    printf "%25s %4.0f%%\n",$file
            ,100*$stats{final}{by_file}{$file}{total}/$stats{final}{by_author}{total};
    foreach my $author (sort keys %{$stats{final}{by_file}{$file}}) {
        next if $author eq 'total';
        printf "%25s %25s %8d %8.0f%% %8.0f%%\n",'', $author,$stats{final}{by_file}{$file}{$author}
            ,100*$stats{final}{by_file}{$file}{$author}/$stats{final}{by_file}{$file}{total}
            ,100*$stats{final}{by_file}{$file}{$author}/$stats{final}{by_author}{total}
        ;
    }
}
print "\n";


print "Total lines committed by author\n";
printf "%25s %8s %8s %9s\n",'author','added','removed','pct add';
foreach my $author (sort keys %{$stats{total}{by_author}}) {
    next if $author eq 'total';
    printf "%25s %8d %8d %8.0f%%\n",$author,@{$stats{total}{by_author}{$author}}{qw{added removed}}
        ,100*$stats{total}{by_author}{$author}{added}/$stats{total}{by_author}{total}{added};
};
print "\n";


print "Total lines in the final project by author\n";
printf "%25s %8s %9s\n",'author','final','percent';
foreach my $author (sort keys %{$stats{final}{by_author}}) {
    printf "%25s %8d %8.0f%%\n",$author,$stats{final}{by_author}{$author}
        ,100*$stats{final}{by_author}{$author}/$stats{final}{by_author}{total};
}
</pre>
<p>Retourne des résultats de la forme : </p>
<p>Références :<br />
<a href="http://stackoverflow.com/questions/2787253/show-number-of-changed-lines-per-author-in-git" target="_blank">authorship.sh</a><br />
<a href="http://stackoverflow.com/questions/1265040/how-to-count-total-lines-changed-by-a-specific-author-in-a-git-repository" target="_blank">author.pl</a><br />
<a href="http://fr.softuses.com/174171" target="_bkank">Récapitulatif de plusieurs méthodes</a></p>
<!-- Matomo -->
<script type="text/javascript">
  var _paq = window._paq || [];
  /* tracker methods like "setCustomDimension" should be called before "trackPageView" */
  _paq.push(['trackPageView']);
  _paq.push(['enableLinkTracking']);
  (function() {
    var u="//stats.frouin.me/";
    _paq.push(['setTrackerUrl', u+'matomo.php']);
    _paq.push(['setSiteId', '1']);
    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
    g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'matomo.js'; s.parentNode.insertBefore(g,s);
  })();
</script>
<!-- End Matomo Code -->
