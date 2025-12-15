FROM python:3.10

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY app.py app.py

CMD ["streamlit", "run", "app.py", "--server.address=0.0.0.0"]