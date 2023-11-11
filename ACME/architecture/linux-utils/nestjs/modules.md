# Nest.js Feature Module

**[Feature modules](https://docs.nestjs.com/modules#feature-modules)**
The CatsController and CatsService belong to the same application domain. As they are closely related, it makes sense to move them into a feature module. A feature module simply organizes code relevant for a specific feature, keeping code organized and establishing clear boundaries. This helps us manage complexity and develop with SOLID principles, especially as the size of the application and/or team grow.

To create a module using the CLI, simply execute the $ nest g module cats command.
