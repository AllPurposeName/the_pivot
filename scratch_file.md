FreshThreads

Off-the-rack clothes are so blah. Let's build a marketplace for buying custom clothing.

Users register on the site as either sellers or buyers
Sellers have a "store" page where they can post one or more items
An item has a title, photos, a detailed description, and a time-to-produce
Each item can also have one or more "options" defined by the seller such as: waist size, color, fabric, sleeve length, etc. These must be chosen by the seller when creating/editing the item and allow them to set specific values (like "S", "M", "L", etc or "Short", "Regular", "Long")
Customers can browse all itemson the platform or browse a specific seller's store
When a customer adds an item to their cart they need to specify each of the options
When the order is submitted the customer is emailed a receipt and the seller is notified to begin production.
It's a pain to enter my options for EVERY purchase. Allow a user to store their options in their account, so when they purchase an item the right values are pre-selected (but can still be changed).

Expectations

You are to extend Dinner Dash so that it can handle multiple, simultaneous businesses. Each business has their own name, unique URL pattern, items, orders, and administrators.

The requirements reference an example.com, but your URL will differ.

Functional Requirements

Individual restaurants can be accessed by specifying their restaurant name as the path prefix.

Given a business named Billy's BBQ
When I visit http://example.com/billys-bbq
Then I expect to see all items defined for Billy's BBQ
And I expect to see branding defined for Billy's BBQ
When I visit http://example.com/billys-bbq/categories
Then I expect to see all categories defined for Billy's BBQ
Public Visitor

As a public, unauthenticated visitor to a business I can:

Maintain a shared shopping cart across all businesses I browse
Add items to a shopping cart
Log in to or create an account before completing checkout
When I create an account, then I expect to receive a welcome email
After login or creating an account, I will immediately resume the checkout process
Request that my account become a business owner
Authenticated Customer

As an authenticated customer I can:

Make purchases on any business I am browsing
Receive an email confirmation of my order with basic order details and a link to the order detail page
Manage my account information shared by all businesses centrally on my account page
Shipping addresses
Billing addresses
Credit cards associated with my account
Basic account info like name and password, as managed previously in Dinner Dash v1
View and manage my purchase history across all businesses
Creating a Business

An account can request to create a new business that includes a name, URL identifier ("slug"), and description
The platform administrators are notified of the pending request
If approved...
the requester is notified by email
the requester automatically becomes a business administrator for the business
If denied...
the requester is notified by email
Authenticated Business Administrator

As an authenticated business admin, by using a dedicated admin area, I can:

Add items, edit items, and retire listings in my business only
Update the details of my business such as the: name, URL identifier, and description
Add or remove other admins for the business
There can never be fewer than 1 admin for a business
Perform the admin actions available to administrators in Dinner Dash as appropriate
Authenticated Platform Administrator

As an authenticated Platform Administrator, I can:

Approve or decline the creation of new businesses
Take a restaurant "offline" temporarily so that attempting to browse it redirects its root and displays a maintenance message
Bring an offline restaurant back online
Override/assist restaurant admins in any functionality available to them via the admin portion of their restaurant pages
Validation and Error Messages

Any form in the application must:

validate the submitted data appropriately
reject invalid input
display clear and helpful errors and corrective instructions
allow the user to quickly fix and resubmit
Non-Functional Requirements

Background Workers

Use background workers for any job that doesn't have to be completed before the response is sent to the user (ex: sending email, updating statistics, etc).

Use Resque or a similar library to support this functionality.

Security

Your app needs to be secure enough that a malicious user with complete knowledge of the source code cannot exploit the system (ie: change other users' data, view other users' data, elevate their own privledge level, etc).

Base Data

Before final delivery, and ideally before customer check-ins, you should have the following data pre-loaded in your marketplace:

