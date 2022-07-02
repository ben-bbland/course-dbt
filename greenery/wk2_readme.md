Question 1: Explain the marts models you added. Why did you organize the models in the way you did?
    Answer 1: This week was a bit tougher than last week for me because it seemed more open-ended. You could make mart models for whatever questions you think management might ask. This is data I am not used to working with so I did my best to configure everything in the fact tables to allow analysts to answer any questions that the company might have about their users, the orders the users placed, and the products that Greenery carried.

Question 2: What assumptions are you making about each model? (i.e. why are you adding each test?)
    Answer 2: I'm assuming that there will always be a unique identifier for most of the tables we are pulling from (i.e. user, address, session, etc.). If these identifiers are not there, or repeat, then something must be wrong with the source data. Tests are in place to catch these events (unique, not_null) but I definately want to look further into tests because I feel that I didn't truly utilize the full power of the dbt feature.

Question 3: Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
    Answer 3: Not necessarily - I did notice that if we applied a 'not_null' test to the promo column then that could've caused some trouble due to an incorrect assumption. Not everyone will be applying a promotional code at checkout, so we do want to keep the nulls there so that our analysts can tell what percentage of orders use a discount code - and if those promo codes are being used consistently by the same group of users.

Question 4: Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.
    Answer 4: We could just schedule a dbt run job at the beginning of every day, during the early hours of the morning. The data team would be able to see the results of the tests by the time they log into work each morning - and could also set up automated alerts to a specified distribution list to employees at the company in the event that tests fail (I get these at my job all the time, even though I am not a regular dbt user).