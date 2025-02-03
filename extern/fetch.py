# fetch.py

# File for database fetching operations

from flask import jsonify
from flask_mysqldb import MySQL
from datetime import datetime


def get_academic_year():
    today = datetime.today()
    current_year = today.year
    if today.month >= 8:
        ay = f"{current_year} - {current_year + 1}"
    else:
        ay = f"{current_year - 1} - {current_year}"
    return ay

month_translation = {
    "January": "Janvier", "February": "Février", "March": "Mars", 
    "April": "Avril", "May": "Mai", "June": "Juin", 
    "July": "Juillet", "August": "Août", "September": "Septembre", 
    "October": "Octobre", "November": "Novembre", "December": "Décembre"
}

def get_club_ids(mysql: MySQL):
    try:
        cur = mysql.connection.cursor()
        cur.execute("SELECT id, name FROM clubs")  # Fetch club ID and name from the 'clubs' table
        clubs = cur.fetchall()
        cur.close()

        return {club[1]: club[0] for club in clubs}
    except Exception as e:
        return {"error": str(e)}


def fetch_club_event_count(mysql: MySQL, club_id: int):
    try:
        cur = mysql.connection.cursor()
        # Query to count events for the specified club
        cur.execute("SELECT COUNT(*) FROM events WHERE club_id = %s", (club_id,))
        result = cur.fetchone()
        cur.close()
        if result and result[0]:
            event_count = result[0]  # Fetch the count
        else:
            event_count = 0

        return event_count
    except Exception as e:
        return {"error": str(e)}
    
def fetch_club_event_type_count(mysql: MySQL, club_id: int):
    try:
        cur = mysql.connection.cursor()
        # Query to count events for the specified club
        cur.execute("SELECT COUNT(*) FROM event_types WHERE club_id = %s", (club_id,))
        result = cur.fetchone()
        cur.close()
        if result and result[0]:
            event_type_count = result[0]  # Fetch the count
        else:
            event_type_count = 0

        return event_type_count
    except Exception as e:
        return {"error": str(e)}
    
def fetch_club_last_event_date(mysql: MySQL, club_id: int):
    try:
        cur = mysql.connection.cursor()
        # Query to count events for the specified club
        cur.execute("SELECT event_date FROM events WHERE club_id = %s ORDER BY event_date DESC LIMIT 1", (club_id,))
        result = cur.fetchone()
        cur.close()

        if result and result[0]:
            last_event_date = result[0]
            last_event_date = datetime.strptime(str(last_event_date), "%Y-%m-%d")
            english_month = last_event_date.strftime("%B")
            french_month = month_translation[english_month]
            last_event_date = last_event_date.strftime(f"%d {french_month} %Y")
        else:
            last_event_date = "No events yet"

        return last_event_date
    except Exception as e:
        return {"error": str(e)}
    
def fetch_club_last_event_nb_participants(mysql: MySQL, club_id: int):
    try:
        cur = mysql.connection.cursor()
        # Query to count events for the specified club
        query = """
            SELECT COUNT(*) 
            FROM event_participants 
            WHERE event_id = (
                SELECT id 
                FROM events 
                WHERE club_id = %s 
                ORDER BY event_date DESC 
                LIMIT 1
            )
        """
        cur.execute(query, (club_id,))
        result = cur.fetchone()
        cur.close()
        if result and result[0]:
            last_event_nb_participants = result[0]  # Fetch the count
        else:
            last_event_nb_participants = 0

        return last_event_nb_participants
    except Exception as e:
        return {"error": str(e)}
    
def fetch_club_last_event_nb_participants_growth(mysql: MySQL, club_id: int):
    try:
        current = fetch_club_last_event_nb_participants(mysql=mysql, club_id=club_id) # number of participants last activity
        cur = mysql.connection.cursor()
        query = """
            SELECT COUNT(*) 
            FROM event_participants 
            WHERE event_id = (
                SELECT id 
                FROM events 
                WHERE club_id = %s 
                ORDER BY event_date DESC 
                LIMIT 1 OFFSET 1
            )
        """
        cur.execute(query, (club_id,))
        result = cur.fetchone()
        cur.close()
        if result and result[0]:
            previous = result[0]  # Fetch the count
        else:
            previous = 0
        
        growth = current - previous
        if previous != 0:
            percent = round(100 * growth/previous, 2)
        else:
            if growth == 0:
                percent = 0
            else:
                percent = "No"

        return growth, percent
    except Exception as e:
        return {"error": str(e)}
    
    
