-- Fetch the 5 longest-tenured users
SELECT * 
FROM users
ORDER BY created_at
LIMIT 5;

-- Determine the day of the week with the highest user registrations
SELECT DATE_FORMAT(created_at, '%W') AS registration_day, COUNT(*) AS total_registrations
FROM users
GROUP BY registration_day
ORDER BY total_registrations DESC;

-- Determine the day of the week with the highest user registrations
SELECT DAYNAME(created_at) AS registration_day, COUNT(*) AS total_registrations
FROM users
GROUP BY registration_day
ORDER BY total_registrations DESC
LIMIT 2;

-- Identify users who have not posted any photos
SELECT username
FROM users
LEFT JOIN photos ON users.id = photos.user_id
WHERE photos.id IS NULL;

-- Find the photo with the highest number of likes and the user who posted it
SELECT users.username, photos.id, photos.image_url, COUNT(likes.id) AS total_likes
FROM likes
JOIN photos ON photos.id = likes.photo_id
JOIN users ON users.id = photos.user_id
GROUP BY photos.id
ORDER BY total_likes DESC
LIMIT 1;

-- Find the photo with the highest number of likes
SELECT users.username, photos.id, photos.image_url, COUNT(likes.id) AS total_likes
FROM photos
JOIN likes ON likes.photo_id = photos.id
JOIN users ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total_likes DESC
LIMIT 1;

-- Calculate the average number of posts per user
SELECT ROUND((SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users), 2) AS avg_posts_per_user;

-- Rank users by the number of their posts, in descending order
SELECT users.username, COUNT(photos.image_url) AS post_count
FROM users
JOIN photos ON users.id = photos.user_id
GROUP BY users.id
ORDER BY post_count DESC;

-- Calculate the total number of posts by all users
SELECT SUM(post_count) AS total_posts
FROM (
    SELECT users.username, COUNT(photos.image_url) AS post_count
    FROM users
    JOIN photos ON users.id = photos.user_id
    GROUP BY users.id
) AS user_post_counts;

-- Count the number of users who have made at least one post
SELECT COUNT(DISTINCT users.id) AS active_users
FROM users
JOIN photos ON users.id = photos.user_id;

-- Identify the top 5 most frequently used hashtags
SELECT tags.tag_name, COUNT(tags.tag_name) AS usage_count
FROM tags
JOIN photo_tags ON tags.id = photo_tags.tag_id
GROUP BY tags.id
ORDER BY usage_count DESC;

-- Find users who have liked every photo on the site
SELECT users.id, users.username, COUNT(likes.user_id) AS likes_count
FROM users
JOIN likes ON users.id = likes.user_id
GROUP BY users.id
HAVING likes_count = (SELECT COUNT(*) FROM photos);

-- Identify users who have never commented on a photo
SELECT users.username
FROM users
LEFT JOIN comments ON users.id = comments.user_id
GROUP BY users.id
HAVING COUNT(comments.id) = 0;

-- Count the number of users who have never commented on a photo
SELECT COUNT(*) AS users_without_comments
FROM (
    SELECT users.username
    FROM users
    LEFT JOIN comments ON users.id = comments.user_id
    GROUP BY users.id
    HAVING COUNT(comments.id) = 0
) AS users_without_comments_count;

-- Calculate the percentage of users who have either never commented or commented on every photo
SELECT 
    no_comments.total_users AS no_commenters,
    (no_comments.total_users / total_users.total_count) * 100 AS no_commenters_percentage,
    all_likes.total_users AS all_likers,
    (all_likes.total_users / total_users.total_count) * 100 AS all_likers_percentage
FROM
    (SELECT COUNT(*) AS total_users FROM users) AS total_users,
    (SELECT COUNT(*) AS total_users FROM (
        SELECT users.id
        FROM users
        LEFT JOIN comments ON users.id = comments.user_id
        GROUP BY users.id
        HAVING COUNT(comments.id) = 0
    ) AS no_comments_users) AS no_comments,
    (SELECT COUNT(*) AS total_users FROM (
        SELECT users.id
        FROM users
        JOIN likes ON users.id = likes.user_id
        GROUP BY users.id
        HAVING COUNT(likes.user_id) = (SELECT COUNT(*) FROM photos)
    ) AS all_likes_users) AS all_likes;

-- Find users who have made at least one comment on a photo
SELECT users.username, comments.comment_text
FROM users
LEFT JOIN comments ON users.id = comments.user_id
GROUP BY users.id
HAVING COUNT(comments.id) > 0;

-- Count the number of users who have made at least one comment
SELECT COUNT(*) AS users_with_comments
FROM (
    SELECT users.username
    FROM users
    LEFT JOIN comments ON users.id = comments.user_id
    GROUP BY users.id
    HAVING COUNT(comments.id) > 0
) AS users_with_comments_count;

-- Calculate the percentage of users who have never commented or have commented at least once
SELECT 
    no_comments.total_users AS no_commenters,
    (no_comments.total_users / total_users.total_count) * 100 AS no_commenters_percentage,
    has_comments.total_users AS commenters,
    (has_comments.total_users / total_users.total_count) * 100 AS commenters_percentage
FROM
    (SELECT COUNT(*) AS total_users FROM users) AS total_users,
    (SELECT COUNT(*) AS total_users FROM (
        SELECT users.id
        FROM users
        LEFT JOIN comments ON users.id = comments.user_id
        GROUP BY users.id
        HAVING COUNT(comments.id) = 0
    ) AS no_comments_users) AS no_comments,
    (SELECT COUNT(*) AS total_users FROM (
        SELECT users.id
        FROM users
        LEFT JOIN comments ON users.id = comments.user_id
        GROUP BY users.id
        HAVING COUNT(comments.id) > 0
    ) AS has_comments_users) AS has_comments;
