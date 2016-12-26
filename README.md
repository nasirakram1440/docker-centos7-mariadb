# +++++++++++++++++++++++++++++++++++++++++++++
# MariaDB on Centos7 			      +
# +++++++++++++++++++++++++++++++++++++++++++++
<font style="color:green">
HOW TO BAKE A NEW IMAGE BASED ON THE DOCKER FILE
- docker build -t image_name:tag_name .

HOW TO RUN THE NEWLY BAKED IMAGE
- docker run -it image_name:tag_name /bin/bash

HOW TO START MARIADB WHEN THE CONTAINER IS INITIALIZED
- docker run -it -e MYSQL_START_DB=yes image_name:tag_name /bin/bash

HOW TO START AND SET ROOT MARIADB PASSWORD
- docker run -it -e MYSQL_START_DB=yes -e MYSQL_ROOT_PASSWORD=password image_name:tag_name /bin/bash

HOW TO SECURE MARIADB
- docker run -it -e MYSQL_SECURE_DB=yes image_name:tag_name /bin/bash

HOW TO MOUNT MARIADB DATADIR ON HOST FILE SYSTEM
- docker run -it -v /root/some_dir:/var/lib/mysql image_name:tag_name /bin/bash
</font>