def fetch_club_average_nb_participants(mysql: MySQL, club_id: int):
    try:
        cur = mysql.connection.cursor()
        query = """
            SELECT AVG(participant_count)
            FROM (
                SELECT event_id, COUNT(*) AS participant_count
                FROM event_participants
                WHERE event_id IN (
                    SELECT id FROM events WHERE club_id = %s
                )
                GROUP BY event_id
            ) AS event_counts;
        """
        cur.execute(query, (club_id,))
        result = cur.fetchone()
        cur.close()
        if result and result[0]:
            avg = round(result[0])  # Fetch average number of participants
        else:
            avg = 0
        
        return avg
    except Exception as e:
        return {"error": str(e)}
    
def fetch_club_max_nb_participants(mysql: MySQL, club_id: int):
    try:
        cur = mysql.connection.cursor()
        query = """
            SELECT event_id, event_date, COUNT(*) AS participant_count
            FROM event_participants AS ep
            INNER JOIN events AS e
            ON ep.event_id = e.id
            WHERE event_id IN (
                SELECT id FROM events WHERE club_id = %s
            )
            GROUP BY event_id
            ORDER BY participant_count DESC
            LIMIT 1;
        """
        cur.execute(query, (club_id,))
        result = cur.fetchone()
        cur.close()
        if result:
            event_id, event_date, participant_count = result
        else:
            event_date = "No data"
            participant_count = 0
        
        return event_date, participant_count
    except Exception as e:
        return {"error": str(e)}
    

def fetch_club_min_nb_participants(mysql: MySQL, club_id: int):
    try:
        cur = mysql.connection.cursor()
        query = """
            SELECT event_id, event_date, COUNT(*) AS participant_count
            FROM event_participants AS ep
            INNER JOIN events AS e
            ON ep.event_id = e.id
            WHERE event_id IN (
                SELECT id FROM events WHERE club_id = %s
            )
            GROUP BY event_id
            ORDER BY participant_count ASC
            LIMIT 1;
        """
        cur.execute(query, (club_id,))
        result = cur.fetchone()
        cur.close()
        if result:
            event_id, event_date, participant_count = result
        else:
            event_date = "No data"
            participant_count = 0
        
        return event_date, participant_count
    except Exception as e:
        return {"error": str(e)}
    

def fetch_club_best_class(mysql: MySQL, club_id: int):
    try:
        cur = mysql.connection.cursor()
        query = """
            SELECT s.class, COUNT(*) AS class_count
            FROM event_participants AS ep
            INNER JOIN events AS e ON ep.event_id = e.id
            INNER JOIN students AS s ON ep.student_id = s.id
            WHERE event_id IN (
                SELECT id FROM events WHERE club_id = %s
            )
            GROUP BY s.class
            ORDER BY class_count DESC
            LIMIT 1
        """
        cur.execute(query, (club_id,))
        result = cur.fetchone()
        cur.close()
        if result:
            name, count = result
        else:
            name = "No data"
            count = 0
        
        return name, count
    except Exception as e:
        return {"error": str(e)}
    

def fetch_club_relative_popularity(mysql: MySQL, club_id: int):
    try:
        cur = mysql.connection.cursor()
        query = """
            SELECT popularity
            FROM (
                SELECT 
                    club_parts.id,
                    club_parts.name, 
                    club_parts.club_participations, 
                    100 * club_parts.club_participations / total_participations.total_count AS popularity
                FROM (
                    SELECT 
                        c.id,
                        c.name, 
                        COUNT(*) AS club_participations
                    FROM 
                        clubs AS c
                    INNER JOIN 
                        events AS e ON e.club_id = c.id
                    INNER JOIN 
                        event_participants AS ep ON ep.event_id = e.id
                    GROUP BY 
                        c.name
                ) AS club_parts
                CROSS JOIN (
                    SELECT COUNT(*) AS total_count
                    FROM event_participants
                ) AS total_participations
            ) AS club_ps
            WHERE club_ps.id = %s
        """
        cur.execute(query, (club_id,))
        result = cur.fetchone()
        cur.close()
        if result:
            popularity = round(result[0], 2)
        else:
            popularity = 0
        
        return popularity
    except Exception as e:
        return {"error": str(e)}
    
    
