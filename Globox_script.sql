-- Main Objectives

            SELECT users.id AS id,
                   groups.join_dt As join_date,
                   users.country AS country,
                   COALESCE(users.gender,'Missing') AS gender,
                   COALESCE(groups.device,'Missing') AS device,
                   groups.group,
              SUM(case WHEN activity.uid is Null THEN 0
                     WHEN activity.uid is NOT NULL THEN 1 END) AS purchase_per_client,
              COALESCE(SUM(activity.spent), 0) AS spent 
            FROM users
            FULL JOIN groups
            ON users.id = groups.uid
            FULL JOIN activity
            ON activity.uid=users.id 
            GROUP BY groups.uid,users.id

-- Advanced tasks

SELECT users.id AS id,
                   activity.dt As purchase_date,
                   COALESCE(activity.device,'Missing') AS purchase_device,
                   COALESCE(activity.spent,0) AS spent,
                   COALESCE(users.gender,'Missing') AS gender,
                   COALESCE(users.country,'Missing') AS country,
                   COALESCE(groups.device,'Missing') AS join_device,
                   groups.join_dt AS join_date,
                   groups.group
            FROM activity
            FULL JOIN users
            ON users.id = activity.uid
            RIGHT JOIN groups
            ON users.id=groups.uid;
