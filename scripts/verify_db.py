import sqlite3
conn=sqlite3.connect('E:/db_fixed.sqlite')
c=conn.cursor()
c.execute("SELECT name FROM sqlite_master WHERE type='table'")
tables=c.fetchall()
print('Tables:', tables)
for t, in tables:
    c.execute('SELECT COUNT(*) FROM '+t)
    print(f'  {t}: {c.fetchone()[0]}')
c.execute('SELECT * FROM exercises LIMIT 3')
print('Columns:', [d[0] for d in c.description])
for row in c.fetchall():
    print(row)
conn.close()
print('Done')
