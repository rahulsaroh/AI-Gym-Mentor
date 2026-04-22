import sqlite3
import datetime

def check_db():
    conn = sqlite3.connect('gym_log_local.sqlite')
    cursor = conn.cursor()
    
    print("Checking body_measurements table...")
    try:
        cursor.execute("SELECT date, weight, body_fat, chest FROM body_measurements ORDER BY date DESC LIMIT 20")
        rows = cursor.fetchall()
        for row in rows:
            # drift stores dates as unix timestamps in seconds
            date_ts = int(row[0])
            date_str = datetime.datetime.fromtimestamp(date_ts).strftime('%Y-%m-%d %H:%M:%S')
            print(f"Date: {date_str} (TS: {date_ts}), Weight: {row[1]}, BodyFat: {row[2]}, Chest: {row[3]}")
            
        if not rows:
            print("No measurements found.")
    except Exception as e:
        print(f"Error: {e}")
    finally:
        conn.close()

if __name__ == '__main__':
    check_db()
