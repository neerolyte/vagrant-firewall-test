This is my first attempt at a set of integration tests for firewalls configured by puppet.

To use this repo you will first have to have a working vagrant setup, once that's done, running ./run-integration-tests should do the rest.

There is currently a race condition which will usually make the tests fail on the very first run, I may come back and fix this one day.