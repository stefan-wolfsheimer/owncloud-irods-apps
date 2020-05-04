#!/bin/bash

# enable app
occ app:enable files_irods
occ app:enable irods_meta

occ config:app:set --value yes core enable_external_storage
occ config:app:set --value yes files_external allow_user_mounting
occ config:app:set --value files_irods files_external user_mounting_backends


# create user
OC_PASS=mara occ user:add --password-from-env mara

# enable storage for user
occ files_external:create --user mara ResearchData files_irods password::password \
    -c "hostname=icat.irods" \
    -c "port=1247" \
    -c "zone=tempZone" \
    -c "using_pam=false" \
    -c "user=mara" \
    -c "password=mara"

# configure irods connection
mount_points=$( cat <<'EOF'
[
  {
    "name": "",
    "type": "Collection",
    "path": "{HOME}",
    "mount_point_config": {
      "acl": {
        "collection": {
          "view": { "level": ["1:"], "group": ["*"] }, 
          "edit": { "level": ["1:"], "group": ["*"] },
          "submit": { "level": ["1:"], "group": ["*"] }
        },
        "object": {
          "view": false,
          "edit": false,
          "submit": false
        }
      }
    }
  }
]
EOF
)

schema=$( cat << 'EOF'
{
  "type": "object",
  "required": [
    "projectid",
    "status",
    "title",
    "pid",
    "authors",
    "dateofcreation",
    "userights",
    "releasedate",
    "ownership"
  ],
  "properties": {
    "projectid": {
      "type": "string",
      "title": "ProjectID"
    },
    "title": {
      "type": "string",
      "title": "Title"
    },
    "pid": {
      "type": "string",
      "title": "PID",
      "readOnly": true
    },
    "authors": {
      "type": "string",
      "title": "Authors"
    },
    "dateofcreation": {
      "type": "string",
      "format": "date",
      "title": "Date Of Creation"
    },
    "ownership": {
      "type": "string",
      "title": "Ownership"
    },
    "releasedate": {
      "type": "string",
      "format": "date",
      "title": "Release Date"
    }
  }
}
EOF
)

occ config:app:set --value="$mount_points" files_irods irods_mount_points
occ config:app:set --value="$schema" irods_meta json_schema



