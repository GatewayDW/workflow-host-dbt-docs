"""
This script updates the 'manifest.json' and 'catalog.json' file in a dbt project.
To test the result:
    1. Run 'dbt docs generate'
    2. Run 'python /home/src/mage/dbt/ab_gaming/upd_catalog_manifest.py'
    3. Run 'dbt docs serve'
    4. Verify that the elements were erased
"""
import json


def update_docs_values(file_path, update_function):
    try:
        # Load the catalog.json file
        with open(file_path, "r") as file:
            catalog_data = json.load(file)

        # Iterate through the keys and apply the update function to each table
        for table in catalog_data.get("nodes", {}).values():
            update_function(table)
        for table in catalog_data.get("sources", {}).values():
            update_function(table)
        for table in catalog_data.get("exposures", {}).values():
            update_function(table)

        # Write the updated data back to the catalog.json file
        with open(file_path, "w") as file:
            json.dump(catalog_data, file, indent=4)

        print(f"Successfully updated values using {update_function.__name__}.")

    except Exception as e:
        print(f"Error: {e}")


def empty_catalog(table):
    table["metadata"] = {}


def empty_manifest(table):
    table["database"] = ""
    table["schema"] = ""
    table["description"] = ""

    # Column description
    for col in table.get("columns", {}).values():
        col["description"] = ""

    # Exposures part
    table["owner"] = {}
    table["url"] = ""


# Example usage
file_path = "target/catalog.json"
update_docs_values(file_path, empty_catalog)

file_path = "target/manifest.json"
update_docs_values(file_path, empty_manifest)
