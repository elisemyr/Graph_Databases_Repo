
// SAMPLE DATA - to try on Neo4j


// Create Users
CREATE (u1:User {username: 'alicem', name: 'Alice'})
CREATE (u2:User {username: 'miah', name: 'Mia'})
CREATE (u3:User {username: 'saadn', name: 'Saad'})
CREATE (u4:User {username: 'elisedy', name: 'Elise'})
CREATE (u5:User {username: 'stephanem', name: 'Stephane'})


// Create Tweets
CREATE (t1:Tweet {id: 't1', text: 'Hi, this is my first tweet', createdAt: '2021-01-15T10:00:00'})
CREATE (t2:Tweet {id: 't2', text: 'i am learning neo4j', createdAt: '2023-02-20T14:30:00'})
CREATE (t3:Tweet {id: 't3', text: 'gds plugin installed', createdAt: '2024-03-10T09:15:00'})
CREATE (t4:Tweet {id: 't4', text: 'bonjour', createdAt: '2023-04-05T16:45:00'})
CREATE (t5:Tweet {id: 't5', text: 'PageRank algorithm', createdAt: '2021-05-12T11:20:00'})


// Create FOLLOWS relationships
CREATE (u1)-[:FOLLOWS]->(u2)
CREATE (u1)-[:FOLLOWS]->(u3)
CREATE (u2)-[:FOLLOWS]->(u3)
CREATE (u2)-[:FOLLOWS]->(u4)
CREATE (u3)-[:FOLLOWS]->(u1)
CREATE (u3)-[:FOLLOWS]->(u4)
CREATE (u3)-[:FOLLOWS]->(u5)
CREATE (u4)-[:FOLLOWS]->(u5);

// Create POSTED relationships
CREATE (u1)-[:POSTED]->(t1)
CREATE (u2)-[:POSTED]->(t2)
CREATE (u3)-[:POSTED]->(t3)
CREATE (u4)-[:POSTED]->(t4)
CREATE (u5)-[:POSTED]->(t5);

// Create RETWEETS relationships
CREATE (u2)-[:RETWEETS]->(t1)
CREATE (u3)-[:RETWEETS]->(t1)
CREATE (u4)-[:RETWEETS]->(t2)
CREATE (u5)-[:RETWEETS]->(t2);

// Create MENTIONS relationships
CREATE (t2)-[:MENTIONS]->(u3)
CREATE (t3)-[:MENTIONS]->(u1)
CREATE (t4)-[:MENTIONS]->(u2);

// Verify data
MATCH (n)
RETURN labels(n) as NodeType, count(n) as Count
UNION ALL
MATCH ()-[r]->()
RETURN type(r) as RelationshipType, count(r) as Count;

