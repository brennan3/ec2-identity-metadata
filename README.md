# ec2-identity-metadata

Determine identity metadata on an EC2

### Sample Usage

```perl
my $im = Net::AWS::EC2::IdentityMetadata->new();
print Dumper $im->local_credentials();
print $im->aws_access_key_id();
print $im->aws_secret_access_key();
print $im->aws_token();
```

### Using these credentials
You need to be sure to set a header attribute for your aws token if you are using these credentials to interact with other AWS tools.  The header property is the X-Amz-Security-Token.  Here is an example grabbing S3 contents using S3::AWSAuthConnection:

```perl
my $im = Net::AWS::EC2::IdentityMetadata->new();
my $aws_access_key_id     = $im->aws_access_key_id();
my $aws_secret_access_key = $im->aws_secret_access_key();
my $token                 = $im->aws_token();

# Setup headers with our session token
my $headers = {
   'X-Amz-Security-Token' => $token
};

# Connect setup for S3
my $conn = S3::AWSAuthConnection->new($aws_access_key_id, $aws_secret_access_key);

# Our bucket
my $bucket = 'my-bucket-name';

# Get bucket data
my $get = $conn->get($bucket, 'key-in-bucket', $headers);

# Dump contents of values for the key in our bucket:
print Dumper $get->object()->{DATA};
```

### Use with aws-mock-metadata

Pass the port that your mocked aws metadat service is running on:
```perl
my $im = Net::AWS::EC2::IdentityMetadata->new({ port => '45000' });
```

