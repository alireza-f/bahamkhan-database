USE bahamkhan;

SELECT post_id, post_title, category_name
FROM blogpost, category
WHERE blogpost.category_id = category.category_id
AND category.category_name IN ('History', 'Chemistry');


SELECT DISTINCT siteuser.first_name, siteuser.last_name, group_name, city.city
FROM sgroup, city, membership, siteuser
WHERE sgroup.sgroup_id = membership.sgroup_id
AND city.city_id = siteuser.city_id
AND siteuser.siteuser_id = membership.siteuser_id
AND city.city IN ('Tabriz', 'Urmia', 'Salmas');


SELECT siteuser.first_name, COUNT(*)
FROM siteuser, blogpost
WHERE siteuser.siteuser_id = blogpost.siteuser_id
GROUP BY siteuser.first_name
HAVING COUNT(*) > 1;



SELECT sgroup.group_name, count(*) AS number_of_members
FROM sgroup, membership, siteuser
WHERE sgroup.sgroup_id = membership.sgroup_id
AND siteuser.siteuser_id = membership.siteuser_id
GROUP BY sgroup.group_name
ORDER BY number_of_members DESC;



SELECT groupmessage.body
FROM groupmessage
WHERE groupmessage.body LIKE '%done%';


SELECT siteuser.first_name, siteuser.last_name, sgroup.group_name, groupmessage.body
FROM groupmessage, siteuser, membership, sgroup
WHERE groupmessage.message_id = membership.message_id
AND siteuser.siteuser_id = membership.siteuser_id
AND sgroup.sgroup_id = membership.sgroup_id
AND membership.sgroup_id = 1;



SELECT siteuser.first_name, siteuser.last_name, sgroup.group_name, groupmessage.body
FROM groupmessage, siteuser, membership, sgroup
WHERE groupmessage.message_id = membership.message_id
AND siteuser.siteuser_id = membership.siteuser_id
AND sgroup.sgroup_id = membership.sgroup_id
AND membership.siteuser_id = 6;


SELECT blogpost.post_title, siteuser.first_name, siteuser.last_name
FROM blogpost, siteuser, city
WHERE blogpost.siteuser_id = siteuser.siteuser_id
AND siteuser.city_id = city.city_id
AND city.city IN (
    SELECT city.city
    FROM city, siteuser
    WHERE city.city_id = 9
);

SELECT siteuser.first_name, siteuser.last_name, sgroup.group_name, groupmessage.create_date, groupmessage.body
FROM groupmessage, siteuser, membership, sgroup
WHERE groupmessage.message_id = membership.message_id
AND siteuser.siteuser_id = membership.siteuser_id
AND sgroup.sgroup_id = membership.sgroup_id
AND siteuser.siteuser_id IN (
    SELECT siteuser_id
    FROM siteuser, city
    WHERE city.city_id = siteuser.city_id
    AND city.city = 'Tabriz'
);


UPDATE membership
SET membership_status = 1
WHERE siteuser_id = (
    SELECT DISTINCT siteuser_id
    FROM siteuser, city
    WHERE city.city_id = siteuser.city_id
    AND city.city_id IN (
        SELECT DISTINCT city.city_id
        FROM city, siteuser
        WHERE city.city LIKE 'A%'
    )
);


SELECT siteuser.first_name, sgroup.group_name, groupmessage.create_date, groupmessage.body
FROM groupmessage, siteuser, membership, sgroup
WHERE groupmessage.message_id = membership.message_id
AND siteuser.siteuser_id = membership.siteuser_id
AND sgroup.sgroup_id = membership.sgroup_id
AND groupmessage.create_date BETWEEN '2005-01-01' AND '2005-12-31'
ORDER BY groupmessage.create_date ASC;



SELECT siteuser.first_name, siteuser.mobile, siteuser.city_id, city.city, sgroup.group_name
FROM siteuser, membership, city, sgroup
WHERE siteuser.siteuser_id = membership.siteuser_id
AND siteuser.city_id = city.city_id
AND membership.sgroup_id = sgroup.sgroup_id
AND membership.membership_status = 0;


SELECT siteuser.first_name, sgroup.group_name, sgroup.create_date
FROM sgroup, siteuser, membership
WHERE sgroup.sgroup_id = membership.sgroup_id
AND siteuser.siteuser_id = membership.siteuser_id
AND sgroup.create_date < '2006-01-01'
ORDER BY sgroup.group_name ASC;


UPDATE membership
SET membership_status = 0
WHERE siteuser_id IN (
    SELECT DISTINCT siteuser_id
    FROM siteuser, membership, groupmessage
    WHERE siteuser.siteuser_id = membership.message_id
    AND membership.message_id = groupmessage.message_id
    AND groupmessage.body LIKE '%advertisment%'
);

DELETE FROM siteuser
WHERE siteuser.siteuser_id NOT IN (
    SELECT siteuser.siteuser_id
    FROM siteuser, membership, groupmessage
    WHERE siteuser.siteuser_id = membership.siteuser_id
    AND membership.message_id = groupmessage.message_id
    AND groupmessage.create_date > '2006-01-01';
);


SELECT siteuser.siteuser_id, groupmessage.create_date
FROM siteuser, membership, groupmessage
WHERE siteuser.siteuser_id = membership.siteuser_id
AND membership.message_id = groupmessage.message_id
AND groupmessage.create_date > '2006-01-01';