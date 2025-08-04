import sys
from awsglue.context import GlueContext
from pyspark.context import SparkContext
from awsglue.utils import getResolvedOptions
from pyspark.sql.functions import to_date

# 1. Initialize Spark/Glue context
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session

# 2. Read JSON from S3 "raw" folder
raw_df = spark.read.json("s3://stock-raw-data-store/raw/")

# 3. Add partition column "date" (from timestamp)
# Assuming timestamp is ISO8601 like "2025-08-04T10:30:00Z"
cleaned_df = raw_df.withColumn("date", to_date("timestamp"))

# 4. Write as Parquet, partitioned by "date"
cleaned_df.write \
    .mode("overwrite") \
    .partitionBy("date") \
    .parquet("s3://stock-raw-data-store/cleaned/")
