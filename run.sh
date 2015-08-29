#!/bin/bash

DEBUG=True
SECRET_KEY='mys3cr3tk3y'
DATABASE_URL='postgres://u_bootcamp:p4ssw0rd@localhost:5432/bootcamp'

python manage.py syncdb
python manage.py runserver
