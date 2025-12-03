
Neo4j EDA Exercises

// EXERCISE 1: Find five random user nodes

MATCH (u:User)
RETURN u
LIMIT 5;


//EXERCISE 2: Find five random FOLLOWS relationships
MATCH (a:User)-[r:FOLLOWS]-> (b:User)
RETURN a, r, b
LIMIT 5;



//EXERCISE 3: Find the text property of three random Tweet nodes

MATCH (t:Tweet)
WITH t, rand() as r
ORDER BY r
RETURN t.text
LIMIT 3;


// EXERCISE 4: Generate a Cypher statement to visualize sample RETWEETS relationships

MATCH (u1:User)-[r:RETWEETS]->(t:Tweet)<-[:POSTED]-(u2:User)
RETURN u1, r, t, u2
LIMIT 10;


// EXERCISE 5: Why using merge and not create?

// Answer: 
// MERGE checks if a node/relationship exists before creating it, preventing duplicates. 
// CREATE always creates new nodes/relationships, which can lead to duplicates if run multiple times.
// MERGE is safer for data loading and prevents errors from duplicate keys.


// EXERCISE 6: Calculate the ratio of missing values for the createdAt node property of the Tweet nodes

MATCH (t:Tweet)
WITH 
    count(t) as totalTweets,
    count(t.createdAt) as tweetsWithDate,
    totalTweets - tweetsWithDate as missingDates
RETURN 
    totalTweets,
    missingDates,
    round(toFloat(missingDates) / totalTweets * 100, 2) as missingRatioPercent;


// EXERCISE 7: Count the number of relationships by their type

MATCH ()-[r]->()
RETURN type(r) as relationshipType, count(r) as count
ORDER BY count DESC;


// EXERCISE 8: Compare the text of an original tweet and its retweet

MATCH (u:User)-[:RETWEETS]->(retweet:Tweet)-[:RETWEETS]->(original:Tweet)
RETURN 
    u.username as retweeter,
    retweet.text as retweetText,
    original.text as originalText
LIMIT 5;



// EXERCISE 9: Calculate the distribution of tweets grouped by year created
MATCH (t:Tweet)
WHERE t.createdAt IS NOT NULL
WITH t, 
     CASE 
         WHEN t.createdAt CONTAINS '-' THEN split(t.createdAt, '-')[0]
         ELSE toString(date(t.createdAt).year)
     END as year
RETURN year, count(t) as tweetCount
ORDER BY year;

// Alternative using date functions:
MATCH (t:Tweet)
WHERE t.createdAt IS NOT NULL
WITH t, date(t.createdAt) as tweetDate
RETURN tweetDate.year as year, count(t) as tweetCount
ORDER BY year;


// EXERCISE 10: Use the MATCH clause in combination with the WHERE clause to select all the tweets that were created in 2021

MATCH (t:Tweet)
WHERE t.createdAt IS NOT NULL 
  AND (t.createdAt CONTAINS '2021' OR date(t.createdAt).year = 2021)
RETURN t.text, t.createdAt
LIMIT 10;


// EXERCISE 11: Return the top four days with the highest count of created tweets
MATCH (t:Tweet)
WHERE t.createdAt IS NOT NULL
WITH t, date(t.createdAt) as tweetDate
RETURN tweetDate as day, count(t) as tweetCount
ORDER BY tweetCount DESC
LIMIT 4;

// Alternative if createdAt is a string:
MATCH (t:Tweet)
WHERE t.createdAt IS NOT NULL
WITH t, 
     CASE 
         WHEN t.createdAt CONTAINS 'T' THEN split(t.createdAt, 'T')[0]
         ELSE split(t.createdAt, ' ')[0]
     END as day
RETURN day, count(t) as tweetCount
ORDER BY tweetCount DESC
LIMIT 4;


// EXERCISE 12: Count the number of users who were mentioned but haven't published a single tweet


MATCH (mentioned:User)<-[:MENTIONS]-()
WHERE NOT (mentioned)-[:POSTED]->()
RETURN count(DISTINCT mentioned) as mentionedButNoTweets;


// EXERCISE 13: Find the top five users with the most distinct tweets retweeted

MATCH (u:User)-[:RETWEETS]->(t:Tweet)
RETURN u.username, u.name, count(DISTINCT t) as distinctRetweets
ORDER BY distinctRetweets DESC
LIMIT 5;


// EXERCISE 14: Find the top five most mentioned users

MATCH (u:User)<-[:MENTIONS]-(t:Tweet)
RETURN u.username, u.name, count(t) as mentionCount
ORDER BY mentionCount DESC
LIMIT 5;


// EXERCISE 15: Find the 10 most followed Users

MATCH (u:User)<-[:FOLLOWS]-(follower:User)
RETURN u.username, u.name, count(follower) as followerCount
ORDER BY followerCount DESC
LIMIT 10;


// EXERCISE 16: Find the top 10 users who follow the most people

MATCH (u:User)-[:FOLLOWS]->(followed:User)
RETURN u.username, u.name, count(followed) as followingCount
ORDER BY followingCount DESC
LIMIT 10;

