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

### Use with aws-mock-metadata

Pass the port that your mocked aws metadat service is running on:
```perl
my $im = Net::AWS::EC2::IdentityMetadata->new({ port => '45000' });
```

