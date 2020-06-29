import boto3
s3 = boto3.client('s3')
print(s3.list_objects_v2(Bucket='a204311-tr-corporate-nonprod-trlabs-usdev', MaxKeys=2))
s3.upload_file('hello.txt', 'a204311-tr-corporate-nonprod-trlabs-usdev', 'data/test/hello.txt')