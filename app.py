from flask import Flask, request, render_template
from flask_mysqldb import MySQL
from datetime import datetime

import os
from dotenv import load_dotenv # For loading .env components

load_dotenv()

# Retrieve variables
HOST = os.getenv("HOST")
DB = os.getenv("DB")
USER = os.getenv("USER")
PASSWORD = os.getenv("PASSWORD")

from extern import fetch # fetch file

app = Flask(__name__)

# MySQL configurations
app.config['MYSQL_HOST'] = HOST
app.config['MYSQL_PORT'] = 3306
app.config['MYSQL_USER'] = USER
app.config['MYSQL_PASSWORD'] = PASSWORD
app.config['MYSQL_DB'] = DB

mysql = MySQL(app)


CLUB_LEADERSHIP: str = "Club Leadership"
CLUB_ANGLAIS: str = "Club Anglais"
CLUB_PRESSE: str = "Club Presse"
CLUB_INFORMATIQUE: str = "Club Informatique"


club_ids = {}
with app.app_context():  # Ensure the application context is active
    club_ids = fetch.get_club_ids(mysql)


@app.route('/')
def index():
    return render_template('index.html', club_ids = club_ids)


@app.route('/leadclub', methods=['GET'])
def lead():
    if request.method == 'POST':
        pass
    else:
        date = request.args.get('date', default=None)
    club_event_count = 0
    academic_year = fetch.get_academic_year()
    # today = datetime.today().strftime("%m/%d/%Y")
    with app.app_context():
        club_event_count = fetch.fetch_club_event_count(mysql=mysql, club_id=club_ids.get(CLUB_LEADERSHIP))
        club_event_type_count = fetch.fetch_club_event_type_count(mysql=mysql, club_id=club_ids.get(CLUB_LEADERSHIP))
        club_last_event_date = fetch.fetch_club_last_event_date(mysql=mysql, club_id=club_ids.get(CLUB_LEADERSHIP))
        club_last_event_nb_participants = fetch.fetch_club_last_event_nb_participants(mysql=mysql, club_id=club_ids.get(CLUB_LEADERSHIP))
        growth, percent = fetch.fetch_club_last_event_nb_participants_growth(mysql=mysql, club_id=club_ids.get(CLUB_LEADERSHIP))
        average_nb_participants = fetch.fetch_club_average_nb_participants(mysql=mysql, club_id=club_ids.get(CLUB_LEADERSHIP))
        max_nb_participants_date, max_nb_participants_value = fetch.fetch_club_max_nb_participants(mysql=mysql, club_id=club_ids.get(CLUB_LEADERSHIP))
        min_nb_participants_date, min_nb_participants_value = fetch.fetch_club_min_nb_participants(mysql=mysql, club_id=club_ids.get(CLUB_LEADERSHIP))
        best_class, best_count = fetch.fetch_club_best_class(mysql=mysql, club_id=club_ids.get(CLUB_LEADERSHIP))
        club_relative_popularity = fetch.fetch_club_relative_popularity(mysql=mysql, club_id=club_ids.get(CLUB_LEADERSHIP))
        club_general_popularity = fetch.fetch_club_general_popularity(mysql=mysql, club_id=club_ids.get(CLUB_LEADERSHIP))
        club_event_participation = fetch.fetch_club_event_participation(mysql=mysql, club_id=club_ids.get(CLUB_LEADERSHIP))
        club_event_days = fetch.fetch_club_event_days(mysql=mysql, club_id=club_ids.get(CLUB_LEADERSHIP))
        if date:
            o_date, event_type, event_participants_count = fetch.fetch_club_event_types_participants_count_for_date(mysql=mysql, club_id=club_ids.get(CLUB_LEADERSHIP), date=date)
            event_participants_count_per_class = fetch.fetch_club_event_particitants_count_per_class_for_date(mysql=mysql, club_id=club_ids.get(CLUB_LEADERSHIP), date=date)
            best_count_class_for_date, _ = fetch.fetch_club_event_particitants_count_best_class_for_date(mysql=mysql, club_id=club_ids.get(CLUB_LEADERSHIP), date=date)
            best_proportion_class_for_date, _ = fetch.fetch_club_event_particitants_proportion_best_class_for_date(mysql=mysql, club_id=club_ids.get(CLUB_LEADERSHIP), date=date)
            return render_template('lead.html',
                           academic_year = academic_year, 
                           club_event_count = club_event_count,
                           club_event_type_count = club_event_type_count,
                           club_last_event_date = club_last_event_date,
                           club_last_event_nb_participants = club_last_event_nb_participants,
                           growth = growth,
                           percent = percent,
                           average_nb_participants = average_nb_participants,
                           max_nb_participants_date = max_nb_participants_date,
                           max_nb_participants_value = max_nb_participants_value,
                           min_nb_participants_date = min_nb_participants_date,
                           min_nb_participants_value = min_nb_participants_value,
                           best_class = best_class,
                           best_count = best_count,
                           club_relative_popularity = club_relative_popularity,
                           club_general_popularity = club_general_popularity,
                           club_event_participation = club_event_participation,
                           club_event_days = club_event_days,
                           o_date = o_date,
                           event_type = event_type,
                           event_participants_count = event_participants_count,
                           event_participants_count_per_class = event_participants_count_per_class,
                           best_count_class_for_date = best_count_class_for_date,
                           best_proportion_class_for_date = best_proportion_class_for_date
                        )
    return render_template('lead.html',
                           academic_year = academic_year, 
                           club_event_count = club_event_count,
                           club_event_type_count = club_event_type_count,
                           club_last_event_date = club_last_event_date,
                           club_last_event_nb_participants = club_last_event_nb_participants,
                           growth = growth,
                           percent = percent,
                           average_nb_participants = average_nb_participants,
                           max_nb_participants_date = max_nb_participants_date,
                           max_nb_participants_value = max_nb_participants_value,
                           min_nb_participants_date = min_nb_participants_date,
                           min_nb_participants_value = min_nb_participants_value,
                           best_class = best_class,
                           best_count = best_count,
                           club_relative_popularity = club_relative_popularity,
                           club_general_popularity = club_general_popularity,
                           club_event_participation = club_event_participation,
                           club_event_days = club_event_days,
                           date = date
                        )


@app.route('/englishclub', methods=['GET'])
def english():
    return render_template('english.html')


@app.route('/pressclub', methods=['GET'])
def press():
    return render_template('press.html')


@app.route('/infoclub', methods=['GET'])
def info():
    return render_template('info.html')



if __name__ == '__main__':
    app.run(debug=True)




