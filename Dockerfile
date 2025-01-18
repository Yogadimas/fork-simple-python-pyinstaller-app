FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .
RUN python -m py_compile sources/add2vals.py sources/calc.py

EXPOSE 5000

HEALTHCHECK CMD curl --fail http://localhost:5000/_stcore/health

ENTRYPOINT ["streamlit", "run", "sources/add_app.py", "--server.port=5000", "--server.address=0.0.0.0"]