At least 500 total businesses
At least 25 categories
At least 1,000 listings per category
At least 500 known customers
At least 10 orders per customer
1 business admin per business (jmejia@turing.io)
1 platform administrators (jorge@turing.io)
It creates a much stronger impression of your site if the data is plausible. We recommend creating a few "template" businesses that have real listings, then replicating those as needed. It's better to have "Taste of India 26" and "Taste of India 27" than "Lorem Ipsum" and "Tellus Domit".

Extensions

In this project you as developers are expected to take a more active role in shaping the project. Although there are a few potential extensions proposed at the outset, you are encouraged to propose additional extensions, in the form of new features and user stories describing them, to your project manager.

If you have an idea for a killer feature for your application, pitch it to your stakeholders for refinement. If they are convinced of its value, they'll work with your team to create one or more user stories in your project management software and prioritize those stories in the context of the rest of the requirements. You may be able to convince them to prioritize your feature ahead of current base requirements if it is sufficiently compelling or necessary.

However, your application should not implement features which have not been approved by your customer.

Dashboard

As a business admin, you should have access to a business dashboard that will give you actionable data to make business decisions. This dashboard should include:

Top 10 customers by revenue
Top 10 customers by units purchased
Top 20 products by revenue
Top 20 products by units sold
Top 10 orders by revenue
Top 10 orders by units sold
Top 10 days by revenue
Custom CSS per Business

Provide a mechanism so that business administrators may provide custom a CSS sheet to change the appearance of their listing page. This custom styling should not affect any other business's appearance.

Have four pre-built themes they can select from and the ability to upload their own.

Use Sub-Domains To Distinguish Businesses

In order to give greater precedence and more SEO-juice to each individual business, as well as pave the way for businesses to use custom domains, change your application so that, instead of using a path prefix per request to identify individual businesses in the system, use unique sub-domains instead.

So instead of http://www.example.com/billys-bbq/items pointing to the items belonging to the business Billy's BBQ, allow http://billys-bbq.example.com/items to be used instead.

Evaluations

Feedback / Evaluation Schedule

Rapid and frequent feedback about the work we produce is a central tenet of agile software development. As such, we'll have frequent meetings to discuss the state of your project and correct course as necessary.

These meetings are intended to model interactions with a real customer, they are not support sessions. As the stories clearly define the customer's expectations, your application needs to exactly follow the stories as they've been developed with your customer. A 95% implementation is wrong.

If you want to deviate from the story as it's written, you need to discuss that with your customer and get approval to change the story first.

Evaluation Rubric

The following criteria will be used for your project's evaluation:

Feature Delivery

You'll be graded on each of the criteria below with a score of (1) well below expectations, (2) below expectations, (3) as expected, (4) better than expected.

1. Completion

4: Team completed all the user stories and requirements set by the client in timely manner.
3: Team completed all the user stories and requirements set by the client.
2: Team completed most of all the user stories and requirements set by the client.
1: Team completed the user stories and requirements partially.
2. Organization

4: Team used a project management tool and updated their progress in real-time.
3: Team used a project management tool to keep their project organized.
2: Team used a project management tool but didn't update the progress frequently.
1: Team failed to use a project management tool to track its progress.
3. Progress

4: Team delivered all the requested features on all iterations.
3: Team delivered all the requested features on all but one iteration.
2: Team delivered all the requested features on all but two iterations.
1: Team failed to delivered requested features on three or more iterations.
Technical Quality

1. Test-Driven Development

4: Project shows exceptional use of testing at different layers (above 95% coverage).
3: Project shows adequate testing (90% - 95% coverage).
2: Project shows gaps in test usage/coverage/design (85 - 90% coverage).
1: Project lacks sufficient testing (under 85% coverage).
2. Code Quality

4: Project demonstrates exceptionally well factored code.
3: Project demonstrates solid code quality and MVC principles.
2: Project demonstrates some gaps in code quality and/or application of MVC principles.
1: Project demonstrates poor factoring and/or understanding of MVC.
3. User Experience

4: Project exhibits a production-ready and polished UX.
3: Project exhibits a production-ready user experience.
2: Project exhibits some gaps in the UX.
1: Project exhibits inattention to the user experience.
