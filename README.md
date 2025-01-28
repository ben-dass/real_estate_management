# API

```bash
docker-compose -f local.yml down -v
docker-compose -f local.yml up --build -d --remove-orphans

docker-compose -f local.yml logs
docker-compose -f local.yml logs api
docker volume inspect api_estate_prod_postgres_data
```

```bash
pip install pipenv
pipenv install
pipenv install --dev
pipenv shell
```
