import sys
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from pyspark.sql.types import StructType, StructField, StringType

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)


def generate_data():
    schema = StructType([
        StructField("first_name", StringType(), True),
        StructField("last_name", StringType(), True)
    ])
    data = [('Bob', 'White'), ('Alice', 'Black')]
    return spark.createDataFrame(data=data, schema=schema)


def main():
    args = getResolvedOptions(sys.argv, ["JOB_NAME"])
    job.init(args["JOB_NAME"], args)
    df = generate_data()
    df.show()
    job.commit()


if __name__ == "__main__":
    main()