def fetch_club_general_popularity(mysql: MySQL, club_id: int):
    try:
        cur = mysql.connection.cursor()
        query = """
            SELECT 100 * unique_parts.unique_participants/total_students.total_count AS popularity
            FROM (
                SELECT 
                    COUNT(DISTINCT ep.student_id) AS unique_participants
                FROM 
                    clubs AS c
                INNER JOIN 
                    events AS e ON e.club_id = c.id
                INNER JOIN 
                    event_participants AS ep ON ep.event_id = e.id
                WHERE 
                    c.id = %s
            ) AS unique_parts
            CROSS JOIN (
                SELECT COUNT(*) AS total_count
                FROM students
            ) AS total_students;
        """
        cur.execute(query, (club_id,))
        result = cur.fetchone()
        cur.close()
        if result:
            popularity = round(result[0], 2)
        else:
            popularity = 0
        
        return popularity
    except Exception as e:
        return {"error": str(e)}
    


def fetch_club_event_participation(mysql: MySQL, club_id: int):
    try:
        cur = mysql.connection.cursor()
        query = """
            SELECT *
            FROM (
                SELECT e.event_date, et.name, COUNT(*) AS participants_count
                FROM event_participants AS ep
                INNER JOIN events AS e ON ep.event_id = e.id
                INNER JOIN clubs AS c ON e.club_id = c.id
                INNER JOIN event_types AS et ON e.event_type_id = et.id
                WHERE c.id = %s
                GROUP BY e.id
                ORDER BY e.event_date DESC
                LIMIT 7
            ) AS e
            ORDER BY e.event_date ASC;
        """
        cur.execute(query, (club_id,))
        results = cur.fetchall()
        cur.close()
        if not results:
            return {"error": "No data found"}
        event_dates = list(datetime.strftime(row[0], format="%d %b") for row in results) # sorted(set(row[0] for row in results))
        event_types = list(row[1] for row in results) # sorted(set(row[1] for row in results))
        event_counts = list(row[2] for row in results)

        return {
            "labels": event_dates, 
            "types": event_types, 
            "values": event_counts
        }

        # datasets = []
        # for event_type in event_types:
        #     counts = [
        #         next((row[2] for row in results if row[0] == date and row[1] == event_type), 0)
        #         for date in event_dates
        #     ]
        #     datasets.append({
        #         "label": event_type,
        #         "data": counts,
        #         "backgroundColor": f"rgba({255 - hash(event_type) % 256}, {hash(event_type) % 256}, 150, 0.7)"
        #     })

        # chart_data = {
        #     "labels": event_dates,  # X-axis labels
        #     "datasets": datasets    # Y-axis datasets
        # }
        # return chart_data
    except Exception as e:
        return {"error": str(e)}
    

def fetch_club_event_days(mysql: MySQL, club_id: int):
    try:
        cur = mysql.connection.cursor()
        query = """
            SELECT event_date
            FROM events
            WHERE club_id = %s;
        """
        cur.execute(query, (club_id,))
        results = cur.fetchall()
        cur.close()
        if not results:
            return {"error": "No data found"}
        event_dates = list(datetime.strftime(row[0], format="%m%d%Y") for row in results) # sorted(set(row[0] for row in results))
        # event_types = list(row[1] for row in results) # sorted(set(row[1] for row in results))
        # event_counts = list(row[2] for row in results)

        return {
            "labels": event_dates, 
            # "types": event_types, 
            # "values": event_counts
        }
    except Exception as e:
        return {"error": str(e)}
    

