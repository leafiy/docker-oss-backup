#!/bin/bash

## 备份配置信息 ##

# 备份名称，用于标记
BACKUP_NAME="${OBJECTKEY}"
OBJECTKEY="${OBJECTKEY}"
# 备份目录，多个请空格分隔
BACKUP_SRC="/src/backups"
BACKUP_DIR="/src/tmp/backup-to-oss"
## 备份配置信息 End ##

## 阿里云 OSS 配置信息 ##

# 存放空间
OSS_BUCKET="${OSS_BUCKET}"
# ACCESS_KEY
OSS_ACCESS_KEY="${OSS_ACCESS_KEY}"
# SECRET_KEY
OSS_SECRET_KEY="${OSS_SECRET_KEY}"
# Endpoint 示例：https://oss-cn-shenzhen.aliyuncs.com
OSS_ENDPOINT="${OSS_ENDPOINT}"

## 阿里云 OSS 配置信息 End ##



## Start ##
NOW=$(date +"%Y%m%d%H%M%S")  # 精确到秒，同一秒内上传的文件会被覆盖

mkdir -p $BACKUP_DIR


# 打包
echo "start tar"
BACKUP_FILENAME="$BACKUP_NAME-backup-$NOW.zip"
zip -q -r $BACKUP_DIR/$BACKUP_FILENAME $BACKUP_SRC
echo "tar ok"

# 上传
echo "start upload"
python3 $(dirname $0)/upload.py -a $OSS_ACCESS_KEY -s $OSS_SECRET_KEY -b $OSS_BUCKET -e $OSS_ENDPOINT -f $BACKUP_DIR/$BACKUP_FILENAME -k $OBJECTKEY
echo "upload ok"

# 清理备份文件
rm -rf $BACKUP_DIR/*
echo "backup clean done"