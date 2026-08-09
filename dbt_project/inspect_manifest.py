import json

with open(r'D:\Projects\DBT Project\dbt_project\target\manifest.json', encoding='utf-8') as f:
    m = json.load(f)

print('Top-level keys:', list(m.keys())[:30])
print()
sources = m.get('sources', {})
print('Sources count:', len(sources))
for k, s in list(sources.items())[:12]:
    print(' ', k, '->', s.get('database'), s.get('schema'), s.get('name'))
