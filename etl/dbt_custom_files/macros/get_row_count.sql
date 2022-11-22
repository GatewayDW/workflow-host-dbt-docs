{% macro get_row_count(query, log_query=false, log_result=false) %}

    {#
        --Ref: https://docs.getdbt.com/reference/dbt-jinja-functions/execute
        --When you execute a dbt compile or dbt run command, dbt:
        --1. Reads all of the files in your project and generates a "manifest" comprised of models, tests, and other graph nodes present in your project. During this phase, dbt uses the ref statements it finds to generate the DAG for your project. No SQL is run during this phase, and execute == False.
        --2. Compiles (and runs) each node (eg. building models, or running tests). SQL is run during this phase, and execute == True.
    #}

    {% if log_query and var('is_debug') %}
    {{ log("query: \n" ~ query, info=True) }}
    {% endif %}

    {% set results = run_query(query) %}
    {% if execute %}
    {% set rc = results.columns[0].values()[0] %}
    {% else %}
    {% set rc = 0 %}
    {% endif %}

    {% if log_result and var('is_debug') %}
    {{ log("row_count: " ~ rc ~ "\n", info=True) }}
    {% endif %}

    {{ return(rc) }}
    
{% endmacro %}