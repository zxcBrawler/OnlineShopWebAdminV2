# OnlineShopWebAdminV2

This is the repository for the Online Shop Web Admin V2 project.

## Overview

OnlineShopWebAdminV2 is a web-based admin interface for managing an online shop. It provides functionality for managing products, orders, customers, and more.
An app has 3 roles which are:
- Admin that can manage all data in database
- Director that can only manage data within the organization
- Employee that can only view info about shop within the organization 

## Features

- Add, edit, and delete products
- View and manage customer orders
- Monitor sales statistics
- User management and authentication

## UI Overview

The OnlineShopWebAdminV2 application provides a user-friendly interface for managing various aspects of an online shop. Below is an overview of the main UI components and features:

### Side menu

Each role has it own side menu items that manage each role navigation. Also every side menu has a **Logout** button that clears local window storage and navigates back to login page.

#### Admin Side menu
- **Dashboard**: View and monitor various metrics and insights related to the online shop's data. Shows widgets representing total clothes divided bu categories, total users also divided by roles and total orders made that are divided by delivery types.
- **Users**: Manage user accounts associated with the online shop, including role-based access control, and profile management.
- **Clothes**: Manage the shop's inventory, including adding new products, updating existing ones, and categorizing items.
- **Shops**: Manage information related to shop locations, including addresses, contact details, and operating hours.
- **Orders**: Process and fulfill customer orders, track order statuses, manage shipping and delivery details, and generate invoices.

![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/3387703d-ecfc-44c3-ad72-220d77287e58)


#### Director Side menu
- **Dashboard**: View and monitor various metrics and insights related to the online shop's data from a director's perspective.
- **Employees**: Manage employee accounts and roles within the organization, including hiring, termination, and role assignment.
- **Clothes**: Manage the shop's inventory, including adding new products, updating existing ones, and categorizing items.
- **My Shop**: Access and manage information specific to the director's assigned shop location, including sales data, customer feedback, and inventory levels.
- **Shop Orders**: Monitor and manage orders placed through the director's assigned shop location, including processing, fulfillment, and tracking.

![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/4e481c99-ecbe-418c-8274-82297b0ca545)

#### Employee Side menu
- **Dashboard**: View and monitor various metrics and insights related to the online shop's data from an employee's perspective.
- **Clothes**: Access and view the shop's inventory.
- **Shop Orders**: View and manage orders placed through the shop location where the employee is assigned, including processing, fulfillment, and tracking.

![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/a37090f2-c788-4120-b4d7-a621ed46f7a5)


### Dashboard

The dashboard serves as the main landing page and provides an overview of essential metrics and insights related to the online shop's performance. It includes charts that shows different widgets based on user's role.
#### Admin Dashboard
Shows widgets representing total clothes divided by categories, total users also divided by roles and total orders made that are divided by delivery types.
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/b585099b-9b18-423f-a6a1-bf555b50ab71)


#### Director Dashboard
Shows widgets representing total clothes items that are stored in specific store, quantity of items that were sold during each day of the current week, which are filtered by clothes gender (male and female) and orders that were made during each day of the current week
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/54729163-67f1-4503-a563-a0f66328339c)
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/37340035-cdaa-4d33-9bf6-e0658ad6a495)

#### Employee Dashboard
Has the same widgets as **Director Dashboard**

### Users/Employees tab

On the "Users/Employees" page, administrators and directors can manage the users and employees associated with the online shop system. This functionality encompasses tasks such as adding new users or employees, updating existing profiles, and maintaining access permissions and roles. Administrators can create accounts for new users, assign them roles and permissions within the system, and manage their personal information such as name, email, and contact details. Additionally, administrators and directors can view a list of all users and employees, filter and search for specific individuals based on criteria such as role or department, and access detailed profiles for each user/employee to review and update their information as needed. This page serves as a centralized hub for overseeing and managing the user and employee base of the online shop, ensuring efficient operation and accountability within the organization.

