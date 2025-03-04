# Pull base image
FROM python:3.11.5-slim-bullseye

RUN apt-get update && apt-get install -y postgresql-client
# Set environment variables
ENV PIP_DISABLE_PIP_VERSION_CHECK 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
WORKDIR /code

# Install dependencies
COPY ./requirements.txt .
RUN pip install -r requirements.txt


# Copy project
COPY . .

RUN python /code/manage.py collectstatic --noinput

COPY entrypoint.sh /code/
RUN chmod +x /code/entrypoint.sh
RUN sed -i 's/\r$//g' /code/entrypoint.sh
# Set the entrypoint
ENTRYPOINT ["/code/entrypoint.sh"]

#SSSSENTRYPOINT ["sh", "/entrypoint.sh"]

#COPY ./entrypoint.sh .
#RUN sed -i 's/\r$//g' /code/entrypoint.sh
#RUN chmod +x /code/entrypoint.sh



##ENTRYPOINT ["/code/entrypoint.sh"]