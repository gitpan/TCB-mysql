$VERSION = "0.2";
package TB::mysql::user;
our $VERSION = "0.2";

# -*- Perl -*- Thu Aug 21 09:19:52 CDT 2003 
###############################################################################
# Written by Tim Skirvin <tskirvin@ks.uiuc.edu> Copyright 2002-2004, Tim
# Skirvin and UIUC Board of Trustees.
###############################################################################
use vars qw( @ISA $FIELDS $KEYS $NAME $LIST $ORDER $ADMIN $REQUIRED ); 

=head1 NAME

TCB::mysql::user - authentication information for MySQL, by username

=head1 SYNOPSIS

  use TCB::mysql::user;

See TCB::mysql for more information.

=head1 DESCRIPTION

The 'user' table describes what users can affect what databases, those
users' passwords, and in what ways they can be affected.  Its siblings are
the 'host' and 'db' tables.

This table contains the following fields:

 Primary Information (TINYTEXT fields, unless noted)
  Host		Hostnames that can modify data.  
  User		Usernames alowed to modify data.
  Password	Password for the user.  Is generally encrypted.

 Priveleges (ENUM(N,Y) unless noted)
  Select_priv	Can this user/db/host set use select()?
  Insert_priv	Can this user/db/host set use insert()?
  Update_priv	Can this user/db/host set use update()? 
  Delete_priv	Can this user/db/host set use delete()?
  Create_priv	Can this user/db/host set use create()?
  Drop_priv	Can this user/db/host set use drop()?
  Grant_priv  	Can this user/db/host set use grant()?
  References_priv  Can this user/db/host set use references()?
  Index_priv  	Can this user/db/host set use index()?
  Alter_priv	Can this user/db/host set use alter()?

Key fields:     Host, User, Password

List items:     Host, User, Password

Required:       Same as 'Keys'

Default order:  None set.

Admin Fields:   None

No other tables depend on this table directly.

Doesn't depend on any other table.

=cut

###############################################################################
### Initialization ############################################################
###############################################################################
use vars qw( @ISA $FIELDS $KEYS $NAME $LIST $REQUIRED $ADMIN $ORDER );
use strict;
use warnings;
use CGI;
use TCB::mysql;

push @ISA, qw( TCB::mysql );

###############################################################################
### Database Variables ########################################################
###############################################################################
$NAME = "user";
$FIELDS = {
  'Host'          =>  'TINYTEXT PRIMARY KEY',
  'User'          =>  'TINYTEXT PRIMARY KEY',
  'Password'      =>  'TINYTEXT PRIMARY KEY',
  'Select_priv'   =>  "ENUM('N', 'Y')", 'Insert_priv'     =>  "ENUM('N', 'Y')",
  'Update_priv'   =>  "ENUM('N', 'Y')", 'Delete_priv'     =>  "ENUM('N', 'Y')",
  'Create_priv'   =>  "ENUM('N', 'Y')", 'Drop_priv'       =>  "ENUM('N', 'Y')",
  'Grant_priv'    =>  "ENUM('N', 'Y')", 'References_priv' =>  "ENUM('N', 'Y')",
  'Index_priv'    =>  "ENUM('N', 'Y')", 'Alter_priv'      =>  "ENUM('N', 'Y')",
          };
$KEYS  = [ 'Host', 'User', 'Password' ];
$LIST  = [ 'Host', 'User', 'Password' ];
$REQUIRED = $KEYS;
$ADMIN = [];
$ORDER = [];

###############################################################################
##### Functions ###############################################################
###############################################################################

=head2 Internal Functions

=over 4

=item html ( ENTRY, TYPE, OPTIONS )

Prints the HTML version of the table.  Heavily customized for the TCB
environment, but then again so is the whole program.                            

=cut

