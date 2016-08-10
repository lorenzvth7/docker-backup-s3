# docker-backup
A way to create backups of folders (e.g. docker volumes). 

Prerequisitions:
* Docker version 1.11.x <
* AWS account (credentials)

#### Build the image
```
docker build -t backup-s3 .
```

#### Fill in the env.txt 
```
AWS_ACCESS_KEY_ID=<aws-access-key-id>
AWS_SECRET_ACCESS_KEY=<aws-sercret-key>
AWS_DEFAULT_REGION=<region>
BACKUP=<name-of-backup>
S3BUCKET=<name-of-s3-bucket>
```

#### Docker run command
```
docker run --rm \
-v /path/to/folder:/backup \
--env-file env.txt
backup-s3
```

This will create a tarball of your specified folder and upload it to your specified s3bucket. If the bucket does not exist it will be created.
Your tarball will in the following format: `<name-of-backup>-08-07-16--11:11:46.tar` (To edit in run.sh)

#### Cron job
To run your backupservice as a cronjob
```
touch /etc/cron.weekly/backup.sh
chmod +x /etc/cron.weekly/backup.sh
```

content of backup.sh
```
#!/bin/sh

# start backup container + define env variables
docker run --rm \
-v /my/path/to/backup:/backup \
-e AWS_ACCESS_KEY_ID=<aws-access-key-id> \
-e AWS_SECRET_ACCESS_KEY=<aws-sercret-key> \
-e AWS_DEFAULT_REGION=<region> \
-e BACKUP=<name-of-backup> \
-e S3BUCKET=<name-of-s3-bucket> \
backup-s3
```

