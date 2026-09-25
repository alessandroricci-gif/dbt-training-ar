{% macro hash(cols) -%}
    {%- if cols is none -%}
        NULL
    {%- else -%}
	    MD5(FORMAT("%T", STRUCT({{ cols|join(',') }})))
    {%- endif -%}
{% endmacro %}