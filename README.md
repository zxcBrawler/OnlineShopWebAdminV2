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

### User/Employee tab

The user management section allows administrators to view, add, edit, and delete user accounts associated with the online shop. It includes features for user authentication, role-based access control, and profile management.

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


### Product Catalog

The product catalog enables administrators to manage the shop's inventory, including adding new products, updating existing ones, and categorizing items. It provides a comprehensive view of product details, such as name, description, price, and availability.


### Shops overview



### Order Management

The order management module facilitates the processing and fulfillment of customer orders. It allows administrators to track order statuses, manage shipping and delivery details, and generate invoices.
