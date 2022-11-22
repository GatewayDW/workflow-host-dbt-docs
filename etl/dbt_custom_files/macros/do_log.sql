{% macro do_log(msg, source=None) %}

{% if (execute) and (var('is_debug') == true) %}
    {% if not source %}
        {{ log(msg, info=True) }}
    {% else %}
        {{ log('['~ source ~ '] ' ~ msg, info=True) }}
    {% endif %}

{% endif %}

{% endmacro %}