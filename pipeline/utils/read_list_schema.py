import os
import logging
import sqlalchemy
from sqlalchemy import create_engine, inspect
from sqlalchemy.orm import sessionmaker

# Initialize logger
logger = logging.getLogger(__name__)

def list_schemas(engine):
    try:
        inspector = inspect(engine)
        schemas = inspector.get_schema_names()
        return schemas
    except Exception as e:
        logger.error(f"Error listing schemas: {e}", exc_info=True)
        return []

def list_tables(engine, schema):
    try:
        inspector = inspect(engine)
        tables = inspector.get_table_names(schema=schema)
        return tables
    except Exception as e:
        logger.error(f"Error listing tables in schema {schema}: {e}", exc_info=True)
        return []