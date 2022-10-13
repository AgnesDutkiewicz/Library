# README

## Library Project

## General info
Library app that allow users to make reservations for books.
It also allow admin user to add, edit and delete books, authors, publishers and reservations.

## Technologies
* Ruby 2.7.4
* Rails 6.1.7

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
* tests - written mostly with Rspec, but also few with Capybara
