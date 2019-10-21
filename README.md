cox-data-usage
==============

This is a Perl script to log in to your Cox Communications account and
download cable modem data usage stats.  It's an ugly web-scraping hack.

First, change the username/password to your own and update any changed
URLs if Cox has reorganized the website again.  The URLs in the script are
working as of October 2019 after the recent site redesign.  Run the script
and it will leave some HTML and JSON files in the current directory,
which are useful for debugging if anything goes wrong.  If everything
worked, the JSON files should contain your customer and usage data.

It was tested with WWW::Mechanize 1.91 from Fedora 30.
Install Perl module dependencies by running:
```
sudo dnf install perl-WWW-Mechanize
```

