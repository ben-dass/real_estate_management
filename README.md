# Real Estate Management

## Docker commands

```bash
docker-compose -f local.yml down -v
docker-compose -f local.yml up --build -d --remove-orphans

docker-compose -f local.yml logs
docker-compose -f local.yml logs api
docker volume inspect api_estate_prod_postgres_data
```

## PIPENV install & usage

```bash
pip install pipenv
pipenv install
pipenv install --dev
pipenv shell
```

## Troubleshooting

### Flower & Django-Admin web access

There seems to be some sort of conflict accessing Flower and Django's Admin site.
Change the following in `config/urls.py` when trying to access each site respectively.

```python
# Flower
path(settings.LOGIN_URL, admin.site.urls),

# Django Admin
path(settings.ADMIN_URL, admin.site.urls),
```
