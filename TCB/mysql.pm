$VERSION = "0.2";
package TCB::mysql;
our $VERSION = "0.2";

# -*- Perl -*-          Wed May 26 09:42:27 CDT 2004 
###############################################################################
# Written by Tim Skirvin <tskirvin@ks.uiuc.edu>.  All rights reserved.
# Distribution terms are below. Copyright 2000-2004, Tim Skirvin and UIUC 
# Board of Trustees.
###############################################################################

=head1 NAME

TCB::mysql - mysql authentication Database

=head1 SYNOPSIS

  use TCB::mysql;
  my $DB = TCB::mysql->connect( $DATABASE, $DBUSER, $DBPASS, 
                                           $DBHOST, $DBTYPE )
        or die("Couldn't connect to $DBHOST: $DBI::errstr\n");

See below for how to actually use this object.

=head1 DESCRIPTION

The mysql database is used by MySQL to provide authentication to the other
databases - ie, usernames, passwords, and hostnames that are allowed to
connect.  This is implemented by mysql itself.  This package offers a
DBIx::Frame interface to the tables.

This base class is used to load the table definitions for the database.

Specific tables offered by this class:

=over 4

=item TCB::mysql::columns_priv - NOT IMPLEMENTED

=item TCB::mysql::db - database priveleges        

=item TCB::mysql::func - NOT IMPLEMENTED

=item TCB::mysql::host - host priveleges

=item TCB::mysql::tables_priv - NOT IMPLEMENTED

=item TCB::mysql::user - user priveleges

=back

See each table's documentation for more information.

=cut

use strict;
use vars qw(@ISA @PROBS @MODULES $SERVER $DATABASE $DBTYPE $USER $PASS $DEBUG );

###############################################################################
### User Variables ############################################################
###############################################################################
@MODULES  = qw( DBIx::Frame Exporter TCB::mysql::db TCB::mysql::host 
		TCB::mysql::user );
# Should probably institute the remaining tables that we've never used - 
# 'columns_priv', 'tables_priv', and 'func'.
@ISA      = qw( DBIx::Frame Exporter );
$SERVER   = "db.ks.uiuc.edu";	     		     # Default web server 
$DATABASE = "mysql";	     
$DBTYPE	  = "mysql";
$USER     = "guest";
$PASS     = "";
$DEBUG    = 0;

###############################################################################
### main() ####################################################################
###############################################################################
foreach ( @MODULES ) { local $@; eval "use $_"; push @PROBS, "$@" if $@; }
die @PROBS if scalar @PROBS;

# Initialize DBIx::Frame (this has already been done a few times, but this
#   allows us to have a definite known state to finish with)
DBIx::Frame->init($SERVER, $DBTYPE, $DATABASE, $USER, $PASS, $SERVER);
###############################################################################

1;

=head1 NOTES

=head1 REQUIREMENTS

Perl 5.6.0 or better, MySQL, C<DBIx::Frame>.

=head1 SEE ALSO

B<DBIx::Frame>, B<TCB::mysql::db>, B<TCB::mysql::host>, B<TCB::mysql::user>

=head1 HOMEPAGE

B<http://www.ks.uiuc.edu/Development/MDTools/tcb-mysql/>

=head1 LICENSE

This code is distributed under the University of Illinois Open Source
License.  See
C<http://www.ks.uiuc.edu/Development/MDTools/tcb-mysql/license.html> for
details.

=head1 COPYRIGHT

Copyright 2000-2004 by the University of Illinois Board of Trustees and
Tim Skirvin <tskirvin@ks.uiuc.edu>.

=cut

###############################################################################
### Version History ###########################################################
###############################################################################
# v0.1 		Thu Aug 21 09:05:02 CDT 2003 
### Basic code to load up other modules as necessary.  Documentation not
### finished.  Based on some older, non-regular code.
# v0.2		Wed May 26 09:42:22 CDT 2004 
### Getting ready for DBIx::Frame.
