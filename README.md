# ec2-identity-metadata

Determine identity metadata on an EC2

### Sample Usage

```perl
my $im = Net::AWS::EC2::IdentityMetaData->new();
print Dumper $im->local_credentials();
print Dumper $im->aws_access_key_id();
print Dumper $im->aws_secret_access_key();
print Dumper $im->aws_token();
```

### Use with aws-mock-metadata

Pass the port that your mocked aws metadat service is running on:
```perl
my $im = Net::AWS::EC2::IdentityMetaData->new({ port => '45000' });
```

