# 📝 Flask Blog App

## 📖 Description
The **Flask Blog App** is a simple yet powerful blogging platform built using **Flask** as the backend framework. This application allows users to create, manage, and read blog posts efficiently. It features a clean UI, authentication, and various enhancements for a smooth blogging experience.

This project includes:
- **User Authentication**: Secure login and registration system.
- **Blog Management**: CRUD operations for creating, editing, and deleting posts.
- **Filtering**: Filter blogs by **Newest First, Oldest First, and Most Liked**.
- **Responsive Design**: Optimized for different screen sizes.
- **Integration with Databases**: Stores blog data using **SQLAlchemy**.
- **Rich Text Editing**: Markdown-supported blog editor.
- **Pagination**: Seamless navigation between multiple blog pages.
- **RESTful API Endpoints**: Fetch posts dynamically.

## 🚀 Features
- ✅ User authentication (Login/Register)
- ✅ Create, update, delete blog posts
- ✅ Filter by Oldest First, Newest First, and Most Liked
- ✅ Like and Comment on the blog post
- ✅ User can follow the other user and see the followed user post by check the feed
- ✅ Blog details page with full content view
- ✅ Embedded rich text editor for blog writing
- ✅ Pagination for blog listing
- ✅ RESTful API integration for fetching blog data

## 🖼️ Screenshots
Here are some screenshots of the Flask Blog App:

### 📌 Home Page
![Screenshot from 2025-03-18 12-58-36](https://github.com/user-attachments/assets/a1d63ab8-2452-4285-8020-7425b5630c36)

### 📌 Search Blog
![Screenshot from 2025-03-18 15-15-28](https://github.com/user-attachments/assets/c16baaf3-88f8-4a09-be61-29c81bc857fb)

### 📌 Create Post Page
![Screenshot from 2025-03-18 14-41-25](https://github.com/user-attachments/assets/5c05ae45-667f-42d5-a48b-e96c205e3871)

### 📌 Post Details Page with Like and Comment section
![Screenshot from 2025-03-18 15-14-15](https://github.com/user-attachments/assets/c18be3be-35b3-4bd4-bda6-64ce80221290)

### 📌 Profile Page
![Screenshot from 2025-03-18 14-42-03](https://github.com/user-attachments/assets/0b3b1444-8a5a-420e-a7de-91813dad84e8)

### 📌 Update Profile Page
![Screenshot from 2025-03-18 14-40-54](https://github.com/user-attachments/assets/bd9cced1-5d05-43cd-8847-3691dfca760b)

### 📌 Followed User Posts
![Screenshot from 2025-03-18 14-41-16](https://github.com/user-attachments/assets/751768a3-08fd-4f20-aa03-41bf36c3cf4d)


## 🛠️ Tech Stack
- **Backend**: Flask, Python
- **Frontend**: HTML, CSS, JavaScript (Jinja Templates)
- **Database**: SQLAlchemy (SQLite/PostgreSQL)
- **Authentication**: Flask-Login, Flask-WTF
- **Other Libraries**: Flask-Migrate, Flask-SQLAlchemy

## Contributing 🤝
If you’d like to contribute, feel free to open an issue or submit a pull request. Contributions are always welcome! 🎯

## License 📜
This project is licensed under the MIT License.

## 🏗️ Installation & Setup
Follow these steps to set up the project locally:

```bash
# Clone the repository
git clone https://github.com/your-username/blog-app-flask.git

# Navigate to the project folder
cd flaskblog

# Create and activate a virtual environment
python -m venv venv
source venv/bin/activate   # On macOS/Linux
venv\Scripts\activate      # On Windows

# Install dependencies
pip install -r requirements.txt

# Run database migrations
flask db upgrade

# Start the Flask application
flask run
