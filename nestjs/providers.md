<https://docs.nestjs.com/providers>
The @Injectable() decorator attaches metadata, which declares that CatsService is a class that can be managed by the Nest IoC container. By the way, this example also uses a Cat interface, which probably looks something like this:

interfaces/cat.interface.tsJS

export interface Cat {
  name: string;
  age: number;
  breed: string;
}

Scopes#
Providers normally have a lifetime ("scope") synchronized with the application lifecycle. When the application is bootstrapped, every dependency must be resolved, and therefore every provider has to be instantiated. Similarly, when the application shuts down, each provider will be destroyed. However, there are ways to make your provider lifetime request-scoped as well. You can read more about these techniques here.
