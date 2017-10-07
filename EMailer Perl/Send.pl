use strict;
use warnings;
use Email::Send::SMTP::Gmail;

#Reading Body of mail
print("Reading Body of mail...\n");
my $bodyfilename = 'Ebody.txt';
open(my $fh, '<:encoding(UTF-8)', $bodyfilename)
  or die "Could not open file '$bodyfilename' $!";
 
my $body="";
while (my $row = <$fh>) {
  $body = $body.$row."\n";
}

print("Reading Header of mail...\n");
#Reading header of mail
my $headerfilename = 'Eheader.txt';
open(my $fhh, '<:encoding(UTF-8)', $headerfilename)
  or die "Could not open file '$headerfilename' $!";
 
my $header="";
while (my $rowh = <$fhh>) {
  $header = $header.$rowh."\n";
}

print("Reading Footer of mail...\n");
#Reading footer of mail
my $footerfilename = 'Efooter.txt';
open(my $ft, '<:encoding(UTF-8)', $footerfilename)
  or die "Could not open file '$footerfilename' $!";
 
my $footer="";
while (my $roww = <$ft>) {
  $footer = $footer.$roww."\n";
}

print("Adding Attachments to the mail...\n");
#Reading Attachment of mail
my $attachfilename = 'Eattachment.txt';
open(my $fh2, '<:encoding(UTF-8)', $attachfilename)
  or die "Could not open file '$attachfilename' $!";
 
my $attach="";
while (my $row2 = <$fh2>) {
  $attach = $attach.$row2."\n";
}

print("Setting up SMTP Server...\n");
#SMTP Server Settings
my ($mail,$error) = Email::Send::SMTP::Gmail->new(
    -layer =>'ssl',
    -port  =>'465',
    -smtp  =>'smtp.gmail.com',
    -login =>'uberhunter420@gmail.com',
    -pass  =>'nihalnihal'
);
 
die "session error: $error" if $mail ==-1;

print("Reading Receiver Email Addresses...\n");
#Reading Receiver Emails
my $receivefilename = 'Esendto.txt';
open(my $fh3, '<:encoding(UTF-8)', $receivefilename)
  or die "Could not open file '$receivefilename' $!";
 
my $receive="";
while (my $row3 = <$fh3>) {
	chomp $row3;
	$receive = $receive.$row3;
}

print("Email Packing...\n");
$mail->send(
    -to         => $receive,
    -subject    => 'OSL Lab EMailer Test',
    -body       => $header."\n".$body."\n".$footer,
    -attachments=> $attach
);
$mail->bye;

print("Email Successfully Sent.\n");