# O'Travail

Welcome to the **O'Travail** repository, a project built using Ruby on Rails (7.1). This site serves as an AI-assisted search engine for the French Labor Law (*Code du Travail*).

## Design
- **Bootstrap 5.3**: The front-end design is powered by Bootstrap 5.3, with customized SCSS variables to maintain a consistent and responsive design.
- **FontAwesome**: Free version of FontAwesome is used for iconography, ensuring that the UI is both user-friendly and visually appealing.

## User Interaction
- **Hotwire (Stimulus.js)**: For seamless, reactive user interactions, Hotwire's Stimulus.js is employed. It enhances the user experience by providing a lightweight framework for building dynamic, interactive components.

## Authorization
- **Devise**: Handles user authentication, including registration, login, and logout functionalities. This ensures that user sessions are secure and managed efficiently.

## Search Engine
- **pg-search**: This Ruby gem facilitates powerful search capabilities within the PostgreSQL database. It enables the searching of multiple keywords across different columns simultaneously, enhancing the search experience.

## Embedding
- **PostgreSQL Vector Extension**: The project uses PostgreSQL's vector extension to handle text embeddings. This integration allows the application to send requests to OpenAI's `text-embedding-small` model. For more engineering details, please refer to `db/seed.rb` and `app/model/article.rb`.

## Find the Vector
- **Neighbor**: This component is responsible for efficiently finding and managing vectors in the database, optimizing search accuracy and performance.

## Real-time Chatbot Room
- **ActionCable Enhanced PostgreSQL Adapter & SolidQueue**: These tools structure the database for real-time communication in the chatbot room. 
- **Hotwire (Turbo)**: On the JavaScript side, Hotwire's Turbo drives the real-time updates, making the chatbot room dynamic and responsive.

## Database Analysis & Cleaning
- **Python Pandas**: For database analysis and data cleaning, Python's Pandas library is used, enabling efficient data processing and management.

---

Feel free to explore the repository, and if you have any questions or contributions, don't hesitate to reach out!
