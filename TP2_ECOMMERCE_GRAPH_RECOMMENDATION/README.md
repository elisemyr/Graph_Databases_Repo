to execute etl.py : docker compose exec -T postgres psql -U postgres -d shop -c "\dt"
step 2 : 
docker compose exec -T postgres psql -U postgres -d shop -c "SELECT count(*) FROM customers;"
docker compose exec -T postgres psql -U postgres -d shop -c "SELECT count(*) FROM orders;"
docker compose exec -T postgres psql -U postgres -d shop -c "SELECT count(*) FROM events;"

part 6 : 

Connect URL: neo4j://localhost:7687 
Username: neo4j
Password: neo4j1234

MATCH (c:Customer) RETURN count(c) AS customers; # returns 3
MATCH (p:Product) RETURN count(p) AS products; #returns 4
MATCH (c:Customer)-[:PLACED]->(o:Order) RETURN count(*) AS orders; #returns 4



# curl http://127.0.0.1:8000/health {"status":"ok"}
ETL done.

# NOTES

1.
The system would recommend products which match the items customers have purchased before. The content-based approach enables product recommendation through feature comparison between products including their category and brand information. The system uses collaborative filtering to connect customers through their purchase history and recommends products which other customers with similar buying behavior have purchased. The graph structure of Neo4j enables users to execute relationship-based queries for product recommendation.

2/
The project needs additional development to achieve production readiness through performance optimization and system reliability enhancement. The ETL process should run automatically while database queries become faster through indexing and Docker health checks should be implemented. The system requires password protection for database access through environment variables and it needs automated testing and monitoring systems. The system requires cloud deployment with CI/CD pipelines to achieve simple maintenance and performance scaling.