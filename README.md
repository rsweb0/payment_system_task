
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

### Covered Points

1. Use the latest stable Rails version
2. Use Slim view engine
3. Frontend Framework
    - React JS
    - Bootstrap
4. Cover changes with Rspec tests
6. Create factories with FactoryBot
7. Apply Rubocop and other linters
8. For Rails models, try to use:
    - Single Table Inheritance (STI)
    - Polymorphic associations
    - Scopes
    - Validations and custom validator object, if necessary
    - Factory pattern
    - Demonstrate meta-programming by generating/defining similar predicate
    - methods
    - private section
9. For Rails controllers
    - Keep them thin
    - Encapsulate business logic in interactors (4)
10. Presentation:
    - Use partials
11. Try to showcase background and cron jobs
12. Dockerize the Application
    - Create the application in the Docker environment
    - Use application and database containers
    - Use Docker compose - https://docs.docker.com/compose

Payment System Task

  1. Relations:

      1.1 Ensure you have merchant and admin user roles (UI)

      1.2 Merchants have many payment transactions of different types

      1.3 Transactions are related (belongs_to)

        - You can also have follow/referenced transactions that refer/depend to/on the initial transaction

          - Authorize Transaction -> Charge Transaction -> Refund Transaction

          - Authorize Transaction -> Reversal Transaction

        - Only approved or refunded transactions can be referenced, otherwise the submitted transaction will be created with status error
        - Ensure you prevent a merchant from being deleted unless there are no related payment transactions

  2. Models:

      2.1. Merchant: name, description, email, status (active, inactive),total_transaction_sum

      2.2. Transaction: uuid, amount, status (approved, reversed, refunded, error), customer_email, customer_phone

        - Use validations for: uuid, amount > 0, customer_email, status
        - Use STI
        - Transaction Types
          - Authorize transaction - has amount and used to hold customer's amount
          - Charge transaction - has amount and used to confirm the amount is taken from the customer's account and transferred to the merchant
            - The merchant's total transactions amount has to be the sum of the approved Charge transactions
          - Refund transaction - has amount and used to reverse a specific amount (whole amount) of the Charge Transaction and return it to the customer
            - Transitions the Charge transaction to status refunded
            - The approved Refund transactions will decrease the merchant's total transaction amount
          - Reversal transaction - has no amount, used to invalidate the
            - Authorize Transaction - Transitions the Authorize transaction to status reversed

  3. Inputs and tasks:

      3.2. A background Job for deleting transactions older than an hour (cron job)

      3.3. Accepts payments using XML/ JSON API (single point POST request) Include API authentication layer (Basic authentication) No transactions can be submitted unless the merchant is in active state

  4. Presentation:

      4.1. Display, edit, destroy merchants

      4.2. Display transactions
