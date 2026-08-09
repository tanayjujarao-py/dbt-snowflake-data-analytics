{% macro multiply(col1,col2) %}

    {{ col1 | replace("'", "") }} * {{ col2 | replace("'", "") }}

{% endmacro %}