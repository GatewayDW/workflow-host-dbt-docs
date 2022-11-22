{%- macro get_schema(model_name='', except_column=[], except_datatype=[]) -%}

    {%- set model_name_cleanse = model_name.replace('[', '').replace(']', '').replace('"', '') -%}
    {%- set table_catalog = model_name_cleanse.split('.')[0] -%}
    {%- set table_schema = model_name_cleanse.split('.')[1] -%}
    {%- set table_name = model_name_cleanse.split('.')[2] -%}

    {%- set query %}
    SELECT
        TABLE_CATALOG,
        TABLE_SCHEMA,
        TABLE_NAME,
        COLUMN_NAME,
        DATA_TYPE,
        replace(convert(varchar(10), CHARACTER_MAXIMUM_LENGTH), '-1', 'max') as CHARACTER_MAXIMUM_LENGTH,
        CASE IS_Nullable
            WHEN 'NO' THEN 'NOT NULL'
            WHEN 'YES' THEN 'NULL'
        END AS IS_Nullable
    FROM
        INFORMATION_SCHEMA.COLUMNS
    WHERE
        1 = 1
        AND TABLE_CATALOG = '{{table_catalog}}'
        AND TABLE_SCHEMA = '{{table_schema}}'
        AND TABLE_NAME = '{{table_name}}'
    {% endset -%}

    {% set q_result = run_query(query) %}

    {% set schema %}
        {
        {% for row in q_result -%}
            "{{row['COLUMN_NAME']}}": "{{ row['DATA_TYPE'] }}{%- if row['CHARACTER_MAXIMUM_LENGTH'] -%} ({{ row['CHARACTER_MAXIMUM_LENGTH']|string() }}) {%- endif %}"
            {%- if not loop.last -%},{%- endif %}
        {% endfor -%}
        }
    {% endset -%}

    {{ return(schema) }}
{%- endmacro -%}