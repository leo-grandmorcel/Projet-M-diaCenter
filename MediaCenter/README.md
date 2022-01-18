# Welcome to MediaCenter!

```
python3 -m venv venv
venv\Scripts\activate
pip install wheel
pip install -r requirements.txt
```
Supprimer le dossier migration
```
flask db init 
flask db migrate -m "users table"
flask db upgrade
```