#### Admin users 
Shows a pie chart of all users divided by role
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/0ec2d272-2685-4d93-ae35-d6d60adad7fe)

By pressing on arrow button, performs a navigation to all users table, that incudes such functions as adding new employee and searching users by username 

![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/de5ed8d4-9ad5-4136-90bd-71af2e8e34d7)

By pressing on **Add Button** above the table the dialog opened where admin can add new employee

Firstly, admin chooses role and gender of future employee
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/2b18e4ba-99e2-4b8b-aad6-2d08eaab2cba)

Then fills up all additional info and chooses shop assossiated with employee
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/b2e0271e-9f59-49e0-be8f-f5cf05bb3345)

By pressing on **Option Button** in a table row performs navigation to show details of selected user on opened page
Depending on a role, shows different info about user.

For example if the user role is *buyer* shows full info about buyer including buyer orders and delivery addresses
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/5587bc32-db95-4e29-894c-7214d0f43ddd)
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/726acbc8-d92e-45be-b6b4-d2498f832493)
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/fa6091f1-dcf9-4431-ab0b-10ee6b0458b1)

Can also view address info by pressing **Option Button** in addresses table which shows the exact location pinned on map
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/2839050c-2e73-441d-8a06-44600e397dcb)

#### Director users 
Show all employees assigned to specific shop
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/9032bdb3-8ce7-4ae7-be94-ea05eaaf1444)


### Clothes Catalog
On the "Clothes" page, users can perform various functionalities related to managing the inventory of clothing items available for sale. This includes tasks such as adding new clothing items, updating existing item details, and categorizing items based on attributes such as type, size, color, and price. Users can input essential information such as the item's name, description, category, and stock availability. Additionally, they can view a list of all existing clothing items, filter and search for specific items based on various criteria, and navigate to individual item pages for more detailed management. This page serves as a centralized hub for overseeing and maintaining the inventory of clothing items associated with the online business, providing a seamless experience for administrators, directors, and employees alike.

#### Admin Clothes
Shows all info about clothes such as total quantity, quantity of female and male items filtered by type clothes in Pie Chart, total items that were sold, total colors and sizes
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/9edcba2f-4df4-4295-88d0-1c7825af50e1)
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/32364cc8-06f0-4e3c-a1cd-3c9f3cd642ab)

By pressing **Arrow Button** of total items that were sold during current week the Bar Chart is shown representing the quantity of items that were sold during each day of the current week.
It also includes info about which items were sold specifically by each date
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/601211d6-34da-4dbb-9697-3558670339ee)

By pressing **Arrow Button** of total clothes widget the table containing all items info is shown. This page includes such functionallity as adding new items, searching items by name and forming a PDF file that contains all info about clothes presented in a table
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/ab0d9091-0556-40f8-8727-c1ae7c444eeb)


By pressing **Options Button** the details of specific clothes item are shown. 
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/9e691b5d-45d4-4579-a912-0c53426ad3f4)

By pressing **Add button** the dialog for adding new item to database is shown.
To add new items it's required to choose item gender, type of future item, fill all additional info, choose sizes and colors of item and uploading URL of clothes image
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/6059bc33-abb6-4e0d-a5cd-c8f8be3b7d55)
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/5a5f4330-bedb-4792-b46d-2d3c216c783c)

Pressing **generate pdf** button is forming a PDF file that contains all info about clothes presented in a table
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/ee3fd790-fbe4-466e-ae09-ae211a473991)

#### Director Clothes
Shows all info about clothes in shop that director is assigned to such as total quantity, quantity of female and male items filtered by type clothes in Pie Chart and total items that were sold by current week.
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/8f3d042a-c82c-42b9-a33b-55ea3f347318)
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/2eb19684-ed44-4539-ad89-3e61c0896a4b)

Same as admin by pressing **Arrow Button** of total clothes widget the table containing all items info is shown. This page includes such functionallity as adding new items to shop, searching items by name and forming a PDF file that contains all info about clothes presented in a table

![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/70cb1f8e-4db1-4a97-8e57-32c71b78ae71)

