# Car Diagnostics API

A Rails API for managing car diagnostics and service history.

## Ruby Version

This application uses Ruby 3.2.2 (as specified in `.ruby-version`).

## System Dependencies

- Ruby 3.2.2
- PostgreSQL

## Configuration

1. Clone the repository
2. Install dependencies:
   ```bash
   bundle install
   ```

## Database Setup

1. Create and setup the database:
   ```bash
   rails db:create
   rails db:migrate
   ```

2. Seed the database (if needed):
   ```bash
   rails db:seed
   ```

## Running the Application

### Development

Start the Rails server:
```bash
rails server
```

The API will be available at `http://localhost:3000`

### Testing

Run the test suite:
```bash
rails test
```

For specific test files:
```bash
rails test test/models/car_test.rb
```

## Deployment

This application is currently deployed on Render

## API Endpoints

The API provides endpoints for:
- Car management (create, read, update, delete)
- Service history management
- Diagnostic information

## Development Tools

- RuboCop for code style enforcement (`.rubocop.yml`)
- GitHub Actions for CI/CD (`.github` directory)
