#!/usr/bin/perl

###############################################
#                                             #
#  Cox Communications Data Usage Web Scraper  #
#  Released under MIT License                 #
#                                             #
#  https://github.com/doug1/cox-data-usage    #
#                                             #
###############################################

use strict;
use warnings;
use WWW::Mechanize;

# Change these to match your primary account
my $username = 'example@cox.net';
my $password = 'moarBandw1dth';

my $login_form_url = 'https://www.cox.com/content/dam/cox/residential/login.html';
my $usage_url = 'https://www.cox.com/internet/ajaxDataUsageJSON.ajax?usagePeriodType=daily';

my $mech = WWW::Mechanize->new(
    ssl_opts => {
        SSL_ca_file => "certs.pem"
    }
);

print "GET Login Form\n";
$mech->get($login_form_url);

print "POST Login Form\n";
$mech->submit_form(
    form_name => 'sign-in',
    fields    => {
        username => $username,
        password => $password,
    }
);

$mech->save_content("postlogin.html");

print "GET Usage Page\n";
$mech->follow_link( text_regex => qr/Data Usage/ );
$mech->save_content("usage.html");

my $raw_usage_page = $mech->content();
if ( $raw_usage_page =~ /var utag_data=(\{[^}]*^\})/ms ) {
    my $customer_json = $1;
    open( JSON, ">customer.json" ) || die;
    print JSON $customer_json;
    close(JSON);
}

print "GET Usage Data\n";
$mech->get($usage_url);
my $usage_json = $mech->content();
$usage_json =~ s/&#160;/ /g;
open( JSON, ">usage.json" ) || die;
print JSON $usage_json;
close(JSON);

exit 0;

