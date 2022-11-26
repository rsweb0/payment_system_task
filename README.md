
### Setup

  `docker-compose up -d`

  `docker-compose exec app bundle exec rails db:setup`

  `docker-compose down`

### Running

  `docker-compose up -d`

### Stoping

  `docker-compose down`
### Check logs

  `docker-compose logs`

### Access Bash inside docker container

  `docker run --rm -it --entrypoint bash payment_system_task_app`

### Accessing Application


  Open localhost:3000 -> Login with below credentials

  `Email: merchant1@paymentsystem.com`

  `Password: payment@321`

### Accessing Admin panel

  Open localhost:3000/admin -> Login with below credentials

  `Email: admin@paymentsystem.com`

  `Password: payment@321`
