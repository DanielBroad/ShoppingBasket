


##Mobile Development Technical Test

#Instructions

The purpose of this assessment is to complete a simple programming assignment. The details of the assignment are elaborated in the following section.

You are required to:
• Produce working, object-oriented and tested source code to solve the problem
• You are expected to work on this task on your own, without help or advice from others.

Pricing a basket

Write a mobile application and associated unit tests that can price a basket of goods in a number of different currencies.

The goods that can be purchased, which are all priced in USD, are:
• Peas – 95 cents per bag
• Eggs – $2.10 per dozen
• Milk – $1.30 per bottle
• Beans – 73 cents per can

The program should allow the user to add or remove items in a basket. The user can click on a checkout button which will then display the total price for the basket with the option to display the amount in different currencies. For example, if the basket contained Milk and the currency selected was GBP with an exchange rate of 0.7, the total would be £ 0.91

No UI design constraints are enforced so feel free to design the UI in the way you see as most appropriate for the solution.

The list of currencies should be consumed from http://jsonrates.com/currencies.json. To convert to other currencies, you will need to create an account on http://jsonrates.com/. This will then issue you with an API-Key that permits reading from the various public APIs listed on their site. The exchange rates may change at any time.

The code and design should meet these requirements but be sufficiently flexible to allow for future extensibility. The code should be well structured, suitably commented, have error handling and be tested.