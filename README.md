# README

## Library Project

## General info
Library app that allow users to make reservations for books.
It also allow admin user to add, edit and delete books, authors, publishers and reservations.

## Technologies
* Ruby
* Rails

### Features
* creating, editing and deleting new user's account, signing in and out
* listing all authors, books and publishers
* listing users, that is available only for signed in users
* creating, editing and deleting authors, books and publishers
* creating reservations for books for signed in users
* editing reservations status, that is available only for admin user
* basic contracts with dry-validation gem
* policies with pundit gem
* service objects for creating and updating authors, books, publishers, users and reservations
* basic monads with dry-monads
* tests - written mostly with Rspec, but also few with Capybara

### Solutions
* MVC
It's software design pattern that divide the related program logic into 3 elements (models, views and controllers) so 
the code is easier to manage and make changes.

* Contracts
They contains validations that used to be in models. It help keeping models dry and allows to check application input.
example: contracts/users/update_contract, services/users/update

* Service Objects
It's a way of encapsulating part of logic, in this case - single action. 
example: services/book/update, book_controller

* Politics
They protect content from being accessed by unauthorized users. It's one of the application's security features.
example: policies/book_policy

* Monads
It's software design pattern that wraps return values into success or failure (in this case). Monads help keep code
execution fluent and help with exceptions and error handling. 
example: services/author/create, author_controller
