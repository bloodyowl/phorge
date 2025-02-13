# Phorge-Docker

This is an unofficial Docker image of Phorge app.  
Application configured as a single image with `supervisord` to control all necessary processes inside one docker container.  

## Docker image available for OS/ARCH
* `linux/amd64, linux/arm64` | tag: `latest`

## Configuration

To startup Phorge with a single command you need configured MySQL/MariaDB and S3 storage (Local server or AWS)

### Variables
|Name|Default Value|
|---|---|
|PROTOCOL|http|
|SSH_PORT|8022|
|GIT_USER|git|
|MYSQL_HOST||
|MYSQL_PORT|3306|
|MYSQL_USER||
|MYSQL_PASSWORD||
|BASE_URI||
|MINIO_SERVER||
|MINIO_PORT||
|MINIO_SERVER_SECRET_KEY||
|MINIO_SERVER_ACCESS_KEY||
|SMTP_SERVER||
|SMTP_PORT||
|SMTP_USER||
|SMTP_PASSWORD||
|SMTP_PROTOCOL||

#### Example command to start:
```
docker run \
    --rm \
    -p 80:80 \
    -p 8022:8022 \
    --env MYSQL_HOST=mysqlhost.com \
    --env MYSQL_PORT=3306 \
    --env MYSQL_USER=root \
    --env MYSQL_PASSWORD=changeme \
    --env MINIO_SERVER_ACCESS_KEY=access_key \
    --env MINIO_SERVER_SECRET_KEY=secret_key \
    --env BASE_URI=yourdomain.com \
    -v /your/repo/folder:/var/repo
    buddyspencer/phorge:latest
```

### To launch all components of Phorge using `docker-compose` use following set of commands:
#### `amd64` arch:
```
export BASE_URI=yourdomain.com
export MYSQL_ROOT_PASSWORD=changeme
docker-compose up -d
```

## Links
[Docker hub](https://hub.docker.com/r/buddyspencer/phorge)