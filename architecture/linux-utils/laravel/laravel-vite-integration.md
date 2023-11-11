https://laravel.com/docs/10.x/vite
Introduction
Vite is a modern frontend build tool that provides an extremely fast development environment and bundles your code for production. When building applications with Laravel, you will typically use Vite to bundle your application's CSS and JavaScript files into production ready assets.

Laravel integrates seamlessly with Vite by providing an official plugin and Blade directive to load your assets for development and production.

Installation & Setup

The following documentation discusses how to manually install and configure the Laravel Vite plugin. However, Laravel's starter kits already include all of this scaffolding and are the fastest way to get started with Laravel and Vite.

https://laravel.com/docs/10.x/starter-kits

Introduction
To give you a head start building your new Laravel application, we are happy to offer authentication and application starter kits. These kits automatically scaffold your application with the routes, controllers, and views you need to register and authenticate your application's users.

While you are welcome to use these starter kits, they are not required. You are free to build your own application from the ground up by simply installing a fresh copy of Laravel. Either way, we know you will build something great!
Laravel Breeze
Laravel Breeze is a minimal, simple implementation of all of Laravel's authentication features, including login, registration, password reset, email verification, and password confirmation. In addition, Breeze includes a simple "profile" page where the user may update their name, email address, and password.

Laravel Breeze's default view layer is made up of simple Blade templates styled with Tailwind CSS. Or, Breeze can scaffold your application using Vue or React and Inertia.

Breeze provides a wonderful starting point for beginning a fresh Laravel application and is also a great choice for projects that plan to take their Blade templates to the next level with Laravel Livewire.

Installing Vite And The Laravel Plugin
Within a fresh installation of Laravel, you will find a package.json file in the root of your application's directory structure. The default package.json file already includes everything you need to get started using Vite and the Laravel plugin. You may install your application's frontend dependencies via NPM:

npm install

Configuring Vite
Vite is configured via a vite.config.js file in the root of your project. You are free to customize this file based on your needs, and you may also install any other plugins your application requires, such as @vitejs/plugin-vue or @vitejs/plugin-react.

The Laravel Vite plugin requires you to specify the entry points for your application. These may be JavaScript or CSS files, and include preprocessed languages such as TypeScript, JSX, TSX, and Sass.

import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
 
export default defineConfig({
    plugins: [
        laravel([
            'resources/css/app.css',
            'resources/js/app.js',
        ]),
    ],
});


Running Vite
There are two ways you can run Vite. You may run the development server via the dev command, which is useful while developing locally. The development server will automatically detect changes to your files and instantly reflect them in any open browser windows.

Or, running the build command will version and bundle your application's assets and get them ready for you to deploy to production:

# Run the Vite development server...
npm run dev
 
# Build and version the assets for production...
npm run build



