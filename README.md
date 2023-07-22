# RRC - Agile Full Stack Web Development Project
## _Goal_

The goal of this assignment is to create a Ruby on Rails ecommerce store for a fictional client using the requirements listed in rubic.

_Description of the CMS Site_
The Bikazon is well-established Winnipeg-based business that specializes in selling the sale of motorcycles and related accessories. With a passion for delivering world renowned and high-quality motorcycles, Bikazon has been serving the local community for over 30 years. We pride ourselves on have highly skilled staff, with extensive knowledge and dedication to customer satisfaction. Bikazon currently employs a team of 50 dedicated staff members. The team consist of experienced salespeople, certified mechanics, administrative staff, and customer service representatives. Each member plays a crucial role in ensuring the smooth operation of the business and delivering an exceptional buying experience to customers.


## _Database Structure Description_

### Account

| Column Name | Data Type | Description |
| ------ | ------ | ------ |
| id | integer | Primary Key for account table |
| email | string | email address/username for customer |
| primaryAddressStreet | string | street name of shipping address |
| PrimaryPostalCode | string | address’s postal code |
| PrimaryProvinceID | integer(FK) | Foreign Key from the province table |
| SecondaryAddressStreet | string | This is the street name of secondary address |
| SecondaryPostalCode | string | This is the street name of secondary address |


### Category

| Column Name | Data Type | Description |
| ------ | ------ | ------ |
| CategoryID | integer | Primary Key for Category record |
| CategoryName | string | The name of the category |

### Product

| Column Name | Data Type | Description |
| ------ | ------ | ------ |
| ProductID  | integer | Primary Key for products record |
| ProductName | string | This is the name of the product |
| Price | decimal | CAD current value of the product |
| Description | string | description of the product to be displayed |
| AmountInStock | integer | This represents the stock count of the products available |
| Image | string | This product’s image storage location |
| CategoryID | integer | This references the CategoryID from Category Table |

### Province

| Column Name | Data Type | Description |
| ------ | ------ | ------ |
| ProvinceID | integer | Primary Key for province record |
| TaxType | string | This states the combination of tax to calculate per province |
| PST | decimal | This is the Provincial Sales Tax value |
| GST | decimal | This is the Goods and Services Tax value |
| HST | decimal | This is the Harmonized Sales Tax value |

### Order

| Column Name | Data Type | Description |
| ------ | ------ | ------ |
| OrderID | integer | This is primary key for the Order record |
| UserID | integer | Foreign Key from the Account table |
| ShippingAddress | string | This specifies the address the order is shipped to |
| PaymentMethod | string | This details the payment card details for this transaction |
| Status | string | This stores the status of the orders tracking purposes |

### OrderItem

| Column Name | Data Type | Description |
| ------ | ------ | ------ |
| OrderItemID | integer | This is primary key for the OrderItem record |
| OrderID | integer | Foreign Key from the Order table |
| ProductID | integer | Foreign Key from the Product table |
| Price | decimal | This stores the price of the item at the time of purchase |
| Quantity | integer | This is the total number of this item ordered |
| PST | decimal | This is the value of the PST tax rate at the time of purchase |
| GST | decimal | This is the value of the GST tax rate at the time of purchase |
| HST | decimal | This is the value of the HST tax rate at the time of purchase |

### Brief Description of the relationships
Category – Product: The Category and Product table has a one-to-many relationship between them. A Category can have zero or many products assigned to it whilst a product must be categorized to a Category.
Association: Category has many Products / Products belong to Category
Province – Account: The Province and Account table has a one-to-many relationship between them. Both the primary and secondary address can be assigned to one province at a time whilst a province can have many Accounts (addresses).
Association: Province has many Accounts / Account belong to Province

Order – Account: The Order and Account table has a one-to-many relationship between them. Each order can be made by only one account whilst an account can make many orders.
Association: Account has many Order / Order belong to Account

Order – OrderItem: The Order and OrderItem table has a one-to-many relationship between them. Each order can have at least to many ordered items. Each OrderItem should be on a specific order.
Association: Order has many OrderItems / OrderItems belong to Order

OrderItem – Product: The OrderItem and the Product table has a many-to-one relationship between them. Each OrderItem is referenced to a particular product however a product can be associated with many order items as products could be ordered on different orders. OrderItem is a join table created from the many-many relationships between Order and Product table. OrderItem is used to store the information related to each product on an order for the specific order. The OrderItem table also stores the Price of the product at the time of the purchase to address the time anomalies.
Association:  Product has many OrderItems / Orderitems belong to Product


_Design considerations_
For this website, there are a few design considerations that are not visible in the erd diagrams that we would like to address:
 - The shopping cart functionality for customers will be implemented as session cart. This means that the cart will only be available in the browser’s session cookies and will not persist beyond the user’s session.
 - Customer’s will be limited to storing two addresses (primary and secondary). In implementing the payment functionality, customer’s will be promoted to enter card details which may include a different address than stored on file.

> Note: Products used in this project was sourced from revzilla.com



