use strict;
use warnings;

our $session;

use MIME::Base64 'encode_base64', 'decode_base64';

#my $api = new freeswitch::API;
#my $res = $api->executeString("version");
#chomp($res);
#freeswitch::consoleLog("INFO", "Version information is '$res'\n");
my $uuid = $session->getVariable('uuid');
freeswitch::consoleLog("INFO", "RingMail: uuid=$uuid\n");

my $from = $session->getVariable('sip_h_X-RingMail-From');
if (defined $from)
{
	freeswitch::consoleLog("INFO", "RingMail: from=$from\n");
}
my $type = $session->getVariable('sip_h_X-RingMail-Type') || 'none';
if ($type eq 'did')
{
	my $target = $session->getVariable('destination_number');
	my $dst = "{origination_caller_id_number=+14243260287,originate_timeout=60}sofia/gateway/flowroute/$target";
	freeswitch::consoleLog("INFO", "RingMail: bridge=$dst\n");
	$session->setVariable('inherit_codec', 'true');
	$session->setVariable('call_timeout', '60');
	$session->execute('bridge', "$dst");
}
if ($type eq 'sip')
{
	my $route = $session->getVariable('sip_h_X-RingMail-Route') || 'none';
	$route = decode_base64($route);
	$route =~ s/^sip://;
	my $dst = "{origination_caller_id_number=+14243260287,originate_timeout=60}sofia/external/$route";
	#my $dst = "{absolute_codec_string=PCMU,origination_caller_id_number=+14243260287,originate_timeout=60}sofia/external/$route";
	freeswitch::consoleLog("INFO", "RingMail: bridge=$dst\n");
	#$session->setVariable('codec_string', 'OPUS');
	#$session->execute('answer');
	$session->setVariable('inherit_codec', 'true');
	$session->setVariable('call_timeout', '60');
	$session->execute('bridge', "$dst");
}

1;

