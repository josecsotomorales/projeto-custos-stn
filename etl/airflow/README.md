
## Airflow

### Requirements

- It is demanded to have Docker installed.
- See more at: [Docker](https://www.docker.com/get-started)

### Running Airflow with Docker Compose:

To run your Airflow local instance use the following command:
- `docker-compose -f ./docker/docker-compose.yml up`

Everytime it runs, it imports the connections and variables from the files `connections.json` and `variables.json`present in your `airflow/import` folder.

**Note**: When importing connections keep in mind that connections are not updated or replaced, they are just added if they don't exist. However, variables will replace the existing ones everytime there is a attempt of import.

View it running on:
http://localhost:8080/

### Deploy

Two Github Actions are utilized and organized to run in 5 steps. The first 4 steps will upload your code to the production EC2 instance. These are the folders and file uploaded to EC2:
 - airflow/dags
 - airflow/plugins
 - airflow/import
 - airflow/airflow.cfg

 The last step will run the a script responsible for importing Airflow connections and variables to production. The python script `import.py` can be found in the `airflow/import` folder. And it will run inside EC2 using `connections.json` and `variables.json` as source of content.