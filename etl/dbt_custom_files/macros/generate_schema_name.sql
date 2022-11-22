{% macro generate_schema_name(custom_schema_name, node) -%}

    {#
        Override the original macro:
        https://about.gitlab.com/handbook/business-technology/data-team/platform/dbt-guide/#schemas

        dbt docs:
        https://docs.getdbt.com/docs/building-a-dbt-project/building-models/using-custom-schemas#changing-the-way-dbt-generates-a-schema-name
    #}

    {%- if custom_schema_name is none -%}

        {{ target.schema.lower() | trim }}

    {%- else -%}

        {{ custom_schema_name.lower() | trim }}

    {%- endif -%}
    
{%- endmacro %}
