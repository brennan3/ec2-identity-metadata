package Net::AWS::EC2::IdentityMetaData;
{
    $Net::AWS::EC2::IdentityMetaData::VERSION = '0.01';
}

use Moose;
use LWP::Simple;
use JSON::Parse 'parse_json';

has 'aws_token'             => ( is => 'ro', isa => 'Str', required => 0, lazy_build => 1 );
has 'aws_access_key_id'     => ( is => 'ro', isa => 'Str', required => 0, lazy_build => 1 );
has 'aws_secret_access_key' => ( is => 'ro', isa => 'Str', required => 0, lazy_build => 1 );
has 'local_credentials'     => ( is => 'rw', isa => 'HashRef', required => 0 );
has 'port'                  => ( is => 'ro', isa => 'Str', required => 0 );

sub BUILD {
    my $self = shift;

    # Allow optional port in event we are running this locally via aws-mock-metadata
    my $base_url = 'http://169.254.169.254';
    if( $self->port() ) {
	$base_url .= ':' . $self->port();
    }
    
    # Determine who credentials are for
    my $credentials_for_url = $base_url . '/latest/meta-data/iam/security-credentials/';
    my $credentials_for     = get($credentials_for_url);
    die "Unable to fetch local credentials for!" unless defined $credentials_for;

    # Grab credentials
    my $credentials_url  = $credentials_for_url . $credentials_for;
    my $credentials_json = get($credentials_url);
    die "Unable to fetch local credentials!" unless defined $credentials_json;

    # Parse/set credentials
    my $perl = parse_json ($credentials_json);
    $self->local_credentials($perl);
}

sub _build_aws_access_key_id {
    my $self = shift;
    return $self->local_credentials()->{AccessKeyId};
}

sub _build_aws_secret_access_key {
    my $self = shift;
    return $self->local_credentials()->{SecretAccessKey};
}

sub _build_aws_token {
    my $self = shift;
    return $self->local_credentials()->{Token};
}

1;