sub html {
  my ($self, $entry, $type, $options, @rest) = @_;
  my $cgi = new CGI;    $entry ||= {};

  my %list = ( 'Y' => "Yes", 'N' => "No" );
  $list{''} = "" if lc $type eq 'search';

  my @return = <<HTML;
<div class="basetable">
 <div class="row1">
  <span class="label">Host</span>
  <span class="formw">
   <input type="text" name="Host" value="@{[ $$entry{Host} || ""]}" size="80" maxlength="255" />
  </span>
 </div>
 <div class="row2">
  <span class="label">User</span>
  <span class="formw">
   <input type="text" name="User" value="@{[ $$entry{User} || ""]}" size="40" maxlength="255" />
  </span>
  <span class="label">Password</span>
  <span class="formw">
   <input type="text" name="Password" value="@{[ $$entry{Password} || ""]}" size="18" maxlength="255" />
  </span>
 </div>

 <div class="row5">
  <span class="label">Select</span>
  <span class="formw">
    @{[ $cgi->popup_menu('Select_priv', [ keys %list ], 
				$$entry{Select_priv} || "", \%list ) ]}
  </span>
  <span class="label">Insert</span>
  <span class="formw">
    @{[ $cgi->popup_menu('Insert_priv', [ keys %list ], 
				$$entry{Insert_priv} || "", \%list ) ]}
  </span>
  <span class="label">Update</span>
  <span class="formw">
    @{[ $cgi->popup_menu('Update_priv', [ keys %list ], 
				$$entry{Update_priv} || "", \%list ) ]}
  </span>
  <span class="label">Delete</span>
  <span class="formw">
    @{[ $cgi->popup_menu('Delete_priv', [ keys %list ], 
				$$entry{Delete_priv} || "", \%list ) ]}
  </span>
  <span class="label">Create</span>
  <span class="formw">
    @{[ $cgi->popup_menu('Create_priv', [ keys %list ], 
				$$entry{Create_priv} || "", \%list ) ]}
  </span>
 </div>
 <div class="row5">
  <span class="label">Drop</span>
  <span class="formw">
    @{[ $cgi->popup_menu('Drop_priv', [ keys %list ], 
				$$entry{Drop_priv} || "", \%list ) ]}
  </span>
  <span class="label">Grant</span>
  <span class="formw">
    @{[ $cgi->popup_menu('Grant_priv', [ keys %list ], 
				$$entry{Grant_priv} || "", \%list ) ]}
  </span>
  <span class="label">References</span>
  <span class="formw">
    @{[ $cgi->popup_menu('References_priv', [ keys %list ], 
				$$entry{References_priv} || "", \%list ) ]}
  </span>
  <span class="label">Index</span>
  <span class="formw">
    @{[ $cgi->popup_menu('Index_priv', [ keys %list ], 
				$$entry{Index_priv} || "", \%list ) ]}
  </span>
  <span class="label">Alter</span>
  <span class="formw">
    @{[ $cgi->popup_menu('Alter_priv', [ keys %list ], 
				$$entry{Alter_priv} || "", \%list ) ]}
  </span>
 </div>

 <div class="submitbar"> @{[ $cgi->submit(-name=>"Submit") ]} </div>
</div>
HTML
  wantarray ? @return : join("\n", @return);
}

=item text ( )

Not currently populated.

=cut

sub text { }

=back

=cut

###############################################################################
##### main() ##################################################################
###############################################################################

TCB::mysql->table_add($NAME, $FIELDS, $KEYS, $LIST, $ORDER,
                         $ADMIN, $REQUIRED, \&html, \&text);

=head1 COMMENTS

=head1 TODO

=head1 REQUIREMENTS

Perl 5.6.0 or better, DBIx::Frame, TB::mysql.

=head1 SEE ALSO

B<TB::mysql>, B<DBIx::Frame>

=head1 AUTHOR

Tim Skirvin <tskirvin@ks.uiuc.edu>

=head1 HOMEPAGE

B<http://www.ks.uiuc.edu/Development/MDTools/tcb-mysql/>

=head1 LICENSE

This code is distributed under the University of Illinois Open Source
License.  See
C<http://www.ks.uiuc.edu/Development/MDTools/tcb-mysql/license.html> for
details.

=head1 COPYRIGHT

Copyright 2003-2004 by the University of Illinois Board of Trustees and
Tim Skirvin <tskirvin@ks.uiuc.edu>.

=cut

###############################################################################
### Version History ###########################################################
###############################################################################
# v0.1 		Thu Aug 21 09:19:47 CDT 2003 
### First functional version, not approved by anybody yet, this will likely 
### still need a lot of work.
# v0.2		Tue May 25 17:00:21 CDT 2004 
### Updated for DBIx::Frame and TCB::mysql.
