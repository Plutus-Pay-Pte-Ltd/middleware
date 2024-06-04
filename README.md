# Know Your Business

Know Your Business (KYB) is a web application designed to streamline the Know Your Customer (KYC) process for businesses. It allows companies to submit their information and required documents electronically for verification. Compliance officers can then review and approve/reject these submissions.

## SETUP

1. Install dependencies:

  ```bash
    bundle install
  ```
2. Set up the database:

  ```bash
    rails db:setup
  ```
# Usage

1. Start the Rails server:

  ```bash
    rails server
  ```
2. Navigate to http://localhost:3000 in your web browser to access the application.

3. Register as a company or a compliance officer, depending on your role.

4. Companies can submit their business information and required documents through the KYB module.

5. Compliance officers can review and approve/reject company submissions.


# Testing

Run the RSpec tests to ensure everything is functioning correctly:

  ```bash
    bundle exec rspec
  ```

 
# API Collection

https://www.postman.com/deqode/workspace/ss/collection/28881076-77ed742d-43ad-451a-be08-5e9368e51a3d?action=share&creator=28881076
