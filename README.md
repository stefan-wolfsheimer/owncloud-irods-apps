# iRODS Apps for OwnCloud

## Git repositories

* iRODS PHP library
  [https://github.com/stefan-wolfsheimer/irods-php.git](https://github.com/stefan-wolfsheimer/irods-php.git)
* iRODS storage driver for OwnCloud 
  [https://github.com/stefan-wolfsheimer/owncloud-files_irods.git](https://github.com/stefan-wolfsheimer/owncloud-files_irods.git)
* iRODS meta data App for OwnCloud
  [https://github.com/stefan-wolfsheimer/owncloud-irods_meta.git](https://github.com/stefan-wolfsheimer/owncloud-irods_meta.git)

## Quick start

### requirements
* docker
* docker-compose

### Start docker
```
docker-compose pull
docker-compose build
docker-compose up
```
When the owncloud container is up and running and owncloud is reachable on localhost,
enable and configure the iRODS apps

```
docker exec owncloud-irods-apps_owncloud_1 /oc_setup.sh
```

### Using the apps

Login as mara (password mara) on localhost. Upload files to *ResearchData* and
edit meta data.

## Troubleshooting 


### iRODS log
```
docker exec owncloud-irods-apps_owncloud_1 tail -f /mnt/data/files/owncloud.log
```
