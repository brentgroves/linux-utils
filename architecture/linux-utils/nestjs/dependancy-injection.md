<https://angular.io/guide/dependency-injection>
nestjs uses DI concepts from angular

Providing dependency
Imagine there is a class called HeroService that needs to act as a dependency in a component.

The first step is to add the @Injectable decorator to show that the class can be injected.

content_copy
@Injectable()
class HeroService {}
The next step is to make it available in the DI by providing it. A dependency can be provided in multiple places:

At the Component level, using the providers field of the @Component decorator. In this case the HeroService becomes available to all instances of this component and other components and directives used in the template. For example:
content_copy
@Component({
  selector: 'hero-list',
  template: '...',
  providers: [HeroService]
})
class HeroListComponent {}
When you register a provider at the component level, you get a new instance of the service with each new instance of that component.

When the Nest IoC container instantiates a CatsController, it first looks for any dependencies*. When it finds the CatsService dependency, it performs a lookup on the CatsService token, which returns the CatsService class, per the registration step (#3 above). Assuming SINGLETON scope (the default behavior), Nest will then either create an instance of CatsService, cache it, and return it, or if one is already cached, return the existing instance.

*This explanation is a bit simplified to illustrate the point. One important area we glossed over is that the process of analyzing the code for dependencies is very sophisticated, and happens during application bootstrapping. One key feature is that dependency analysis (or "creating the dependency graph"), is transitive. In the above example, if the CatsService itself had dependencies, those too would be resolved. The dependency graph ensures that dependencies are resolved in the correct order - essentially "bottom up". This mechanism relieves the developer from having to manage such complex dependency graphs.
