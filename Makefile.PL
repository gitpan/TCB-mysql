use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

my $modules = {};  my $man3page = {};  my $man1page = {};
foreach my $module ( qw( TCB::mysql TCB::mysql::db TCB::mysql::host 
		TCB::mysql::user ) ) { 
  my $file = $module;
     $file =~ s/::/\//g;  
     $file =~ s/$/.pm/;
  my $shortfile = $file;  $shortfile =~ s%^TCB/%%;
  my $libdir = join('/', '$(INST_LIBDIR)', $shortfile);
  my $man3 = join('/', '$(INST_MAN3DIR)', "$module.3");
  $$modules{$file} = $libdir; $$man3page{$file} = $man3;
}

my (@progs);
foreach my $script ( qw( cgi-bin/mysql_admin.cgi ) ) {
  my $pkg = $script;  $pkg =~ s%.*/%%g;
  $$man1page{$script} = join('/', '$(INST_MAN1DIR)', "$pkg.1");
  push @progs, $script;
}

WriteMakefile(
    'NAME'	=> 'TCB::mysql',
    'DISTNAME'  => 'TCB-mysql',
    'MAN1PODS'  => $man1page, 
    'MAN3PODS'  => $man3page, 
    'VERSION_FROM' => 'Version.pm', # finds $VERSION
    'PREREQ_PM' => { 'DBIx::Frame' => 1.06 },
    'PM' 	=> $modules,
    'EXE_FILES' => [ @progs ],
    'dist' => { COMPRESS => 'gzip', SUFFIX => 'gz' },
    'AUTHOR'    => 'tskirvin@ks.uiuc.edu (Tim Skirvin)',
    'ABSTRACT_FROM'  => 'TCB/mysql.pm',
);