def fetch_club_event_types_participants_count_for_date(mysql: MySQL, club_id: int, date: str):
    f_date = datetime.strptime(date, "%m%d%Y").strftime("%Y-%m-%d")
    o_date = datetime.strptime(date, "%m%d%Y").strftime("%d %b %Y")
    try:
        cur = mysql.connection.cursor()
        query = """
            SELECT et.name, COUNT(*) AS participants_count
            FROM event_participants AS ep
            INNER JOIN events AS e ON ep.event_id = e.id
            INNER JOIN clubs AS c ON e.club_id = c.id
            INNER JOIN event_types AS et ON e.event_type_id = et.id
            WHERE c.id = %s AND e.event_date = %s
            GROUP BY e.id
            ORDER BY e.event_date DESC
        """
        cur.execute(query, (club_id, f_date))
        results = cur.fetchone()
        cur.close()

        if not results:
            return o_date, None, None
        
        # event_type = [row[0] for row in results]
        # event_participants_count = [row[1] for row in results]
        event_type, event_participants_count = results

        return o_date, event_type, event_participants_count
        
    except Exception as e:
        return {"error": str(e)}
    

def fetch_club_event_particitants_count_per_class_for_date(mysql: MySQL, club_id: int, date: str):
    f_date = datetime.strptime(date, "%m%d%Y").strftime("%Y-%m-%d")
    try:
        cur = mysql.connection.cursor()
        query = """
            SELECT s.class, COUNT(*) AS participants_count
            FROM event_participants AS ep
            INNER JOIN events AS e ON ep.event_id = e.id
            INNER JOIN clubs AS c ON e.club_id = c.id
            INNER JOIN event_types AS et ON e.event_type_id = et.id
            INNER JOIN students AS s ON s.id = ep.student_id
            WHERE c.id = %s AND e.event_date = %s
            GROUP BY s.class
            ORDER BY participants_count;
        """
        cur.execute(query, (club_id, f_date))
        results = cur.fetchall()
        cur.close()

        if not results:
            return {"error": "No data found"}
        event_classes = list(row[0] for row in results)
        event_participants_count = list(row[1] for row in results)

        return {
            "classes": event_classes, 
            "values": event_participants_count
        }
        
    except Exception as e:
        return {"error": str(e)}
    

def fetch_club_event_particitants_count_best_class_for_date(mysql: MySQL, club_id: int, date: str):
    f_date = datetime.strptime(date, "%m%d%Y").strftime("%Y-%m-%d")
    try:
        cur = mysql.connection.cursor()
        query = """
            SELECT s.class, COUNT(*) AS participants_count
            FROM event_participants AS ep
            INNER JOIN events AS e ON ep.event_id = e.id
            INNER JOIN clubs AS c ON e.club_id = c.id
            INNER JOIN event_types AS et ON e.event_type_id = et.id
            INNER JOIN students AS s ON s.id = ep.student_id
            WHERE c.id = %s AND e.event_date = %s
            GROUP BY s.class
            ORDER BY participants_count DESC
            LIMIT 1;
        """
        cur.execute(query, (club_id, f_date))
        results = cur.fetchone()
        cur.close()

        if not results:
            return {"error": "No data found"}
        
        return results
        
    except Exception as e:
        return {"error": str(e)}
    

def fetch_club_event_particitants_proportion_best_class_for_date(mysql: MySQL, club_id: int, date: str):
    f_date = datetime.strptime(date, "%m%d%Y").strftime("%Y-%m-%d")
    try:
        cur = mysql.connection.cursor()
        query = """
            SELECT class, 100*participants_count/class_students AS proportion
            FROM (
                SELECT *
                FROM (
                    SELECT s.class, COUNT(*) AS participants_count
                    FROM event_participants AS ep
                    INNER JOIN events AS e ON ep.event_id = e.id
                    INNER JOIN clubs AS c ON e.club_id = c.id
                    INNER JOIN event_types AS et ON e.event_type_id = et.id
                    INNER JOIN students AS s ON s.id = ep.student_id
                    WHERE c.id = %s AND e.event_date = %s
                    GROUP BY s.class
                    ORDER BY participants_count DESC
                ) AS cc
                INNER JOIN (
                    SELECT s.class AS sclass, COUNT(*) AS class_students
                    FROM students AS s
                    GROUP BY s.class
                ) AS ce
                WHERE ce.sclass = cc.class
            ) AS globals
            ORDER BY proportion DESC
            LIMIT 1;
        """
        cur.execute(query, (club_id, f_date))
        results = cur.fetchone()
        cur.close()

        if not results:
            return {"error": "No data found"}
        
        return results
        
    except Exception as e:
        return {"error": str(e)}