By pressing **Add button** the dialog for adding new item to shop is shown.
To add new items it's required to choose item from dropdwon, size and color of item and quantity of item with specific size and color
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/dc83ae2a-6481-471b-9de6-f0cd9bbfe145)

#### Employee Clothes

Employee clothes page has the same functionallity as Director clothes page excluding an abillity to add and delete clothes from the shop


### Shops overview
On the "Shops" page, users can perform various functionalities related to managing information about shop locations. This includes tasks such as adding new shop locations, updating existing location details, and managing the availability status of each shop. Users can input essential information such as the shop's address, contact details, operating hours, and any additional notes. Additionally, they can view a list of all existing shop locations, filter and search for specific shops, and navigate to individual shop pages for more detailed management. This page serves as a centralized hub for overseeing and maintaining the network of shop locations associated with the online business, providing a seamless experience for administrators, directors, and employees alike.

#### Admin Shops
Shows all info about shops in a table which includes searching shop by address.
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/dde6e3a9-471b-42de-9eac-0eba50457b9c)

By pressing **Options Button** the details of specific shop are shown. 
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/24305719-d2d2-458f-9354-6c9152ced44d)

By pressing **Add button** the dialog for adding new shop to database is shown.
To add new shop it is required to fill all info about shop such as shop address, shop subway/metro station and contact number
While filling the address of shop a marker is placed on map to show the location of shop
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/12d7c59a-c558-4fb3-85f5-df9d45b9903b)


#### Director My Shop
Shows brief info about shop that director is assinged to
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/f12e0418-090d-422c-b3e9-ff134c68d358)


### Orders overview

On the "Orders" page, administrators, directors, and employees can view, manage, and track orders placed within the online shop system. This functionality enables users to monitor the status of orders, process new orders, update order details, and manage order fulfillment. Administrators and directors have access to a comprehensive overview of all orders within the system, including details such as order ID, customer information, order date, items purchased, payment status, and shipping details. They can filter and search for specific orders based on various criteria, such as order status, customer name, or order date, to quickly locate and manage orders as needed. Additionally, administrators and directors can take actions such as updating order statuses, managing inventory levels, and resolving any issues or discrepancies related to orders. Employees involved in order fulfillment can use this page to view assigned orders, update order statuses as they progress through the fulfillment process, and communicate with customers regarding order updates or inquiries. Overall, the Orders page serves as a central hub for monitoring and managing the entire order lifecycle, ensuring smooth and efficient order processing and customer satisfaction.

#### Admin Orders
Shows info about total orders, including Pie Chart to represent orders by statuses and Line Chart that shows how much orders were made during each day of current week

![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/c54c6adb-ad64-4a13-b5c8-da0ca99d9db5)
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/41e0b0a6-6256-4e50-9ac9-f87384f55077)

By pressing **Arrow Button** of total orders widget the table containing all orders info is shown. This page includes such functionallity as searching orders by number and forming a PDF file that contains all info about orders presented in a table
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/b75007fd-b766-439d-873a-4c32e119e996)

By pressing **Options Button** the details of specific order are shown. 

It includes full order info and the item composition of current order.

Each role has the abillity to only change status of order.
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/16b90bb5-43c7-415e-bb0e-2b277f3e6103)
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/55fab736-1b86-4e49-9811-0bc99591fb0d)

By pressing **Arrow Button** of total orders that were made during current week the Line Chart is shown representing the quantity of orders that were made during each day of the current week.
It also includes full info about which orders were made specifically by each date
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/59c5cda0-eb66-4ffa-b804-4121c0208789)


#### Director Orders
This page has the same functionallity as Admin Orders Page but only shows orders for shop that director is assigned to.
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/b6720312-a5db-4b9d-947c-1826ddee4771)
![image](https://github.com/zxcBrawler/OnlineShopWebAdminV2/assets/97828450/e5dbe144-ead6-437c-ba96-63de084ba4c6)

#### Employee Orders
Has the same functionallity as Director Orders
