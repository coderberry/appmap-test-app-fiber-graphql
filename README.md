# AppMap + GraphQL + Fiber Bug

This app replicates the bug reported at https://github.com/getappmap/appmap-ruby/issues/349.

## Conditions

- Using the appmap gem
- Using the latest graphql gem
- `config.active_support.isolation_level = :fiber` in application.rb

## Steps to reproduce

### 1. Prepare app

```bash
git clone git@github.com:coderberry/appmap-test-app-fiber-graphql.git
cd appmap-test-app-fiber-graphql
bin/setup
bin/rails db:migrate
bin/rails db:seed
```

### 2. Run the app

```bash
bin/rails s
```

### 3. Execute a query via GraphiQL

Open [http://locahost:3000/graphiql](http://localhost:3000/graphiql)) and execute the following query 5 times:

```graphql
query {
  localCounts
}
```

### 4. Observe the hung fibers

Ensure you are viewing the Rails server logs and sumbmit the request a 6th time. The request will hang and you will see that the connection pool was not cleaned up.

Example:

![CleanShot 2024-03-05 at 16 17 57](https://github.com/coderberry/appmap-test-app-fiber-graphql/assets/12481/c3287d73-fb38-47cd-ab44-c202e0a6507a)
