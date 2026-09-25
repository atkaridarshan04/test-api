FROM python:3.13-slim

ARG APP_ENV=dev
ENV APP_ENV=${APP_ENV}

WORKDIR /app
RUN pip install --no-cache-dir --upgrade pip setuptools

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app/ ./app/

RUN useradd --create-home --shell /usr/sbin/nologin appuser
USER appuser

EXPOSE 8000
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
