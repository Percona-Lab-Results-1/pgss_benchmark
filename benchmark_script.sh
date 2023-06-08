#!/bin/bash

# Benchmark script for pg_stat_statements

# Set the database connection parameters
DB_HOST="localhost"
DB_PORT="5432"
DB_NAME="your_database_name"
DB_USER="your_username"
DB_PASSWORD="your_password"

# Set the number of iterations and concurrency level
ITERATIONS=100
CONCURRENCY=10

# Set the output file name
OUTPUT_FILE="benchmark_results.txt"

# Connect to the database and enable pg_stat_statements
psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c "CREATE EXTENSION IF NOT EXISTS pg_stat_statements;"

# Clear the existing pg_stat_statements data
psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c "SELECT pg_stat_statements_reset();"

# Run the benchmark
echo "Running benchmark..."
echo "Iterations: $ITERATIONS"
echo "Concurrency: $CONCURRENCY"
echo ""

for ((i=1; i<=$ITERATIONS; i++))
do
    echo "Iteration $i:"
    echo ""

    # Spawn concurrent connections and execute queries
    for ((j=1; j<=$CONCURRENCY; j++))
    do
        psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c "SELECT * FROM your_table_name WHERE your_column = $j;"
    done

    echo ""
done > $OUTPUT_FILE

echo "Benchmark completed. Results saved to $OUTPUT_FILE."

