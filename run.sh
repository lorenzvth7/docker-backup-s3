#!/bin/sh
# Create .tarball for backup
tar -cvpzf ${BACKUP}.tar backup/

# Check if S3 Bucket exists. Otherwise create it
BUCKET_EXIST=$(aws s3 ls | grep $S3BUCKET | wc -l)
if [ $BUCKET_EXIST -eq 0 ];
then
  aws s3 mb s3://$S3BUCKET
fi

# Upload to S3 Bucket
aws s3 --region $AWS_DEFAULT_REGION cp ${BACKUP}.tar s3://${S3BUCKET}/${BACKUP}-`date "+%m-%d-%y--%H:%M:%S"`.tar
