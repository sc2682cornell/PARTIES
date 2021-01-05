#!/usr/bin/perl
sub rndStr{ join'', @_[ map{ rand @_ } 1 .. shift ] }
$nbytes=$ARGV[0];
$pre="<HTML>";
$post="<HTML>\n";
$nb=length($pre . $post);
$body=rndStr $nbytes-$nb, 'A'..'Z',' ','a'..'z',' ','0'..'9';
print $pre.$body.$post;
1;
